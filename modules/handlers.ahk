#Include, %A_ScriptDir%/modules/popups.ahk
#Include, %A_ScriptDir%/modules/handlerHelpers.ahk


; VD.createUntil(3)
onDesktopSwitch() {
    n := getN()
    onDesktopSwitchN(n)
}
onDesktopSwitchN(n) {
    createDesktopsIfNeed(n)
    VD.goToDesktopNum(n)
    ChangeTrayText(n)
    invokePopup(n)
    removeUnusedLastDesktops(n)
}

onMoveWindow() {
    n := getN()
    createDesktopsIfNeed(n)
    VD.MoveWindowToDesktopNum("A", n)
}

onPinWindow() {
    VD.TogglePinWindow("A")
}

onCloseWindow() {
    WinGetTitle, Title, A
    PostMessage, 0x112, 0xF060,,, %Title%
}
