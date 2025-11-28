@echo off
setlocal EnableDelayedExpansion

REM AI-Assisted Nonfiction Authoring Framework - Configuration Bootstrap
REM This script runs configure.md to set up PROJECT_ROOT

echo ============================================================
echo  AI-Assisted Nonfiction Authoring Framework - Configuration
echo ============================================================
echo.

REM Get the directory where this script is located (FW_ROOT)
set "FW_ROOT=%~dp0"
set "FW_ROOT=%FW_ROOT:~0,-1%"

REM Check if Claude Code CLI is available
where claude >nul 2>&1
if errorlevel 1 (
    echo ERROR: Claude Code CLI not found.
    echo.
    echo Please install Claude Code CLI first:
    echo   npm install -g @anthropic-ai/claude-code
    echo.
    echo After installation, run this script again.
    pause
    exit /b 1
)

REM Check if VERSION file exists (confirms we're in FW_ROOT)
if not exist "%FW_ROOT%\VERSION" (
    echo ERROR: VERSION file not found.
    echo This script must be run from the framework directory.
    pause
    exit /b 1
)

echo Starting configuration...
echo Framework location: %FW_ROOT%
echo.

REM Create a temp file to store PROJECT_ROOT path
set "TEMP_FILE=%TEMP%\fw_project_root.txt"
if exist "%TEMP_FILE%" del "%TEMP_FILE%"

REM Run Claude Code with configure.md
REM Ask Claude to write PROJECT_ROOT path to temp file before exiting
cd /d "%FW_ROOT%"
claude --append-system-prompt "IMPORTANT: Execute configure.md immediately. After completing setup, write the PROJECT_ROOT path to %TEMP_FILE% before the user types /exit." "Run configure.md"

echo.
echo Configuration session ended.

REM Check if PROJECT_ROOT was created
if exist "%TEMP_FILE%" (
    set /p PROJECT_ROOT=<"%TEMP_FILE%"
    del "%TEMP_FILE%"

    if exist "!PROJECT_ROOT!\start-authoring.bat" (
        echo.
        echo PROJECT_ROOT created at: !PROJECT_ROOT!
        echo.
        echo Launching start-authoring to begin your first session...
        echo.
        timeout /t 3 /nobreak >nul
        call "!PROJECT_ROOT!\start-authoring.bat"
    ) else (
        echo.
        echo PROJECT_ROOT path found but start-authoring.bat not detected.
        echo Please navigate to !PROJECT_ROOT! and run start-authoring.bat manually.
    )
) else (
    echo.
    echo Configuration may not have completed.
    echo.
    echo If PROJECT_ROOT was created, navigate there and run:
    echo   start-authoring.bat
    echo.
    echo To reconfigure, run this script again.
)

endlocal
pause
