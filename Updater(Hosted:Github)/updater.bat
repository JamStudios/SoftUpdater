:: Copywrite (C) SoftUpdater since 2022, MIT License.
:: SoftUpdater a opensource project used for automating updates of software.
::
::  Name: Software Updater for Github
::  Version: v0.1-Alpha
::  Hosting: Github (raw.githubusercontent.com)
::  
::  Requirements:
::   Curl.exe > https://curl.se/windows/
::   Github Repository > https://github.com
::   Folder (Directory)
::	 Folder with the software's version file+
::
:Main
set ActiveDir=%cd%
 :: UpdaterLink : Where the updater will search for the currentversion file hosted in your github repository.
 :: (Make sure the repository is Public and is in the raw page or in the raw.githubusercontent.com)
set UpdaterLink=https://raw.githubusercontent.com/JamStudios/SoftUpdater/example/updater/currentversion
set VersionFile=%Activedir%\example\versionfile.txt

for /f "tokens=" %%a in (%Versionfile%) do (
	set VersionFile=%%a)

powershell -command Write-Host "Checking for updates" -Foreground Yellow
ping localhost >nul
%activedir%\utility\curl\bin\curl.exe %UpdaterLink% -o %Activedir%\updtlnk.tmp
for /f "tokens=*" %%a in (%activedir%\updtlnk.tmp) do (
    set /a count+=1
    set updtline[!count!]=%%a
)
if '%Versionfile%'=='updtline[2]' (
	powershell -command Write-Host "Your Up-To-Date!" -Foreground Yellow
	:: powershell -command Write-Host "Would you like to try again? [y/n]" -Foreground Yellow
	:: choice /cs /n /c:yn
	:: if errorlevel=y goto Main
	:: if errorlevel=n exit
	pause >nul
	exit
) else (
	powershell -command Write-Host "Update Found! %updtline[2]%" -Foreground Yellow
	:: powershell -command Write-Host "Do you wan't to update to this version? [y/n]" -Foreground Yellow
	:: choice /cs /n /c:yn
	:: if errorlevel=y goto Start-Update
	:: if errorlevel=n exit
	:: :Start-Update
	powershell -command Write-Host "Downloading Update . . ." -Foreground Yellow
	%activedir%\utility\curl\bin\curl.exe updtline[1] -o updtfile.zip
	cd %activedir% ..
	set mainextractdir=%cd%
	cd %activedir%
	powershell -command Write-Host "Installing Update . . ." -Foreground Yellow
	compact /U updtfile.zip %mainextractdir%
	if '%Versionfile%'=='updtline[2]' (
		powershell -command Write-Host "Update Complete!" -Foreground Green
		pause >nul
		exit
	) else (
		powershell -command Write-Host "Update Installation Failed!" -Foreground Red
		:: powershell -command Write-Host "Would you like to try again? [y/n]" -Foreground Yellow
		:: choice /cs /n /c:yn
		:: if errorlevel=y goto Start-Update
		:: if errorlevel=n exit
		pause >nul
		exit )
		)

:: Copywrite (C) SoftUpdater since 2022, MIT License.
:: SoftUpdater a opensource project used for automating updates of software.
