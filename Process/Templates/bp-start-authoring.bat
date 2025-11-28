@echo off
REM Start Claude Code for AI-Assisted Nonfiction Authoring (Bypass Permissions)
REM This script starts Claude in CONFIG_ROOT (.config/) at PROJECT_ROOT
REM WARNING: Bypasses permission prompts - use only in trusted environments

cd /d "%~dp0.config"
claude --permission-mode "bypassPermissions" --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
