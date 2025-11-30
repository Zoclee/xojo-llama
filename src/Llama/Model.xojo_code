#tag Class
Protected Class Model
	#tag Method, Flags = &h0
		Sub Constructor(initModelPath As FolderItem)
		  Soft Declare Sub llama_model_default_params Lib "llama.dll" (ByRef params As Llama.ModelParamsStruct)
		  Soft Declare Function llama_load_model_from_file Lib "llama.dll" (path As CString, ByRef params As Llama.ModelParamsStruct) As Ptr
		  Soft Declare Sub llama_context_default_params Lib "llama.dll" (Byref params As Llama.ContextParamsStruct)
		  Soft Declare Function llama_new_context_with_model Lib "llama.dll" (model As Ptr, ByRef params As Llama.ContextParamsStruct) As Ptr
		  Soft Declare Function llama_model_get_vocab Lib "llama.dll" (model As Ptr) As Ptr
		  
		  Var e As Llama.ModelException
		  
		  ModelPath = initModelPath
		  
		  ' --- Load model ---
		  
		  llama_model_default_params(mModelParams)
		  mModelPtr = llama_load_model_from_file(ModelPath.NativePath, mModelParams)
		  If mModelPtr = Nil Then
		    e = new Llama.ModelException()
		    e.ErrorNumber = Integer(ErrorEnum.ModelLoadFailure)
		    e.Message = "Failed to load model."
		    Raise e
		  End If
		  
		  ' --- Create context ---
		  
		  llama_context_default_params(mContextParams)
		  mContextPtr = llama_new_context_with_model(mModelPtr, mContextParams)
		  If mContextPtr = Nil Then
		    e = new Llama.ModelException()
		    e.ErrorNumber = Integer(ErrorEnum.ContextFailure)
		    e.Message = "Failed to create context."
		    Raise e
		  End If
		  
		  ' --- Get pointer to vocab ---
		  
		  mVocabPtr = llama_model_get_vocab(mModelPtr)
		  If mVocabPtr = Nil Then
		    e = new Llama.ModelException()
		    e.ErrorNumber = Integer(ErrorEnum.VocabFailure)
		    e.Message = "Failed to get vocab."
		    Raise e
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Soft Declare Sub llama_free_model Lib "llama.dll" (model As Ptr)
		  Soft Declare Sub llama_free Lib "llama.dll" (ctx As Ptr)
		  
		  if mContextPtr <> nil then
		    llama_free(mContextPtr)
		    mContextPtr = nil
		  end if
		  
		  if mModelPtr <> nil then
		    llama_free_model(mModelPtr)
		    mModelPtr = nil
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Infer(prompt As String) As String
		  Soft Declare Function llama_tokenize Lib "llama.dll" (vocab As Ptr, text As CString, text_len As Int32, tokens As Ptr, n_max_tokens As Int32, add_special As Boolean, parse_special As Boolean) As Int32
		  Soft Declare Function llama_batch_get_one Lib "llama.dll" (tokens As Ptr, n_tokens As Int32, pos_0 As Int32, seq_id As Int32) As Llama.Batch
		  Soft Declare Function llama_decode Lib "llama.dll" (ctx As Ptr, ByRef batch As Llama.Batch) As Int32
		  Soft Declare Function llama_sampler_init_greedy Lib "llama.dll" () As Ptr
		  Soft Declare Function llama_vocab_eos Lib "llama.dll" (vocab As Ptr) As Int32
		  Soft Declare Function llama_sampler_sample Lib "llama.dll" (smpl As Ptr, ctx As Ptr, idx As Int32) As Int32
		  Soft Declare Function llama_token_to_piece Lib "llama.dll" (vocab As Ptr, token As Int32, buf As Ptr, length As Int32, lstrip As Int32, special As Boolean) As Int32
		  Soft Declare Sub llama_sampler_accept Lib "llama.dll" (smpl As Ptr, token As Int32)
		  Soft Declare Sub llama_sampler_free Lib "llama.dll" (smpl As Ptr)
		  
		  Var e As Llama.ModelException
		  
		  ' --- Tokenize the prompt ---
		  Var tokenMB As New MemoryBlock(MaxTokens * 4)  ' 4 bytes per token (Int32)
		  Var tokenPtr As Ptr = tokenMB
		  
		  Var promptUTF8 As String = prompt.ConvertEncoding(Encodings.UTF8)
		  
		  Dim numTokens As Int32 = llama_tokenize(mVocabPtr, promptUTF8, promptUTF8.LenB, tokenPtr, MaxTokens, True, False)
		  If numTokens < 0 Then
		    Var needed As Int32 = -numTokens
		    e = new Llama.ModelException()
		    e.ErrorNumber = Integer(ErrorEnum.TooFewTokens)
		    e.Message = "Token buffer too small, need " + needed.ToString + " tokens."
		    Raise e
		  End If
		  
		  ' ========================
		  ' IMPORTANT: run prompt through llama_decode
		  ' ========================
		  
		  var promptBatch As Llama.Batch
		  promptBatch = llama_batch_get_one(tokenPtr, numTokens, 0 , 0)
		  
		  Dim rc As Int32 = llama_decode(mContextPtr, promptBatch)
		  If rc <> 0 Then
		    e = new Llama.ModelException()
		    e.ErrorNumber = Integer(ErrorEnum.DecodeFailure)
		    e.Message = "llama_decode(prompt) failed with code " + rc.ToString
		    Raise e
		  End If
		  
		  ' ========================
		  ' Generate response
		  ' ========================
		  
		  Const maxTokensToGenerate As Int32 = 2048
		  
		  Var smpl As Ptr = llama_sampler_init_greedy()
		  If smpl = Nil Then
		    e = new Llama.ModelException()
		    e.ErrorNumber = Integer(ErrorEnum.SamplerFailure)
		    e.Message = "Failed to create sampler."
		    Raise e
		  End If
		  
		  Var eosToken As Int32 = llama_vocab_eos(mVocabPtr)
		  
		  ' Reusable 1-token buffer for generation
		  Var genTokenMB As New MemoryBlock(4)  ' Int32
		  Var genTokenPtr As Ptr = genTokenMB
		  
		  Dim result As String = ""
		  
		  For i As Integer = 0 To maxTokensToGenerate - 1
		    
		    ' 1) Sample from logits of last token in context
		    Dim nextToken As Int32 = llama_sampler_sample(smpl, mContextPtr, -1)
		    If nextToken < 0 Then Exit For
		    
		    ' 2) End-of-sequence?
		    If nextToken = eosToken Or nextToken = 0 Then Exit For
		    
		    ' 3) Convert token to text
		    Var buffer As New MemoryBlock(256)
		    Dim pieceLen As Int32 = llama_token_to_piece(mVocabPtr, nextToken, buffer, 256, 0, False)
		    If pieceLen > 0 Then
		      result = result + DefineEncoding(buffer.CString(0), Encodings.UTF8)
		    End If
		    
		    ' 4) Accept token into sampler state
		    llama_sampler_accept(smpl, nextToken)
		    
		    ' 5) Put this token into the 1-element buffer
		    genTokenMB.Int32Value(0) = nextToken
		    
		    ' 6) Build batch for this single token
		    Dim genBatch As Llama.Batch = llama_batch_get_one(genTokenPtr, 1, 0, 0)
		    
		    //' 7) Decode it – extend KV cache with this token
		    rc = llama_decode(mContextPtr, genBatch)
		    If rc <> 0 Then
		      e = new Llama.ModelException()
		      e.ErrorNumber = Integer(ErrorEnum.DecodeFailure)
		      e.Message = "llama_decode(prompt) failed with code " + rc.ToString
		      Raise e
		    End If
		    
		  Next
		  
		  llama_sampler_free(smpl)
		  
		  return result
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		MaxTokens As Int32 = 512
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContextParams As ContextParamsStruct
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContextPtr As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModelParams As ModelParamsStruct
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModelPtr As Ptr
	#tag EndProperty

	#tag Property, Flags = &h0
		ModelPath As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVocabPtr As Ptr
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
