@echo off
:: Thin wrapper that calls install.ps1 — for users who double-click .bat files.
:: Equivalent to:  powershell -ExecutionPolicy Bypass -File install.ps1
::
:: For curl|bash style installs, use:
::   irm https://raw.githubusercontent.com/ilkerprdal/Claude-Software-Office/main/install.ps1 | iex

setlocal

set "SCRIPT_DIR=%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%install.ps1" %*

endlocal
