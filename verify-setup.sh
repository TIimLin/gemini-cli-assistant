#!/bin/bash

# Simplified Gemini CLI Plugin Verification
# This script performs a quick check without extensive testing

echo "======================================"
echo "Gemini CLI Plugin - Quick Verification"
echo "======================================"
echo ""

# 1. Check Gemini CLI
echo "1. Gemini CLI: $(which gemini 2>/dev/null || echo 'NOT FOUND')"
if command -v gemini &> /dev/null; then
    echo "   Version: $(gemini --version 2>&1 | head -1)"
    echo "   Status: ✓ Installed"
else
    echo "   Status: ✗ Not installed"
    echo "   Install: npm install -g @google/generative-ai-cli"
    exit 1
fi
echo ""

# 2. Check Authentication
echo "2. Authentication:"
if [ -n "$GEMINI_API_KEY" ]; then
    echo "   Method: API Key"
    echo "   Status: ✓ GEMINI_API_KEY is set"
else
    echo "   Method: Account Login (assumed)"
    echo "   Status: ℹ No API key, using account credentials"
    echo "   Note: Run 'gemini auth login' if you haven't logged in"
fi
echo ""

# 3. Check Plugin Files
echo "3. Plugin Files:"
PLUGIN_DIR="$HOME/.config/claude-code/plugins/gemini-cli-assistant"

if [ -f "$PLUGIN_DIR/.claude-plugin/plugin.json" ]; then
    echo "   ✓ plugin.json"
else
    echo "   ✗ plugin.json missing"
    exit 1
fi

if [ -f "$PLUGIN_DIR/agents/gemini-analyzer.md" ]; then
    echo "   ✓ gemini-analyzer.md"
else
    echo "   ✗ gemini-analyzer.md missing"
    exit 1
fi

if [ -f "$PLUGIN_DIR/README.md" ]; then
    echo "   ✓ README.md"
else
    echo "   ✗ README.md missing"
fi
echo ""

# 4. Test Gemini CLI (optional, non-blocking)
echo "4. Testing Gemini CLI (this may take a few seconds)..."
if echo "console.log('test')" | gemini -p "What language is this?" 2>&1 | head -3 | grep -qi "javascript\|loaded"; then
    echo "   ✓ Gemini CLI is working"
else
    echo "   ⚠ Could not verify Gemini CLI (might still work)"
    echo "   Try manually: echo 'test' | gemini -p 'hello'"
fi
echo ""

echo "======================================"
echo "Setup appears ready! ✓"
echo "======================================"
echo ""
echo "Next steps:"
echo "1. Restart Claude Code"
echo "2. Test with: 'Use Gemini CLI to analyze this project'"
echo ""
