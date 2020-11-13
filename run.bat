@ECHO OFF&PUSHD %~DP0
setlocal EnableDelayedExpansion&color 3e & cd /d "%~dp0"
TITLE System Monitor
set title="%date%-%time% 127.0.0.0 服务器信息简报"

del info.txt

echo %title%
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
cscript //nologo cpu.vbs >> info.txt
echo ----------------------------------- >> info.txt
cscript //nologo ram.vbs >> info.txt
echo ----------------------------------- >> info.txt
cscript //nologo hard.vbs >> info.txt
echo ----------------------------------- >> info.txt
systeminfo >> info.txt

echo 发送服务器信息到邮箱中，请等待...
mailsend-go -sub %title% -smtp smtp.163.com -port 25 auth  -user  "user@163.com" -pass "password" -to  user@163.com -from "user@163.com" -subject %title% -cs "gb2312" body -file info.txt 
rem pause > nul
exit