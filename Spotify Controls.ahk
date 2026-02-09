#Requires AutoHotkey v2.0
#SingleInstance Force
InstallKeybdHook()

if not A_IsAdmin
{
    try
    {
        Run "*RunAs `"" A_ScriptFullPath "`""
    }
    ExitApp
}

; Only activate if Spotify is running (checks for the process)
#HotIf ProcessExist("Spotify.exe")

Media_Next::
Media_Prev::
Media_Play_Pause::
{
    try {
        DetectHiddenWindows(true)
        spotify_hwnds := WinGetList("ahk_class Chrome_WidgetWin_1 ahk_exe Spotify.exe")
        if (spotify_hwnds.Length > 0)
        {
            switch A_ThisHotkey
            {
                case "Media_Next":       cmd := 720896
                case "Media_Prev":       cmd := 786432
                case "Media_Play_Pause": cmd := 917504
            }
            
            for hwnd in spotify_hwnds
            {
                PostMessage(0x319, 0, cmd, , "ahk_id " . hwnd)
            }
        }
        else
        {
            Send("{" . A_ThisHotkey . "}")
        }
    } catch {
        Send("{" . A_ThisHotkey . "}")
    }
}
#HotIf
