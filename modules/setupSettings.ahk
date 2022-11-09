#Include, %A_ScriptDir%/AutoHotkey-JSON/Jxon.ahk

HasVal(haystack, needle) {
	if !(IsObject(haystack)) || (haystack.Length() = 0)
		return 0
	for index, value in haystack
		if (value = needle)
			return index
	return 0
}

normModifiers(str, defValue) {
    arrayS := Object(),                     arrayR := Object()
    arrayS.Insert("\s*|,"),                 arrayR.Insert("")
    arrayS.Insert("L(Ctrl|Shift|Alt|Win)"), arrayR.Insert("<$1")
    arrayS.Insert("R(Ctrl|Shift|Alt|Win)"), arrayR.Insert(">$1")
    arrayS.Insert("Ctrl"),                  arrayR.Insert("^")
    arrayS.Insert("Shift"),                 arrayR.Insert("+")
    arrayS.Insert("Alt"),                   arrayR.Insert("!")
    arrayS.Insert("Win"),                   arrayR.Insert("#")

    splitted := StrSplit(str, "+")
    out := ""

    for index, value in splitted {
        good := false
        for i in arrayS {
            if (RegExMatch(Haystack, NeedleRegEx [, UnquotedOutputVar = "", StartingPos = 1]) <> 0) {
                good := true
                splitted[index] := RegExReplace(splitted[index], arrayS[i], arrayR[i])
            }
        }
        if (not good) {
            return defValue
        }
        out .= splitted[index]
    }

    return out
}

filename := A_ScriptDir . "/settings.json"

FileRead, fileJxon, %filename%

global settings := Jxon_Load(fileJxon)

; pos  LEFT/CENTER/RIGHT and TOP/CENTER/BOTTOM
; modifiers Win, Shift, Ctrl, LAlt, RAlt

defSettingsStr = 
(
{
    "popup": {
        "position": {
            "x": "CENTER",
            "y": "CENTER"
        },
        "font": {
            "size": 11,
            "color": "0xFFFFFF",
            "bold": true
        },
        "durations": {
            "fadeIn": 20,
            "lifetime": 80,
            "fadeOut": 70
        },
        "backgroundColor": "0x1F1F1F",
        "everyMonitor": false
    },
    
    "shortcuts": {
        "desktopsModifiers": {
            "switcher": "Win",
            "moveWindow": "Win+Shift"
        },
        "pinWindow": "Win+Shift+F"
    }
}
)

defaultSettings := Jxon_Load(defSettingsStr)

; TODO: check color vals
if settings.HasKey("popup") {
    if settings.popup.HasKey("position") {
        if not HasVal(["LEFT", "CENTER", "RIGHT"], settings.popup.position.x) {
            settings.popup.position.x := defaultSettings.popup.position.x
        }
        if not HasVal(["TOP", "CENTER", "BOTTOM"], settings.popup.position.y) {
            settings.popup.position.y := defaultSettings.popup.position.y
        }
    }
    else {
        settings.popup.position := defaultSettings.popup.position
    }

    if settings.popup.HasKey("font") {
        if not settings.popup.HasKey("size") or settings.popup.font.size is not integer {
            settings.popup.font.size := defaultSettings.popup.font.size
        }
        if not settings.popup.HasKey("color") {
            settings.popup.font.color := defaultSettings.popup.font.color
        }
        if not settings.popup.HasKey("bold") or not HasVal([false, true], settings.popup.font.bold) {
            settings.popup.font.bold := defaultSettings.popup.font.bold
        }
    }
    else {
        settings.popup.font := defaultSettings.popup.font
    }

    if not settings.popup.HasKey("backgroundColor") {
        settings.popup.backgroundColor := defaultSettings.popup.backgroundColor
    }
    if not settings.popup.HasKey("everyMonitor") or HasVal([false, true], settings.popup.everyMonitor) {
        settings.popup.everyMonitor := defaultSettings.popup.everyMonitor
    }
}
else {
    settings.popup := defaultSettings.popup
}

if settings.HasKey("shortcuts") {
    if settings.shortcuts.HasKey("desktopsModifiers") {
        settings.shortcuts.desktopsModifiers.switcher := normModifiers(settings.shortcuts.desktopsModifiers.switcher, defaultSettings.shortcuts.desktopsModifiers.switcher)
        settings.shortcuts.desktopsModifiers.moveWindow := normModifiers(settings.shortcuts.desktopsModifiers.moveWindow, defaultSettings.shortcuts.desktopsModifiers.moveWindow)
        ; TODO: check pin window shortcut
    }
    else {
        settings.shortcuts.desktopsModifiers := defaultSettings.shortcuts.desktopsModifiers
    }
}
else {
    settings.shortcuts := defaultSettings.shortcuts
}
