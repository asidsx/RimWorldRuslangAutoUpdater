set tempDirName=temp
set localizationName=Russian (GitHub)
powershell.exe -Command "Invoke-WebRequest -OutFile ./master.zip https://github.com/Ludeon/RimWorld-ru/archive/master.zip"
powershell.exe "Add-Type -A 'System.IO.Compression.FileSystem';[IO.Compression.ZipFile]::ExtractToDirectory('master.zip', '%tempDirName%');"
RD /s /q "Data\Core\Languages\%localizationName%\"
RD /s /q "Data\Royalty\Languages\%localizationName%\"
RD /s /q "Data\Ideology\Languages\%localizationName%\"
RD /s /q "Data\Biotech\Languages\%localizationName%\"
xcopy "%tempDirName%\RimWorld-ru-master\Core" "Data\Core\Languages\%localizationName%\"  /H /Y /C /R /S
xcopy "%tempDirName%\RimWorld-ru-master\Royalty" "Data\Royalty\Languages\%localizationName%\"  /H /Y /C /R /S
xcopy "%tempDirName%\RimWorld-ru-master\Ideology" "Data\Ideology\Languages\%localizationName%\"  /H /Y /C /R /S
xcopy "%tempDirName%\RimWorld-ru-master\Biotech" "Data\Biotech\Languages\%localizationName%\"  /H /Y /C /R /S
RD /s /q %tempDirName%
del master.zip
