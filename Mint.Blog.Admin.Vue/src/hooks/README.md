# hooks

`hooks` 用于存放 Vue 组合式复用逻辑。

这类代码通常会使用 Vue Composition API，例如 `ref`、`computed`、`watch`、生命周期函数，或者依赖 `router`、`store`、组件状态等。它的目标是把多个组件中重复出现的响应式逻辑抽出来复用。

## 适合放在 hooks 的内容

- 多个组件都会复用的响应式状态逻辑
- 使用 `ref`、`computed`、`watch` 的组合式逻辑
- 使用 `onMounted`、`onUnmounted` 等生命周期的逻辑
- 封装 router、store、请求状态、表格状态、倒计时等逻辑
- 和 Vue 组件使用方式强相关的功能

## 不适合放在 hooks 的内容

- 完全不依赖 Vue 的纯工具函数
- 单一组件私有且不会复用的简单逻辑
- 接口请求定义本身
- 全局共享状态本身
- 复杂业务状态的统一管理

这些内容更适合放在 `utils`、组件内部、`service` 或 `store` 中。

## 目录说明

```text
hooks/
  state/     基础状态 hooks，例如 boolean、loading、count-down
  routing/   路由相关 hooks，例如 router push 封装
  form/      表单相关 hooks，例如 Ant Design Vue 表单封装和校验规则
  table/     表格相关 hooks，例如通用表格状态和 Ant Design Vue 表格封装
  chart/     图表相关 hooks，例如 ECharts 初始化、更新和销毁
  auth/      登录、权限、验证码等认证相关 hooks
  index.ts   hooks 统一导出入口
```

### state

`state` 放最基础、最通用的状态类 hooks，尽量不绑定具体业务。

例如：

- `use-boolean.ts`
- `use-loading.ts`
- `use-count-down.ts`

### routing

`routing` 放路由相关 hooks。

例如：

- `use-router-push.ts`：统一路由跳转封装

### form

`form` 放表单相关 hooks。

例如：

- `use-antd-form.ts`：Ant Design Vue 表单实例和通用校验规则封装

### table

`table` 放表格相关 hooks。

例如：

- `use-hook-table.ts`：底层表格状态、列配置和请求封装
- `use-table.ts`：Ant Design Vue 表格场景封装

### chart

`chart` 放图表相关 hooks。

例如：

- `use-echarts.ts`：ECharts 初始化、更新、resize 和销毁封装

### auth

`auth` 放登录、权限、验证码等认证相关 hooks。

例如：

- `use-auth.ts`：权限判断
- `use-captcha.ts`：验证码逻辑

## 命名约定

hooks 函数建议使用 `useXxx` 命名，例如：

```ts
useLoading
useBoolean
useRouterPush
useTable
useAuth
```

文件名建议使用 kebab-case，并以 `use-` 开头，例如：

```text
use-loading.ts
use-count-down.ts
use-router-push.ts
use-antd-form.ts
```

每个分类目录可以提供 `index.ts` 作为当前分类的导出入口；`hooks/index.ts` 作为全局导出入口。

## 与 utils 的区别

- `utils`：普通工具函数，尽量不依赖 Vue。
- `hooks`：Vue 组合式复用逻辑，通常依赖响应式状态、生命周期、router 或 store。

简单判断：

```ts
// 适合放在 utils
export function isEmpty(value: unknown) {
  return value === null || value === undefined || value === '';
}

// 适合放在 hooks
export function useBoolean(initValue = false) {
  const bool = ref(initValue);

  function toggle() {
    bool.value = !bool.value;
  }

  return {
    bool,
    toggle
  };
}
```

## 使用建议

当某段逻辑满足以下条件时，可以考虑抽成 hook：

- 多个组件都会用
- 需要维护响应式状态
- 依赖路由、store、生命周期或监听器
- 放在组件里会让组件过于臃肿

不建议为了抽象而抽象。如果逻辑只在一个组件中使用，并且代码很少，直接放在组件内通常更清晰。
