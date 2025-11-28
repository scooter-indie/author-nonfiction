#!/bin/bash

# AI-Assisted Nonfiction Authoring Framework - Configuration Bootstrap
# This script runs configure.md to set up PROJECT_ROOT

echo "============================================================"
echo " AI-Assisted Nonfiction Authoring Framework - Configuration"
echo "============================================================"
echo ""

# Get the directory where this script is located (FW_ROOT)
FW_ROOT="$(cd "$(dirname "$0")" && pwd)"

# Check if Claude Code CLI is available
if ! command -v claude &> /dev/null; then
    echo "ERROR: Claude Code CLI not found."
    echo ""
    echo "Please install Claude Code CLI first:"
    echo "  npm install -g @anthropic-ai/claude-code"
    echo ""
    echo "After installation, run this script again."
    exit 1
fi

# Check if VERSION file exists (confirms we're in FW_ROOT)
if [ ! -f "$FW_ROOT/VERSION" ]; then
    echo "ERROR: VERSION file not found."
    echo "This script must be run from the framework directory."
    exit 1
fi

echo "Starting configuration..."
echo "Framework location: $FW_ROOT"
echo ""

# Create a temp file to store PROJECT_ROOT path
TEMP_FILE="/tmp/fw_project_root.txt"
rm -f "$TEMP_FILE"

# Run Claude Code with configure.md
# Ask Claude to write PROJECT_ROOT path to temp file before exiting
cd "$FW_ROOT"
claude --append-system-prompt "IMPORTANT: Execute configure.md immediately. After completing setup, write the PROJECT_ROOT path to $TEMP_FILE before the user types /exit." "Run configure.md"

echo ""
echo "Configuration session ended."

# Check if PROJECT_ROOT was created
if [ -f "$TEMP_FILE" ]; then
    PROJECT_ROOT=$(cat "$TEMP_FILE")
    rm -f "$TEMP_FILE"

    if [ -f "$PROJECT_ROOT/start-authoring.sh" ]; then
        echo ""
        echo "PROJECT_ROOT created at: $PROJECT_ROOT"
        echo ""
        echo "Launching start-authoring to begin your first session..."
        echo ""
        sleep 3
        exec "$PROJECT_ROOT/start-authoring.sh"
    else
        echo ""
        echo "PROJECT_ROOT path found but start-authoring.sh not detected."
        echo "Please navigate to $PROJECT_ROOT and run start-authoring.sh manually."
    fi
else
    echo ""
    echo "Configuration may not have completed."
    echo ""
    echo "If PROJECT_ROOT was created, navigate there and run:"
    echo "  ./start-authoring.sh"
    echo ""
    echo "To reconfigure, run this script again."
fi
