Menu, Tray, NoStandard
Menu, Tray, Add, Reload Settings, Reload
Menu, Tray, Add, Exit, Exit
Menu, Tray, Click, 1

ChangeTrayText(n) {
    Menu, Tray, Tip, % "Desktop" n
    if (FileExist("./icons/" . n ".ico")) {
        Menu, Tray, Icon, icons/%n%.ico
    }
    else {
        Menu, Tray, Icon, icons/+.ico
    }
}

Reload() {
    Reload
}

Exit() {
    ExitApp, 0
}


ChangeTrayText(VD.getCurrentDesktopNum())
