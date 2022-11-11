# Windows Virtual Desktop Enhancer
Run windows-virtual-desktop-enhancer.exe as administrator for better work

## Workdirectory tree
windows-virtual-desktop-enhancer.ahk - main file that contains only includings of other files

#### icons/ - tray icons for virtual desktops

#### modules/
- handlerHelpers.ahk - file with main functions that are using in handler.ahk
- handler.ahk - handlers for keybindings
- popups.ahk - make a popup and close all popups functions, used only in handler.ahk
- setupSettings.ahk - parse settings.json and setup *settings* variable
- tray.ahk - tray managing (changing desktop number icon), used only in handler.ahk

## Special thanks to the authors of open-source projects
- [sdias](https://github.com/sdias/win-10-virtual-desktop-enhancer)
- [FuPeiJiang](https://github.com/FuPeiJiang/VD.ahk)
- [cocobelgica](https://github.com/cocobelgica/AutoHotkey-JSON)
