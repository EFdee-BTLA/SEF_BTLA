@echo off
color 0a
echo Deleting BTLA Skins...

REM I'm still gonna murder EFdee :KEKW:

del /q /f ..\ContentExpansion\CustomSkins\BlackBDU.skn"
del /q /f ..\ContentExpansion\CustomSkins\BlackBDU2.skn"
del /q /f ..\ContentExpansion\CustomSkins\BlueBDU.skn"
del /q /f ..\ContentExpansion\CustomSkins\BlueBDU2.skn"
del /q /f ..\ContentExpansion\CustomSkins\CityBDU.skn"
del /q /f ..\ContentExpansion\CustomSkins\GrayBDU.skn"
del /q /f ..\ContentExpansion\CustomSkins\LeadBDU.skn"
del /q /f ..\ContentExpansion\CustomSkins\LeadBDU2.skn"
del /q /f ..\ContentExpansion\CustomSkins\OliveBDU.skn"
del /q /f ..\ContentExpansion\CustomSkins\SkyBlueBDU.skn"

echo Finished Deleting The Found Skins.
echo .
pause
echo .
echo Regenerating MD5s For You...
call "GenerateMD5.bat"
cls
color 0c
echo You're Done! Try Multiplayer Now!
pause