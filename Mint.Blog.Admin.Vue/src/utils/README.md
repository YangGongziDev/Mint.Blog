# utils

`utils` 用于存放普通工具函数或轻量工具模块。

这类代码通常不依赖 Vue 的响应式系统，也不依赖组件生命周期。优先保持为纯函数或低副作用函数，方便在组件、hooks、store、service 等任意位置复用和测试。

## 适合放在 utils 的内容

- 字符串、数组、对象等通用数据处理
- 日期、颜色、图标等格式化或转换逻辑
- 加密、哈希、随机 ID 生成
- `localStorage`、`sessionStorage` 等本地存储封装
- 浏览器、设备、环境判断
- 不依赖组件状态的通用辅助函数

## 不适合放在 utils 的内容

- 使用 `ref`、`computed`、`watch` 的响应式逻辑
- 使用 `onMounted`、`onUnmounted` 等生命周期的逻辑
- 强依赖 `router`、`store`、组件状态的逻辑
- 具体业务流程逻辑
- 接口请求定义或接口状态管理

这些内容更适合放在 `hooks`、`store`、`service` 或具体业务模块中。

## 与 hooks 的区别

- `utils` 更偏普通工具函数，尽量不依赖 Vue。
- `hooks` 更偏 Vue 组合式复用逻辑，通常会使用响应式状态、生命周期、路由或 store。

简单判断：

```ts
// 适合放在 utils
export function formatDate(value: string) {
  return value.slice(0, 10);
}

// 适合放在 hooks
export function useLoading() {
  const loading = ref(false);

  function startLoading() {
    loading.value = true;
  }

  function endLoading() {
    loading.value = false;
  }

  return {
    loading,
    startLoading,
    endLoading
  };
}
```

## 当前目录示例

- `agent.ts`：设备或浏览器环境判断
- `color.ts`：颜色处理
- `common.ts`：通用辅助函数
- `crypto.ts`：加密相关工具
- `icon.ts`：图标相关工具
- `klona.ts`：对象深拷贝
- `nanoid.ts`：随机 ID
- `storage.ts`：本地存储封装

## 编写建议

- 函数职责保持单一，避免一个工具函数做太多事情。
- 优先使用明确的入参和返回值，减少隐式依赖。
- 尽量避免直接修改入参对象，除非函数名和文档明确说明会修改。
- 如果逻辑需要 Vue 响应式能力，优先考虑放到 `hooks`。
- 如果逻辑是业务状态管理，优先考虑放到 `store`。
- 如果逻辑是接口调用，优先考虑放到 `service`。
