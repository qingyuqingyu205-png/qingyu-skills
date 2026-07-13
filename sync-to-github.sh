#!/bin/bash

# ==============================================
# 一人公司OS - 安全同步到GitHub脚本
# ==============================================
# 作用：将本地Skills/模板/系统配置同步到GitHub
# 防止：个人信息、用户数据泄露
# ==============================================

echo "🔄 开始同步到GitHub..."
echo ""

# 配置路径
GITHUB_REPO="D:/qingyu-skills"
SKILLS_SOURCE="C:/Users/whx/.claude/skills"
PARA_ROOT="D:/一人公司OS"

# 进入GitHub仓库
cd "$GITHUB_REPO" || exit 1

# ==============================================
# 第一步：创建备份分支
# ==============================================
BACKUP_BRANCH="backup/v$(date +%Y%m%d_%H%M%S)"
echo "📦 创建备份分支: $BACKUP_BRANCH"
git checkout -b "$BACKUP_BRANCH"
git push origin "$BACKUP_BRANCH"
git checkout main
echo "✅ 备份完成"
echo ""

# ==============================================
# 第二步：清空目标目录（防止残留）
# ==============================================
echo "🧹 清空目标目录..."
rm -rf skills/* workflows/* templates/* system/*
echo "✅ 清空完成"
echo ""

# ==============================================
# 第三步：复制Skills（只复制qy-开头的）
# ==============================================
echo "📋 复制Skills..."
echo "   源目录: $SKILLS_SOURCE"
echo "   目标目录: $GITHUB_REPO/skills/"
echo ""

# 只复制qy-*.skill文件
SKILL_COUNT=0
for skill_dir in "$SKILLS_SOURCE"/qy-*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")

        # 🔒 安全检查1：确保是qy-开头
        if [[ "$skill_name" == qy-* ]]; then
            # 复制skill.md到.skill文件
            if [ -f "$skill_dir/skill.md" ]; then
                cp "$skill_dir/skill.md" "skills/${skill_name}.skill"
                echo "   ✅ $skill_name"
                ((SKILL_COUNT++))
            else
                echo "   ⚠️  $skill_name (未找到skill.md)"
            fi
        fi
    fi
done

echo ""
echo "✅ 共复制 $SKILL_COUNT 个Skills"
echo ""

# ==============================================
# 第四步：复制工作流文档（排除个人数据）
# ==============================================
echo "📄 复制工作流文档..."
echo "   源目录: $PARA_ROOT/Resources/01-系统工作流/"
echo "   目标目录: $GITHUB_REPO/workflows/"
echo ""

# 🔒 安全检查2：只复制系统工作流，不复制用户数据
WORKFLOW_COUNT=0
for workflow_file in "$PARA_ROOT/Resources/01-系统工作流"/*.md; do
    if [ -f "$workflow_file" ]; then
        filename=$(basename "$workflow_file")

        # 🔒 排除包含个人信息的文件
        if [[ "$filename" == *"个人"* ]] || [[ "$filename" == *"私人"* ]] || [[ "$filename" == *"测试"* ]]; then
            echo "   🔒 跳过: $filename (可能包含个人信息)"
        else
            cp "$workflow_file" "workflows/$filename"
            echo "   ✅ $filename"
            ((WORKFLOW_COUNT++))
        fi
    fi
done

echo ""
echo "✅ 共复制 $WORKFLOW_COUNT 个工作流文档"
echo ""

# ==============================================
# 第五步：复制模板库（排除个人模板）
# ==============================================
echo "📑 复制模板库..."
echo "   源目录: $PARA_ROOT/Resources/04-模板库/"
echo "   目标目录: $GITHUB_REPO/templates/"
echo ""

TEMPLATE_COUNT=0
for template_file in "$PARA_ROOT/Resources/04-模板库"/*.md; do
    if [ -f "$template_file" ]; then
        filename=$(basename "$template_file")

        # 🔒 排除包含个人信息的模板
        if [[ "$filename" == *"个人"* ]] || [[ "$filename" == *"私人"* ]] || [[ "$filename" == *"清予"* ]]; then
            echo "   🔒 跳过: $filename (个人模板)"
        else
            cp "$template_file" "templates/$filename"
            echo "   ✅ $filename"
            ((TEMPLATE_COUNT++))
        fi
    fi
done

echo ""
echo "✅ 共复制 $TEMPLATE_COUNT 个模板"
echo ""

# ==============================================
# 第六步：复制系统文件（脱敏处理）
# ==============================================
echo "⚙️  复制系统文件..."

# 复制CLAUDE.md（需要脱敏）
if [ -f "$PARA_ROOT/CLAUDE.md" ]; then
    echo "   处理 CLAUDE.md（脱敏）..."

    # 🔒 安全检查3：移除可能的个人路径
    sed 's|D:\\一人公司OS|/opt/para-system|g' "$PARA_ROOT/CLAUDE.md" | \
    sed 's|C:\\Users\\whx|/home/user|g' > "system/CLAUDE.md"

    echo "   ✅ CLAUDE.md（已脱敏）"
fi

# 复制SYSTEM_DEFAULTS.json（需要脱敏）
if [ -f "$PARA_ROOT/SYSTEM_DEFAULTS.json" ]; then
    echo "   处理 SYSTEM_DEFAULTS.json（脱敏）..."

    # 🔒 安全检查4：移除个人路径
    sed 's|D:\\\\一人公司OS\\\\|/opt/para-system/|g' "$PARA_ROOT/SYSTEM_DEFAULTS.json" | \
    sed 's|C:\\\\Users\\\\whx\\\\.claude\\\\skills\\\\|/opt/para-system/skills/|g' > "system/SYSTEM_DEFAULTS.json"

    echo "   ✅ SYSTEM_DEFAULTS.json（已脱敏）"
fi

# 复制README.md
if [ -f "$PARA_ROOT/README.md" ]; then
    # 🔒 安全检查5：检查README是否包含个人信息
    if grep -qi "清予\|个人\|私人\|电话\|邮箱\|微信" "$PARA_ROOT/README.md"; then
        echo "   ⚠️  README.md 可能包含个人信息，已跳过"
        echo "   💡 建议：为GitHub仓库单独创建README.md"
    else
        cp "$PARA_ROOT/README.md" "system/README.md"
        echo "   ✅ README.md"
    fi
fi

echo ""
echo "✅ 系统文件复制完成"
echo ""

# ==============================================
# 第七步：安全检查（扫描敏感信息）
# ==============================================
echo "🔒 安全检查：扫描敏感信息..."
echo ""

# 定义敏感关键词
SENSITIVE_KEYWORDS=(
    "清予"
    "whx"
    "电话"
    "手机"
    "微信"
    "邮箱"
    "@qq.com"
    "@163.com"
    "密码"
    "token"
    "secret"
    "API_KEY"
)

FOUND_SENSITIVE=0

for keyword in "${SENSITIVE_KEYWORDS[@]}"; do
    # 在即将提交的文件中搜索敏感词
    matches=$(grep -r "$keyword" skills/ workflows/ templates/ system/ 2>/dev/null | wc -l)

    if [ "$matches" -gt 0 ]; then
        echo "   ⚠️  发现 \"$keyword\" 出现 $matches 次"
        FOUND_SENSITIVE=1
    fi
done

if [ $FOUND_SENSITIVE -eq 1 ]; then
    echo ""
    echo "🚨 警告：检测到可能的敏感信息！"
    echo ""
    echo "建议操作："
    echo "1. 手动检查上述文件"
    echo "2. 确认信息是否可以公开"
    echo "3. 如果不确定，取消本次同步"
    echo ""
    read -p "确认继续同步吗？(y/n): " confirm

    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo "❌ 已取消同步"
        exit 1
    fi
else
    echo "   ✅ 未发现敏感信息"
fi

echo ""

# ==============================================
# 第八步：生成更新日志
# ==============================================
echo "📝 生成更新日志..."

# 读取当前版本
CURRENT_VERSION=$(grep -oP '"version":\s*"\K[^"]+' version.json | head -1)

# 让用户输入版本号和更新说明
echo ""
echo "当前版本: $CURRENT_VERSION"
read -p "新版本号 (例如: 3.2): " NEW_VERSION
read -p "更新说明 (例如: 新增领域定义Skill): " CHANGE_SUMMARY

# 更新version.json（这里需要手动编辑，或用jq工具）
echo "   💡 请手动编辑 version.json 更新版本号和changelog"
echo ""

# ==============================================
# 第九步：Git提交
# ==============================================
echo "📤 提交到GitHub..."

git add skills/ workflows/ templates/ system/ version.json
git status

echo ""
read -p "确认提交？(y/n): " git_confirm

if [ "$git_confirm" == "y" ] || [ "$git_confirm" == "Y" ]; then
    git commit -m "Update to v${NEW_VERSION} - ${CHANGE_SUMMARY} ($(date +%Y-%m-%d))"
    git push origin main

    echo ""
    echo "✅ 同步完成！"
    echo ""
    echo "📊 同步统计："
    echo "   - Skills: $SKILL_COUNT 个"
    echo "   - 工作流: $WORKFLOW_COUNT 个"
    echo "   - 模板: $TEMPLATE_COUNT 个"
    echo "   - 备份分支: $BACKUP_BRANCH"
    echo ""
    echo "🕐 网站将在5分钟内自动同步新版本"
else
    echo "❌ 已取消提交"
    exit 1
fi

# ==============================================
# 第十步：保存同步记录
# ==============================================
SYNC_LOG="$PARA_ROOT/Resources/02-系统设计文档/系统更新日志/同步记录_$(date +%Y%m%d_%H%M%S).md"

cat > "$SYNC_LOG" << EOF
# 系统同步记录

**同步时间：** $(date +%Y-%m-%d\ %H:%M:%S)
**版本：** v${NEW_VERSION}
**更新说明：** ${CHANGE_SUMMARY}

---

## 同步内容

- Skills: $SKILL_COUNT 个
- 工作流文档: $WORKFLOW_COUNT 个
- 模板: $TEMPLATE_COUNT 个
- 系统文件: CLAUDE.md, SYSTEM_DEFAULTS.json

---

## 备份信息

- 备份分支: $BACKUP_BRANCH
- GitHub仓库: https://github.com/qingyuqingyu205-png/qingyu-skills

---

## 安全检查

$(if [ $FOUND_SENSITIVE -eq 1 ]; then
    echo "⚠️ 检测到敏感关键词，已手动确认"
else
    echo "✅ 未发现敏感信息"
fi)

---

**操作人：** 清予
EOF

echo ""
echo "📄 同步记录已保存: $SYNC_LOG"
echo ""
echo "🎉 全部完成！"
