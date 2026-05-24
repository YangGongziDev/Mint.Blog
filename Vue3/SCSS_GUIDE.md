# SCSS 使用指南

本项目已完成 SCSS 配置，可以在 Vue 组件中使用 SCSS 的所有功能。

## 📁 文件结构

```
src/
├── styles/
│   ├── variables.scss    # 全局变量
│   ├── mixins.scss       # 混合器
│   └── global.scss       # 全局样式
├── main.ts               # 导入全局样式
└── vite.config.ts        # SCSS 配置
```

## 🎨 全局变量 (variables.scss)

### 颜色变量
```scss
$primary-color: #409eff;     // 主色
$success-color: #67c23a;     // 成功色
$warning-color: #e6a23c;     // 警告色
$danger-color: #f56c6c;      // 危险色
$info-color: #909399;        // 信息色
```

### 文本颜色
```scss
$text-primary: #303133;      // 主要文本
$text-regular: #606266;      // 常规文本
$text-secondary: #909399;    // 次要文本
$text-placeholder: #c0c4cc;  // 占位符文本
```

### 字体大小
```scss
$font-size-extra-large: 20px;
$font-size-large: 18px;
$font-size-medium: 16px;
$font-size-base: 14px;
$font-size-small: 13px;
$font-size-extra-small: 12px;
```

### 间距
```scss
$spacing-xs: 4px;
$spacing-sm: 8px;
$spacing-md: 16px;
$spacing-lg: 24px;
$spacing-xl: 32px;
```

## 🔧 混合器 (mixins.scss)

### Flex 布局
```scss
@include flex(row, center, center);           // 水平垂直居中
@include flex(column, flex-start, stretch);   // 垂直布局
```

### 文本省略
```scss
@include ellipsis(1);    // 单行省略
@include ellipsis(2);    // 多行省略
```

### 居中对齐
```scss
@include center(both);        // 水平垂直居中
@include center(horizontal);  // 水平居中
@include center(vertical);    // 垂直居中
```

### 按钮样式
```scss
@include button-variant(#fff, $primary-color, $primary-color);
```

### 卡片样式
```scss
@include card($spacing-lg, $border-radius-base, $box-shadow-base);
```

### 响应式断点
```scss
@include respond-to(sm) {
  // 小屏幕样式
}

@include respond-to(md) {
  // 中等屏幕样式
}
```

### 过渡动画
```scss
@include transition(all, 0.3s, ease);
```

### 滚动条样式
```scss
@include scrollbar(8px, #f1f1f1, #c1c1c1);
```

## 📱 响应式断点

```scss
$breakpoint-xs: 480px;   // 超小屏
$breakpoint-sm: 768px;   // 小屏
$breakpoint-md: 992px;   // 中屏
$breakpoint-lg: 1200px;  // 大屏
$breakpoint-xl: 1920px;  // 超大屏
```

## 🎯 在 Vue 组件中使用

### 基本用法
```vue
<template>
  <div class="my-component">
    <h1 class="title">标题</h1>
    <p class="description">描述文本</p>
  </div>
</template>

<style lang="scss" scoped>
.my-component {
  padding: $spacing-lg;
  background-color: $bg-color;
  
  .title {
    color: $primary-color;
    font-size: $font-size-large;
    margin-bottom: $spacing-md;
  }
  
  .description {
    color: $text-regular;
    @include ellipsis(2);
  }
}
</style>
```

### 使用混合器
```vue
<style lang="scss" scoped>
.card {
  @include card($spacing-xl, $border-radius-base, $box-shadow-light);
  
  .header {
    @include flex(row, space-between, center);
    margin-bottom: $spacing-md;
  }
  
  .content {
    @include respond-to(sm) {
      padding: $spacing-sm;
    }
  }
}

.button {
  @include button-variant(#fff, $primary-color, $primary-color);
  @include transition(all);
}
</style>
```

## 🛠️ 工具类

全局样式文件提供了常用的工具类：

### 文本对齐
```html
<div class="text-center">居中文本</div>
<div class="text-left">左对齐文本</div>
<div class="text-right">右对齐文本</div>
```

### 文本颜色
```html
<p class="text-primary">主要文本</p>
<p class="text-regular">常规文本</p>
<p class="text-secondary">次要文本</p>
```

### 背景颜色
```html
<div class="bg-primary">主色背景</div>
<div class="bg-success">成功色背景</div>
```

### 间距
```html
<div class="mt-lg">上边距大</div>
<div class="mb-md">下边距中</div>
<div class="p-sm">内边距小</div>
```

## 📝 最佳实践

1. **使用变量**: 优先使用全局变量而不是硬编码值
2. **复用混合器**: 利用混合器避免重复代码
3. **嵌套适度**: SCSS 嵌套不要超过 3 层
4. **语义化命名**: 使用有意义的类名
5. **响应式优先**: 使用响应式混合器适配不同屏幕

## 🔍 示例页面

访问项目首页可以看到 SCSS 功能的完整演示，包括：
- 变量使用
- 混合器应用
- 响应式设计
- 嵌套语法
- 工具类使用

## 📚 扩展阅读

- [SCSS 官方文档](https://sass-lang.com/documentation)
- [Vue 3 + SCSS 最佳实践](https://vuejs.org/api/sfc-css-features.html)
- [响应式设计指南](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design)