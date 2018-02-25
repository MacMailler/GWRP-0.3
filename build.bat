@set NAME=GWRP
@set SRC=%CD%\src\%NAME%.pwn
@set OUT=%CD%\server\gamemodes\%NAME%.amx
@set PAWNCC=%CD%\compiler\pawncc.exe

@echo off

echo.
echo * Compilation started...

%PAWNCC% "%SRC%" -D"%CD%" -o"%OUT%" -iinc -;+ -(+ -ebuild_log.txt %1 %2 %3 %4 %5 %6 %7 %8 %9

if %ERRORLEVEL% EQU 0 (
	if exist %CD%\build_log.txt (
		echo * Compilation completed with warnings! See build_log.txt
	) else (
		echo * Compilation completed!
	)
) else (
	echo * Compilation aborted! See build_log.txt
)
echo.

timeout /t 15