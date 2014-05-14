@echo off
cl /nologo /TC /D _WINDOWS /I lua /I win/include /I src src\*.c lua\*.c /MD /link win\*.lib  /SUBSYSTEM:CONSOLE /OUT:a.exe
del /q *.obj
move a.exe working
cd working

if not exist libfreetype-6.dll copy ..\win\libfreetype-6.dll .
if not exist SDL2.dll copy ..\win\SDL2.dll .
if not exist SDL2_ttf.dll copy ..\win\SDL2_ttf.dll .
if not exist zlib1.dll copy ..\win\zlib1.dll .

a.exe

