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

RmvDuplic(object) {
    secondobject:=[]
    Loop % object.Length()
    {
        value:=Object.RemoveAt(1) ; otherwise Object.Pop() a little faster, but would not keep the original order
        Loop % secondobject.Length()
            If (value=secondobject[A_Index])
                Continue 2 ; jump to the top of the outer loop, we found a duplicate, discard it and move on
        secondobject.Push(value)
    }
    return secondobject
}

getUsedDesktops() {
    DetectHiddenWindows On
    WinGet, id, List
    ud := []
    Loop %id%
    {
        hwnd := id%A_Index%
        ;VD.getDesktopNumOfWindow will filter out invalid windows
        desktopNum_ := VD.getDesktopNumOfWindow("ahk_id" hwnd) ;-1 for invalid window, 0 for "Show on all desktops", 1 for Desktop 1
        If (desktopNum_ > -1) {
            ud.Push(desktopNum_)
        }
    }
    return RmvDuplic(ud)
}

removeUnusedLastDesktops(n) {
    usedDesktops := getUsedDesktops()
    mx := Max(usedDesktops*)
    desktopCount := VD.getCount()
    lastUsedDesktop := mx > n ? mx : n
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
