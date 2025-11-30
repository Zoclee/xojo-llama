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


End Module
#tag EndModule
