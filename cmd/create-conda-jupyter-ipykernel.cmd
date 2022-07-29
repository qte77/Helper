@echo off
rem TODO check if already installed
if __%1__ == __?__ (
	echo.
	echo Auto setup miniconda env with python3, jupyter and ipykernel
	echo Downloads conda but does not start browser
	echo https://conda.io, https://docs.conda.io/
	echo https://pypi.org/project/jupyterlab/
	echo.
	echo Arguments:
	echo 1: ? open help or name of venv, "env1" if empty
	echo 2: Name of conda version to download
	echo 3: Hash of the conda version to download
	echo.
	echo To open server:
	echo %AppData%\jupyter\runtime\nbserver-XXX-open.html
	echo or
	echo localhost:8888/?token=TOKEN
	echo.
	echo Environment:
	echo conda activate env1, conda deactivate
	exit /b -1
)

set cname=Miniconda3-latest-Windows-x86_64.exe
set hash=1acbc2e8277ddd54a5f724896c7edee112d068529588d944702966c867e7e9cc
set cpkg=https://repo.anaconda.com/miniconda/%cname%
set cpath=%userprofile%\miniconda3
set sevenz="%ProgramFiles%\7-Zip\7z.exe"
set cinst="%cpath%\Scripts\activate.bat" "%userprofile%\miniconda3"
set cactiv="%cpath%\condabin\conda.bat"
set ctmp=ctmp.bat
set cexec="%cpath%\_conda.exe"
set curl="%windir%\system32\curl.exe"

if __%1__ == ____ (
	set name=env1
) else (
	set name=%1
	set name=%name: =-%
	set name=%name:\=-%
	set name=%name:/=-%
)
if __%2__ == ____ (
	set %cname%=%cname%
	set %cname%=%cname: =-%
) else (
	set cname=%2
)
if not __%2__ == ____ (
	set hash=_%2
) else (
	set hash=%hash%
)

set cname=%cname:\=-%
set cname=%cname:/=-%
if not exist "%cname%" (
	if exist "%curl%" (
		"%curl%" "%cpkg%" -o "%cname%"
	) else (
		rem uncomment if need be, defender may alert
		rem [-cert-util-.-exe-] -urlcache -f "%cpkg%"
	)
) else (
	echo "%cname%" found
)
if exist %sevenz% (
	%sevenz% h -scrcSHA256 "%cname%" | find /i "%cname%"
	echo %hash%
) else (
	echo 7z not found
)
set cenv=%userprofile%\.conda\envs\%name%
set crun="%cenv%\python.exe" "%cenv%\Scripts\jupyter-notebook-script.py"
set crun=%crun% "%USERPROFILE%/" rem "%cenv%\python.exe" "%cenv%\cwp.py" "%cenv%"

cmd /v:on /c !cname! /S

cmd /v:on /c !cinst!
cmd /v:on /c !cexec! create -n %name% -y python jupyterlab
cmd /v:on /c !cactiv! activate %name%
rem %cexec% init cmd.exe rem bash
rem cmd /v:on /c !cexec! install -n %name% -y jupyterlab
rem %cexec% run python -m ipykernel install --name=!name!
%crun% --no-browser

rem conda env list
rem conda update conda
rem jupyter lab

exit /b
