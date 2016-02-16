@set COMPILER=%CD%\compiler\pawncc.exe
@set SRCPATH=%CD%\src\gwrp.pwn
@set BINPATH=%CD%\server\gamemodes
@set OUTNAME=gwrp

%COMPILER% "%SRCPATH%" -D"%CD%" -o"%BINPATH%\%OUTNAME%.amx" -iinc -; -( -w217 -d2

pause