@echo off
REM Start Claude Code for AI-Assisted Nonfiction Authoring
REM This script ensures Claude starts in the framework directory (FW_ROOT)

cd /d "%~dp0"
claude --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
