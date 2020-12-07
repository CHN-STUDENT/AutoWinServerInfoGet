Set fsoobj = CreateObject("Scripting.FileSystemObject")
 DriversInfo = GetDriversInfo
 DriversInfo = Replace(DriversInfo, "|", vbCrLf)
 sReturn ="Ӳ����Ϣ��" & vbCrLf & DriversInfo
 Wscript.Echo sReturn
Function GetDriversInfo()

   GetDriversInfo = ""
   AllSpaces = 0
   AllFreeSpaces = 0
   Set drvObj = fsoobj.Drives
   For Each D In drvObj
       Err.Clear
       If D.DriveLetter <> "A" and D.DriveType = 2 Then
           If D.isReady Then
               GetDriversInfo = GetDriversInfo & "����:" & D.DriveLetter & vbCrLf
               GetDriversInfo = GetDriversInfo & "���ÿռ�:" & cSize(D.FreeSpace) & vbCrLf
               GetDriversInfo = GetDriversInfo & "�ܴ�С:" & cSize( D.TotalSize) & vbCrLf
               GetDriversInfo = GetDriversInfo & "ʹ���� :" & (100*((D.TotalSize-D.FreeSpace)/D.TotalSize)) &"%" & vbCrLf
               GetDriversInfo = GetDriversInfo & "|"
               AllSpaces = AllSpaces + D.TotalSize 
               AllFreeSpaces = AllFreeSpaces + D.FreeSpace
             Else
           End If
         Else
       End If
   Next
   GetDriversInfo = GetDriversInfo & "��Ӳ�̿��ÿռ䣺" & cSize(AllFreeSpaces) & vbCrLf
   GetDriversInfo = GetDriversInfo & "��Ӳ�̿ռ䣺" & cSize(AllSpaces) & vbCrLf
   GetDriversInfo = GetDriversInfo & "��Ӳ��ʹ���� :" & (100*((AllSpaces-AllFreeSpaces)/AllSpaces)) &"%" & vbCrLf
   GetDriversInfo = GetDriversInfo & "|"
End Function

 Function cSize(tSize)

     If tSize >= 1073741824 Then
         cSize = Int((tSize / 1073741824) * 1000) / 1000 & " GB"
       ElseIf tSize >= 1048576 Then
         cSize = Int((tSize / 1048576) * 1000) / 1000 & " MB"
       ElseIf tSize >= 1024 Then
         cSize = Int((tSize / 1024) * 1000) / 1000 & " KB"
       Else
         cSize = tSize & "B"
     End If

End Function