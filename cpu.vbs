On Error Resume Next
Set objProc  = GetObject("winmgmts:\\.\root\cimv2:win32_processor='cpu0'")
Wscript.Echo "CPU ’º”√¬ £∫" & objProc.LoadPercentage & "%"