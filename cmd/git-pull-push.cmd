@echo off
setlocal enabledelayedexpansion

call:set_error_levels

if __%1__ == __?__ (
    call:log "Commits and pushes git from 1::target with 2::message"
    call:log "Example: this.cmd 'path\to/folder here' 'commit message'"
    set elvl=%elvl_hlp%
    goto:cleanup
)
if __%1__ == ____ (
    call:log "Path to folder with .git required"
    set elvl=%elvl_tar%
    goto:cleanup
) else (
    set target=%1
    set target=!target:"=!
    set target=!target:'=!
    set target=!target:/=\!
)
if __%2__ == ____ (
    call:log "Commit message required"
    set elvl=%elvl_msg%
    goto:cleanup
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
    set elvl=%elvl_tnf%
    goto:cleanup
) else (
    call:log "Target '%target%' not found"
    set elvl=%elvl_tnf%
    goto:cleanup
)

set elvl=%elvl_unk%
goto:cleanup

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
    echo %0 exiting with error level %elvl%
exit /b %1
