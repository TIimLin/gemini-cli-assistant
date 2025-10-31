# Gemini CLI Assistant - Quick Start Guide

## 5-Minute Setup

### Step 1: Verify Gemini CLI Installation

```bash
which gemini
```

If not installed:
```bash
npm install -g @google/generative-ai-cli
```

### Step 2: Authentication (Choose One)

**Option A: Account Login (推薦，更方便)**

```bash
# 使用 Google 帳號登錄
gemini auth login

# 驗證登錄狀態
gemini -p "Hello"
# 應該看到 "Loaded cached credentials."
```

**Option B: API Key**

1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Click "Create API Key"
3. Set the API key:

```bash
# Temporary (current session only)
export GEMINI_API_KEY="your-api-key-here"

# Permanent
echo 'export GEMINI_API_KEY="your-api-key-here"' >> ~/.bashrc
source ~/.bashrc
```

For zsh users:
```bash
echo 'export GEMINI_API_KEY="your-api-key-here"' >> ~/.zshrc
source ~/.zshrc
```

### Step 3: Verify Setup

```bash
~/.config/claude-code/plugins/gemini-cli-assistant/test-plugin.sh
```

You should see all tests pass. The test will automatically detect which authentication method you're using.

### Step 4: Restart Claude Code

Close and reopen Claude Code to load the plugin.

## First Use

### Test the Plugin

In Claude Code, try these commands:

**Example 1: Analyze current project**
```
Use Gemini CLI to give me an overview of this codebase
```

**Example 2: Analyze a specific file**
```
This file is large. Use Gemini CLI to explain what it does
```

**Example 3: Check for a feature**
```
Use Gemini CLI to check if this project has authentication implemented
```

## Usage Patterns

### When Claude Code says "context is too large"

Instead of reading multiple files, use:
```
Use Gemini CLI to analyze the entire app/ directory
```

### When exploring a new codebase

Start with:
```
Use Gemini CLI to give me:
1. Project architecture overview
2. Key components and their roles
3. Main data flows
4. Technology stack
```

### When comparing implementations

```
Use Gemini CLI to compare file1.py and file2.py
```

## Troubleshooting

### Plugin not appearing

1. Check installation:
   ```bash
   ls -la ~/.config/claude-code/plugins/gemini-cli-assistant/
   ```

2. Verify structure:
   ```bash
   cat ~/.config/claude-code/plugins/gemini-cli-assistant/.claude-plugin/plugin.json
   ```

3. Restart Claude Code completely

### Gemini CLI not working

1. Verify installation:
   ```bash
   which gemini
   gemini --version
   ```

2. Check API key:
   ```bash
   echo $GEMINI_API_KEY
   ```

3. Test manually:
   ```bash
   echo "console.log('test')" > /tmp/test.js
   gemini -p "@/tmp/test.js What is this?"
   ```

### API quota exceeded

Gemini has API rate limits. If exceeded:
- Wait a few minutes
- Check your usage at [Google AI Studio](https://makersuite.google.com/)
- Consider upgrading your API plan

## Best Practices

1. **Use for large-scale analysis**: >100KB files or entire directories
2. **Be specific**: Ask focused questions
3. **Combine with Claude Code**: Use Gemini for discovery, Claude Code for editing
4. **Check first**: Before implementing features, use Gemini CLI to verify they don't exist

## Next Steps

- Read the full [README.md](README.md) for advanced usage
- Check [agent documentation](agents/gemini-analyzer.md) for detailed patterns
- Customize the agent for your specific needs

## Support

If you encounter issues:
1. Run the test script: `~/.config/claude-code/plugins/gemini-cli-assistant/test-plugin.sh`
2. Check the logs
3. Verify API key and Gemini CLI installation
4. Restart Claude Code

---

**Ready to go!** Start using Gemini CLI integration in Claude Code to overcome context limitations.
