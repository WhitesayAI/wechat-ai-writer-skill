# wechat-ai-writer-skill

> 微信公众号 AI 写作助手 - 基于 Claudian 的智能内容创作工具

[![Release](https://img.shields.io/github/v/release/WhitesayAI/wechat-ai-writer-skill)](https://github.com/WhitesayAI/wechat-ai-writer-skill/releases)
[![License](https://img.shields.io/github/license/WhitesayAI/wechat-ai-writer-skill)](LICENSE)

## 👋🏻 关于作者

**林浩** | Wechat：EmbraceAIWorld

- 👋🏻 热爱 AI 的文科打工人
- 💻 专注 AI 编程、agent、自动化
- 🌱 纯小白视角，记录学习干货

---

## 📖 简介

`wechat-ai-writer` 是一个完整的微信公众号文章管理工具，支持文章创作、提取、转换、排版和发布的全流程自动化。

**核心能力**：
- 🎨 **智能创作**：基于参考文章改写、基于标题创作、直接发布
- 📄 **提取转换**：从微信公众号链接提取文章并转换为 Markdown
- 🖼️ **智能配图**：自动生成封面和文中配图（豆包/千问）
- 🚀 **一键发布**：自动创建草稿并发布到公众号
- 🎯 **多种排版**：支持 doocs 引擎 + LINHAO-style 林浩风格
- ✍️ **写作风格**：内置浩哥风格（HAOGE-style），说人话、不制造焦虑

---

## ✨ 特性展示

### ✍️ 浩哥写作风格（HAOGE-style）

**核心原则**：说人话，给结果，不制造焦虑。

**风格特点**：
- **人设开场**：自我介绍 + 身份定位（"大家好，我是林浩！一位文科小白..."）
- **对话感强**：像朋友聊天，不用官方腔（"说白了"、"不得劲"）
- **口语化表达**：接地气，不端着（"生成了个寂寞"、"就是这么快"）
- **括号补充**：增加节奏感（"是的，在 Claude Code 的帮助下，就是这么快"）
- **共情结尾**：总结 + 共情 + CTA + 引导关注

**触发指令**：
```
使用浩哥风格
用林浩的写作风格
按照浩哥公众号风格
```

### 🎨 LINHAO-style 排版风格

专为科技干货设计的排版风格：

- **正文**：16px 字体 / 28px 行高 / 深灰色
- **标题**：绿色背景 + 白色文字 + 居中对齐
- **代码块**：GitHub Dark 风格 + macOS 三色圆点 + 语法高亮
- **提示框**：浅灰背景 + emoji 图标

**触发指令**：
```
使用 LINHAO-style 排版风格
按照林浩风格排版
```

### 智能配图

- 自动生成横屏图片（16:9 比例）
- 支持豆包和千问两个 AI 图像生成平台
- 自动压缩到合适大小（封面 800KB，配图 600KB）

---

## 📦 安装

### 方法 1：使用 skill zip 包（推荐）

1. 下载 [wechat-ai-writer-skill.zip](https://github.com/WhitesayAI/wechat-ai-writer-skill/releases/latest/download/wechat-ai-writer-skill.zip)

2. 解压到 Obsidian vault：
   ```
   skills/wechat-ai-writer/
   ```

3. 配置凭证（见下方）

### 方法 2：克隆仓库

```bash
# 克隆仓库
git clone https://github.com/WhitesayAI/wechat-ai-writer-skill.git

# 复制技能到 Claudian 技能目录
cp -r wechat-ai-writer-skill/wechat-article-publisher ~/skills/wechat-ai-writer
```

---

## 🔧 配置

### 1. 复制配置文件

```bash
cd skills/wechat-ai-writer
cp .env.example .env
```

### 2. 编辑 .env 文件

```bash
# 微信公众号凭证（必填）
WECHAT_APP_ID=你的 AppID
WECHAT_APP_SECRET=你的 AppSecret

# 图片生成 API（二选一）
# 方案 A：千问（推荐）
IMAGE_PROVIDER=qwen
DASHSCOPE_API_KEY=你的千问 APIKey

# 方案 B：豆包
# IMAGE_PROVIDER=doubao
# DOUBAO_API_KEY=你的豆包 APIKey

# Tavily 搜索 API（可选，用于联网搜索）
TAVILY_API_KEY=你的 Tavily APIKey
```

### 3. 获取凭证指南

#### 微信公众号
1. 登录 https://mp.weixin.qq.com
2. 进入「开发」→「基本配置」
3. 获取 AppID 和 AppSecret
4. 将你的服务器 IP 加入白名单

#### 阿里云千问（通义万相）
1. 访问 https://dashscope.console.aliyun.com/
2. 注册账号并创建 API Key
3. 确保开通了图像生成服务

#### 火山引擎豆包
1. 访问 https://console.volc.com/iam/keylist
2. 创建 API Key
3. 确保开通了豆包图像生成服务

#### Tavily（可选）
1. 访问 https://tavily.com/
2. 注册获取 API Key

---

## 🚀 使用

### 在 Claudian 中调用

安装配置完成后，在 Claudian 中使用以下指令：

#### 场景 1：基于参考文章改写
```
帮我改写这篇文章并发布到草稿箱：https://mp.weixin.qq.com/s/xxx
```

#### 场景 2：基于标题创作
```
写一篇关于"AI 如何提升工作效率"的文章并发布到草稿箱
```

#### 场景 3：使用林浩风格排版
```
使用 LINHAO-style 排版风格，写一篇 Claudian 教程
```

#### 场景 4：仅生成文章预览
```
写一篇关于 AI 编程的文章（先不发布）
```

---

## 📁 目录结构

```
wechat-ai-writer/
├── .env.example          # 配置模板
├── .gitignore            # Git 忽略文件
├── README.md             # 使用说明
├── INSTALL.md            # 详细安装指南
├── CONFIG.md             # 配置说明
├── SKILL.md              # 技能定义
├── LINHAO_STYLE.md       # 林浩排版风格
├── CHICKEN_SOUP_STYLE.md # 鸡汤文章风格
├── THEME_GUIDE.md        # 主题选择指南
├── HUMANIZE_GUIDE.md     # 去 AI 化写作指南
├── reader/               # 文章提取工具
├── scripts/              # Python 脚本
│   ├── generate_cover.py
│   ├── markdown_to_wechat_doocs.py
│   ├── create_draft.py
│   └── ...
└── references/           # 参考资料
```

---

## 🛠️ 脚本说明

### 核心脚本

| 脚本 | 功能 |
|------|------|
| `generate_cover.py` | 生成封面图片 |
| `markdown_to_wechat_doocs.py` | Markdown 转 HTML（doocs 排版） |
| `create_draft.py` | 创建公众号草稿 |
| `extract_to_markdown.py` | 提取公众号文章为 Markdown |
| `upload_material.py` | 上传素材到公众号 |

### 使用示例

```bash
# 生成封面
python scripts/generate_cover.py --prompt "科技风格插画" --provider qwen

# Markdown 转 HTML
python scripts/markdown_to_wechat_doocs.py --input article.md --output article.html --theme blue

# 创建草稿
python scripts/create_draft.py --title "文章标题" --content "$(cat article.html)" --thumb_media_id "xxx"
```

---

## 📝 排版风格

### 可用风格

1. **doocs 引擎**（默认）
   - orange（橙心）：温暖有活力
   - blue（蓝色）：专业理性
   - green（绿色）：清新自然
   - pink/purple：浪漫/优雅

2. **LINHAO-style**（林浩风格）
   - 适合：AI 技术教程、工具指南、代码示例
   - 特点：绿色标题、GitHub Dark 代码块

### 使用方法

```
使用 LINHAO-style 排版风格
```

或

```
按照林浩风格排版
```

---

## ⚠️ 注意事项

### 安全提示

- ⚠️ **不要提交 `.env` 文件到 Git**
- ⚠️ **妥善保管 API Key，不要泄露**
- ⚠️ **微信公众号 IP 白名单需要配置**

### 文件排除

`.gitignore` 已配置自动排除：
- `.env`（敏感配置）
- `*.jpg`, `*.png`（临时图片）
- `__pycache__/`（Python 缓存）
- `node_modules/`（Node 依赖）

---

## 📄 许可证

MIT License

---

## 🙏 致谢

- [doocs/md](https://github.com/doocs/md) - 微信公众号排版引擎
- [Claudian](https://github.com/Antropic/Claudian) - Obsidian AI 插件
- 阿里云通义万相 - AI 图像生成
- 火山引擎豆包 - AI 图像生成

---

## 📮 联系方式

- GitHub: https://github.com/WhitesayAI/wechat-ai-writer-skill
- Issues: https://github.com/WhitesayAI/wechat-ai-writer-skill/issues
