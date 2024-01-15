@echo off
setlocal enableDelayedExpansion
::
::
:: SteamDeckPostInstallScript script by ryanrudolf and modified by PaladinArcade
:: This is an inspiration from the guide here - https://github.com/baldsealion/Steamdeck-Ultimate-Windows11-Guide
:: This script installs the needed apps and configuration settings for WindowsOnDeck - except the Equalizer and Peace GUI.
:: It does not install the Valve drivers, grab them from the official Steam Deck website and install them - 
:: https://help.steampowered.com/en/faqs/view/6121-ECCD-D643-BAA8
::
:: I still need to learn the autohotkey scripting. For now this utilizes Checkmate AHK scripts.
:: 
:: There are 2 prerequisites for this script to work correctly -
:: 1] Make sure you are connected to the Internet before running this script or else the HIDHide install will fail.
:: 2] Script needs to run with admin rights. Right-click the script and select RunAs Administrator.
::
:: Install steam
mkdir c:\temp
start /wait powershell -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -Command wget https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe -outfile c:\temp\SteamSetup.exe' -Verb RunAs"
echo "Press Enter to Install Steam Client , Once complete close steam and continue with the script"
pause
cmd /min /C "set __COMPAT_LAYER=RUNASINVOKER && start "" "c:\temp\SteamSetup.exe"
::
:: define variables here
:: change the localname and localpassword to match the local Windows account on your system
:: change the newcomputername and change the swapsize accordingly
set newcomputername=steamdeck
set swapsize=4096
::
:: registry edit for autologin - localname:localpassword. uncomment this segment if you want to utilize autologin
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v AutoAdminLogon /t REG_SZ /d 1
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v DefaultUserName /t REG_SZ /d %localname%
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v DefaultPassword /t REG_SZ /d %localpassword%
::
:: registry edit for unbranded boot. uncomment this segment if you want to utilize unbranded boot
::reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Embedded\EmbeddedLogon" /f /v HideAutoLogonUI /t REG_DWORD /d 1
::reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Embedded\EmbeddedLogon" /f /v HideFirstLogonAnimation /t REG_DWORD /d 1
::reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Embedded\EmbeddedLogon" /f /v BrandingNeutral /t REG_DWORD /d 1
::bcdedit -set {globalsettings} bootuxdisabled on
::
:: disable hibernate, import and set power scheme, disable password prompt from sleep mode
powercfg /hibernate off
powercfg /import %~dp0packages\config\steamdeck.pow 11111111-aaaa-bbbb-cccc-111111111111
powercfg /setactive 11111111-aaaa-bbbb-cccc-111111111111
powercfg /setdcvalueindex scheme_current sub_none consolelock 0
powercfg /setacvalueindex scheme_current sub_none consolelock 0
::
:: set swap size
wmic computersystem set AutomaticManagedPagefile=False
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=%swapsize%,MaximumSize=%swapsize%
::
:: change computername
wmic computersystem where name="%computername%" call rename %newcomputername%
::
:: registry import for Time Settings and gamebar
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /f /v RealTimeIsUniversal /t REG_DWORD /d 1
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /f /v TimeZoneKeyName /t REG_SZ /d "Eastern Standard Time"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /f /v AppCaptureEnabled /t REG_DWORD /d 0
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /f /v GameDVR_Enabled /t REG_DWORD /d 0
::
::
:: *** software install begins here ***
::
::
:: perform a silent install - vc++, swicd, tetherscript, vigembus, hidhide, winrar directx
mkdir c:\tools
start "" /wait %~dp0packages\vcpp-aio.exe /y
start "" /wait %~dp0packages\swicd.exe /S
start "" /wait %~dp0packages\tether.exe /verysilent /norestart
start "" /wait %~dp0packages\vigembus.exe /qn /norestart
start "" /wait %~dp0packages\hidhide.exe /qn /norestart
start "" /wait %~dp0packages\7Zip.exe /S
start "" /wait %~dp0packages\directx.exe /q /t:c:\tools\directx
start "" /wait c:\tools\directx\dxsetup.exe /silent
::
:: copy apps that doesnt have silent install to c:\tools - ryzenadj, hwinfo, checkmate_ahk, nircmd
xcopy %~dp0packages\ahk c:\tools\ahk /s /i /y
xcopy %~dp0packages\ryzenadj c:\tools\ryzenadj /s /i /y
xcopy %~dp0packages\nircmd c:\tools\nircmd /s /i /y
::
::
:: *** software configuration begins here ***
::
::
::
:: ahk configuration. 5sec pause as the previous schtask command may not have completed yet
timeout /t 5 > nul
schtasks /create /tn AHK /xml %~dp0packages\config\AHK.xml
::
:: swicd configuraton
call "C:\Program Files (x86)\HID Virtual Device Kit Standard 2.1\Drivers Signed\Gamepad\uninstall.bat"
call "C:\Program Files (x86)\HID Virtual Device Kit Standard 2.1\Drivers Signed\Joystick\uninstall.bat"
mkdir %userprofile%\documents\swicd
copy /y %~dp0packages\config\app_config.json %userprofile%\documents\swicd\app_config.json
::
::
:: hidhide configuration
%~dp0packages\hidhidecli.exe --app-reg "C:\Program Files (x86)\Steam\Steam.exe"
%~dp0packages\hidhidecli.exe --app-reg "C:\Program Files (x86)\Steam\Streaming_client.exe"
%~dp0packages\hidhidecli.exe --app-reg "C:\Program Files (x86)\Steam\GameOverlayUI.exe"
%~dp0packages\hidhidecli.exe --dev-hide "HID\VID_28DE&PID_1205&MI_02\8&3b15de89&0&0000"
%~dp0packages\hidhidecli.exe --inv-on
%~dp0packages\hidhidecli.exe --cloak-on
::
:: all done! reboot for changes to take effect
shutdown /r /c "Windows needs to restart to complete the installation . . ."
