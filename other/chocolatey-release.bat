@echo off

rem This is for Chocolatey releases.
rem Call the regular release script first to get the binary file generated.
rem Must also edit the version in the nuspec file.
rem After running this script, `choco push chocolatey-files\keyboard-chatter-blocker.[version].nupkg`

rem This is to maintain the current directory, which batch tends to mix up a lot
cd /d "%~dp0/.."

del other\chocolatey-files\tools\KeyboardChatterBlocker.exe
del other\chocolatey-files\tools\VERIFICATION.txt
del other\chocolatey-files\tools\LICENSE.txt

echo F|xcopy release\KeyboardChatterBlocker.exe other\chocolatey-files\tools\KeyboardChatterBlocker.exe
echo F|xcopy LICENSE.txt other\chocolatey-files\tools\LICENSE.txt

FOR /F "tokens=*" %%g IN ('other\hash.bat release\KeyboardChatterBlocker.exe MD5') do (SET md5=%%g)
FOR /F "tokens=*" %%g IN ('other\hash.bat release\KeyboardChatterBlocker.exe SHA1') do (SET sha1=%%g)
FOR /F "tokens=*" %%g IN ('other\hash.bat release\KeyboardChatterBlocker.exe SHA256') do (SET sha256=%%g)

(
echo Official releases of KeyboardChatterBlocker are at https://github.com/FreneticLLC/KeyboardChatterBlocker/releases
echo.
echo This Chocolatey package is distributed by Alex "mcmonkey" Goodwin and Frenetic LLC, the developer and maintainer of KeyboardChatterBlocker.
echo.
echo KeyboardChatterBlocker.exe checksums:
echo md5: %md5%
echo sha1: %sha1%
echo sha256: %sha256%
echo.
echo Those especially concerned about validity of the binary can opt to instead compile the source code from https://github.com/FreneticLLC/KeyboardChatterBlocker after reviewing the code yourself.
echo Compilation is just standard, open the sln file in Microsoft Visual Studio 2022 and press Build.
)>other\chocolatey-files\tools\VERIFICATION.txt

cd other\chocolatey-files
choco pack

echo Now run: choco push chocolatey-files\keyboard-chatter-blocker.[version].nupkg

cd /d "%~dp0"
