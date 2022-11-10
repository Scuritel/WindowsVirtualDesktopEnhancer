#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
ListLines Off
SetBatchLines -1
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#KeyHistory 0
#WinActivateForce

Process, Priority,, H

SetWinDelay -1
SetControlDelay -1

; DetectHiddenWindows, On


#Include, %A_ScriptDir%/VD.ahk/VD.ahk

#Include, %A_ScriptDir%/modules/setupSettings.ahk

#Include, %A_ScriptDir%/modules/shortcuts.ahk

#Include, %A_ScriptDir%/modules/tray.ahk

; TODO: tray icon
