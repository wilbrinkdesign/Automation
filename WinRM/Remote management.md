### Session with certificate

```powershell
$Cred = Get-Credential
Enter-PSSession -ComputerName "<server>" -Credential $Cred -UseSSL
```

### Session with certificate without check

```powershell
$options = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck
Enter-PSSession -ComputerName "<server>" -UseSSL -Credential $Cred -SessionOption $options
```

### Session Kerberos authentication

```powershell
Enter-PSSesion -ComputerName "<server>"
```