getN() {
    Local n := substr(A_ThisHotkey, 0, 1)

    if (n = 0) {
        n := 10
    }

    return n
}

createDesktopsIfNeed(n) {
    desktopsCount := VD.getCount()

    while (n > desktopsCount) {
        VD.createDesktop()
        desktopsCount := desktopsCount + 1
    }
}

removeUnusedLastDesktops(n) {
    DetectHiddenWindows On
    WinGet, id, List
    lastUsedDesktop := n
    Loop %id%
    {
        hwnd := id%A_Index%
        ;VD.getDesktopNumOfWindow will filter out invalid windows
        desktopNum_ := VD.getDesktopNumOfWindow("ahk_id" hwnd) ;-1 for invalid window, 0 for "Show on all desktops", 1 for Desktop 1
        If (desktopNum_ > -1) {
            lastUsedDesktop := lastUsedDesktop < desktopNum_ ? desktopNum_ : lastUsedDesktop
        }
    }

    desktopCount := VD.getCount()
    i := lastUsedDesktop
    while (i < desktopCount) {
        VD.removeDesktop(lastUsedDesktop + 1)
        i := i + 1
    }
}

invokePopup(n) {
    if (settings.popup.enable) {
        Popup("Desktop" n)
    }
}
