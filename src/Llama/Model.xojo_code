#tag Class
Protected Class Model
	#tag Method, Flags = &h0
		Sub Constructor(initModelPath As FolderItem)
		  Soft Declare Sub llama_model_default_params Lib "llama.dll" (ByRef params As Llama.ModelParamsStruct)
		  Soft Declare Function llama_load_model_from_file Lib "llama.dll" (path As CString, ByRef params As Llama.ModelParamsStruct) As Ptr
		  Soft Declare Sub llama_context_default_params Lib "llama.dll" (Byref params As Llama.ContextParamsStruct)
		  Soft Declare Function llama_new_context_with_model Lib "llama.dll" (model As Ptr, ByRef params As Llama.ContextParamsStruct) As Ptr
		  
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
