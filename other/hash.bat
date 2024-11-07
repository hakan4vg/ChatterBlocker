@echo off
setlocal enableDelayedExpansion

set "hash="
for /f "skip=1 tokens=* delims=" %%# in ('certutil -hashfile "%~f1" "%~2"') do (
	if not defined hash (
		for %%Z in (%%#) do set "hash=!hash!%%Z"
	)
)

echo %hash%
