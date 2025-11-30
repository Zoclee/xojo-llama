#tag Module
Protected Module Llama
	#tag Method, Flags = &h0
		Sub BackendFree()
		  Soft Declare Sub llama_backend_free Lib "llama.dll" ()
		  
		  llama_backend_free()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BackendInit() As Boolean
		  Soft Declare Function llama_backend_init Lib "llama.dll" () As Boolean
		  Soft Declare Sub ggml_backend_load_all Lib "ggml.dll" ()
		  
		  Var result As Boolean
		  
		  result = llama_backend_init()
		  if result then
		    ggml_backend_load_all()
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Structure, Name = ModelParamsStruct, Flags = &h0
		devices As Ptr
		  tensor_buft_overrides As Ptr
		  n_gpu_layers As Int32
		  split_mode As Int32
		  main_gpu As Int32
		  pad0 As Int32
		  tensor_split As Ptr
		  progress_callback As Ptr
		  progress_callback_user_data As Ptr
		  kv_overrides As Ptr
		  vocab_only As Boolean
		  use_mmap As Boolean
		  use_mlock As Boolean
		  check_tensors As Boolean
		pad1 As String * 4
	#tag EndStructure


	#tag Enum, Name = ErrorEnum, Type = Integer, Flags = &h0
		ModelLoadFailure = 1
	#tag EndEnum


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
End Module
#tag EndModule
