@echo off
setlocal enabledelayedexpansion

if __%1__ == __?__ (
    set "msg=Pushes git from %%1:<target> with %%2:<message>"
    echo.
    echo !msg!
    exit /b
)
if __%1__ == ____ (
    exit /b
) else (
    set target=%1
    set target=!target:"=!
)
if __%2__ == ____ (
    exit /b
) else (
    set msg=%2
    set msg="!msg:"=!"
)

set "com=git fetch && git pull && git add . && git status"
set "com=%com% && git commit -m !msg! && git push"

if exist "%target%\.git" (
    pushd "%target%"
    dir | find /i "%target%"
    %com%
    popd
) else (
    echo "%target%" not found
)
exit /b