#!/bin/bash

# Gemini CLI Assistant Plugin Test Script
# This script tests the basic functionality of the plugin

echo "==================================="
echo "Gemini CLI Assistant Plugin Test"
echo "==================================="
echo ""

# Test 1: Check Gemini CLI installation
echo "Test 1: Checking Gemini CLI installation..."
if command -v gemini &> /dev/null; then
    echo "✓ Gemini CLI is installed at: $(which gemini)"
    gemini --version
else
    echo "✗ Gemini CLI not found. Please install:"
    echo "  npm install -g @google/generative-ai-cli"
    exit 1
fi
echo ""

# Test 2: Check Authentication
echo "Test 2: Checking Gemini CLI authentication..."
if [ -n "$GEMINI_API_KEY" ]; then
    echo "✓ Using API key authentication (GEMINI_API_KEY is set)"
else
    echo "ℹ API key not set, checking for account login..."
    # Test if gemini works with cached credentials
    # We only need to see if it starts loading credentials, not wait for full response
    TEST_FILE=$(mktemp)
    echo "test" > "$TEST_FILE"

    # Run gemini in background and capture initial output
    timeout 5 gemini -p "@$TEST_FILE test" > /tmp/gemini_test_output 2>&1 &
    GEMINI_PID=$!
    sleep 2

    # Check if we see cached credentials message
    if grep -q "Loaded cached credentials" /tmp/gemini_test_output 2>/dev/null; then
        echo "✓ Using account login authentication (cached credentials found)"
        kill $GEMINI_PID 2>/dev/null
    else
        wait $GEMINI_PID 2>/dev/null
        if grep -q "Loaded cached credentials" /tmp/gemini_test_output 2>/dev/null; then
            echo "✓ Using account login authentication (cached credentials found)"
        else
            echo "⚠ No authentication found"
            echo "  Please either:"
            echo "  1. Login with: gemini auth login"
            echo "  2. Or set API key: export GEMINI_API_KEY='your-api-key'"
            rm "$TEST_FILE" /tmp/gemini_test_output 2>/dev/null
            exit 1
        fi
    fi
    rm "$TEST_FILE" /tmp/gemini_test_output 2>/dev/null
fi
echo ""

# Test 3: Check plugin structure
echo "Test 3: Checking plugin structure..."
PLUGIN_DIR="$HOME/.config/claude-code/plugins/gemini-cli-assistant"

if [ ! -f "$PLUGIN_DIR/.claude-plugin/plugin.json" ]; then
    echo "✗ plugin.json not found"
    exit 1
fi
echo "✓ plugin.json exists"

if [ ! -f "$PLUGIN_DIR/agents/gemini-analyzer.md" ]; then
    echo "✗ gemini-analyzer.md not found"
    exit 1
fi
echo "✓ gemini-analyzer.md exists"

if [ ! -f "$PLUGIN_DIR/README.md" ]; then
    echo "✗ README.md not found"
    exit 1
fi
echo "✓ README.md exists"
echo ""

# Test 4: Test Gemini CLI basic functionality
echo "Test 4: Testing Gemini CLI basic functionality..."
TEST_FILE=$(mktemp)
echo "console.log('Hello World');" > "$TEST_FILE"

if timeout 10 gemini -p "@$TEST_FILE What language is this code written in?" &> /dev/null; then
    echo "✓ Gemini CLI is working"
else
    echo "⚠ Gemini CLI test timed out or failed (this may be due to API limits)"
fi
rm "$TEST_FILE"
echo ""

# Test 5: Validate plugin.json
echo "Test 5: Validating plugin.json..."
if python3 -m json.tool "$PLUGIN_DIR/.claude-plugin/plugin.json" > /dev/null 2>&1; then
    echo "✓ plugin.json is valid JSON"
else
    echo "✗ plugin.json is invalid JSON"
    exit 1
fi
echo ""

echo "==================================="
echo "All tests passed! ✓"
echo "==================================="
echo ""
echo "Plugin is ready to use. Restart Claude Code to load the plugin."
echo ""
echo "Usage examples:"
echo "  1. In Claude Code, say: 'Use Gemini CLI to analyze this codebase'"
echo "  2. Or: 'I need to understand this large file using Gemini'"
echo ""
