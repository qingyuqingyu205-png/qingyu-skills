---
name: OPC时间记录
description: 用自然语言记录时间投入，自动关联项目并写入飞书表格
version: 1.0.0
author: 清予
category: 生产力/人生管理
tags: [OPC, 时间管理, 时间记录, 项目管理]
dependencies: 
  - Claude Code
  - 飞书多维表格
---

# OPC时间记录

用自然语言描述时间投入，AI 自动解析并写入飞书时间表。

**一句话搞定时间记录**：
- "今天9-11点写代码"
- "昨天下午2-4点开会"
- "本周一上午10-12点做方案"

AI 会自动：
1. 解析日期（今天、昨天、本周一等）
2. 解析时间段（9-11点、下午2-4点等）
3. 识别事项名称
4. 让你选择关联的项目
5. 写入飞书时间表

---

## 📦 安装说明

### 前置条件

1. **已配置 config.yaml**
   - 路径：`~/.opc/config.yaml`
   - 包含飞书 API 配置和 Claude API 配置

2. **飞书多维表格已创建**
   - 必须有"⏰ 时间（Time）"表
   - 必须有"🪐 项目（Project）"表

### 安装步骤

```bash
# 1. 复制文件到 Claude Code Skills 目录
cp timetracking.md ~/.claude/skills/opc/

# 2. 验证安装
# 在 Claude Code 中输入 /timetracking 能识别即成功
```

---

## 🎯 使用说明

### 启动方式

在 Claude Code 中输入：
```
/timetracking
```

或者直接描述时间记录（AI 会自动识别）：
```
今天9-11点写代码
昨天下午2-4点开会
```

### 交互示例

**场景1：单条时间记录**

```
你: 今天9-11点写代码

AI: 
解析结果：
- 日期：2026-06-22
- 开始时间：09:00
- 结束时间：11:00
- 事项：写代码

请选择关联的项目：
1. 公众号运营
2. OPC系统开发
3. 个人品牌建设

你: 2

AI: ✅ 时间记录已写入飞书
- 所属项目：OPC系统开发
- 开始时间：2026-06-22 09:00
- 结束时间：2026-06-22 11:00
- 事项名称：写代码
- 耗时：2 小时
```

**场景2：批量时间记录**

```
你: 
今天9-11点写代码
11-12点开会
下午2-5点做方案

AI:
识别到 3 条时间记录，逐条处理：

【第1条】2026-06-22 09:00-11:00 写代码
请选择关联的项目...

【第2条】2026-06-22 11:00-12:00 开会
请选择关联的项目...

【第3条】2026-06-22 14:00-17:00 做方案
请选择关联的项目...
```

---

## 🧠 核心能力

### 1. 日期解析

支持的日期表达：
- **绝对日期**：2026-06-22、6月22日
- **相对日期**：今天、昨天、前天
- **星期表达**：本周一、上周三、这周五
- **更灵活**：3天前、上个月15号

### 2. 时间解析

支持的时间表达：
- **24小时制**：9-11点、14-16点
- **12小时制**：上午9-11点、下午2-4点
- **时段表达**：早上、上午、中午、下午、晚上
- **简写**：9-11（自动补"点"）

### 3. 批量识别

支持一次输入多条时间记录：
- 换行分隔：每行一条
- 自然段落：AI 自动拆分
- 混合格式：不同日期、不同项目

### 4. 项目智能匹配

根据事项名称智能推荐项目：
- "写公众号" → 推荐"公众号运营"
- "改代码" → 推荐"OPC系统开发"
- 如果无法确定，让用户手动选择

---

## 🔧 技术实现

### API 函数库

```python
import yaml
import requests
from pathlib import Path
from datetime import datetime, timedelta
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

def get_all_projects(app_token, table_id, token):
    """获取所有项目列表"""
    url = f"https://open.feishu.cn/open-api/bitable/v1/apps/{app_token}/tables/{table_id}/records"
    headers = {"Authorization": f"Bearer {token}"}
    params = {"page_size": 500}
    
    response = requests.get(url, headers=headers, params=params)
    data = response.json()
    
    projects = []
    if data.get("code") == 0:
        for record in data["data"]["items"]:
            fields = record["fields"]
            projects.append({
                "record_id": record["record_id"],
                "name": fields.get("项目名称", ""),
                "status": fields.get("项目状态", "")
            })
    return projects

def create_time_record(app_token, table_id, fields, token):
    """创建时间记录"""
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
        raise Exception(f"创建记录失败: {data}")

# ============ 日期时间解析 ============

def parse_relative_date(date_str, base_date=None):
    """解析相对日期表达
    
    支持：今天、昨天、前天、本周一、上周三、3天前等
    """
    if base_date is None:
        base_date = datetime.now()
    
    date_str = date_str.strip()
    
    # 今天、昨天、前天
    if date_str == "今天" or date_str == "今日":
        return base_date
    elif date_str == "昨天" or date_str == "昨日":
        return base_date - timedelta(days=1)
    elif date_str == "前天":
        return base_date - timedelta(days=2)
    
    # 本周X、这周X
    weekday_map = {"一": 0, "二": 1, "三": 2, "四": 3, "五": 4, "六": 5, "日": 6, "天": 6}
    for prefix in ["本周", "这周"]:
        if date_str.startswith(prefix):
            day_char = date_str.replace(prefix, "")
            if day_char in weekday_map:
                target_weekday = weekday_map[day_char]
                current_weekday = base_date.weekday()
                days_diff = target_weekday - current_weekday
                return base_date + timedelta(days=days_diff)
    
    # 上周X
    if date_str.startswith("上周"):
        day_char = date_str.replace("上周", "")
        if day_char in weekday_map:
            target_weekday = weekday_map[day_char]
            current_weekday = base_date.weekday()
            days_diff = target_weekday - current_weekday - 7
            return base_date + timedelta(days=days_diff)
    
    # N天前
    match = re.match(r"(\d+)天前", date_str)
    if match:
        days = int(match.group(1))
        return base_date - timedelta(days=days)
    
    # 默认返回今天
    return base_date

def parse_time_range(time_str, date_obj):
    """解析时间段表达
    
    支持：9-11点、下午2-4点、上午9-11等
    返回：(start_datetime, end_datetime)
    """
    time_str = time_str.strip()
    
    # 提取时段标记（上午、下午、晚上等）
    period = None
    if "上午" in time_str or "早上" in time_str:
        period = "am"
        time_str = time_str.replace("上午", "").replace("早上", "")
    elif "下午" in time_str:
        period = "pm"
        time_str = time_str.replace("下午", "")
    elif "晚上" in time_str:
        period = "pm"
        time_str = time_str.replace("晚上", "")
    
    # 解析时间范围：9-11点、9-11、9点-11点
    time_str = time_str.replace("点", "").replace("：", ":").strip()
    
    # 匹配 9-11 或 9:00-11:00
    match = re.match(r"(\d{1,2}):?(\d{2})?[-到至](\d{1,2}):?(\d{2})?", time_str)
    if match:
        start_hour = int(match.group(1))
        start_minute = int(match.group(2)) if match.group(2) else 0
        end_hour = int(match.group(3))
        end_minute = int(match.group(4)) if match.group(4) else 0
        
        # 根据时段调整小时（下午2点 = 14点）
        if period == "pm" and start_hour < 12:
            start_hour += 12
            end_hour += 12
        
        start_dt = date_obj.replace(hour=start_hour, minute=start_minute, second=0, microsecond=0)
        end_dt = date_obj.replace(hour=end_hour, minute=end_minute, second=0, microsecond=0)
        
        return start_dt, end_dt
    
    return None, None

def datetime_to_timestamp(dt):
    """将 datetime 转为毫秒时间戳（飞书需要）"""
    return int(dt.timestamp() * 1000)

# ============ 智能项目匹配 ============

def smart_match_project(task_name, projects):
    """根据事项名称智能匹配项目
    
    返回：推荐的项目列表（按匹配度排序）
    """
    task_name_lower = task_name.lower()
    
    # 关键词匹配
    keyword_map = {
        "公众号": ["公众号", "写文", "写作", "文章"],
        "OPC": ["OPC", "代码", "开发", "bug", "功能"],
        "品牌": ["品牌", "个人IP", "营销"],
    }
    
    matched = []
    for project in projects:
        project_name = project["name"]
        # 检查项目名是否包含任务关键词
        for keyword, patterns in keyword_map.items():
            if keyword in project_name:
                for pattern in patterns:
                    if pattern in task_name_lower:
                        matched.append(project)
                        break
    
    # 如果有匹配，返回匹配的；否则返回全部
    return matched if matched else projects

# ============ 时间记录解析 ============

def parse_time_entry(text):
    """解析一条时间记录文本
    
    输入："今天9-11点写代码"
    输出：{
        "date_str": "今天",
        "time_str": "9-11点",
        "task": "写代码"
    }
    """
    # 尝试匹配：日期 + 时间段 + 事项
    # 例如：今天9-11点写代码、昨天下午2-4点开会
    
    patterns = [
        r"(今天|昨天|前天|本周[一二三四五六日]|上周[一二三四五六日]|\d+天前)[\s]*([上下早中晚]?[午上]?\d{1,2}[-到至点:：\s]+\d{1,2}[点]?)[\s]*(.+)",
        r"(\d{4}[-/年]\d{1,2}[-/月]\d{1,2}[日]?)[\s]*([上下早中晚]?[午上]?\d{1,2}[-到至点:：\s]+\d{1,2}[点]?)[\s]*(.+)",
    ]
    
    for pattern in patterns:
        match = re.match(pattern, text.strip())
        if match:
            return {
                "date_str": match.group(1),
                "time_str": match.group(2),
                "task": match.group(3).strip()
            }
    
    return None

def parse_multiple_entries(text):
    """解析多条时间记录
    
    输入：多行文本或段落
    输出：[entry1, entry2, ...]
    """
    lines = text.strip().split('\n')
    entries = []
    
    for line in lines:
        line = line.strip()
        if not line:
            continue
        
        entry = parse_time_entry(line)
        if entry:
            entries.append(entry)
    
    return entries
```

---

## 💡 Skill Prompt

当用户启动 `/timetracking` 或输入包含时间记录的文本时，你进入**时间记录模式**。

### 工作流程

**Step 1：解析时间记录**

用户输入：
```
今天9-11点写代码
```

你调用 `parse_time_entry()` 解析，得到：
```python
{
    "date_str": "今天",
    "time_str": "9-11点",
    "task": "写代码"
}
```

**Step 2：转换为具体时间**

调用 `parse_relative_date("今天")` → `datetime(2026, 6, 22)`
调用 `parse_time_range("9-11点", date_obj)` → `(09:00, 11:00)`

**Step 3：读取项目列表**

```python
config = load_config()
token = get_tenant_access_token(config["feishu"]["app_id"], config["feishu"]["app_secret"])
project_table_id = get_table_id_by_name(config["feishu"]["app_token"], "项目", token)
projects = get_all_projects(config["feishu"]["app_token"], project_table_id, token)
```

**Step 4：智能推荐项目**

```python
recommended = smart_match_project("写代码", projects)
```

展示给用户：
```
解析结果：
- 日期：2026-06-22
- 开始时间：09:00
- 结束时间：11:00
- 事项：写代码

请选择关联的项目：
1. OPC系统开发（推荐）
2. 公众号运营
3. 个人品牌建设
```

**Step 5：用户选择项目**

用户回复："1" 或 "OPC系统开发"

**Step 6：写入飞书**

```python
time_table_id = get_table_id_by_name(app_token, "时间", token)

fields = {
    "事项名称": "写代码",
    "开始时间": datetime_to_timestamp(start_dt),
    "结束时间": datetime_to_timestamp(end_dt),
    "所属项目": [selected_project["record_id"]],  # link类型字段
    "记录添加时间": datetime_to_timestamp(datetime.now())
}

create_time_record(app_token, time_table_id, fields, token)
```

**Step 7：确认成功**

告诉用户：
```
✅ 时间记录已写入飞书
- 所属项目：OPC系统开发
- 开始时间：2026-06-22 09:00
- 结束时间：2026-06-22 11:00
- 事项名称：写代码
- 耗时：2 小时
```

### 批量处理

如果识别到多条记录，逐条处理：

```python
entries = parse_multiple_entries(user_input)

for i, entry in enumerate(entries):
    print(f"【第{i+1}条】处理中...")
    # 重复 Step 1-7
```

### 错误处理

- 日期解析失败 → 询问用户具体日期
- 时间解析失败 → 询问用户具体时间段
- 没有项目 → 提示用户先用 `/lifecoach` 创建项目
- API 调用失败 → 显示错误信息，建议检查配置

---

## 📚 进阶使用

### 配合其他 Skill

**时间记录 + 觉察分析**：
```
/timetracking
今天9-11点写代码
...

/insight
看看我这周时间都花在哪了
```

**时间记录 + 复盘**：
```
/review week
（会自动读取本周的时间记录）
```

### 快捷方式

可以不启动 Skill，直接描述时间记录：
```
今天9-11点写代码
```

AI 会自动识别并进入时间记录模式。

---

## 🔄 更新日志

### v1.0.0 (2026-06-22)
- 初始版本
- 支持自然语言日期和时间解析
- 支持批量时间记录
- 智能项目匹配推荐
- 自动写入飞书时间表
