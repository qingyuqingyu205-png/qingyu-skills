---
name: OPC复盘
description: 基于真实数据生成周复盘/月复盘报告，并制定下阶段计划
version: 1.0.0
author: 清予
category: 生产力/人生管理
tags: [OPC, 复盘, 反思, 项目管理]
dependencies: 
  - Claude Code
  - 飞书多维表格
---

# OPC复盘

基于飞书真实数据，AI 生成周复盘或月复盘报告。

**一句话触发复盘**：
- "/review week" → 本周复盘
- "/review month" → 本月复盘
- "复盘" → 默认本周复盘

AI 会自动：
1. 读取时间段内的所有数据（项目、指标、时间、任务）
2. 分析时间投入、目标达成、执行情况
3. 生成结构化复盘报告
4. 给出下阶段具体建议
5. 写入飞书复盘表

---

## 📦 安装说明

### 前置条件

1. **已配置 config.yaml**
   - 路径：`~/.opc/config.yaml`
   - 包含飞书 API 配置和 Claude API 配置

2. **飞书多维表格已创建**
   - 必须有"📝 复盘（Review）"表
   - 必须有"⏰ 时间（Time）"表
   - 必须有"📈 指标（Target）"表
   - 必须有"🧾 任务（Tasks）"表
   - 必须有"🪐 项目（Project）"表

### 安装步骤

```bash
# 1. 复制文件到 Claude Code Skills 目录
cp review.md ~/.claude/skills/opc/

# 2. 验证安装
# 在 Claude Code 中输入 /review 能识别即成功
```

---

## 🎯 使用说明

### 启动方式

在 Claude Code 中输入：
```
/review week    # 本周复盘
/review month   # 本月复盘
/review         # 默认本周复盘
```

或者直接说：
```
复盘
周复盘
月复盘
```

### 交互示例

**场景1：周复盘**

```
你: /review week

AI: 正在读取本周数据...

📊 数据汇总
- 时间范围：2026-06-16 至 2026-06-22
- 时间记录：35 条，总计 42.5 小时
- 进行中项目：3 个
- 指标完成情况：8/12 个指标有进展
- 任务完成情况：15/23 个任务已完成

开始生成复盘报告...

---

# 本周复盘（2026-06-16 至 2026-06-22）

## 一、时间投入分析

### 总体数据
- 总工作时长：42.5 小时
- 平均每天：6.1 小时
- 工作日投入：35 小时
- 周末投入：7.5 小时

### 项目时间分布
1. **OPC系统开发**：18 小时（42%）
   - 主要工作：新功能开发、bug修复
   - 时间趋势：前期集中，后期减少
   
2. **公众号运营**：15 小时（35%）
   - 主要工作：写作、排版、数据分析
   - 时间趋势：平稳

3. **个人品牌建设**：9.5 小时（23%）
   - 主要工作：小红书内容、社群运营
   - 时间趋势：周末集中

### 洞察
✓ OPC开发占比最高，符合当前重点
⚠ 公众号写作时间碎片化，建议固定时段
⚠ 周末休息不足，需要调整节奏

---

## 二、目标达成情况

### 进展良好（5个）
1. **OPC系统开发 - 功能迭代**
   - 目标：20个功能点，完成 15个
   - 进度：75%
   - 评价：进度超预期

2. **公众号运营 - 发布文章数**
   - 目标：4篇，完成 3篇
   - 进度：75%
   - 评价：基本达标

...（其他指标）

### 进展缓慢（3个）
1. **公众号运营 - 新增粉丝数**
   - 目标：+200人，实际 +45人
   - 进度：22.5%
   - 原因：流量获取不足，内容吸引力弱

2. **个人品牌 - 小红书爆文数**
   - 目标：1篇，完成 0篇
   - 进度：0%
   - 原因：选题和内容质量未达标

...

### 洞察
✓ 执行型指标（发文、迭代）完成良好
⚠ 结果型指标（粉丝、爆文）严重滞后
→ 下周重点：从"做了多少"转向"有没有效果"

---

## 三、任务执行情况

### 完成任务（15个）
- 每周一三五更新公众号 ✓
- OPC功能开发任务 ✓
- 小红书内容发布 ✓
...

### 未完成任务（8个）
- 公众号数据分析报告 ✗（原因：时间不够）
- 对标账号研究 ✗（原因：拖延）
- 小红书选题库建立 ✗（原因：优先级低）
...

### 执行力分析
- 任务完成率：65%（15/23）
- 高频任务完成率：90%（有提醒机制的）
- 低频任务完成率：30%（没有提醒的）

### 洞察
✓ 有提醒机制的任务执行良好
⚠ 一次性任务容易被拖延
→ 建议：重要的一次性任务也设置提醒

---

## 四、问题识别

### 严重问题
1. **时间碎片化严重**
   - 表现：单次工作时长平均 1.2 小时
   - 影响：深度工作不足，效率低
   - 建议：设置 3 小时深度工作块

2. **结果导向不足**
   - 表现：大量时间花在执行上，但结果不明显
   - 影响：忙碌但无效果
   - 建议：每天先问"今天要拿到什么结果"

### 轻微问题
1. **周末无法完全休息**
   - 表现：周末仍有 7.5 小时工作
   - 建议：周日完全休息

2. **数据分析类任务总是拖延**
   - 原因：不喜欢做
   - 建议：固定在周五下午做

---

## 五、下周计划

### 核心目标（最重要的3件事）
1. **拿到公众号爆文**
   - 具体：1篇阅读5000+的文章
   - 时间投入：12 小时
   - 关键动作：对标分析、标题测试、开头优化

2. **OPC系统完成 v1.0 上线**
   - 具体：剩余 5 个功能全部完成
   - 时间投入：15 小时
   - 关键动作：集中开发、测试、文档

3. **小红书建立选题库**
   - 具体：30个选题+10个爆款拆解
   - 时间投入：6 小时
   - 关键动作：对标研究、用户调研

### 时间分配计划
- OPC开发：15 小时（周一到周三）
- 公众号：12 小时（周四周五）
- 小红书：6 小时（周六）
- 周日：完全休息

### 执行策略
1. 每天设置 1 个 3 小时深度工作块
2. 周五下午固定做数据分析
3. 结果导向：每天早上先定"今天要拿到什么结果"

---

## 六、本周亮点

🌟 OPC系统开发进度超预期
🌟 公众号保持稳定更新
🌟 时间记录习惯已养成

---

✅ 复盘报告已写入飞书
```

**场景2：月复盘**

```
你: /review month

AI: 正在读取本月数据（2026-06-01 至 2026-06-22）...

（生成类似结构的月度复盘报告，时间跨度更长，分析更宏观）
```

---

## 🧠 核心能力

### 1. 数据读取与聚合

从飞书读取指定时间段的所有数据：
- **时间记录**：按项目聚合时长
- **指标进展**：对比目标值和完成值
- **任务完成**：统计完成率
- **项目状态**：识别进行中/暂停/完成

### 2. 多维度分析

**时间维度**：
- 总工作时长、平均每天时长
- 工作日 vs 周末分布
- 项目时间占比
- 时间趋势变化

**目标维度**：
- 指标完成进度
- 进展良好 vs 进展缓慢
- 目标达成率

**执行维度**：
- 任务完成率
- 高频 vs 低频任务差异
- 执行力分析

**问题识别**：
- 时间碎片化
- 结果导向不足
- 休息不足
- 特定类型任务拖延

### 3. 洞察生成

基于数据自动生成洞察：
- **趋势洞察**：时间投入的变化趋势
- **效率洞察**：忙碌 vs 有效的对比
- **问题洞察**：识别执行中的瓶颈
- **机会洞察**：发现可优化的点

### 4. 下阶段计划

基于复盘结果制定计划：
- **核心目标**：最重要的3件事（SMART原则）
- **时间分配**：具体到每个项目的小时数
- **执行策略**：可操作的具体动作
- **改进措施**：针对问题的解决方案

---

## 🔧 技术实现

### API 函数库

```python
import yaml
import requests
from pathlib import Path
from datetime import datetime, timedelta
from collections import defaultdict

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

def get_records_in_timerange(app_token, table_id, start_ts, end_ts, token, time_field="记录添加时间"):
    """获取时间范围内的记录"""
    url = f"https://open.feishu.cn/open-api/bitable/v1/apps/{app_token}/tables/{table_id}/records"
    headers = {"Authorization": f"Bearer {token}"}
    
    all_records = []
    page_token = None
    
    while True:
        params = {"page_size": 500}
        if page_token:
            params["page_token"] = page_token
        
        response = requests.get(url, headers=headers, params=params)
        data = response.json()
        
        if data.get("code") == 0:
            records = data["data"]["items"]
            
            # 过滤时间范围
            for record in records:
                fields = record["fields"]
                record_time = fields.get(time_field, 0)
                if start_ts <= record_time <= end_ts:
                    all_records.append(record)
            
            # 检查是否有下一页
            if data["data"].get("has_more"):
                page_token = data["data"]["page_token"]
            else:
                break
        else:
            break
    
    return all_records

def create_review_record(app_token, table_id, fields, token):
    """创建复盘记录"""
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
        raise Exception(f"创建复盘记录失败: {data}")

# ============ 时间范围计算 ============

def get_week_range():
    """获取本周时间范围（周一到周日）"""
    today = datetime.now()
    weekday = today.weekday()  # 0=周一, 6=周日
    
    # 本周一
    start = today - timedelta(days=weekday)
    start = start.replace(hour=0, minute=0, second=0, microsecond=0)
    
    # 本周日
    end = start + timedelta(days=6, hours=23, minutes=59, seconds=59)
    
    return start, end

def get_month_range():
    """获取本月时间范围"""
    today = datetime.now()
    
    # 本月1日
    start = today.replace(day=1, hour=0, minute=0, second=0, microsecond=0)
    
    # 本月最后一天
    if today.month == 12:
        next_month = today.replace(year=today.year + 1, month=1, day=1)
    else:
        next_month = today.replace(month=today.month + 1, day=1)
    end = next_month - timedelta(seconds=1)
    
    return start, end

def datetime_to_timestamp(dt):
    """将 datetime 转为毫秒时间戳"""
    return int(dt.timestamp() * 1000)

def timestamp_to_datetime(ts):
    """将毫秒时间戳转为 datetime"""
    return datetime.fromtimestamp(ts / 1000)

# ============ 数据分析 ============

def analyze_time_records(records):
    """分析时间记录
    
    返回：{
        "total_hours": 总时长,
        "by_project": {项目: 时长},
        "by_day": {日期: 时长},
        "avg_session": 平均单次时长
    }
    """
    total_hours = 0
    by_project = defaultdict(float)
    by_day = defaultdict(float)
    sessions = []
    
    for record in records:
        fields = record["fields"]
        
        # 获取时长（耗时字段是formula，已计算好）
        # 如果有"耗时(小时)"字段直接读取
        duration = fields.get("耗时(小时)", 0)
        
        # 如果没有，则从开始结束时间计算
        if not duration:
            start_ts = fields.get("开始时间", 0)
            end_ts = fields.get("结束时间", 0)
            if start_ts and end_ts:
                duration = (end_ts - start_ts) / (1000 * 3600)  # 转为小时
        
        total_hours += duration
        sessions.append(duration)
        
        # 按项目聚合
        project_info = fields.get("所属项目", [])
        if project_info:
            project_name = project_info[0].get("text", "未分类")
            by_project[project_name] += duration
        
        # 按日期聚合
        start_ts = fields.get("开始时间", 0)
        if start_ts:
            date = timestamp_to_datetime(start_ts).strftime("%Y-%m-%d")
            by_day[date] += duration
    
    avg_session = sum(sessions) / len(sessions) if sessions else 0
    
    return {
        "total_hours": round(total_hours, 1),
        "by_project": dict(by_project),
        "by_day": dict(by_day),
        "avg_session": round(avg_session, 1),
        "record_count": len(records)
    }

def analyze_indicators(records):
    """分析指标完成情况
    
    返回：{
        "total": 总数,
        "completed": 已完成,
        "in_progress": 进行中,
        "good": 进展良好列表,
        "slow": 进展缓慢列表
    }
    """
    good = []  # 进度 >= 70%
    slow = []  # 进度 < 30%
    in_progress = []  # 30% <= 进度 < 70%
    
    for record in records:
        fields = record["fields"]
        
        indicator = {
            "name": fields.get("指标名称", ""),
            "target": fields.get("目标值", 0),
            "current": fields.get("完成值", 0),
            "progress": 0
        }
        
        # 计算进度
        if indicator["target"] > 0:
            indicator["progress"] = (indicator["current"] / indicator["target"]) * 100
        
        # 获取所属项目
        project_info = fields.get("所属项目", [])
        if project_info:
            indicator["project"] = project_info[0].get("text", "")
        
        # 分类
        if indicator["progress"] >= 70:
            good.append(indicator)
        elif indicator["progress"] < 30:
            slow.append(indicator)
        else:
            in_progress.append(indicator)
    
    return {
        "total": len(records),
        "good": good,
        "slow": slow,
        "in_progress": in_progress
    }

def analyze_tasks(records):
    """分析任务完成情况
    
    返回：{
        "total": 总数,
        "completed": 已完成数,
        "completion_rate": 完成率,
        "completed_list": 已完成列表,
        "uncompleted_list": 未完成列表
    }
    """
    completed = []
    uncompleted = []
    
    for record in records:
        fields = record["fields"]
        
        task = {
            "name": fields.get("任务名称", ""),
            "status": fields.get("是否完成", "未完成")
        }
        
        # 获取推进指标
        indicator_info = fields.get("推进指标", [])
        if indicator_info:
            task["indicator"] = indicator_info[0].get("text", "")
        
        if task["status"] == "已完成":
            completed.append(task)
        else:
            uncompleted.append(task)
    
    total = len(records)
    completion_rate = (len(completed) / total * 100) if total > 0 else 0
    
    return {
        "total": total,
        "completed": len(completed),
        "completion_rate": round(completion_rate, 1),
        "completed_list": completed,
        "uncompleted_list": uncompleted
    }
```

---

## 💡 Skill Prompt

当用户启动 `/review` 时，你进入**复盘模式**。

### 工作流程

**Step 1：确定复盘周期**

用户输入：`/review week` 或 `/review month` 或 `复盘`

如果没有明确指定，默认为周复盘。

**Step 2：计算时间范围**

```python
if period == "week":
    start, end = get_week_range()
elif period == "month":
    start, end = get_month_range()

start_ts = datetime_to_timestamp(start)
end_ts = datetime_to_timestamp(end)
```

**Step 3：读取数据**

```python
config = load_config()
token = get_tenant_access_token(config["feishu"]["app_id"], config["feishu"]["app_secret"])

# 读取时间记录
time_table_id = get_table_id_by_name(app_token, "时间", token)
time_records = get_records_in_timerange(app_token, time_table_id, start_ts, end_ts, token, "开始时间")

# 读取指标（所有指标，不限时间）
indicator_table_id = get_table_id_by_name(app_token, "指标", token)
indicator_records = get_all_records(app_token, indicator_table_id, token)

# 读取任务（这个周期内添加的任务）
task_table_id = get_table_id_by_name(app_token, "任务", token)
task_records = get_records_in_timerange(app_token, task_table_id, start_ts, end_ts, token, "记录添加日期")
```

**Step 4：数据分析**

```python
time_analysis = analyze_time_records(time_records)
indicator_analysis = analyze_indicators(indicator_records)
task_analysis = analyze_tasks(task_records)
```

**Step 5：生成复盘报告**

使用 AI 生成结构化报告（见交互示例）。

报告结构：
1. **数据汇总**：总体数据概览
2. **时间投入分析**：总时长、项目分布、趋势、洞察
3. **目标达成情况**：进展良好/缓慢的指标、洞察
4. **任务执行情况**：完成/未完成、执行力分析、洞察
5. **问题识别**：严重/轻微问题、原因、建议
6. **下阶段计划**：核心目标、时间分配、执行策略
7. **本周亮点**：正向反馈

**Step 6：写入飞书**

```python
review_table_id = get_table_id_by_name(app_token, "复盘", token)

fields = {
    "复盘时间": datetime_to_timestamp(datetime.now()),
    "复盘周期": "周复盘" if period == "week" else "月复盘",
    "复盘报告": report_text  # markdown格式的完整报告
}

create_review_record(app_token, review_table_id, fields, token)
```

**Step 7：确认完成**

```
✅ 复盘报告已生成并写入飞书
- 复盘周期：本周（2026-06-16 至 2026-06-22）
- 报告字数：约 2500 字
- 核心洞察：3 条
- 下周目标：3 个
```

### 报告生成规范

1. **基于数据**：所有结论都要有数据支撑
2. **具体可行**：建议要具体到动作层面
3. **正向为主**：先肯定亮点，再指出问题
4. **SMART原则**：下阶段目标要符合SMART
5. **结构清晰**：用markdown标题和列表

### 错误处理

- **没有数据** → 提示用户这个周期没有记录，无法复盘
- **数据不完整** → 标注"部分数据缺失"，尽量生成
- **API失败** → 显示错误，建议检查配置

---

## 📚 进阶使用

### 配合其他 Skill

**复盘 + 时间记录**：
```
/timetracking
（记录本周时间）

/review week
（基于时间记录生成复盘）
```

**复盘 + 觉察分析**：
```
/insight
（深度分析当前状态）

/review week
（结合觉察生成复盘）
```

### 定期复盘习惯

建议：
- **每周日晚上** → 周复盘
- **每月最后一天** → 月复盘

可以配合任务提醒：
```
/taskmanager
每周日晚上8点做周复盘
```

---

## 🔄 更新日志

### v1.0.0 (2026-06-22)
- 初始版本
- 支持周复盘和月复盘
- 多维度数据分析（时间、目标、任务）
- 自动生成洞察和下阶段计划
- 写入飞书复盘表
