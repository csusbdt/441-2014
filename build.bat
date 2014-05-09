@echo off
cl /nologo /TC /D _WINDOWS /I lua /I win/include /I src src\*.c lua\*.c /MD /link win\*.lib  /SUBSYSTEM:CONSOLE /OUT:a.exe
del /q *.obj
move a.exe assets
