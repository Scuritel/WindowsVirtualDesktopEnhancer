Popup(message) {
    global

    monitorsCount := 1
    local width, height, x, y
    local posX := settings.popup.position.x,
        posY := settings.popup.position.y,
        fontSize := settings.popup.font.size,
        fontColor := settings.popup.font.color,
        fontBold := settings.popup.font.bold,
        fadeIn := settings.popup.durations.fadeIn,
        lifetime := settings.popup.durations.lifetime,
        bgColor := settings.popup.backgroundColor,
        everyMonitor := settings.popup.everyMonitor

    if (everyMonitor) {
        SysGet, monitorsCount, 80
    }

    Loop, %monitorsCount% {
		handler = popupHandler%A_Index%

		SysGet, Workspace, MonitorWorkArea, %A_Index%

		Gui, %handler%:Destroy
		Gui, %handler%:-Caption +ToolWindow +LastFound +AlwaysOnTop
		Gui, %handler%:Color, %bgColor%
		Gui, %handler%:Font, s%fontSize% c%fontColor% w700, Segoe UI
		Gui, %handler%:Add, Text, xp+25 yp+20, %message%
		Gui, %handler%:Show, Hide

		OnMessage(0x201, "closeAllPopups")

		GUI_ID_%A_Index% := WinExist()

        WinGetPos, _, _, width, height
        width += 20
		height += 15

        if (posX = "LEFT") {
            x := WorkspaceLeft
        }
        else if (posX = "RIGHT") {
            x := WorkspaceRight - width
        }
        else {
            x := (WorkspaceRight - WorkspaceLeft - width) / 2
        }

        if (posY = "TOP") {
            y := WorkspaceTop
        }
        else if (posT = "BOTTOM") {
            y := WorkspaceBottom - height
        }
        else {
            y := (WorkspaceBottom - WorkspaceTop - height) / 2
        }

        r1 := width / 5
        r2 := height / 5
        WinSet, Region, 0-0 w%width% h%height% R%r1%-%r2%
        Gui, %handler%:Show, Hide x%x% y%y% w%width% h%height%
		DllCall("AnimateWindow", "UInt", GUI_ID_%A_Index%, "Int", fadeIn, "UInt", "0x00080000")
    }

    SetTimer, closeAllPopups, % -lifetime
}

closeAllPopups() {
global
	Loop, %monitorsCount% {
		DllCall("AnimateWindow", "UInt", GUI_ID_%A_Index%, "Int", settings.popup.durations.fadeOut, "UInt", "0x00090000")

		handler = popupHandler%A_Index%
		Gui, %handler%:Destroy
	}
}
