### Install Ansible on CentOS

```bash
yum -y update
yum -y install epel-release
yum -y install ansible
```

### Install Ansible dependencies on CentOS for Windows Kerberos

```bash
ansible-galaxy collection install community.windows
yum -y install python-kerberos python-devel krb5-devel krb5-libs krb5-workstation pam_krb5
sudo pip install kerberos requests_kerberos
```

### Install Ansible on Windows Server

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
wsl --install Ubuntu-18.04
sudo apt update
sudo apt install ansible
```