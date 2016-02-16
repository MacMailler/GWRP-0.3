@set COMPILER=%CD%\compiler\pawncc.exe
@set SRCPATH=%CD%\src\gwrp.p
@set BINPATH=%CD%\server\gamemodes
@set OUTNAME=gwrp

@rem Компиляция проекта
%COMPILER% "%SRCPATH%" -D"%CD%" -o"%BINPATH%/%OUTNAME%.amx" -iinc -; -( -w217 -d2

pause