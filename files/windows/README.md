# Windows

## Easy Download

- https://massgrave.dev/windows_11_links

## Ansible on Windows

- https://woshub.com/ansible-manage-windows-machines/

## Windows Install

- https://github.com/rh-dttl-edge-virt-demo/edge-virt/blob/main/applications/windows-10-image/templates/autounattend.yaml
- https://github.com/robifis/AI_Windows-Install
- https://pureinfotech.com/windows-11-installation-unsupported-hardware-unattended-answer-file/
- https://github.com/larsks/windows-openstack-image

## Autounattend XML generator

Configured:

[autounattend.xml (Dark Mode)](https://schneegans.de/windows/unattend-generator/view/?LanguageMode=Unattended&UILanguage=en-US&Locale=en-US&Keyboard=00000409&UseKeyboard2=true&Locale2=es-US&Keyboard2=0000040a&GeoLocation=244&ProcessorArchitecture=amd64&BypassNetworkCheck=true&ComputerNameMode=Random&CompactOsMode=Never&TimeZoneMode=Implicit&PartitionMode=Unattended&PartitionLayout=GPT&EspSize=300&RecoveryMode=Partition&RecoverySize=1000&DiskAssertionMode=Skip&WindowsEditionMode=Generic&WindowsEdition=pro&UserAccountMode=Unattended&AccountName0=Admin&AccountDisplayName0=&AccountPassword0=&AccountGroup0=Administrators&AccountName1=User&AccountDisplayName1=&AccountPassword1=&AccountGroup1=Users&AutoLogonMode=Own&PasswordExpirationMode=Unlimited&LockoutMode=Default&HideFiles=None&ShowFileExtensions=true&ClassicContextMenu=true&TaskbarSearch=Hide&TaskbarIconsMode=Default&DisableWidgets=true&LeftTaskbar=true&DisableBingResults=true&StartTilesMode=Empty&StartPinsMode=Empty&DisableFastStartup=true&EnableRemoteDesktop=true&HardenSystemDriveAcl=true&DisableLastAccess=true&DisableAppSuggestions=true&HideEdgeFre=true&DisableEdgeStartupBoost=true&DeleteWindowsOld=true&EffectsMode=Default&DesktopIconsMode=Custom&IconHome=true&IconNetwork=true&IconThisPC=true&WifiMode=Skip&ExpressSettings=DisableAll&KeysMode=Configure&CapsLockInitial=Off&CapsLockBehavior=Toggle&NumLockInitial=Off&NumLockBehavior=Toggle&ScrollLockInitial=Off&ScrollLockBehavior=Toggle&ColorMode=Custom&SystemColorTheme=Dark&AppsColorTheme=Dark&AccentColor=%230078d4&AccentColorOnBorders=true&EnableTransparency=true&WallpaperMode=Default&Remove3DViewer=true&RemoveBingSearch=true&RemoveClipchamp=true&RemoveCopilot=true&RemoveCortana=true&RemoveDevHome=true&RemoveMailCalendar=true&RemoveMaps=true&RemoveMediaFeatures=true&RemoveMixedReality=true&RemoveZuneVideo=true&RemoveNews=true&RemoveOneSync=true&RemovePowerAutomate=true&RemoveSkype=true&RemoveSolitaire=true&RemoveStepsRecorder=true&RemoveStickyNotes=true&RemoveWallet=true&RemoveWeather=true&RemoveXboxApps=true&DefaultUserScript0=%3A%3A+This+will+restore+the+classic+right+click+menu%0D%0Areg+add+HKU%5CDefaultUser%5CSoftware%5CClasses%5CCLSID%5C%7B86ca1aa0-34aa-4e8b-a509-50c905bae2a2%7D%5CInprocServer32+%2Ff+%2Fve%0D%0A%0D%0A%3A%3A+This+will+make+the+taskbar+less+like+Apple%0D%0Areg+add+HKU%5CDefaultUser%5CSoftware%5CMicrosoft%5CWindows%5CCurrentVersion%5CExplorer%5CAdvanced+%2Fv+TaskbarAl+%2Ft+REG_DWORD+%2Fd+0+%2Ff%0D%0A%0D%0A%3A%3A+This+will+remove+fun+facts+tips+and+more+on+the+lock+screen%0D%0Areg+add+HKU%5CDefaultUser%5CSoftware%5CMicrosoft%5CWindows%5CCurrentVersion%5CContentDeliveryManager+%2Fv+RotatingLockScreenOverlayEnabled+%2Ft+REG_DWORD+%2Fd+0+%2Ff%0D%0Areg+add+HKU%5CDefaultUser%5C%5CSoftware%5CMicrosoft%5CWindows%5CCurrentVersion%5CContentDeliveryManager+%2Fv+SubscribedContent-338387Enabled+%2Ft+REG_DWORD+%2Fd+0+%2Ff&DefaultUserScriptType0=Cmd&WdacMode=Skip)

## Create autounattend ISO

```sh
mkdir config
cp autounattend.xml config/

mkisofs -o win-config.iso -J -r config
```
