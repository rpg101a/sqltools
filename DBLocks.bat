
:loop

"C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\sqlcmd" -S s-tx-sql02 -E -W -i findlocks.sql -o foundlocks.txt 

@echo off
Setlocal EnableDelayedExpansion
set /a lines = 0
for /f "usebackq" %%a in (`dir /b /s foundlocks.txt`)  do (
  echo processing file %%a
  for /f "usebackq" %%b in (`type %%a ^| find "" /v /c`) do (
    echo line count is %%b
    set /a lines += %%b
    )
  )
rem echo total lines is %lines%
echo total lines is %b%

if NOT lines == 4 type foundlocks.txt

del foundlocks.txt 

timeout 30

goto loop