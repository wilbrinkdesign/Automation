New-SelfSignedCertificate -CertstoreLocation Cert:\LocalMachine\My -DnsName "WinRMCertificate"
Enable-PSRemoting -SkipNetworkProfileCheck -Force
($cert = gci Cert:\LocalMachine\My\) -and (New-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $cert.Thumbprint -Force)
New-NetFirewallRule -DisplayName 'Windows Remote Management (HTTPS-In)' -Name 'Windows Remote Management (HTTPS-In)' -Profile Any -LocalPort 5986 -Protocol TCP
Set-Item WSMan:\localhost\Service\Auth\Basic -Value $true
Set-Item WSMan:\localhost\Service\AllowUnencrypted $true -Force
Restart-Service WinRM