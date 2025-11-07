@echo off
chcp 65001 >> nul

IF "%TEMP%"=="" (
	set %TEMP%=Temp >> nul
)

echo Скачивание последней версии локализации...
powershell.exe -Command "Invoke-WebRequest -OutFile %TEMP%/master.zip https://github.com/Ludeon/RimWorld-ru/archive/master.zip" >> nul
powershell.exe "Add-Type -A 'System.IO.Compression.FileSystem';[IO.Compression.ZipFile]::ExtractToDirectory('%TEMP%/master.zip', '%TEMP%');" > nul
cls

echo Удаление существующей локализации...
del /F /Q "%~dp0Data\Core\Languages\Russian (Русский).tar" >> nul
rd /S /Q "%~dp0Data\Core\Languages\Russian (Русский)\" >> nul
del /F /Q "%~dp0Data\Royalty\Languages\Russian (Русский).tar" >> nul
rd /S /Q "%~dp0Data\Royalty\Languages\Russian (Русский)\" >> nul
del /F /Q "%~dp0Data\Ideology\Languages\Russian (Русский).tar" >> nul
rd /S /Q "%~dp0Data\Ideology\Languages\Russian (Русский)\" >> nul
del /F /Q "%~dp0Data\Biotech\Languages\Russian (Русский).tar" >> nul
rd /S /Q "%~dp0Data\Biotech\Languages\Russian (Русский)\" >> nul
del /F /Q "%~dp0Data\Anomaly\Languages\Russian (Русский).tar" >> nul
rd /S /Q "%~dp0Data\Anomaly\Languages\Russian (Русский)\" >> nul
del /F /Q "%~dp0Data\Odyssey\Languages\Russian (Русский).tar" >> nul
rd /S /Q "%~dp0Data\Odyssey\Languages\Russian (Русский)\" >> nul
cls

echo Распаковка обновлённой локализации...
xcopy "%TEMP%\RimWorld-ru-master\Core" "%~dp0Data\Core\Languages\Russian (Русский)\"  /H /Y /C /R /S >> nul
xcopy "%TEMP%\RimWorld-ru-master\Royalty" "%~dp0Data\Royalty\Languages\Russian (Русский)\"  /H /Y /C /R /S >> nul
xcopy "%TEMP%\RimWorld-ru-master\Ideology" "%~dp0Data\Ideology\Languages\Russian (Русский)\"  /H /Y /C /R /S >> nul
xcopy "%TEMP%\RimWorld-ru-master\Biotech" "%~dp0Data\Biotech\Languages\Russian (Русский)\"  /H /Y /C /R /S >> nul
xcopy "%TEMP%\RimWorld-ru-master\Anomaly" "%~dp0Data\Anomaly\Languages\Russian (Русский)\"  /H /Y /C /R /S >> nul
xcopy "%TEMP%\RimWorld-ru-master\Odyssey" "%~dp0Data\Odyssey\Languages\Russian (Русский)\"  /H /Y /C /R /S >> nul
cls

echo Удаление оставшихся файлов...
del /F /Q "%TEMP%\master.zip" >> nul
rd /S /Q "%TEMP%\RimWorld-ru-master" >> nul
exit

