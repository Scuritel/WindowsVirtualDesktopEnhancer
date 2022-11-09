#Include, %A_ScriptDir%/modules/popups.ahk

getN() {
    Local n := substr(A_ThisHotkey, 0, 1)

    if (n = 0) {
        n := 10
    }

    return n
}

; VD.createUntil(3)
onDesktopSwitch() {
    n := getN()
    invokePopup(n)
    VD.goToDesktopNum(n)
}

onMoveWindow() {
    n := getN()
    VD.MoveWindowToDesktopNum("A", n)
}

onPinWindow() {
    VD.TogglePinWindow("A")
}

invokePopup(n) {
    if (settings.popup.enable) {
        Popup("Desktop" n)
    }
}
