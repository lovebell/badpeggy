set WshShell= WScript.CreateObject("WScript.Shell")
set fso = CreateObject("Scripting.FileSystemObject")
dir = WshShell.CurrentDirectory
set oShLnk = WshShell.CreateShortcut(WshShell.SpecialFolders("Desktop") & "\Bad Peggy.lnk")
oShLnk.TargetPath = dir & "\jre\bin\javaw.exe"
oShLnk.Arguments = "-jar " & """" & dir & "\badpeggy.jar"""
oShLnk.WindowStyle = 1
oShLnk.IconLocation = dir & "\badpeggy.ico"
oShLnk.Description = "Bad Peggy"
oShLnk.WorkingDirectory = dir
oShLnk.Save
WScript.Echo "There should be a shortcut to Bad Peggy available on the desktop now."
