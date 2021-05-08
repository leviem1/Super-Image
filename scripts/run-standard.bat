@echo off
setlocal enabledelayedexpansion
set flags=--tty --rm

set /A argCount=0
for %%x in (%*) do (
    set /A argCount+=1
)

if %argCount% EQU 0 (
    set flags=%flags% --interactive
)

@echo on

docker run -v %CD%:/home/si-user %flags% super-image:dev %*