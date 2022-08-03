@echo off
setlocal enabledelayedexpansion

call:set_error_levels

if __%1__ == __?__ (
    call:log "Commits and pushes git from 1::target with 2::message"
    call:log "Example: this.cmd 'path\to/folder here' 'commit message'"
    goto:cleanup %elvl_hlp%
)
if __%1__ == ____ (
    call:log "Path to folder with .git required"
    goto:cleanup %elvl_tar%
) else (
    set target=%1
    set target=!target:"=!
    set target=!target:'=!
    set target=!target:/=\!
)
if __%2__ == ____ (
    call:log "Commit message required"
    goto:cleanup %elvl_msg%
) else (
    set msg=%2
    set msg=!msg:"=!
    set msg=!msg:'=!
    set msg="!msg!"
)

set "com=git fetch && git pull && git add . && git status"
set "com=%com% && git commit -m !msg! && git push"

if exist "%target%\.git" (
    call:log "Starting workflow"
    pushd "%target%"
    dir | find /i "%target%"
    %com%
    popd
    goto:cleanup %elvl_suc%
) else (
    call:log "Target '%target%' not found"
    goto:cleanup %elvl_tnf%
)

goto:cleanup %elvl_unk%

:log
    set log=%*
    echo.
    echo %log:"=%
goto:eof

:set_error_levels
    set elvl_suc=0
    set elvl_hlp=1
    set elvl_tar=-1
    set elvl_msg=-2
    set elvl_tnf=-3
    set elvl_unk=-99
goto:eof

:cleanup
    echo Exiting with error level %1
exit /b %1
