### Export-Clixml

Encrypt plain text credentials with Export-Clixml in scripts. It is important to notice that you should run the Export-Clixml command on the server with the user that will run your script. Export-Clixml uses the combination of both the server and the users password to encrypt the XML-based file. This way you can only decrypt the file on the server with that specific user.

#### Example

1. You want to encrypt the credentials of a local account **CLIENT01\Admin** which u use to create a drive mapping with
2. Your server that hosts the script is **SRV01**
3. The user that runs the script is **SERVICEACC01**

**Example: Run PowerShell as user SERVICEACC01 on SRV01**

```powershell
# In the pop-up window you want to provide the credentials of CLIENT01\Admin
Get-Credential | Export-Clixml -Path <encrypted_credentials>.<xml/cred/sec> # Extension doesn't matter
```

**Example: Decrypt the credentials on SRV01 with user SERVICEACC01**

```powershell
$Cred = Import-Clixml <encrypted_credentials>.<xml/cred/sec>
```

**Example: Use the credentials to make a drive mapping**

```powershell
New-PSDrive -Name <name> -Root <destination> -PSProvider "FileSystem" -Credential $Cred
```
