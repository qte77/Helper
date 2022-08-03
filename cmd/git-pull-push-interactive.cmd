@echo off
rem interactive wrapper for automatic commits to git
setlocal EnableDelayedExpansion

call:set_vars

if exist "%cmd_to_use%" (
    :set_path
        set /p "usr_path_to_git=%msg_path%"
        if _!usr_path_to_git!_ == _ex_ goto:cleanup -2
        if not exist "!usr_path_to_git!" (
            call:out_log path "!usr_path_to_git!"
            goto:set_path
        )
    :set_msg
        set /p "usr_commit_msg=%msg_commsg%"
        if _!usr_commit_msg!_ == _ex_ goto:cleanup -3
        if _!usr_commit_msg!_ == __ (
            call:out_log msg
            goto:set_msg
        )
    echo %msg_git_start%
    "%cmd_to_use%" "!usr_path_to_git!" "!usr_commit_msg!"
    goto:cleanup %errorlevel%
) else (
    call:out_log path "%target%"
    goto:cleanup -1
)
goto:cleanup %errorlevel%

:set_vars
    set cmd_to_use=git-pull-push.cmd
    set msg_path=Input parent directory of .git: 
    set msg_commsg=Input the commit message to use: 
    set msg_exit=Try again or type "ex" for exit.
    set msg_git_start=Starting git with the given inputs
    set msg_choice=Done. Exiting with ErrorLevel
goto:eof

:out_log
    if _%1_ == _path_ echo "%2"not found. %msg_exit%
    if _%1_ == _msg_ echo Commit message empty. %msg_exit%
goto:eof

:cleanup
    echo %msg_choice% %1
    timeout /t 5
exit /b %1
