@echo off

rem This is to maintain the current directory, which batch tends to mix up a lot
cd /d "%~dp0"

del release\KeyboardChatterBlocker.exe
del release\KeyboardChatterBlockerWindowsInstaller.msi

rem NOTE: You must run "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\VSI\DisableOutOfProcBuild\DisableOutOfProcBuild.exe"

rem msbuild KeyboardChatterBlocker.sln /p:Configuration=SignedReleaseBuild

devenv KeyboardChatterBlocker.sln /Rebuild "SignedReleaseBuild|x64"

cd /d "%~dp0"

echo F|xcopy KeyboardChatterBlocker\bin\Release\KeyboardChatterBlocker.exe release\KeyboardChatterBlocker.exe
echo F|xcopy WindowsInstaller\Release\WindowsInstaller.msi release\KeyboardChatterBlockerWindowsInstaller.msi

..\signing\sign-kbc-installer.bat

cd /d "%~dp0"
