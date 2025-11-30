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


	#tag Structure, Name = ContextParamsStruct, Flags = &h0
		n_ctx As UInt32
		  n_batch As UInt32
		  n_ubatch As UInt32
		  n_seq_max As UInt32
		  n_threads As Int32
		  n_threads_batch As Int32
		  rope_scaling_type As Int32
		  pooling_type As Int32
		  attention_type As Int32
		  rope_freq_base As Single
		  rope_freq_scale As Single
		  yarn_ext_factor As Single
		  yarn_attn_factor As Single
		  yarn_beta_fast As Single
		  yarn_beta_slow As Single
		  yarn_orig_ctx As UInt32
		  defrag_thold As Single
		  pad0 As Int32
		  cb_eval As Ptr
		  cb_eval_user_data  As Ptr
		  type_k As Int32
		  type_v As Int32
		  abort_callback As Ptr
		  abort_callback_data As Ptr
		  embeddings As Boolean
		  offload_kqv As Boolean
		  flash_attn As Boolean
		  no_perf As Boolean
		  op_offload As Boolean
		  swa_full As Boolean
		  kv_unified As Boolean
		pad1 As Byte
	#tag EndStructure

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
		  ContextFailure = 2
		VocabFailure = 3
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
