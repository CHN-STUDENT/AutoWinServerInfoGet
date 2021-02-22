@ECHO OFF&PUSHD %~DP0
setlocal EnableDelayedExpansion&color 3e & cd /d "%~dp0"
TITLE System Monitor
set title="%date%-%time% 127.0.0.1 Server Info"
set smtpserver="smtp.163.com"
set smtpport=25
set user="user@163.com"
set password="password"
set sendto="user@163.com"

del info.txt
del info.old

echo %title%
echo ----------------------------------- 
For /F "UseBackQ Tokens=1-4" %%A In (
    `Powershell "$OS=GWmi Win32_OperatingSystem;$UP=(Get-Date)-"^
    "($OS.ConvertToDateTime($OS.LastBootUpTime));$DO='d='+$UP.Days+"^
    "' h='+$UP.Hours+' n='+$UP.Minutes+' s='+$UP.Seconds;Echo $DO"`) Do (
    Set "%%A"&Set "%%B"&Set "%%C"&Set "%%D")
echo 系统运行时间: %d% 天, %h% 小时, %n% 分钟, %s% 秒. 
echo -----------------------------------
cscript //nologo cpu.vbs 
echo -----------------------------------
cscript //nologo ram.vbs
echo ----------------------------------- 
cscript //nologo hard.vbs 
echo ----------------------------------- 
systeminfo
echo ----------------------------------- 
echo 另存信息到文件中，请等待...


echo %title% >> info.txt
echo ----------------------------------- >> info.txt
For /F "UseBackQ Tokens=1-4" %%A In (
    `Powershell "$OS=GWmi Win32_OperatingSystem;$UP=(Get-Date)-"^
    "($OS.ConvertToDateTime($OS.LastBootUpTime));$DO='d='+$UP.Days+"^
    "' h='+$UP.Hours+' n='+$UP.Minutes+' s='+$UP.Seconds;Echo $DO"`) Do (
    Set "%%A"&Set "%%B"&Set "%%C"&Set "%%D")
echo 系统运行时间: %d% 天, %h% 小时, %n% 分钟, %s% 秒. >> info.txt
echo ----------------------------------- >> info.txt
cscript //nologo cpu.vbs >> info.txt
echo ----------------------------------- >> info.txt
cscript //nologo ram.vbs >> info.txt
echo ----------------------------------- >> info.txt
cscript //nologo hard.vbs >> info.txt
echo ----------------------------------- >> info.txt
systeminfo >> info.txt

echo 文件编码转换中，请等待...
ren info.txt info.old
iconv -f GB2312 -t UTF-8 < info.old > info.txt

echo 发送服务器信息到邮箱中，请等待...
mailsend-go -sub %title% -smtp %smtpserver% -port %smtpport% auth  -user  %user% -pass %password% -to %sendto% -from %user% -subject %title% -cs "utf8" body -file info.txt 
rem pause > nul
exit