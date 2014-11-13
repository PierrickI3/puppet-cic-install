#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; =============================
; Wait for the reporting screen
; =============================
WinWait, IC Setup Assistant, Choose a reporting option, 300
IfWinNotActive, IC Setup Assistant, , WinActivate, IC Setup Assistant, 
WinWaitActive, IC Setup Assistant, 

; ================
; Enable reporting
; ================
Send {down}

; =====
; Next!
; =====
Send {tab}{tab}{space}