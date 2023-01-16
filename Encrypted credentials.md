### Encrypt your credentials with Export-Clixml and export to a XML-based file

**Example: Script will run on SERVER01 under the user SVC_USER01. Start PowerShell => SERVER01 => Run as SVC_USER01 => Run command below**

```powershell
Get-Credential | Export-Clixml -Path <encrypted_credentials>.<xml/cred/sec> # Extension doesnt matter
```

**Example: To decrypt the credentials, you must run the script on the same server under the same user.**

```powershell
$Cred = Import-Clixml <encrypted_credentials>.<xml/cred/sec>
```

**Example: Use the credentials to make a drive mapping.**

```powershell
New-PSDrive -Name <name> -Root <destination> -PSProvider "FileSystem" -Credential $Cred
```
