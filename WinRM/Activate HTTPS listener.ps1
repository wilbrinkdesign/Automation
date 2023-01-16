Param(
	[int]$ExpireAfter = 12,
	[switch]$Force
)

$FQDN = [System.Net.Dns]::GetHostByName($env:computerName).HostName
$Cert = Get-ChildItem -Path Cert:\LocalMachine\My\ | Where-Object { $_.Subject -like "CN=$FQDN" -and $_.NotAfter -gt (Get-Date) } | Sort-Object NotAfter -Descending | Select-Object -First 1
$HTTPSListener = Try { Get-WSManInstance winrm/config/listener -SelectorSet @{Transport='HTTPS'; Address='*'} } Catch {}

If ($Cert.Thumbprint -eq $HTTPSListener.CertificateThumbprint -and !$Force)
{
	Write-Host "HTTPS listener already configured with cert and activated. Nothing to do." -ForegroundColor Green
}
ElseIf ($HTTPSListener -and !$Force)
{
	Write-Host "HTTPS listener already activated. Nothing to do." -ForegroundColor Green
}
Else
{
	If ($Cert)
	{
		Write-Host "Valid cert found. This cert will be bind to the HTTPS listener..." -ForegroundColor Green
	}
	Else
	{
		Write-Host "No (valid) cert was found. Creating self-signed cert to bind to the HTTPS listener..." -ForegroundColor Yellow
		$Cert = New-SelfSignedCertificate -CertStoreLocation Cert:\LocalMachine\My -DnsName $FQDN -NotAfter (Get-Date).AddMonths($ExpireAfter)
	}

	Write-Host "Enable-PSRemoting..." -ForegroundColor Yellow
	Enable-PSRemoting -SkipNetworkProfileCheck -Force

	If (!$HTTPSListener)
	{
		Write-Host "Create HTTPS listener en bind new self-signed cert..." -ForegroundColor Yellow
		New-WSManInstance winrm/config/listener -SelectorSet @{Transport='HTTPS'; Address='*'} -ValueSet @{Hostname=$FQDN;CertificateThumbprint=$Cert.Thumbprint} | Out-Null
	} 
	Else
	{
		Write-Host "Bind cert to existing HTTPS listener..." -ForegroundColor Yellow
		Set-WSManInstance winrm/config/listener -SelectorSet @{Transport="HTTPS"; Address="*"} -ValueSet @{Hostname=$FQDN;CertificateThumbprint=$Cert.Thumbprint} | Out-Null
	}

	Write-Host "Create firewall rule: Windows Remote Management (HTTPS-In)" -ForegroundColor Yellow
	if (!(Get-NetFirewallRule -DisplayName "Windows Remote Management (HTTPS-In)" -ErrorAction SilentlyContinue))
	{
		New-NetFirewallRule -DisplayName "Windows Remote Management (HTTPS-In)" -Name "Windows Remote Management (HTTPS-In)" -Profile Any -LocalPort 5986 -Protocol TCP
	}

	Write-Host "Restart WinRM..." -ForegroundColor Yellow
	Restart-Service WinRM -Force
}
