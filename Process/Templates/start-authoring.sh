#!/usr/bin/env bash
# Start Claude Code for AI-Assisted Nonfiction Authoring
# This script ensures Claude starts in the framework directory (FW_ROOT)

cd "$(dirname "$0")"
claude --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
