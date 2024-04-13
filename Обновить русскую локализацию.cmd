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
del /F /Q "Data\Core\Languages\Russian (Русский).tar" >> nul
rd /S /Q "Data\Core\Languages\Russian (Русский)\" >> nul
del /F /Q "Data\Royalty\Languages\Russian (Русский).tar" >> nul
rd /S /Q "Data\Royalty\Languages\Russian (Русский)\" >> nul
del /F /Q "Data\Ideology\Languages\Russian (Русский).tar" >> nul
rd /S /Q "Data\Ideology\Languages\Russian (Русский)\" >> nul
del /F /Q "Data\Biotech\Languages\Russian (Русский).tar" >> nul
rd /S /Q "Data\Biotech\Languages\Russian (Русский)\" >> nul
del /F /Q "Data\Anomaly\Languages\Russian (Русский).tar" >> nul
rd /S /Q "Data\Anomaly\Languages\Russian (Русский)\" >> nul
cls

echo Распаковка обновлённой локализации...
xcopy "%TEMP%\RimWorld-ru-master\Core" "Data\Core\Languages\Russian (Русский)\"  /H /Y /C /R /S >> nul
xcopy "%TEMP%\RimWorld-ru-master\Royalty" "Data\Royalty\Languages\Russian (Русский)\"  /H /Y /C /R /S >> nul
xcopy "%TEMP%\RimWorld-ru-master\Ideology" "Data\Ideology\Languages\Russian (Русский)\"  /H /Y /C /R /S >> nul
xcopy "%TEMP%\RimWorld-ru-master\Biotech" "Data\Biotech\Languages\Russian (Русский)\"  /H /Y /C /R /S >> nul
xcopy "%TEMP%\RimWorld-ru-master\Anomaly" "Data\Anomaly\Languages\Russian (Русский)\"  /H /Y /C /R /S >> nul
cls

echo Удаление оставшихся файлов...
del /F /Q "%TEMP%\master.zip" >> nul
rd /S /Q "%TEMP%\RimWorld-ru-master" >> nul
exit
