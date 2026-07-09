---
name: OPC任务管理
description: 创建任务、关联指标、设置提醒机制，并写入飞书表格
version: 1.0.0
author: 清予
category: 生产力/人生管理
tags: [OPC, 任务管理, 提醒, 项目管理]
dependencies: 
  - Claude Code
  - 飞书多维表格
---

# OPC任务管理

快速创建任务，关联推进指标，设置提醒机制。

**一句话创建任务**：
- "每周一三五更新公众号"
- "每天早上9点做晨间日记"
- "每周复盘一次"

AI 会自动：
1. 识别任务描述
2. 让你选择推进哪个指标
3. 设置提醒机制（时间、频率）
4. 写入飞书任务表

---

## 📦 安装说明

### 前置条件

1. **已配置 config.yaml**
   - 路径：`~/.opc/config.yaml`
   - 包含飞书 API 配置和 Claude API 配置

2. **飞书多维表格已创建**
   - 必须有"🧾 任务（Tasks）"表
   - 必须有"📈 指标（Target）"表
   - 必须有"🪐 项目（Project）"表

### 安装步骤

```bash
# 1. 复制文件到 Claude Code Skills 目录
cp taskmanager.md ~/.claude/skills/opc/

# 2. 验证安装
# 在 Claude Code 中输入 /taskmanager 能识别即成功
```

---

## 🎯 使用说明

### 启动方式

在 Claude Code 中输入：
```
/taskmanager
```

或者直接描述任务（AI 会自动识别）：
```
每周一三五更新公众号
```

### 交互示例

**场景1：创建周期性任务**

```
你: 每周一三五更新公众号

AI: 
识别到任务：每周一三五更新公众号

这个任务推进哪个指标？
【公众号运营项目】
1. 发布文章数（目标50篇，已完成12篇）
2. 新增粉丝数（目标1000人，已完成230人）

你: 1

AI: 
提醒机制设置：
- 频率：每周一、三、五
- 时间：请指定具体时间（如：09:00、19:00）

你: 09:00

AI: ✅ 任务已创建
- 任务名称：每周一三五更新公众号
- 推进指标：发布文章数
- 提醒机制：每周一、三、五 09:00
- 是否完成：未完成
```

**场景2：创建每日任务**

```
你: 每天早上9点做晨间日记

AI:
识别到任务：每天早上9点做晨间日记

这个任务推进哪个指标？
【个人成长项目】
1. 晨间日记天数（目标100天，已完成15天）
2. 阅读书籍数量（目标12本，已完成3本）

或回复"不关联指标"创建独立任务

你: 1

AI: ✅ 任务已创建
- 任务名称：做晨间日记
- 推进指标：晨间日记天数
- 提醒机制：每天 09:00
- 是否完成：未完成
```

**场景3：不关联指标的任务**

```
你: 每周日复盘一次

AI:
识别到任务：每周日复盘一次

这个任务推进哪个指标？
【个人成长项目】
1. 复盘次数（目标52次，已完成8次）

或回复"不关联指标"创建独立任务

你: 不关联指标

AI: ✅ 任务已创建
- 任务名称：每周日复盘一次
- 推进指标：无
- 提醒机制：每周日 20:00（默认）
- 是否完成：未完成
```

---

## 🧠 核心能力

### 1. 任务描述解析

支持自然语言描述：
- **频率表达**：每天、每周、每月、每周一三五
- **时间表达**：早上9点、下午2点、晚上8点
- **任务内容**：更新公众号、做晨间日记、复盘

AI 自动提取：
- 任务名称（去掉频率词）
- 提醒频率（每天/每周X/每月X日）
- 提醒时间（具体钟点）

### 2. 指标智能匹配

根据任务名称推荐相关指标：
- "更新公众号" → 推荐"发布文章数"
- "做晨间日记" → 推荐"晨间日记天数"
- "读书" → 推荐"阅读书籍数量"

显示指标进度，帮助用户选择。

### 3. 提醒机制配置

支持多种提醒模式：
- **每天**：每天 HH:MM
- **每周固定日**：每周一、三、五 HH:MM
- **每月固定日**：每月1日、15日 HH:MM
- **工作日**：工作日 HH:MM
- **自定义**：用户自己写规则

### 4. 任务状态管理

任务字段：
- **任务名称**：去掉频率的纯任务描述
- **推进指标**：关联的指标（可为空）
- **提醒机制**：文本描述，如"每周一三五 09:00"
- **是否完成**：未完成/已完成
- **截止日期**：可选
- **所属项目**：通过指标自动关联（lookup字段）

---

## 🔧 技术实现

### API 函数库

```python
import yaml
import requests
from pathlib import Path
from datetime import datetime
import re

# ============ 配置读取 ============

def load_config():
    """读取 ~/.opc/config.yaml 配置"""
    config_path = Path.home() / ".opc" / "config.yaml"
    with open(config_path, 'r', encoding='utf-8') as f:
        return yaml.safe_load(f)

# ============ 飞书 API ============

def get_tenant_access_token(app_id, app_secret):
    """获取飞书 tenant_access_token"""
    url = "https://open.feishu.cn/open-api/auth/v3/tenant_access_token/internal"
    payload = {
        "app_id": app_id,
        "app_secret": app_secret
    }
    response = requests.post(url, json=payload)
    data = response.json()
    if data.get("code") == 0:
        return data["tenant_access_token"]
    else:
        raise Exception(f"获取 token 失败: {data}")

def get_table_id_by_name(app_token, table_name, token):
    """根据表名获取 table_id"""
    url = f"https://open.feishu.cn/open-api/bitable/v1/apps/{app_token}/tables"
    headers = {"Authorization": f"Bearer {token}"}
    response = requests.get(url, headers=headers)
    data = response.json()
    
    if data.get("code") == 0:
        for table in data["data"]["items"]:
            if table_name in table["name"]:
                return table["table_id"]
    return None

def get_all_indicators(app_token, table_id, token):
    """获取所有指标列表（包含项目信息）"""
    url = f"https://open.feishu.cn/open-api/bitable/v1/apps/{app_token}/tables/{table_id}/records"
    headers = {"Authorization": f"Bearer {token}"}
    params = {"page_size": 500}
    
    response = requests.get(url, headers=headers, params=params)
    data = response.json()
    
    indicators = []
    if data.get("code") == 0:
        for record in data["data"]["items"]:
            fields = record["fields"]
            
            # 获取所属项目名称（lookup字段返回的是列表）
            project_info = fields.get("所属项目", [])
            project_name = project_info[0]["text"] if project_info else "未知项目"
            
            indicators.append({
                "record_id": record["record_id"],
                "name": fields.get("指标名称", ""),
                "project": project_name,
                "target": fields.get("目标值", 0),
                "current": fields.get("完成值", 0),
                "progress": fields.get("进度", "0%")
            })
    return indicators

def create_task(app_token, table_id, fields, token):
    """创建任务"""
    url = f"https://open.feishu.cn/open-api/bitable/v1/apps/{app_token}/tables/{table_id}/records"
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }
    payload = {"fields": fields}
    
    response = requests.post(url, headers=headers, json=payload)
    data = response.json()
    
    if data.get("code") == 0:
        return data["data"]["record"]
    else:
        raise Exception(f"创建任务失败: {data}")

# ============ 任务描述解析 ============

def parse_task_description(text):
    """解析任务描述
    
    输入："每周一三五更新公众号"
    输出：{
        "frequency": "每周一三五",
        "task_name": "更新公众号",
        "time": None
    }
    """
    text = text.strip()
    
    # 提取时间（如"早上9点"）
    time_match = re.search(r"(早上|上午|中午|下午|晚上)?(\d{1,2})[点时:]", text)
    time_str = None
    if time_match:
        period = time_match.group(1) or ""
        hour = int(time_match.group(2))
        if period in ["下午", "晚上"] and hour < 12:
            hour += 12
        time_str = f"{hour:02d}:00"
        text = text.replace(time_match.group(0), "").strip()
    
    # 提取频率
    frequency_patterns = [
        (r"每天", "每天"),
        (r"每日", "每天"),
        (r"每周([一二三四五六日天,、]+)", "每周\\1"),
        (r"每月(\d+)[日号]", "每月\\1日"),
        (r"工作日", "工作日"),
        (r"每周", "每周"),
        (r"每月", "每月")
    ]
    
    frequency = None
    for pattern, replacement in frequency_patterns:
        match = re.search(pattern, text)
        if match:
            frequency = match.group(0)
            text = text.replace(match.group(0), "").strip()
            break
    
    # 剩余部分就是任务名称
    task_name = text
    
    return {
        "frequency": frequency,
        "task_name": task_name,
        "time": time_str
    }

def generate_reminder_text(frequency, time):
    """生成提醒机制文本
    
    输入：frequency="每周一三五", time="09:00"
    输出："每周一、三、五 09:00"
    """
    if not frequency:
        frequency = "手动触发"
    
    # 格式化周几（加顿号）
    if "每周" in frequency and len(frequency) > 2:
        days = frequency.replace("每周", "")
        formatted_days = "、".join(list(days))
        frequency = f"每周{formatted_days}"
    
    if time:
        return f"{frequency} {time}"
    else:
        return frequency

def smart_match_indicators(task_name, indicators):
    """根据任务名称智能匹配指标"""
    task_lower = task_name.lower()
    
    # 关键词映射
    keyword_map = {
        "公众号": ["公众号", "文章", "更新", "发布"],
        "日记": ["日记", "记录"],
        "阅读": ["阅读", "读书", "看书"],
        "运动": ["运动", "健身", "跑步"],
        "学习": ["学习", "课程"],
    }
    
    matched = []
    for indicator in indicators:
        indicator_name = indicator["name"]
        for keyword, patterns in keyword_map.items():
            if keyword in indicator_name:
                for pattern in patterns:
                    if pattern in task_lower:
                        matched.append(indicator)
                        break
    
    return matched if matched else indicators

def datetime_to_timestamp(dt):
    """将 datetime 转为毫秒时间戳"""
    return int(dt.timestamp() * 1000)
```

---

## 💡 Skill Prompt

当用户启动 `/taskmanager` 或输入包含任务描述的文本时，你进入**任务管理模式**。

### 工作流程

**Step 1：解析任务描述**

用户输入：
```
每周一三五更新公众号
```

调用 `parse_task_description()`：
```python
{
    "frequency": "每周一三五",
    "task_name": "更新公众号",
    "time": None
}
```

**Step 2：读取指标列表**

```python
config = load_config()
token = get_tenant_access_token(config["feishu"]["app_id"], config["feishu"]["app_secret"])
indicator_table_id = get_table_id_by_name(config["feishu"]["app_token"], "指标", token)
indicators = get_all_indicators(config["feishu"]["app_token"], indicator_table_id, token)
```

**Step 3：智能推荐指标**

```python
recommended = smart_match_indicators("更新公众号", indicators)
```

显示给用户（按项目分组）：
```
识别到任务：更新公众号
提醒频率：每周一三五

这个任务推进哪个指标？

【公众号运营项目】
1. 发布文章数（目标50篇，已完成12篇，进度24%）
2. 新增粉丝数（目标1000人，已完成230人，进度23%）

【个人品牌建设项目】
3. 品牌曝光次数（目标100次，已完成25次，进度25%）

或回复"不关联指标"创建独立任务
```

**Step 4：用户选择指标**

用户回复："1" 或 "发布文章数" 或 "不关联指标"

**Step 5：确认提醒时间**

如果解析时没有提取到时间：
```
提醒机制设置：
- 频率：每周一、三、五
- 时间：请指定具体时间（如：09:00、19:00）
```

用户回复："09:00"

**Step 6：写入飞书**

```python
task_table_id = get_table_id_by_name(app_token, "任务", token)

fields = {
    "任务名称": "更新公众号",
    "推进指标": [selected_indicator["record_id"]] if selected_indicator else [],  # link字段
    "提醒机制": generate_reminder_text("每周一三五", "09:00"),
    "是否完成": "未完成",
    "记录添加日期": datetime_to_timestamp(datetime.now())
}

# 如果有截止日期
if deadline:
    fields["截止日期"] = datetime_to_timestamp(deadline)

create_task(app_token, task_table_id, fields, token)
```

**Step 7：确认成功**

```
✅ 任务已创建
- 任务名称：更新公众号
- 推进指标：发布文章数
- 提醒机制：每周一、三、五 09:00
- 是否完成：未完成
```

### 批量创建

如果用户一次输入多个任务：
```
每周一三五更新公众号
每天早上9点做晨间日记
每周日晚上复盘
```

逐个处理：
```python
lines = text.strip().split('\n')
for line in lines:
    if line.strip():
        # 处理单个任务
        ...
```

### 错误处理

- **没有指标** → 提示用户先用 `/lifecoach` 创建项目和指标
- **任务描述不清晰** → 询问用户具体任务名称
- **提醒时间格式错误** → 提示正确格式（HH:MM）
- **API 调用失败** → 显示错误信息，建议检查配置

---

## 📚 进阶使用

### 配合其他 Skill

**任务管理 + 时间记录**：
```
/taskmanager
每周一三五更新公众号

/timetracking
今天9-11点写公众号
```

**任务管理 + 复盘**：
```
/review week
（会分析本周任务完成情况）
```

### 任务提醒

提醒机制写入后，需要配合定时任务系统（如飞书机器人、cron）定期检查并发送提醒。

提醒逻辑：
1. 每天定时扫描任务表
2. 匹配提醒机制（今天是否该提醒）
3. 发送飞书消息提醒用户

---

## 🔄 更新日志

### v1.0.0 (2026-06-22)
- 初始版本
- 支持自然语言任务描述解析
- 智能指标匹配推荐
- 灵活的提醒机制配置
- 自动写入飞书任务表
