@ECHO OFF&PUSHD %~DP0
setlocal EnableDelayedExpansion&color 3e & cd /d "%~dp0"
echo ----------------------------------- 
echo �����Զ���ʱ����
schtasks  /create  /tn  getsysinfo /tr  D:\win\auto.bat  /sc  DAILY /st  17:30:00
echo ----------------------------------- 
echo �鿴�Զ���ʱ����
schtasks  /Query  /tn getsysinfo
echo ----------------------------------- 
rem ɾ���Զ���ʱ����
rem schtasks /Delete /tn getsysinfo
pause > nul
exit