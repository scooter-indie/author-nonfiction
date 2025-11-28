#!/usr/bin/env bash
# Start Claude Code for AI-Assisted Nonfiction Authoring (Bypass Permissions)
# This script starts Claude in CONFIG_ROOT (.config/) at PROJECT_ROOT
# WARNING: Bypasses permission prompts - use only in trusted environments

cd "$(dirname "$0")/.config"
claude --permission-mode "bypassPermissions" --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
