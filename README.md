# AI清予网站 - 一人公司OS Skills仓库

> **版本：** v3.1  
> **更新日期：** 2026-07-12  
> **仓库性质：** 私有

---

## 📦 仓库说明

本仓库存储一人公司OS系统的所有Skills、工作流文档、模板和系统配置文件。

**用途：**
- 网页版AI清予网站会定时从本仓库同步最新的Skills
- 确保所有用户使用的是最新版本的系统配置

---

## 📁 目录结构

```
qingyu-skills/
├── skills/                 ← Skills文件（.skill格式）
│   ├── qy-organize-chat.skill
│   ├── qy-write-article.skill
│   ├── qy-record-work.skill
│   ├── qy-daily-log.skill
│   ├── qy-sync-structure.skill
│   ├── qy-indicator-driven-project.skill
│   ├── qy-work-done.skill
│   ├── qy-update-claude-rules.skill
│   └── qy-process-input.skill
│
├── workflows/              ← 工作流文档（供用户参考）
│   ├── 整理对话记录工作流.md
│   ├── 记录工作工作流.md
│   ├── 工作日志管理工作流.md
│   ├── 结构变更同步工作流.md
│   ├── 工作流使用分析工作流.md
│   └── qy-indicator-driven-project.md
│
├── templates/              ← 模板库
│   ├── 项目默认文件夹模板.md
│   ├── 领域默认文件夹模板.md
│   ├── 资源库默认文件夹模板.md
│   ├── 归档默认文件夹模板.md
│   ├── 项目级CLAUDE.md模板（OPC式管理）.md
│   ├── 原文处理模板.md
│   ├── 方法论卡片模板.md
│   └── 选题卡片模板.md
│
├── system/                 ← 系统配置
│   ├── CLAUDE.md           ← 根目录CLAUDE.md
│   ├── SYSTEM_DEFAULTS.json ← 系统默认清单
│   └── README.md           ← 系统说明
│
├── version.json            ← 版本信息
└── README.md               ← 本文件
```

---

## 🔄 同步机制

### 本地 → GitHub
使用 `sync-to-github.sh` 脚本将本地Skills同步到GitHub：
```bash
cd D:/qingyu-skills
bash sync-to-github.sh
```

### GitHub → 网站
- 服务器每5分钟检查一次 `version.json`
- 发现新版本时自动同步Skills到数据库
- 所有网页版用户自动获得更新

---

## 📋 版本管理

**版本号规则：**
- **X.0** - 大版本：系统架构变更
- **X.Y** - 小版本：新增Skill、重要功能更新
- **X.Y.Z** - 补丁：Bug修复、文档更新

**当前版本：v3.1**

详见 `version.json`

---

## 🔐 安全说明

- 本仓库为**私有仓库**
- 不包含用户数据和敏感信息
- 只包含系统配置和Skills代码

---

**最后更新：** 2026-07-12
