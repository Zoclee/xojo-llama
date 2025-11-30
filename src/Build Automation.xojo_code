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
				Begin CopyFilesBuildStep CopyLlamaBinFiles
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vLi4vYmluL2dnbWwtY3B1LXNhbmR5YnJpZGdlLmRsbA==
					FolderItem = Li4vLi4vYmluL2dnbWwtY3B1LXNhcHBoaXJlcmFwaWRzLmRsbA==
					FolderItem = Li4vLi4vYmluL2dnbWwtY3B1LXNreWxha2V4LmRsbA==
					FolderItem = Li4vLi4vYmluL2dnbWwtY3B1LXNzZTQyLmRsbA==
					FolderItem = Li4vLi4vYmluL2dnbWwtY3B1LXg2NC5kbGw=
					FolderItem = Li4vLi4vYmluL2dnbWwtY3VkYS5kbGw=
					FolderItem = Li4vLi4vYmluL2dnbWwtcnBjLmRsbA==
					FolderItem = Li4vLi4vYmluL2xpYmN1cmwteDY0LmRsbA==
					FolderItem = Li4vLi4vYmluL2xpYm9tcDE0MC54ODZfNjQuZGxs
					FolderItem = Li4vLi4vYmluL0xJQ0VOU0UtY3VybA==
					FolderItem = Li4vLi4vYmluL0xJQ0VOU0UtaHR0cGxpYg==
					FolderItem = Li4vLi4vYmluL0xJQ0VOU0UtanNvbmhwcA==
					FolderItem = Li4vLi4vYmluL0xJQ0VOU0UtbGluZW5vaXNl
					FolderItem = Li4vLi4vYmluL2xsYW1hLmRsbA==
					FolderItem = Li4vLi4vYmluL210bWQuZGxs
					FolderItem = Li4vLi4vYmluL2dnbWwuZGxs
					FolderItem = Li4vLi4vYmluL2dnbWwtYmFzZS5kbGw=
					FolderItem = Li4vLi4vYmluL2dnbWwtY3B1LWFsZGVybGFrZS5kbGw=
					FolderItem = Li4vLi4vYmluL2dnbWwtY3B1LWhhc3dlbGwuZGxs
					FolderItem = Li4vLi4vYmluL2dnbWwtY3B1LWljZWxha2UuZGxs
				End
			End
#tag EndBuildAutomation
