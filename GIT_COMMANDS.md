# Git 操作指令集

這個檔案包含所有需要手動執行的 git 指令。請**複製並手動執行**這些指令。

## 📝 修正 README.md 錯誤

### 1. 修正安裝指令

```bash
cd ~/.config/claude-code/plugins/gemini-cli-assistant

# 編輯 README.md，將第 23 行的：
# npm install -g @google/gemini-cli
# 改為：
# npm install -g @google/gemini-cli

# 使用 sed 快速替換（或手動編輯）
sed -i 's/@google\/generative-ai-cli/@google\/gemini-cli/g' README.md

# 檢查修改
git diff README.md
```

### 2. 提交修正

```bash
cd ~/.config/claude-code/plugins/gemini-cli-assistant

git add README.md
git commit -m "Fix: Correct Gemini CLI package name"
git push
```

---

## 🔄 常用 Git 操作

### 查看狀態

```bash
cd ~/.config/claude-code/plugins/gemini-cli-assistant
git status
```

### 查看變更

```bash
git diff
git diff --staged
```

### 提交變更

```bash
git add .
git commit -m "描述你的變更"
git push
```

### 更新版本號

修改檔案後（例如從 1.0.0 → 1.1.0）：

```bash
# 1. 編輯 .claude-plugin/plugin.json
# 2. 編輯 marketplace.json
# 3. 提交

git add .claude-plugin/plugin.json marketplace.json
git commit -m "Bump version to 1.1.0"
git push
```

### 查看提交歷史

```bash
git log --oneline
git log --graph --oneline --all
```

### 撤銷未提交的變更

```bash
# 撤銷所有變更
git checkout .

# 撤銷特定檔案
git checkout -- 檔案名稱
```

### 撤銷已提交的變更

```bash
# 撤銷最後一次 commit（保留變更）
git reset --soft HEAD~1

# 撤銷最後一次 commit（刪除變更）
git reset --hard HEAD~1
```

---

## 🚀 發布新版本流程

```bash
cd ~/.config/claude-code/plugins/gemini-cli-assistant

# 1. 更新版本號（手動編輯這些檔案）
#    - .claude-plugin/plugin.json
#    - marketplace.json

# 2. 提交變更
git add .
git commit -m "Release version X.Y.Z"

# 3. 建立 tag
git tag -a v1.1.0 -m "Release version 1.1.0"

# 4. 推送
git push
git push --tags
```

---

## 🔧 同步遠端更新

```bash
cd ~/.config/claude-code/plugins/gemini-cli-assistant

# 拉取最新變更
git pull

# 如果有衝突，解決後
git add .
git commit -m "Merge remote changes"
git push
```

---

## 📊 查看 GitHub 狀態

```bash
# 查看 remote URL
git remote -v

# 查看分支
git branch -a

# 查看與遠端的差異
git fetch
git log HEAD..origin/main --oneline
```

---

## 🗑️ 清理操作

```bash
# 清理未追蹤的檔案（預覽）
git clean -n

# 清理未追蹤的檔案（執行）
git clean -f

# 清理未追蹤的檔案和目錄
git clean -fd
```

---

## 📝 使用說明

**所有指令請手動執行，不要透過 Claude Code 自動執行。**

建議工作流程：
1. 修改檔案（使用你偏好的編輯器）
2. 複製本文檔中的 git 指令
3. 在終端機手動執行
4. 驗證結果

---

## ⚠️ 重要提醒

- **備份**: 重要變更前先備份
- **測試**: 推送前先本地測試
- **Commit Message**: 使用清楚的 commit 訊息
- **小步提交**: 經常提交，每次提交一個邏輯單元

---

更新時間：2025-10-31
