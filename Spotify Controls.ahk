#Requires AutoHotkey v2.0
#SingleInstance Force

; Only activate if Spotify is running (checks for the process)
#HotIf ProcessExist("Spotify.exe")

Media_Next::
Media_Prev::
Media_Play_Pause::
{
    try {
        DetectHiddenWindows(true)
        if WinExist("ahk_exe Spotify.exe")
        {
            switch A_ThisHotkey
            {
                case "Media_Next":       PostMessage(0x319, 0, 720896, , "ahk_exe Spotify.exe")
                case "Media_Prev":       PostMessage(0x319, 0, 786432, , "ahk_exe Spotify.exe")
                case "Media_Play_Pause": PostMessage(0x319, 0, 917504, , "ahk_exe Spotify.exe")
            }
        }
        else
        {
            ; Fallback if window not found despite process existing
            Send("{" . A_ThisHotkey . "}")
        }
    } catch {
        Send("{" . A_ThisHotkey . "}")
    }
}
#HotIf
