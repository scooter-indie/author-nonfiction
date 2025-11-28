@echo off
REM Start Claude Code for AI-Assisted Nonfiction Authoring (Bypass Permissions)
REM This script ensures Claude starts in the framework directory (FW_ROOT)
REM WARNING: Bypasses permission prompts - use only in trusted environments

cd /d "%~dp0"
claude --permission-mode "bypassPermissions" --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
