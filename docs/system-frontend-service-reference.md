# Mint 前端 Service 封装规范

## 目的

本文档用于统一 `Mint` 系统前端 `service` 层的目录结构、封装方式、请求处理、错误处理、分页适配和页面调用边界，适用于当前已有的 `Blog`、`System`，以及未来扩展的 `MES` 等业务域。

本规范只做一件事：

- 让整个前端按照同一套接口调用边界长期演进，而不是每个页面、每个模块各自发明一套请求和数据适配方式。

适用范围：

- `Mint.Blog.Vue/src/service`
- `Mint.Blog.Vue/src/store`
- `Mint.Blog.Vue/src/views`
- `Mint.Blog.Vue/src/hooks`

参考来源：

- [axios.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/service/axios.ts)
- [auth.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/service/system/auth.ts)
- [article.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/service/blog/admin/article.ts)
- [article.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/service/blog/surfer/article.ts)
- [comment.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/service/blog/admin/comment.ts)
- [article-list.vue](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/views/blog-admin/article-list.vue)

关联文档：

- [system-restful-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-restful-reference.md)
- [system-api-contract-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-api-contract-reference.md)
- [system-auth-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-auth-reference.md)
- [system-naming-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-naming-reference.md)

推荐阅读顺序：

1. 先看 [system-restful-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-restful-reference.md)，确定接口设计
2. 再看 [system-api-contract-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-api-contract-reference.md)，确定返回体与错误码
3. 再看 [system-auth-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-auth-reference.md)，确定鉴权接入
4. 最后看本文，确定这些规则如何在前端 `service` 层落地

---

## 一、Service 总决策

后续前端 `service` 统一按照以下结论执行：

1. 页面、组件、store 不直接拼接口协议细节，统一通过 `service` 层访问后端。
2. `service` 层是前端和后端协议之间的边界层，负责请求封装、返回体解析、错误收口和必要的数据适配。
3. `service` 层按 `业务域 + 入口视角 + 资源` 组织，不按页面文件组织。
4. 所有请求统一复用同一个 `axios` 实例，不允许各模块自行创建长期并行的请求实例。
5. 认证 Token 注入、401/403 收口、错误提示去重、续签同步统一放在基础请求层处理。
6. 分页字段、旧接口字段、组件所需字段之间的转换统一收口到 `service` 或 view-model 边界层，不允许散落到页面。
7. 页面层优先拿到“可直接使用的数据”，而不是拿到一大坨原始接口协议自行拆解。

这是本文档的最高原则。后续所有新建 `service`、页面请求逻辑和接口适配代码，都必须服从这七条。

---

## 二、分层边界

### 1. `axios.ts` 的职责

基础请求层负责：

- 统一 `baseURL`
- 注入 `Authorization`
- 处理 Token 续签头
- 统一处理 `success=false`
- 统一处理未登录、过期态
- 统一错误提示

它不负责：

- 业务资源命名
- 页面字段转换
- 页面提示文案编排
- 视图组件专属数据结构

### 2. `service/*.ts` 的职责

业务 `service` 文件负责：

- 资源级接口方法封装
- 请求参数和路径组织
- 返回类型声明
- 协议边界的轻量适配

它不负责：

- 直接操作 UI 组件
- 弹窗控制
- 页面 loading 状态
- 业务页面中的交互流程编排

### 3. 页面 / 组件的职责

页面和组件负责：

- 触发调用
- 控制 loading
- 接收结果并渲染
- 表单交互和组件状态管理

它们不应负责：

- 拼接 URL
- 判断错误码字符串细节
- 兼容多套分页协议
- 拼接 `Authorization` 头

---

## 三、目录组织规则

### 1. 基础结构

当前推荐结构：

```text
src/service/
  axios.ts
  blog/
    admin/
      article.ts
      comment.ts
    surfer/
      article.ts
      comment.ts
  system/
    auth.ts
    user.ts
```

### 2. 目录划分原则

- 第一层按业务域：`blog`、`system`、未来 `mes`
- 第二层按入口视角：`admin`、`surfer`、未来 `terminal`
- 第三层按资源：`article.ts`、`comment.ts`、`user.ts`

### 3. 不推荐的组织方式

不推荐：

```text
src/service/
  article-list-page.ts
  home.ts
  comment-dialog.ts
  login-form.ts
```

原因：

- 页面名不稳定
- 页面改版会导致 service 命名和职责漂移
- 同一资源接口会被拆散到多个页面文件中

---

## 四、命名规则

### 1. 文件命名

统一按资源命名：

- `article.ts`
- `comment.ts`
- `auth.ts`
- `user.ts`

不推荐：

- `articleApi.ts`
- `getArticle.ts`
- `article-list.ts`

### 2. 方法命名

统一按动作命名：

- `getArticlePageList`
- `getArticleDetail`
- `createArticle`
- `updateArticle`
- `deleteArticle`
- `fetchLogin`

规则：

- 查询用 `getXxx`
- 创建用 `createXxx`
- 更新用 `updateXxx`
- 删除用 `deleteXxx`
- 特殊认证动作可用 `fetchLogin`、`fetchGetUserInfo`

### 3. 类型命名

统一使用清晰语义名：

- `ArticlePageQuery`
- `AdminArticleListItem`
- `AdminArticleDetail`
- `ArticleFormModel`
- `ExamineCommentPayload`

不推荐：

- `Data`
- `Result`
- `Form`
- `RequestBody`

---

## 五、统一请求入口规则

### 1. 统一使用共享 `axios` 实例

后续业务 `service` 统一复用：

- [axios.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/service/axios.ts)

不允许：

- 每个模块再 `axios.create()`
- 每个页面单独拼请求拦截器

### 2. Token 注入统一在请求层处理

当前 Token 注入已在请求拦截器中完成。

统一要求：

- 页面和业务 `service` 不再手写 `Authorization`
- Token 续签头同步统一由基础请求层处理

### 3. 未登录与过期处理统一在响应层处理

当前基础请求层已统一处理：

- `unauthorized`
- `token_expired`

统一要求：

- 页面层不重复编写这一套逻辑
- 页面只处理业务成功后的 UI 行为

---

## 六、返回结果封装规则

### 1. 推荐统一返回风格

后续 `service` 层优先统一返回：

```ts
type ServiceResult<T> = {
  data: T | null;
  error: unknown | null;
};
```

或者在统一请求封装层进一步收口成：

- 成功直接返回业务数据
- 失败统一抛出标准错误

但一个项目内不要长期并存多套风格。

### 2. 当前现状说明

当前项目中存在多种并行风格：

- `safeRequest<T>() => { data, error }`
- `axios.get(...) as Promise<{ success, data }>`
- `Promise<T>` 泛型透传

后续统一目标：

- 尽量收口到一套稳定的 `service` 返回风格
- 页面层不再同时兼容 2 到 3 套请求结果形态

### 3. 页面层不应直接消费原始 `ApiResponse`

页面层最理想拿到的是：

- 已经判定成功与失败的结果
- 已经完成字段适配的数据

不推荐页面里到处写：

```ts
if (res.success) {
  tableData.value = res.data.items || res.data.records || [];
}
```

这类协议兼容应尽量收口到 `service` 层或专门的适配函数中。

---

## 七、参数组织规则

### 1. Query 参数对象化

列表和筛选接口统一用对象传参：

```ts
getArticlePageList({
  pageNumber: 1,
  pageSize: 10,
  categoryId: 2
});
```

不要用大量位置参数：

```ts
getArticlePageList(1, 10, 2, undefined);
```

### 2. Path 参数显式化

资源标识统一作为方法第一参数：

- `getArticleDetail(articleId)`
- `updateArticle(articleId, data)`
- `deleteComment(commentId, deleteType)`

### 3. Body 参数语义化

请求体对象统一使用明确类型：

- `ArticleFormModel`
- `ExamineCommentPayload`

不推荐直接用：

- `any`
- `unknown`
- `Record<string, any>`

作为长期业务方法签名。

---

## 八、分页适配规则

### 1. 后端协议字段优先在 `service` 边界处理

后端统一规范字段是：

- `items`
- `pageNumber`
- `pageSize`
- `totalCount`

前端 UI 组件可能需要：

- `current`
- `size`
- `total`

统一要求：

- 在 `service` 或 view-model 边界转换
- 页面层不反复写兼容逻辑

### 2. 不允许页面长期兼容多套字段

不推荐：

```ts
tableData.value = res.data.items || res.data.records || [];
total.value = res.data.totalCount || res.data.total || 0;
```

统一目标：

- 由 `service` 层返回稳定字段
- 页面层只使用统一字段

### 3. 建议抽分页适配函数

例如可抽：

- `normalizePageResult()`
- `toTablePaginationState()`

让分页兼容逻辑只存在一处。

---

## 九、错误处理规则

### 1. 通用错误统一在基础请求层处理

包括：

- 网络错误
- 未登录
- Token 过期
- 通用错误提示去重

### 2. 业务错误统一在 `service` 或调用边界层处理

例如：

- 某些错误码需要转为特定页面流程
- 某些业务错误需要转换成更具体的 UI 行为

规则：

- 页面不直接依赖 `message` 文案分支判断
- 页面尽量依赖稳定错误语义

### 3. 页面只处理自己真正关心的异常

例如：

- 表单校验提示
- 删除确认失败提示
- 某个业务空态提示

不应让每个页面都重新写一遍：

- token 失效跳登录
- 通用网络错误提示

---

## 十、鉴权接入规则

### 1. `service` 不重复处理登录态判断

登录态接入统一依赖：

- 基础请求层的 Token 注入
- 响应层的 `unauthorized` / `token_expired` 处理

业务 `service` 不应重复写：

- 是否有 token
- 无 token 跳转登录

### 2. 鉴权接口与业务接口分开组织

例如：

- `system/auth.ts` 负责登录与当前用户信息
- `blog/admin/article.ts` 负责文章管理

不要把登录接口混入普通业务资源文件。

### 3. 按钮权限不放在 `service` 层判断

按钮权限属于页面可见性控制，统一由：

- 权限 hook
- store 中的用户权限信息

处理，不放在 `service` 方法里做前置拦截。

---

## 十一、页面调用规则

### 1. 页面只调用语义化方法

推荐：

```ts
await getArticlePageList(query);
await deleteArticle(articleId, deleteType);
```

不推荐：

```ts
await axios.get('/blog-admin/article', { params: query });
await axios.patch(`/blog-admin/comment/${id}/delete`, body);
```

### 2. 页面不直接拼接接口路径

接口路径属于协议细节，统一放 `service` 层管理。

### 3. 页面不直接定义长期业务类型

长期复用的接口数据结构优先定义在 `service` 文件或专门类型文件中，而不是每个页面局部复制一份。

---

## 十二、针对当前项目的收口建议

### 1. 优先统一返回风格

当前项目建议优先统一：

- `safeRequest`
- 直接 `axios as Promise<{ success, data }>`
- `Promise<T>` 透传

这三种并行风格。

### 2. 优先统一分页适配位置

将页面中的：

- `items || records`
- `totalCount || total`

收口到 `service` 层或分页适配函数。

### 3. 优先统一前台与后台 `article.ts` 风格

当前：

- 后台 `article.ts` 偏显式类型
- 前台 `article.ts` 偏泛型透传

后续建议统一成：

- 显式资源方法
- 显式参数类型
- 显式返回类型

---

## 十三、禁止项

以下做法不应继续出现在新代码中：

- 页面直接使用 `axios`
- 页面直接拼接接口路径
- 页面直接兼容多套分页字段
- 每个 `service` 文件自建一套错误处理
- `service` 方法大量返回 `any`
- 同一资源文件中混入登录态和页面逻辑
- 页面层通过错误文案做核心业务判断

---

## 十四、落地检查清单

每次新建 `service` 或页面请求逻辑前，先检查：

1. 这个接口是否已经有资源级 `service` 方法
2. 是否错误地准备在页面中直接调用 `axios`
3. 参数、路径、返回类型是否已经语义化
4. 是否把分页适配逻辑错误地下沉到了页面
5. 是否把鉴权、错误提示、token 处理重复写进业务 `service`
6. 返回风格是否和现有统一目标一致
7. 是否把页面专属逻辑混进了 `service`

---

## 十五、最终结论

- 页面、组件、store 不直接拼接口协议细节，统一通过 `service` 层访问后端
- `service` 层是前端和后端协议之间的边界层，负责请求封装、返回体解析、错误收口和必要的数据适配
- `service` 按 `业务域 + 入口视角 + 资源` 组织，不按页面组织
- 所有请求统一复用同一个 `axios` 实例，认证、过期处理和通用错误提示统一在基础请求层收口
- 分页字段、旧字段、组件字段之间的转换统一放在 `service` 或适配层，不散落到页面
- 页面优先拿到可直接使用的数据，而不是原始接口协议
