#!/usr/bin/env bash
# Start Claude Code for AI-Assisted Nonfiction Authoring
# This script starts Claude in CONFIG_ROOT (.config/) at PROJECT_ROOT

cd "$(dirname "$0")/.config"
claude --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
