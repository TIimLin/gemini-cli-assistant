# Gemini CLI Assistant - Marketplace 安裝指南

透過 Claude Code 的 Plugin Marketplace 功能，可以更方便地安裝和管理這個 plugin。

## 🎯 安裝方式比較

| 方式 | 難度 | 更新 | 推薦場景 |
|------|------|------|----------|
| **Marketplace** | ⭐ | 自動 | 最推薦！一鍵安裝 |
| Git Clone | ⭐⭐ | `git pull` | 開發者 |
| 手動複製 | ⭐⭐⭐ | 手動 | 快速測試 |

---

## 📦 方法 1: 透過 GitHub Marketplace（推薦）

### 前置準備

1. **建立 GitHub Repository**

```bash
# 在當前主機
cd ~/.config/claude-code/plugins/gemini-cli-assistant

# 設定 GitHub remote（如果還沒有）
git remote add origin https://github.com/YOUR_USERNAME/gemini-cli-assistant.git
git branch -M main
git push -u origin main
```

2. **確保 marketplace.json 已推送**

```bash
git add marketplace.json
git commit -m "Add marketplace configuration"
git push
```

### 在其他主機安裝

1. **開啟 Claude Code**

2. **執行 `/plugin` 命令**
   - 在 Claude Code 中輸入: `/plugin`
   - 選擇 **"3. Add marketplace"**

3. **輸入 Marketplace 來源**

   根據截圖，可以使用以下任一格式：

   ```
   # GitHub 格式（推薦）
   YOUR_USERNAME/gemini-cli-assistant

   # 完整 Git URL
   https://github.com/YOUR_USERNAME/gemini-cli-assistant.git

   # SSH 格式
   git@github.com:YOUR_USERNAME/gemini-cli-assistant.git
   ```

4. **安裝 Plugin**
   - 選擇 **"1. Browse and install plugins"**
   - 找到 "Gemini CLI Assistant"
   - 點擊安裝

5. **完成設定**

   安裝後需要：
   ```bash
   # 安裝 Gemini CLI
   npm install -g @google/gemini-cli

   # 認證
   gemini auth login
   # 或
   export GEMINI_API_KEY="your-key"

   # 驗證
   ~/.config/claude-code/plugins/gemini-cli-assistant/verify-setup.sh

   # 重啟 Claude Code
   ```

---

## 📦 方法 2: 本地 Marketplace（開發/測試）

如果你在同一台機器測試，可以使用本地路徑：

1. **執行 `/plugin`**
2. **選擇 "3. Add marketplace"**
3. **輸入本地路徑**:
   ```
   ~/.config/claude-code/plugins/gemini-cli-assistant
   ```

---

## 📦 方法 3: 自定義 Marketplace JSON URL

如果你有自己的伺服器：

1. **上傳 marketplace.json 到公開 URL**
   ```
   https://your-domain.com/claude-plugins/marketplace.json
   ```

2. **在 Claude Code 執行 `/plugin`**
3. **選擇 "3. Add marketplace"**
4. **輸入 URL**:
   ```
   https://your-domain.com/claude-plugins/marketplace.json
   ```

---

## 🔧 Marketplace 配置詳解

`marketplace.json` 結構：

```json
{
  "name": "Marketplace 名稱",
  "version": "1.0.0",
  "description": "描述",
  "plugins": [
    {
      "id": "plugin-id",
      "name": "Plugin 顯示名稱",
      "version": "1.0.0",
      "description": "Plugin 描述",
      "repository": "GitHub URL",
      "source": {
        "type": "git",
        "url": "Git clone URL"
      },
      "requirements": {
        "依賴項名稱": {
          "description": "說明",
          "install": "安裝指令",
          "verify": "驗證指令"
        }
      }
    }
  ]
}
```

---

## 🎨 自定義你的 Marketplace

### 編輯 marketplace.json

```bash
cd ~/.config/claude-code/plugins/gemini-cli-assistant
vim marketplace.json
```

### 可自訂項目：

- ✏️ **name**: Marketplace 名稱
- 📝 **description**: 描述
- 🏷️ **categories**: 分類標籤
- 🔖 **tags**: 搜尋標籤
- 📋 **requirements**: 依賴項目說明
- 📚 **setup.instructions**: 安裝後步驟

### 提交更新

```bash
git add marketplace.json
git commit -m "Update marketplace configuration"
git push
```

---

## 📊 完整安裝流程圖

```
┌─────────────────────────────────────┐
│   Claude Code: /plugin 命令         │
└─────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────┐
│   選擇 "3. Add marketplace"          │
└─────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────┐
│   輸入來源:                          │
│   • GitHub: owner/repo              │
│   • Git URL: https://...            │
│   • Local: ./path/to/plugin         │
└─────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────┐
│   選擇 "1. Browse and install"       │
└─────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────┐
│   找到並安裝 Gemini CLI Assistant    │
└─────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────┐
│   完成設定:                          │
│   1. 安裝 Gemini CLI                │
│   2. 認證                           │
│   3. 驗證                           │
│   4. 重啟 Claude Code               │
└─────────────────────────────────────┘
```

---

## 🚀 快速指令

### 發布到 GitHub

```bash
# 初次設定
cd ~/.config/claude-code/plugins/gemini-cli-assistant
git remote add origin https://github.com/YOUR_USERNAME/gemini-cli-assistant.git
git push -u origin main

# 更新
git add .
git commit -m "Update plugin"
git push
```

### 在其他主機安裝

```
1. 開啟 Claude Code
2. 輸入: /plugin
3. 選擇: 3. Add marketplace
4. 輸入: YOUR_USERNAME/gemini-cli-assistant
5. 選擇: 1. Browse and install plugins
6. 安裝 Gemini CLI Assistant
```

---

## ❓ 常見問題

### Q: 如何更新已安裝的 plugin？

```
/plugin → 2. Manage and uninstall plugins → 找到 plugin → Update
```

或手動：
```bash
cd ~/.config/claude-code/plugins/gemini-cli-assistant
git pull
```

### Q: 可以建立私有 marketplace 嗎？

可以！使用私有 GitHub repository：
```
/plugin → Add marketplace → git@github.com:YOUR_USERNAME/private-repo.git
```

需要設定 SSH key。

### Q: Marketplace 和手動安裝有什麼差別？

| 特性 | Marketplace | 手動安裝 |
|------|-------------|----------|
| 安裝 | 一鍵安裝 | 需要複製檔案 |
| 更新 | 自動檢查 | 手動 git pull |
| 管理 | UI 介面 | 命令列 |
| 分享 | 發布到 GitHub | 傳輸檔案 |

### Q: 如何移除 marketplace？

```
/plugin → 4. Manage marketplaces → 選擇要移除的 → Remove
```

---

## 🌟 最佳實踐

1. **使用語意化版本**
   - 在 `marketplace.json` 和 `plugin.json` 使用 semver
   - 例如: `1.0.0`, `1.1.0`, `2.0.0`

2. **維護 CHANGELOG.md**
   - 記錄每個版本的變更

3. **測試後再發布**
   - 本地測試驗證
   - 提交到 GitHub 前確認功能正常

4. **清楚的文檔**
   - README.md 說明功能
   - QUICK_START.md 快速開始
   - 本文檔說明 marketplace 安裝

---

## 📚 相關文檔

- `README.md` - 完整使用說明
- `QUICK_START.md` - 快速開始
- `SHARING_GUIDE.md` - 傳統分享方式
- `marketplace.json` - Marketplace 配置

---

## 🎉 總結

使用 Marketplace 方式的優勢：

✅ **一鍵安裝** - 不需要手動複製檔案
✅ **自動更新** - 檢查並更新到最新版本
✅ **易於管理** - UI 介面管理所有 plugins
✅ **專業分享** - 透過 GitHub 分享給團隊或社群
✅ **版本控制** - 明確的版本管理

現在就試試看！在 Claude Code 輸入 `/plugin` 開始使用！🚀
