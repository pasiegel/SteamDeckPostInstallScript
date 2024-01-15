# SteamDeckPostInstallScript

## About
This repository contains the script, packages and configs I use to automate the WindowsOnDeck installation guide.

This is an inspiration from the post install script localted here [Original SteamDeckPostInstallScript.](https://github.com/ryanrudolfoba/SteamDeckPostInstallScript) This script installs the needed apps and configuration settings for WindowsOnDeck.

I would suggest to visit the [SteamDeck guide](https://github.com/baldsealion/Steamdeck-Ultimate-Windows11-Guide) first, as after running this script your SteamDeck will behave similar to the guide. I still need to learn the autohotkey scripting. For now this utilizes Checkmate AHK scripts.

It also does not install the Valve drivers due to the size of the package. Grab them from the [official Steam Deck website](https://help.steampowered.com/en/faqs/view/6121-ECCD-D643-BAA8) and install them.

## What the Script Does?
1. Sets steamdeck:deck for autologin (optional, disabled by default)
2. Configures unbranded boot (optional, disabled by default)
3. Disables hibernate and disables password prompt from wakeup when plugged in or when running in battery
4. Imports and sets active the SteamDeck power profile. If you dont want this power profile you can go back to the Default Balanced Profile
5. Sets the computername to steamdeck512g (you can change this to a different computername that you prefer)
6. Sets the pagefile to 4GB (4GB (4096) seems fine, you can change this to 8GB (8192) or 16GB (16384) but based on my testing 4GB is OK)
7. Sets time zone to Eastern Time Zone
8. Disables XBOX gamebar DVR to prevent pop-up warning when using SWICD
9. Automatically configures HIDHIDE to disable / hide the Neptune controller from Steam.
10. Sets scheduled tasks Checkmate_hotkeys

## What Applications / Programs Does it Install?
This script automatically installs this programs -
1. AIO Visual C++ runtime - [click here for more details](https://github.com/abbodi1406/vcredist)
2. DirectX Runtime - [click here for more details](https://www.microsoft.com/en-us/download/details.aspx?id=8109)
3. SWICD - [click here for more details](https://github.com/mKenfenheuer/steam-deck-windows-usermode-driver)
4. Tetherscript - [click here for more details](https://tetherscript.com/hid-driver-kit-download/)
5. VIGEM - [click here for more details](https://github.com/ViGEm/ViGEmBus)
6. HIDHIDE - [click here for more details](https://github.com/ViGEm/HidHide)
7. 7-zip - [click here for more details](https://7-zip.org/)
8. ryzenadj - [click here for more details](https://github.com/FlyGoat/RyzenAdj)
9. nircmd - [click here for more details](https://www.nirsoft.net/utils/nircmd.html)
10. Steam - [click here for more details](https://store.steampowered.com/about/)

## Pre-requisites - What is needed for this to run correctly?
1. Make sure you are connected to the Internet before running this script or else the HIDHide install will fail.
2. Script needs to run with admin rights. Right-click the script and select RunAs Administrator.

## How to Use the Script
1. Download and extract the zip archive to a common folder (example c:\temp).
2. Right-click the filename called SteamDeckPostInstallScript.bat and select RunAs Administrator.
3. Wait until the script finishes and it will reboot automatically to apply the changes.
4. There is one thing that needs manual intervetion. When the install for Tetherscript pops-up, press the Install button.

### Screenshot for reference
![tetherscript](https://user-images.githubusercontent.com/98122529/201535455-2895bf32-7a98-4acc-b4b1-e7512d543154.png)

## HIDHIDE Configuration
The script assumes that Steam is installed in C:\ProgramFiles(x86)\Steam. If Steam is installed elsewhere then HIDHIDE needs to be reconfigured. If Steam is installed in the default location C:\ProgramFiles(x86)\Steam, then no action is needed.
1. Open the HIDHIDE desktop shortcut.
2. Press the + sign, and then browse to where Steam.exe is located.
3. Press the + sign again and then browse to where GameOverlayUI.exe and Streaming_Client.exe are located.
4. Once done, close HIDHIDE.

### Screenshot for reference
![image](https://user-images.githubusercontent.com/98122529/201547049-34b1f28d-02a3-44d7-9e61-5ef88098c97f.png)

## SWICD Keymapping Reference
**STEAM + X** = CTL+WIN+O / Toggle On Screen Keyboard  
**STEAM + B** = ALT+F4 / Close current open window / application  
**STEAM + Y** = ALT+TAB / Toggle between windows  
**STEAM + A** = CTL+SHIFT+ESC / Launch Task Manager  
**STEAM + (LEFT DPAD)** = Show Current TDP  
**STEAM + (UP DPAD)** = Increase TDP by 1W  
**STEAM + (RIGHT DPAD)** = Reset TDP to default 15W  
**STEAM + (DOWN DPAD)** = Decrease TDP by 1W  
**STEAM + L5** = Toggle Lizard Mode  
**STEAM + R5** = Toggle emulation of X360 controller  
**STEAM + LB** = Mouse backward button  
**STEAM + RB** = Mouse forward button  
**STEAM + (...)** = Launch Windows Control Center  
**(...) + LB** = Decrease brightness by 10%  
**(...) + RB** = Increase brightness by 10%  
**(...) + R5** = ALT+ENTER / Toggle App Full Screen  
**(...) + L5** = F11 / Toggle Browser Full Screen  
**(...) + (UP DPAD)** = Toggle FSR scaling  
**(...) + (LEFT DPAD)** = Set Refresh Rate to 40Hz  
**(...) + (DOWN DPAD)** = Toggle RTSS On Screen Display  
**(...) + (RIGHT DPAD)** = Set Refresh Rate to 60Hz  

### Screenshot for reference
![image](https://user-images.githubusercontent.com/98122529/201567368-4839d4f9-0472-4dfa-b564-47be2b07f8ec.png)
![image](https://user-images.githubusercontent.com/98122529/201567407-f39e2a42-662e-4279-a626-183b6420855e.png)
