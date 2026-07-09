---
name: OPC觉察分析
description: 六维深度分析当前状态，生成洞察报告和具体改进建议
version: 1.0.0
author: 清予
category: 生产力/人生管理
tags: [OPC, 觉察, 分析, 洞察, 项目管理]
dependencies: 
  - Claude Code
  - 飞书多维表格
---

# OPC觉察分析

基于飞书真实数据，进行六维深度分析，生成洞察报告。

**一句话触发觉察**：
- "/insight" → 完整六维分析
- "看看我最近状态" → 快速觉察
- "分析一下我的时间" → 时间维度分析

AI 会自动：
1. 读取最近一段时间的所有数据
2. 从六个维度深度分析
3. 识别模式、问题和机会
4. 给出具体可执行的改进建议

---

## 📦 安装说明

### 前置条件

1. **已配置 config.yaml**
   - 路径：`~/.opc/config.yaml`
   - 包含飞书 API 配置和 Claude API 配置

2. **飞书多维表格已创建**
   - 必须有"⏰ 时间（Time）"表
   - 必须有"📈 指标（Target）"表
   - 必须有"🧾 任务（Tasks）"表
   - 必须有"🪐 项目（Project）"表

### 安装步骤

```bash
# 1. 复制文件到 Claude Code Skills 目录
cp insight.md ~/.claude/skills/opc/

# 2. 验证安装
# 在 Claude Code 中输入 /insight 能识别即成功
```

---

## 🎯 使用说明

### 启动方式

在 Claude Code 中输入：
```
/insight
```

或者直接问：
```
看看我最近状态怎么样
分析一下我的时间投入
我的项目进展如何
```

### 交互示例

```
你: /insight

AI: 正在读取最近30天数据...

📊 数据范围
- 时间跨度：2026-05-23 至 2026-06-22
- 时间记录：142 条，总计 178 小时
- 活跃项目：3 个
- 进行中指标：12 个
- 活跃任务：23 个

开始六维分析...

---

# 觉察分析报告

## 一、时间投入维度

### 总体画像
- **总工作时长**：178 小时（约 6 小时/天）
- **工作强度**：中等偏高
- **时间分布**：工作日 145h，周末 33h
- **碎片化指数**：1.8 小时/次（偏碎片）

### 项目时间分布
1. **OPC系统开发**：82h（46%）
   - 趋势：持续上升
   - 单次平均：2.1h
   - 评价：深度工作时间充足

2. **公众号运营**：68h（38%）
   - 趋势：波动较大
   - 单次平均：1.3h
   - 评价：碎片化严重

3. **个人品牌建设**：28h（16%）
   - 趋势：逐渐减少
   - 单次平均：1.5h
   - 评价：投入不足

### 时间质量分析
✓ **深度工作时间**：54h（30%）← 单次 ≥2h
⚠ **碎片时间**：124h（70%）← 单次 <2h
⚠ **低效时段**：周一上午、周五下午效率偏低

### 核心洞察
1. **OPC开发是当前重点**，时间投入和质量都不错
2. **公众号严重碎片化**，需要固定大块时间
3. **个人品牌被边缘化**，要么加大投入，要么暂停

---

## 二、项目进展维度

### 项目健康度
1. **OPC系统开发**：🟢 健康
   - 指标完成率：75%（3/4个指标进展良好）
   - 时间投入：充足且持续
   - 瓶颈：无明显瓶颈
   - 预计：可按时完成

2. **公众号运营**：🟡 亚健康
   - 指标完成率：40%（2/5个指标进展良好）
   - 时间投入：碎片化，质量不高
   - 瓶颈：流量获取、内容质量
   - 预计：难以达成目标

3. **个人品牌建设**：🔴 停滞
   - 指标完成率：15%（0/3个指标进展良好）
   - 时间投入：不足且不稳定
   - 瓶颈：优先级低，无明确方向
   - 预计：本月无法达成

### 核心洞察
1. **精力过度分散**：3个项目同时推进，实际只有1个健康
2. **公众号假努力**：投入38%时间，产出不匹配
3. **品牌项目应暂停**：与其做不好，不如暂停聚焦

---

## 三、指标达成维度

### 完成情况分布
- **进展良好**（≥70%）：5个
- **正常进展**（30%-70%）：4个
- **进展缓慢**（<30%）：3个

### 进展良好的指标
1. OPC系统 - 功能迭代（85%）
2. OPC系统 - bug修复（90%）
3. 公众号 - 发文数量（75%）
4. 公众号 - 文章字数（80%）
5. 个人 - 时间记录天数（100%）

### 进展缓慢的指标
1. 公众号 - 新增粉丝（18%）← **严重滞后**
2. 公众号 - 文章阅读量（22%）
3. 品牌 - 小红书爆文（0%）

### 类型分析
✓ **投入型指标**（做了多少）：完成良好
✗ **结果型指标**（拿到什么）：严重滞后

### 核心洞察
1. **执行力没问题**，每周稳定产出
2. **但方向可能有问题**，忙碌不等于有效
3. **流量和结果严重不足**，需要策略调整

---

## 四、投入产出比维度

### ROI分析
**高ROI项目**：
- OPC系统：46%时间 → 75%目标达成 = 1.63x

**低ROI项目**：
- 公众号：38%时间 → 40%目标达成 = 1.05x
- 个人品牌：16%时间 → 15%目标达成 = 0.94x

### 时间性价比
- **最值得投入**：OPC系统（投入转化率高）
- **需要优化**：公众号（投入多产出少）
- **建议暂停**：个人品牌（投入产出倒挂）

### 核心洞察
1. **OPC是当前最优策略**，继续加大投入
2. **公众号需要质变**，不是投入更多时间，是改变方法
3. **品牌项目应果断暂停**，等OPC和公众号稳定后再说

---

## 五、执行力维度

### 任务完成情况
- **总任务数**：23个
- **已完成**：15个（65%）
- **未完成**：8个（35%）

### 完成率分析
- **高频任务**（每天/每周）：90%完成率
  - 有提醒机制的：95%
  - 无提醒机制的：75%
  
- **低频任务**（一次性）：30%完成率
  - 重要但不紧急的：10%
  - 数据分析类：0%

### 拖延模式识别
**总是被拖延的任务**：
1. 数据分析报告（拖延3次）
2. 对标账号研究（拖延4次）
3. 小红书选题库（从未开始）

**拖延原因**：
- 没有明确产出物（不知道做完什么样）
- 没有提醒机制（容易忘记）
- 不喜欢做（心理抗拒）

### 核心洞察
1. **执行力整体良好**，有提醒就能做到
2. **一次性任务是死穴**，需要强制提醒
3. **数据分析类总是拖延**，要么外包，要么固定时段硬做

---

## 六、情绪状态维度

### 时间投入与心理状态
**从时间分布看心理状态**：
- 周末仍有33h工作 → **休息不足，可能焦虑**
- 周五下午效率低 → **疲劳累积**
- 碎片时间占70% → **可能被各种事情打断，缺乏掌控感**

**从任务完成看心理状态**：
- 高频任务完成良好 → **在确定性中有安全感**
- 低频任务大量拖延 → **面对不确定性时会逃避**
- 数据分析0完成 → **对某类任务有心理抗拒**

### 可能的心理状态
⚠ **轻度焦虑**：周末无法休息，总想做点什么
⚠ **掌控感不足**：时间碎片化，被动响应多
⚠ **完美主义倾向**：不确定做不好就不开始

### 核心洞察
1. **你需要更多休息**，焦虑可能来自疲劳
2. **你需要更多掌控感**，固定大块时间
3. **你需要降低标准**，先开始再优化

---

## 七、综合诊断

### 核心问题（最重要的3个）
1. **精力分散，无法聚焦**
   - 3个项目同时推进，实际只有1个健康
   - 建议：暂停个人品牌，聚焦OPC+公众号

2. **公众号假努力陷阱**
   - 投入38%时间，但结果型指标严重滞后
   - 建议：不是更努力，是改方法（对标、测试、优化）

3. **时间碎片化严重**
   - 70%时间是碎片，深度工作不足
   - 建议：每天固定1个3小时深度工作块

### 优势保持
✓ 执行力强，有提醒就能做到
✓ OPC项目推进顺利，时间质量高
✓ 时间记录习惯已养成

### 三个具体改进动作
1. **下周一早上**：暂停个人品牌所有任务，时间全部投入OPC和公众号
2. **下周二开始**：每天9-12点固定深度工作块，专注OPC或公众号写作
3. **下周五下午**：固定做数据分析，先做15分钟（降低心理门槛）

---

✅ 觉察分析完成
```

---

## 🧠 核心能力

### 1. 六维分析框架

**时间投入维度**：
- 总时长、强度、分布
- 项目占比、趋势
- 碎片化指数
- 深度工作占比

**项目进展维度**：
- 项目健康度（健康/亚健康/停滞）
- 指标完成率
- 瓶颈识别
- 进度预测

**指标达成维度**：
- 完成情况分布
- 进展良好 vs 缓慢
- 投入型 vs 结果型
- 类型分析

**投入产出比维度**：
- ROI计算（目标达成/时间投入）
- 时间性价比
- 最优策略识别

**执行力维度**：
- 任务完成率
- 高频 vs 低频
- 拖延模式识别
- 拖延原因分析

**情绪状态维度**：
- 从时间分布推测心理状态
- 从任务模式推测情绪
- 识别焦虑、疲劳、掌控感
- 心理建议

### 2. 模式识别

自动识别以下模式：
- **假努力陷阱**：投入多但结果少
- **精力分散**：多个项目同时推进但都不好
- **时间碎片化**：单次工作时长太短
- **执行拖延**：特定类型任务总是拖延
- **休息不足**：周末持续工作
- **完美主义**：不确定做不好就不开始

### 3. 洞察生成

每个维度都生成：
- **现状描述**（基于数据）
- **趋势分析**（变化方向）
- **问题识别**（瓶颈在哪）
- **核心洞察**（最重要的发现）

### 4. 可执行建议

所有建议都是：
- **具体到动作**（不是"要努力"，是"每天9-12点"）
- **有明确时间**（下周一、下周二）
- **可验证**（能检查是否做到）
- **优先级明确**（最重要的3个）

---

## 🔧 技术实现

### API 函数库

```python
import yaml
import requests
from pathlib import Path
from datetime import datetime, timedelta
from collections import defaultdict
import statistics

# ============ 配置读取 ============

def load_config():
    """读取 ~/.opc/config.yaml 配置"""
    config_path = Path.home() / ".opc" / "config.yaml"
    with open(config_path, 'r', encoding='utf-8') as f:
        return yaml.safe_load(f)

# ============ 飞书 API ============
# （与 review.md 相同的 API 函数，此处省略）

# ============ 高级分析函数 ============

def calculate_fragmentation_index(time_records):
    """计算时间碎片化指数
    
    返回：平均单次工作时长（小时）
    """
    durations = []
    for record in time_records:
        fields = record["fields"]
        duration = fields.get("耗时(小时)", 0)
        if duration > 0:
            durations.append(duration)
    
    return round(statistics.mean(durations), 1) if durations else 0

def identify_deep_work_sessions(time_records, threshold=2.0):
    """识别深度工作时段
    
    threshold: 单次工作时长阈值（小时）
    返回：深度工作总时长、占比
    """
    total_hours = 0
    deep_work_hours = 0
    
    for record in time_records:
        fields = record["fields"]
        duration = fields.get("耗时(小时)", 0)
        total_hours += duration
        
        if duration >= threshold:
            deep_work_hours += duration
    
    ratio = (deep_work_hours / total_hours * 100) if total_hours > 0 else 0
    
    return {
        "deep_work_hours": round(deep_work_hours, 1),
        "total_hours": round(total_hours, 1),
        "ratio": round(ratio, 1)
    }

def calculate_project_roi(project_name, time_records, indicator_records):
    """计算项目ROI
    
    ROI = 指标平均完成率 / 时间投入占比
    """
    # 计算该项目的时间投入占比
    total_hours = sum(r["fields"].get("耗时(小时)", 0) for r in time_records)
    project_hours = sum(
        r["fields"].get("耗时(小时)", 0) 
        for r in time_records 
        if project_name in str(r["fields"].get("所属项目", []))
    )
    time_ratio = (project_hours / total_hours) if total_hours > 0 else 0
    
    # 计算该项目的指标平均完成率
    project_indicators = [
        ind for ind in indicator_records
        if project_name in str(ind["fields"].get("所属项目", []))
    ]
    
    if not project_indicators:
        return 0
    
    completion_rates = []
    for ind in project_indicators:
        fields = ind["fields"]
        target = fields.get("目标值", 0)
        current = fields.get("完成值", 0)
        if target > 0:
            completion_rates.append(current / target)
    
    avg_completion = statistics.mean(completion_rates) if completion_rates else 0
    
    # ROI = 完成率 / 时间占比
    roi = (avg_completion / time_ratio) if time_ratio > 0 else 0
    
    return round(roi, 2)

def identify_procrastination_patterns(task_records):
    """识别拖延模式
    
    返回：总是被拖延的任务列表及原因
    """
    uncompleted = [
        r for r in task_records 
        if r["fields"].get("是否完成", "未完成") == "未完成"
    ]
    
    # 分析拖延原因（启发式规则）
    patterns = []
    
    for task in uncompleted:
        fields = task["fields"]
        task_name = fields.get("任务名称", "")
        reminder = fields.get("提醒机制", "")
        
        reasons = []
        
        # 没有提醒机制 → 容易忘记
        if not reminder or reminder == "手动触发":
            reasons.append("没有提醒机制")
        
        # 任务名称包含"分析""报告""研究" → 产出物不明确
        if any(word in task_name for word in ["分析", "报告", "研究", "总结"]):
            reasons.append("产出物不明确")
        
        # 任务名称包含"数据" → 可能有心理抗拒
        if "数据" in task_name:
            reasons.append("可能有心理抗拒")
        
        if reasons:
            patterns.append({
                "task": task_name,
                "reasons": reasons
            })
    
    return patterns

def infer_psychological_state(time_records, task_records):
    """从数据推测心理状态
    
    返回：可能的心理状态列表
    """
    states = []
    
    # 分析周末工作情况
    weekend_hours = 0
    for record in time_records:
        fields = record["fields"]
        start_ts = fields.get("开始时间", 0)
        if start_ts:
            dt = datetime.fromtimestamp(start_ts / 1000)
            if dt.weekday() >= 5:  # 周六周日
                weekend_hours += fields.get("耗时(小时)", 0)
    
    if weekend_hours > 10:
        states.append({
            "state": "轻度焦虑",
            "evidence": f"周末工作{weekend_hours}小时，休息不足",
            "suggestion": "强制周日完全休息"
        })
    
    # 分析时间碎片化
    frag_index = calculate_fragmentation_index(time_records)
    if frag_index < 1.5:
        states.append({
            "state": "掌控感不足",
            "evidence": f"平均单次工作{frag_index}小时，碎片化严重",
            "suggestion": "每天设置3小时深度工作块"
        })
    
    # 分析拖延模式
    patterns = identify_procrastination_patterns(task_records)
    if len(patterns) >= 3:
        states.append({
            "state": "完美主义倾向",
            "evidence": f"{len(patterns)}个任务长期拖延，可能是不确定做不好就不开始",
            "suggestion": "降低标准，先开始15分钟再说"
        })
    
    return states
```

---

## 💡 Skill Prompt

当用户启动 `/insight` 时，你进入**觉察分析模式**。

### 工作流程

**Step 1：确定分析时间范围**

默认：最近30天

```python
end = datetime.now()
start = end - timedelta(days=30)
start_ts = datetime_to_timestamp(start)
end_ts = datetime_to_timestamp(end)
```

**Step 2：读取数据**

```python
config = load_config()
token = get_tenant_access_token(config["feishu"]["app_id"], config["feishu"]["app_secret"])

# 读取所有表的数据
time_records = get_records_in_timerange(...)
indicator_records = get_all_records(...)
task_records = get_records_in_timerange(...)
project_records = get_all_records(...)
```

**Step 3：六维分析**

逐个维度执行分析：

```python
# 1. 时间投入维度
time_analysis = analyze_time_investment(time_records)
fragmentation = calculate_fragmentation_index(time_records)
deep_work = identify_deep_work_sessions(time_records)

# 2. 项目进展维度
project_health = analyze_project_health(time_records, indicator_records)

# 3. 指标达成维度
indicator_analysis = analyze_indicator_completion(indicator_records)

# 4. 投入产出比维度
roi_analysis = calculate_all_projects_roi(time_records, indicator_records)

# 5. 执行力维度
execution_analysis = analyze_execution(task_records)
procrastination = identify_procrastination_patterns(task_records)

# 6. 情绪状态维度
psychological_state = infer_psychological_state(time_records, task_records)
```

**Step 4：生成报告**

使用 AI 将分析结果整合成结构化报告（见交互示例）。

报告结构：
- 数据范围说明
- 六个维度分析（每个维度：现状+趋势+问题+洞察）
- 综合诊断（核心问题、优势保持、具体改进动作）

**Step 5：展示报告**

直接展示给用户，**不写入飞书**（insight 是即时分析，不需要存档）。

### 分析深度

**浅层分析**（数据层）：
- 统计数字（总时长、完成率等）
- 分布情况（项目占比等）

**中层分析**（模式层）：
- 趋势变化（上升、下降、波动）
- 模式识别（碎片化、拖延等）

**深层分析**（洞察层）：
- 因果关系（为什么会这样）
- 问题诊断（核心症结在哪）
- 心理推测（可能的心理状态）

**建议层**（行动层）：
- 具体动作（下周一做什么）
- 优先级（最重要的3个）
- 可验证性（能检查是否做到）

### 错误处理

- **数据不足** → 提示用户至少需要7天数据才能分析
- **没有时间记录** → 提示用户先用 `/timetracking` 记录时间
- **API失败** → 显示错误，建议检查配置

---

## 📚 进阶使用

### 配合其他 Skill

**觉察 → 复盘**：
```
/insight
（发现问题和模式）

/review week
（基于觉察做深度复盘）
```

**觉察 → 任务调整**：
```
/insight
（发现某些任务总是拖延）

/taskmanager
（调整任务设置，增加提醒）
```

### 定期觉察

建议：
- **每周做一次觉察**，保持对自己状态的敏感
- **月初做一次深度觉察**，调整月度策略

---

## 🔄 更新日志

### v1.0.0 (2026-06-22)
- 初始版本
- 六维分析框架
- 模式识别与洞察生成
- 心理状态推测
- 可执行改进建议
