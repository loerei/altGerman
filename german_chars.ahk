; AltGerman.ahk
; Press Alt+S => ÃŸ
; Press Alt+U => Ã¼
; Press Alt+O => Ã¶
; Press Alt+A => Ã¤
; Hold Shift or have CapsLock ON to get uppercase (Ã„ Ã– Ãœ and áºž)

#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; --- System Tray Configuration ---
Menu, Tray, NoStandard
Menu, Tray, Add, Show Dashboard, ShowGui
Menu, Tray, Add, Exit, ExitLabel
Menu, Tray, Default, Show Dashboard
Menu, Tray, Tip, AltGerman Active

; Robust Tray Click Hook (Single/Double click to open GUI)
OnMessage(0x404, "AHK_NOTIFYICON")

; --- Startup Registry Check ---
RegRead, StartupVal, HKCU, Software\Microsoft\Windows\CurrentVersion\Run, AltGerman
if (StartupVal != "")
    HasStartup := 1
else
    HasStartup := 0

; --- GUI Dashboard Build ---
Gui +LastFound +AlwaysOnTop -Resize -MaximizeBox -MinimizeBox
Gui Color, 0x141419, 0x22222A  ; Sleek premium dark gray
Gui Font, s11 cFFFFFF Q5, Segoe UI

; Title
Gui Font, s15 bold cFFFFFF
Gui Add, Text, x20 y20 w320 Center, ALTGERMAN

; Status
Gui Font, s10 bold c4CAF50  ; Active Green
Gui Add, Text, x20 y65 w320 Center, STATUS: ACTIVE & RUNNING

; Settings (Centered Checkbox)
Gui Font, s10 norm cFFFFFF
Gui Add, CheckBox, x55 y110 w250 h25 vAutoStart Checked%HasStartup% gToggleStartup, Start automatically with Windows

; Buttons (Clean modern styling)
Gui Add, Button, x30 y165 w140 h35 gHideGui, Minimize to Tray
Gui Add, Button, x190 y165 w140 h35 gExitLabel, Exit Completely

; Start minimized directly in system tray (do not call ShowGui on launch)
return

; --- System Tray Event Handler ---
AHK_NOTIFYICON(wParam, lParam) {
    if (lParam = 0x201 || lParam = 0x203) ; 0x201 = WM_LBUTTONDOWN, 0x203 = WM_LBUTTONDBLCLK
    {
        Gosub, ShowGui
        return 0
    }
}

; --- GUI Event Handlers ---

ShowGui:
    Gui Show, w360 h230, AltGerman
return

HideGui:
    Gui Hide
return

GuiClose:
    Gui Hide
return

ToggleStartup:
    Gui Submit, NoHide
    if (AutoStart) {
        RegWrite, REG_SZ, HKCU, Software\Microsoft\Windows\CurrentVersion\Run, AltGerman, "%A_ScriptFullpath%"
        if (ErrorLevel) {
            MsgBox, 16, Error, Failed to set automatic startup.
        }
    } else {
        RegDelete, HKCU, Software\Microsoft\Windows\CurrentVersion\Run, AltGerman
    }
return

ExitLabel:
    ExitApp
return

; --- Hotkey Bindings ---

IsUpperRequested() {
    return (GetKeyState("Shift", "P") || GetKeyState("CapsLock", "T"))
}

!u::
    if IsUpperRequested()
        SendInput {U+00DC}  ; Ãœ
    else
        SendInput {U+00FC}  ; Ã¼
return

!o::
    if IsUpperRequested()
        SendInput {U+00D6}  ; Ã–
    else
        SendInput {U+00F6}  ; Ã¶
return

!a::
    if IsUpperRequested()
        SendInput {U+00C4}  ; Ã„
    else
        SendInput {U+00E4}  ; Ã¤
return

!s::
    if IsUpperRequested()
        SendInput {U+1E9E}  ; áºž
    else
        SendInput {U+00DF}  ; ÃŸ
return
