# 林浩风格排版指南 (LINHAO-style)

> **风格来源**：林浩学 AI 编程公众号
> **风格定位**：科技干货、简洁专业、视觉舒适
> **适用场景**：AI 技术教程、工具使用指南、效率提升类文章

---

## 🎨 整体视觉规范

### 基础样式
```html
<section style="font-size: 16px; line-height: 28px; color: rgb(63, 63, 63);">
```

| 属性 | 值 | 说明 |
|------|-----|------|
| 字体大小 | 16px | 正文字号 |
| 行高 | 28px | 行间距 |
| 文字颜色 | rgb(63, 63, 63) | 深灰色，易阅读 |
| 段落间距 | margin-bottom: 24px | 段与段之间 |

---

## 📐 标题样式

### H2 章节标题（绿色背景）

```html
<section style="margin-bottom: 24px; text-align: center;">
  <section style="background-color: rgb(0, 152, 116); padding: 6px 25px; border-radius: 4px; display: inline-block;">
    <strong style="color: rgb(255, 255, 255); font-size: 18px;">标题文字</strong>
  </section>
</section>
```

**样式特点**：
- 背景色：`rgb(0, 152, 116)` 林浩绿
- 文字：白色，18px，加粗
- 圆角：4px
- 内边距：上下 6px，左右 25px
- 居中对齐，背景自适应文字宽度

---

## 💻 代码块样式（GitHub Dark 风格）

### 样式规范

```html
<section style="background-color: rgb(39, 46, 61); padding: 20px; border-radius: 8px; margin: 24px 0; font-size: 14px; line-height: 1.8; font-family: Consolas, 'Courier New', monospace;">
<span style="color: rgb(255, 95, 87);">●</span><span style="color: rgb(255, 189, 46);">●</span><span style="color: rgb(52, 199, 89);">●</span><br/><br/>
<!-- 代码内容 -->
</section>
```

### 颜色方案

| 元素 | 颜色 | RGB 值 |
|------|------|--------|
| 背景色 | 深蓝灰 | rgb(39, 46, 61) |
| macOS 圆点 1 | 红色 | rgb(255, 95, 87) |
| macOS 圆点 2 | 黄色 | rgb(255, 189, 46) |
| macOS 圆点 3 | 绿色 | rgb(52, 199, 89) |
| 注释 | 灰色 | rgb(106, 122, 141) |
| 变量名 | 紫色 | rgb(198, 120, 200) |
| 变量值 | 绿色 | rgb(140, 190, 120) |

---

## 💡 提示框样式

```html
<section style="background-color: rgb(245, 245, 245); padding: 16px; border-radius: 4px; margin: 24px 0;">
<p style="margin-bottom: 0; font-size: 15px;">💡 <strong>提示：</strong>提示内容</p>
</section>
```

---

## ➖ 分隔线样式

```html
<section style="margin-top: 32px; margin-bottom: 32px; border-top: 1px solid rgb(217, 217, 217);"></section>
```

---

**风格名称**：LINHAO-style
**版本**：1.0
**最后更新**：2026-04-08
