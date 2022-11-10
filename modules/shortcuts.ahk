#Include, %A_ScriptDir%/modules/handlers.ahk

setShortcut(keybind, handler) {
    Hotkey, %keybind%, %handler%, UseErrorLevel
    if (ErrorLevel <> 0) {
        MsgBox, 16,, Error in shortcut binding: %keybind% to handle %handler%.
        Exit
    }
}

i := 0
while i < 10 {
    setShortcut(settings.shortcuts.desktopsModifiers.switcher . i, "onDesktopSwitch")
    setShortcut(settings.shortcuts.desktopsModifiers.moveWindow . i, "onMoveWindow")
    i := i + 1
}

setShortcut(settings.shortcuts.pinWindow, "onPinWindow")

setShortcut(settings.shortcuts.closeWindow, "onCloseWindow")
