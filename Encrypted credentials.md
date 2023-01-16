### Export-Clixml

Export-Clixml makes it possible to encrypt your plain text credentials in scripts. It is important to notice that you should run the Export-Clixml command on the server with the user that will run your script. Export-Clixml uses the combination of both the server name and username to encrypt the file. This way you can only decrypt the XML-based file on the server with that specific user.

**Example: Run PowerShell as user SVC_USER01 on SERVER01.**

```powershell
Get-Credential | Export-Clixml -Path <encrypted_credentials>.<xml/cred/sec> # Extension doesnt matter
```

**Example: To decrypt the credentials, you must run the script on the same server (SERVER01) under the same user (SVC_USER01).**

```powershell
$Cred = Import-Clixml <encrypted_credentials>.<xml/cred/sec>
```

**Example: Use the credentials to make a drive mapping.**

```powershell
New-PSDrive -Name <name> -Root <destination> -PSProvider "FileSystem" -Credential $Cred
```
