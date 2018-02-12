@set COMPILER=%CD%\compiler\pawncc.exe
@set SRCPATH=%CD%\src\gwrp.pwn
@set BINPATH=%CD%\server\gamemodes
@set OUTNAME=gwrp

@echo off

echo.
echo * Compilation started...

%COMPILER% "%SRCPATH%" -D"%CD%" -o"%BINPATH%\%OUTNAME%.amx" -iinc -;+ -(+ -w217 -ebuild_log.txt %1 %2 %3 %4 %5 %6 %7 %8 %9

if not exist "%CD%\build_log.txt" (
	echo * Compilation completed successfully!
) else (
	echo * Compilation aborted! See build_log.txt
)
echo.

timeout /t 15