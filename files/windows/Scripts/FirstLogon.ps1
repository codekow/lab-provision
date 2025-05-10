Set-PSDebug -Trace 1
#####################################
# Perform some basic configurations #
#####################################

Write-Host "Performing some basic configurations"
# Configure legacy control panel view
Start-Process reg -Wait -ArgumentList 'add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v StartupPage /t REG_DWORD /d 1 /f'
# Modify control panel icon size
Start-Process reg -Wait -ArgumentList 'add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v AllItemsIconView /t REG_DWORD /d 0 /f'
# Remove automatic admin login
Start-Process reg -Wait -ArgumentList 'add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 0 /f'
# Disable Windows SmartScreen Filter
Start-Process reg -Wait -ArgumentList 'add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /t REG_DWORD /d 0 /f'
# Prevent password expiration
Start-Process wmic -Wait -ArgumentList 'useraccount where name="Administrator" set PasswordExpires=false'

Write-Host "Installing additional drivers"
# Install all remaining VirtIO drivers
Start-Process msiexec -Wait -ArgumentList '/i e:\virtio-win-gt-x64.msi /qn /passive /norestart'
# Install qemu Guest Agent
Start-Process msiexec -Wait -ArgumentList '/i e:\guest-agent\qemu-ga-x86_64.msi /qn /passive /norestart'

Write-Host "Enabling RDP"
# Enable RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

#####################################
# Perform custom post-install steps #
#####################################

Write-Host "Performing custom setup"

#####################################
# Finalize installation via sysprep #
#####################################

Write-Host "Finalizing"
# Prevent picking up old autounattend.xml
mv C:\Windows\Panther\unattend.xml C:\Windows\Panther\unattend.install.xml
# Eject disk to prevent additional sysprep pickup
(New-Object -COM Shell.Application).NameSpace(17).ParseName('F:').InvokeVerb('Eject')

# Perform full sysprep
# C:\Windows\System32\Sysprep\sysprep.exe /generalize /oobe /shutdown /mode:vm
# Just shut down
Start-Process shutdown -ArgumentList '/s /f /t 5'
