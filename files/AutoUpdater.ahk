#Requires AutoHotkey v2.0

AdvancedHotkeysPath := IniRead("info.ini", "locations", "ScriptPath", "notfound")
FileDelete "info.ini"
if AdvancedHotkeysPath = "notfound"
{
	msgbox "Unable to find the path of the application."
	ExitApp
}
Try FileDelete AdvancedHotkeysPath
Catch
{
	msgbox "Unable to delete the old version."
	ExitApp
}
whr := ComObject("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://raw.githubusercontent.com/Incinerate93/shc-de-advanced-hotkeys/main/info/version", true)
whr.Send()
whr.WaitForResponse()
LatestVersion := StrReplace(whr.ResponseText, "`n", "")	
Download "https://raw.githubusercontent.com/Incinerate93/shc-de-advanced-hotkeys/refs/heads/main/versions/" LatestVersion "/SHC DE Advanced Hotkeys", AdvancedHotkeysPath
msgbox "Update successfull, the application will now reload."
Run "*RunAs " AdvancedHotkeysPath
ExitApp