strComputer = "."
set objWMI = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
set colOS = objWMI.InstancesOf("Win32_OperatingSystem")
for each objOS in colOS
strReturn = "�ڴ�����: " &  round(objOS.TotalVisibleMemorySize / 1024) & " MB" & vbCrLf &"�ڴ������: " & round(objOS.FreePhysicalMemory / 1024) & " MB" & vbCrLf &"�ڴ�ʹ���� :" & Round(((objOS.TotalVisibleMemorySize-objOS.FreePhysicalMemory)/objOS.TotalVisibleMemorySize)*100) & "%"
Wscript.Echo strReturn
next