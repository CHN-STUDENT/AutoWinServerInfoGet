@ECHO OFF&PUSHD %~DP0
setlocal EnableDelayedExpansion&color 3e & cd /d "%~dp0"
TITLE System Monitor
set title="%date%-%time% 127.0.0.1 Server Info"
set smtpserver="smtp.163.com"
set smtpport=25
set user="user@163.com"
set password="password"
set sendto="user@163.com"

if "%~1" == "auto" (
    @REM del info.txt
    @REM del info.old
    echo %title% >> info.txt
    echo ----------------------------------- >> info.txt
    @REM For /F "UseBackQ Tokens=1-4" %%A In (
    @REM     `Powershell "$OS=GWmi Win32_OperatingSystem;$UP=(Get-Date)-"^
    @REM     "($OS.ConvertToDateTime($OS.LastBootUpTime));$DO='d='+$UP.Days+"^
    @REM     "' h='+$UP.Hours+' n='+$UP.Minutes+' s='+$UP.Seconds;Echo $DO"`) Do (
    @REM     Set "%%A"&Set "%%B"&Set "%%C"&Set "%%D")
    cscript //nologo uptime.vbs >> info.txt
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

    echo 删除临时文件...
    del info.txt
    del info.old
) else (
    echo %title%
    echo ----------------------------------- 
    @REM Powershell 方式可能并不适用所有 Windows 系统，使用 VBScript 方式替代
    @REM For /F "UseBackQ Tokens=1-4" %%A In (
    @REM     `Powershell "$OS=GWmi Win32_OperatingSystem;$UP=(Get-Date)-"^
    @REM     "($OS.ConvertToDateTime($OS.LastBootUpTime));$DO='d='+$UP.Days+"^
    @REM     "' h='+$UP.Hours+' n='+$UP.Minutes+' s='+$UP.Seconds;Echo $DO"`) Do (
    @REM     Set "%%A"&Set "%%B"&Set "%%C"&Set "%%D")
    @REM echo 系统运行时间: %d% 天, %h% 小时, %n% 分钟, %s% 秒. 
    cscript //nologo uptime.vbs
    echo -----------------------------------
    cscript //nologo cpu.vbs 
    echo -----------------------------------
    cscript //nologo ram.vbs
    echo ----------------------------------- 
    cscript //nologo hard.vbs 
    echo ----------------------------------- 
    systeminfo
    echo ----------------------------------- 
    pause > nul
) 
exit