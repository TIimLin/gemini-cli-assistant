# Gemini CLI Assistant Plugin - 分享指南

這個文檔說明如何在不同主機/專案之間分享這個 plugin。

## 📦 方法 1: Git Repository（推薦）

### 步驟 1: 推送到 GitHub（在當前主機）

```bash
# 如果還沒有 GitHub repo，先在 GitHub 上建立一個新的 repository
# 然後執行：

cd ~/.config/claude-code/plugins/gemini-cli-assistant

# 設定遠端 repository
git remote add origin https://github.com/YOUR_USERNAME/gemini-cli-assistant.git

# 推送到 GitHub
git branch -M main
git push -u origin main
```

### 步驟 2: 在其他主機安裝

**在新主機上執行：**

```bash
# 方式 A: 全域安裝（所有專案可用）
cd ~/.config/claude-code/plugins/
git clone https://github.com/YOUR_USERNAME/gemini-cli-assistant.git

# 方式 B: 專案級安裝（僅該專案可用）
cd /path/to/your/project
mkdir -p .claude/plugins
cd .claude/plugins
git clone https://github.com/YOUR_USERNAME/gemini-cli-assistant.git
```

### 步驟 3: 設定並驗證

```bash
# 安裝 Gemini CLI（如果尚未安裝）
npm install -g @google/gemini-cli

# 登錄 Gemini（二選一）
gemini auth login
# 或設定 API key
export GEMINI_API_KEY="your-api-key"

# 驗證安裝
~/.config/claude-code/plugins/gemini-cli-assistant/verify-setup.sh

# 重啟 Claude Code
```

### 優點
- ✅ 版本控制：可以追蹤修改歷史
- ✅ 易於更新：`git pull` 即可更新
- ✅ 團隊協作：多人可以貢獻改進
- ✅ 文檔齊全：README、QUICK_START 等

---

## 📋 方法 2: 直接複製（快速但不推薦長期使用）

### 在當前主機打包

```bash
# 建立壓縮檔
cd ~/.config/claude-code/plugins/
tar -czf gemini-cli-assistant.tar.gz gemini-cli-assistant/

# 或使用 zip
zip -r gemini-cli-assistant.zip gemini-cli-assistant/
```

### 傳輸到其他主機

使用 scp、rsync 或其他方式傳輸：

```bash
# 使用 scp
scp gemini-cli-assistant.tar.gz user@remote-host:/tmp/

# 使用 rsync
rsync -avz gemini-cli-assistant/ user@remote-host:~/.config/claude-code/plugins/gemini-cli-assistant/
```

### 在新主機解壓安裝

```bash
# 解壓到正確位置
cd ~/.config/claude-code/plugins/
tar -xzf /tmp/gemini-cli-assistant.tar.gz

# 或從 zip
unzip /tmp/gemini-cli-assistant.zip

# 設定執行權限
chmod +x gemini-cli-assistant/*.sh

# 驗證安裝
./gemini-cli-assistant/verify-setup.sh
```

---

## 🔗 方法 3: Symlink（同一台機器的多個專案）

如果你在同一台機器上有多個專案，想共用 plugin：

```bash
# Plugin 已安裝在 user-level
# 所有專案自動可用，無需額外設定！

# 檢查是否生效
ls -la ~/.config/claude-code/plugins/
```

如果你想在特定專案覆蓋 user-level plugin：

```bash
cd /path/to/specific/project
mkdir -p .claude/plugins
ln -s ~/.config/claude-code/plugins/gemini-cli-assistant .claude/plugins/
```

---

## 🌐 方法 4: 內網共享（團隊使用）

### 設定內部 Git Server 或共享位置

```bash
# 選項 A: 使用內部 GitLab/Gitea
git remote add internal https://git.company.com/tools/gemini-cli-assistant.git
git push internal main

# 選項 B: 使用共享網路磁碟
cp -r ~/.config/claude-code/plugins/gemini-cli-assistant /mnt/shared/claude-plugins/
```

### 團隊成員安裝

```bash
# 從內部 Git
cd ~/.config/claude-code/plugins/
git clone https://git.company.com/tools/gemini-cli-assistant.git

# 或從共享磁碟
cp -r /mnt/shared/claude-plugins/gemini-cli-assistant ~/.config/claude-code/plugins/
```

---

## 📝 安裝後檢查清單

不管使用哪種方法，在新主機上都要檢查：

- [ ] Gemini CLI 已安裝：`which gemini`
- [ ] 已認證（帳號登錄或 API key）
- [ ] Plugin 檔案完整：6 個檔案
- [ ] 執行權限正確：`.sh` 檔案可執行
- [ ] 驗證測試通過：`verify-setup.sh`
- [ ] Claude Code 已重啟

## 🔄 更新 Plugin

### 使用 Git（推薦）

```bash
cd ~/.config/claude-code/plugins/gemini-cli-assistant
git pull origin main
# 重啟 Claude Code
```

### 手動更新

```bash
# 下載新版本
# 覆蓋到 ~/.config/claude-code/plugins/gemini-cli-assistant/
# 重啟 Claude Code
```

---

## 🛠️ 常見問題

### Q: Plugin 在新主機上不工作？

檢查：
1. Gemini CLI 是否已安裝？
2. 是否已認證？
3. 檔案權限是否正確？
4. Claude Code 是否已重啟？

```bash
# 執行完整檢查
~/.config/claude-code/plugins/gemini-cli-assistant/verify-setup.sh
```

### Q: 如何移除 Plugin？

```bash
rm -rf ~/.config/claude-code/plugins/gemini-cli-assistant
# 重啟 Claude Code
```

### Q: 可以同時在多台機器使用嗎？

可以！每台機器獨立安裝即可。使用 Git repository 最方便。

### Q: 如何自訂 Plugin？

```bash
# 編輯 agent 定義
vim ~/.config/claude-code/plugins/gemini-cli-assistant/agents/gemini-analyzer.md

# 修改後重啟 Claude Code
```

---

## 📊 比較表

| 方法 | 難度 | 維護性 | 適用場景 |
|------|------|--------|----------|
| Git Repository | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | 長期使用、團隊協作 |
| 直接複製 | ⭐ | ⭐⭐ | 快速測試、一次性分享 |
| Symlink | ⭐⭐ | ⭐⭐⭐ | 同機器多專案 |
| 內網共享 | ⭐⭐⭐ | ⭐⭐⭐⭐ | 企業團隊 |

---

## 🎯 推薦流程

**個人使用：**
1. 建立 GitHub repository
2. 在其他機器 `git clone`
3. 定期 `git pull` 更新

**團隊使用：**
1. 建立內部 Git repository
2. 團隊成員 clone
3. 定期同步更新

**快速測試：**
1. 打包 tar.gz
2. scp 傳輸
3. 解壓使用

---

需要協助設定嗎？執行 `verify-setup.sh` 或查看 `README.md` 獲取更多資訊。
