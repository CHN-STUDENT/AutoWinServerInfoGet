@ECHO OFF&PUSHD %~DP0
setlocal EnableDelayedExpansion&color 3e & cd /d "%~dp0"
TITLE System Monitor
set title="%date%-%time% 127.0.0.0 ��������Ϣ��"

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
echo �����Ϣ���ļ��У���ȴ�...

echo %title% >> info.txt
echo ----------------------------------- >> info.txt
cscript //nologo cpu.vbs >> info.txt
echo ----------------------------------- >> info.txt
cscript //nologo ram.vbs >> info.txt
echo ----------------------------------- >> info.txt
cscript //nologo hard.vbs >> info.txt
echo ----------------------------------- >> info.txt
systeminfo >> info.txt

echo ���ͷ�������Ϣ�������У���ȴ�...
mailsend-go -sub %title% -smtp smtp.163.com -port 25 auth  -user  "user@163.com" -pass "password" -to  user@163.com -from "user@163.com" -subject %title% -cs "gb2312" body -file info.txt 
rem pause > nul
exit