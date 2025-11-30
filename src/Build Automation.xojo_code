#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin SignProjectStep Sign
				  DeveloperID=
				  macOSEntitlements={"App Sandbox":"False","Hardened Runtime":"False","Notarize":"False","UserEntitlements":""}
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyBinaryFiles
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9nZ21sLWNwdS1hbGRlcmxha2UuZGxs
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9nZ21sLWNwdS1oYXN3ZWxsLmRsbA==
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9nZ21sLWNwdS1pY2VsYWtlLmRsbA==
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9nZ21sLWNwdS1zYW5keWJyaWRnZS5kbGw=
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9nZ21sLWNwdS1zYXBwaGlyZXJhcGlkcy5kbGw=
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9nZ21sLWNwdS1za3lsYWtleC5kbGw=
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9nZ21sLWNwdS1zc2U0Mi5kbGw=
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9nZ21sLWNwdS14NjQuZGxs
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9nZ21sLWN1ZGEuZGxs
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9nZ21sLXJwYy5kbGw=
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9saWJjdXJsLXg2NC5kbGw=
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9saWJvbXAxNDAueDg2XzY0LmRsbA==
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9MSUNFTlNFLWN1cmw=
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9MSUNFTlNFLWh0dHBsaWI=
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9MSUNFTlNFLWpzb25ocHA=
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9MSUNFTlNFLWxpbmVub2lzZQ==
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9sbGFtYS5kbGw=
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9tdG1kLmRsbA==
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9nZ21sLmRsbA==
					FolderItem = Li4vLi4vYmluL3dpbi1jdWRhLXg2NC9nZ21sLWJhc2UuZGxs
				End
			End
#tag EndBuildAutomation
