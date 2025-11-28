@echo off
REM Start Claude Code for AI-Assisted Nonfiction Authoring
REM This script starts Claude in CONFIG_ROOT (.config/) at PROJECT_ROOT

cd /d "%~dp0.config"
claude --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
