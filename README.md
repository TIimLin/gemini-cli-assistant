# Gemini CLI Assistant Plugin

A Claude Code plugin that integrates Google's Gemini CLI to overcome context window limitations and enable large-scale codebase analysis.

## Overview

Claude Code has context window limitations that can make analyzing large files or entire codebases challenging. This plugin leverages **Gemini's million-token context window** to provide comprehensive codebase analysis, architectural insights, and feature verification.

## Features

- **Large File Analysis**: Analyze files >100KB that exceed Claude Code's context
- **Entire Codebase Overview**: Get architectural insights across entire projects
- **Feature Verification**: Check if features exist before implementing
- **Multi-Component Analysis**: Understand interactions between modules
- **Deep Code Analysis**: Thorough analysis across many files simultaneously

## Prerequisites

### Install Gemini CLI

```bash
# Using npm
npm install -g @google/generative-ai-cli

# Or using yarn
yarn global add @google/generative-ai-cli
```

### Verify Installation

```bash
which gemini
gemini --version
```

### Authentication

Choose one of the following authentication methods:

**Method 1: Account Login (推薦)**

```bash
# Login with your Google account
gemini auth login

# Verify
gemini -p "Hello"
# Should see: "Loaded cached credentials."
```

**Method 2: API Key**

Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey), then:

```bash
# Temporary
export GEMINI_API_KEY="your-api-key"

# Permanent
echo 'export GEMINI_API_KEY="your-api-key"' >> ~/.bashrc
source ~/.bashrc
```

## Installation

### Option 1: Marketplace (推薦！一鍵安裝) ⭐

在 Claude Code 中：

```
1. 輸入: /plugin
2. 選擇: 3. Add marketplace
3. 輸入: YOUR_USERNAME/gemini-cli-assistant
4. 選擇: 1. Browse and install plugins
5. 安裝 Gemini CLI Assistant
```

詳細步驟請看 [MARKETPLACE_INSTALL.md](MARKETPLACE_INSTALL.md)

### Option 2: Git Clone (適合開發者)

```bash
cd ~/.config/claude-code/plugins/
git clone https://github.com/YOUR_USERNAME/gemini-cli-assistant.git
```

### Option 3: 手動複製 (快速測試)

```bash
# Clone or copy this plugin to your Claude Code plugins directory
cp -r gemini-cli-assistant ~/.config/claude-code/plugins/
```

### Option 4: Symlink (本地開發)

```bash
ln -s /path/to/gemini-cli-assistant ~/.config/claude-code/plugins/gemini-cli-assistant
```

## Usage

### Invoking the Agent

In Claude Code, use the Task tool to launch the Gemini analyzer agent:

```
User: I need to understand the entire codebase structure

Claude Code: I'll use the Task tool to launch the gemini-analyzer agent to provide a comprehensive codebase analysis.
```

Or explicitly request:

```
Use Gemini CLI to analyze this entire project
```

### Common Use Cases

#### 1. Project Overview

**Request:**
> "Use Gemini CLI to give me a complete overview of this codebase"

**What happens:**
- Agent executes: `gemini "Provide comprehensive overview... @./"`
- Returns structured analysis of architecture, components, data flow

#### 2. Large File Analysis

**Request:**
> "This file is too large for Claude Code to analyze. Use Gemini CLI to explain it."

**What happens:**
- Agent analyzes file using Gemini's large context window
- Provides detailed breakdown with key insights

#### 3. Feature Verification

**Request:**
> "Does this project already implement user authentication? Use Gemini CLI to check."

**What happens:**
- Agent searches entire codebase for authentication implementation
- Reports findings with file locations and line numbers

#### 4. Component Comparison

**Request:**
> "Compare app/service_a.py and app/service_b.py using Gemini CLI"

**What happens:**
- Agent analyzes both files simultaneously
- Provides detailed comparison of implementations

**Important**: All Gemini CLI commands must be run from the project root directory. The CLI will verify the working directory matches the IDE workspace.

## Workflow Integration

### Recommended Development Flow

1. **Initial Analysis with Gemini CLI** (this plugin)
   ```
   "Use Gemini CLI to understand this codebase structure"
   ```

2. **Get Architectural Overview**
   - Gemini CLI provides comprehensive analysis
   - Identifies key files and components

3. **Focused Reading with Claude Code**
   - Use Claude Code's Read tool on specific files
   - Get detailed line-by-line analysis

4. **Implementation with Claude Code**
   - Use Edit/Write tools for changes
   - Claude Code excels at precise modifications

5. **Verification with Gemini CLI** (this plugin)
   ```
   "Use Gemini CLI to verify the authentication flow is complete"
   ```

## Examples

### Example 1: Understanding Project Architecture

```markdown
User: I'm new to this codebase. Use Gemini CLI to help me understand it.

Agent: I'll analyze the entire codebase structure...

[Executes: gemini "Explain: 1) Architecture, 2) Components, 3) Data flow, 4) Tech stack @./"]

## Analysis Summary
This is a Flask-based LINE Bot application with dual-mode architecture...

## Key Components
1. app/linebot_service.py:1-150 - Webhook handler
2. app/gemini_service_with_serper.py:1-200 - Direct API mode
...
```

### Example 2: Feature Detection

```markdown
User: Does this project have retry logic? Use Gemini CLI.

Agent: Checking entire codebase for retry implementations...

[Executes: gemini "Find all retry logic implementations @./"]

## Analysis Summary
Yes, retry logic is implemented in multiple locations...

## File References
- mcp-servers/serper/server.py:45-67 - Exponential backoff retry
- app/serper_service.py:89-102 - Request retry with timeout
```

### Example 3: Multi-File Analysis

```markdown
User: Compare the MCP and direct API implementations using Gemini CLI

Agent: Analyzing both implementations...

[Executes: gemini "Compare these implementations @app/gemini_service_with_serper.py @app/gemini_service_with_mcp_serper.py"]

## Key Differences
1. **Async Handling**: MCP uses async/await, Direct API is synchronous
2. **Communication**: MCP uses stdio, Direct API uses HTTP
...
```

## Best Practices

### When to Use This Plugin

✅ **Use Gemini CLI when:**
- Analyzing files >100KB
- Need entire project overview
- Searching across many files
- Initial codebase exploration
- Verifying feature existence
- Understanding cross-file interactions

❌ **Use Claude Code directly when:**
- Single small file (<50KB)
- Making code edits
- Quick grep/glob searches
- Writing new code
- Focused line-by-line review

### Performance Tips

1. **Be Specific**: Ask focused questions for better results
2. **Use Directory Paths**: For architectural questions
3. **Combine Tools**: Use both Gemini CLI and Claude Code tools
4. **Cache Findings**: Save Gemini CLI output for reference

## Troubleshooting

### Gemini CLI Not Found

```bash
# Check installation
which gemini

# If not found, install
npm install -g @google/generative-ai-cli
```

### Authentication Issues

```bash
# Check if using account login
gemini -p "test" 2>&1 | grep "cached credentials"

# Or check API key
echo $GEMINI_API_KEY

# Re-authenticate if needed
gemini auth login
# Or set API key
export GEMINI_API_KEY="your-key"
```

### Plugin Not Loading

```bash
# Verify plugin structure
ls -R ~/.config/claude-code/plugins/gemini-cli-assistant/

# Should show:
# .claude-plugin/plugin.json
# agents/gemini-analyzer.md
# README.md
```

### Permission Issues

```bash
# Fix permissions
chmod -R 755 ~/.config/claude-code/plugins/gemini-cli-assistant/
```

## Configuration

### Customizing Agent Behavior

Edit `agents/gemini-analyzer.md` to:
- Modify response format
- Add custom analysis patterns
- Change default behaviors
- Add domain-specific prompts

### Project-Specific Customization

Add to your project's `CLAUDE.md`:

```markdown
## Gemini CLI Usage

When analyzing this codebase with Gemini CLI:
- Focus on [specific aspects]
- Always check [specific files]
- Use [custom patterns]
```

## Sharing Across Projects

### Method 1: User-Level Plugin (Recommended)

Install once at `~/.config/claude-code/plugins/` and it's available in all projects.

### Method 2: Project-Level Plugin

```bash
# Copy to project
cp -r ~/.config/claude-code/plugins/gemini-cli-assistant .claude/plugins/
```

### Method 3: Git Submodule (For Teams)

```bash
# Add as submodule
git submodule add <repo-url> .claude/plugins/gemini-cli-assistant
```

## Advanced Usage

### Custom Analysis Queries

Create project-specific queries in `CLAUDE.md`:

```markdown
## Gemini CLI Shortcuts

**Security Analysis:**
```bash
gemini -p "@./ Analyze security vulnerabilities, authentication flows, and data validation"
```

**Performance Analysis:**
```bash
gemini -p "@./ Identify performance bottlenecks, async issues, and optimization opportunities"
```
```

### Combining with Other Tools

```bash
# Use with git diff
git diff main | gemini -p "Analyze these changes for potential issues"

# Use with specific file types
gemini -p "@**/*.py Analyze all Python files for design patterns"
```

## Limitations

- Requires Gemini CLI installation and API key
- Subject to Gemini API rate limits and quotas
- Large analyses may take longer than local file reads
- Depends on Gemini API availability

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Test thoroughly
4. Submit pull request

## License

MIT License - See LICENSE file for details

## Support

For issues or questions:
- Check [Troubleshooting](#troubleshooting) section
- Open an issue on GitHub
- Refer to [Claude Code documentation](https://docs.claude.com/claude-code)

## Version History

### v1.0.0 (2025-10-31)
- Initial release
- Gemini analyzer agent
- Support for file, directory, and project-wide analysis
- Integration with Claude Code workflow

## Related Resources

- [Claude Code Documentation](https://docs.claude.com/claude-code)
- [Gemini CLI Documentation](https://ai.google.dev/gemini-api/docs/cli)
- [Google AI Studio](https://makersuite.google.com/)

---

**Note:** This plugin complements Claude Code by extending its capabilities for large-context analysis. Use both tools together for the best development experience.
