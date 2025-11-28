#!/usr/bin/env bash
# Start Claude Code for AI-Assisted Nonfiction Authoring (Bypass Permissions)
# This script ensures Claude starts in the framework directory (FW_ROOT)
# WARNING: Bypasses permission prompts - use only in trusted environments

cd "$(dirname "$0")"
claude --permission-mode "bypassPermissions" --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
