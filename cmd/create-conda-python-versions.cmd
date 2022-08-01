@echo off
set pyver=3.7 3.8 3.9 3.10

if __%1__ == __?__ (
    echo Create conda envs with different python versions
    echo Versions: %pyver%
    exit /b 1
)

set cpath=%userprofile%\miniconda3
set cexec="%cpath%\_conda.exe"

for %%v in (%pyver%) do (
    echo Creating python%%v with Python version %%v
    %cexec% create -y -n python%%v python=%%v
)
exit /b %errorlevel%