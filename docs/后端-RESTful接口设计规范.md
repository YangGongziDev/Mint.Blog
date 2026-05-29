# Mint RESTful 接口风格规范

## 目的

本文档用于统一 `Mint` 系统后续 Web API 的 RESTful 风格，适用于当前已有的 `Blog`、`System`，以及未来扩展的 `MES` 等业务域。

本规范只做一件事：

- 让整个系统按照同一套资源化接口语言长期演进，而不是每个控制器各自定义一套路由和动作风格。

适用范围：

- `Mint.Blog.WebApi`
- `Mint.Blog.Vue/src/service`
- 后续新增的 `MES` 或其他业务域 API

参考来源：

- [ArticleController.cs](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.WebApi/Controllers/Blog/Surfer/ArticleController.cs)
- [CommentController.cs](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.WebApi/Controllers/Blog/Admin/CommentController.cs)
- [AuthController.cs](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.WebApi/Controllers/System/AuthController.cs)

关联文档：

- [系统API契约参考.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/系统API契约参考.md)
  - 本文负责“接口怎么设计”，包括资源、路由、HTTP 方法、查询参数和状态码使用边界
  - 关联文档负责“接口怎么返回”，包括 `ApiResponse<T>`、错误码、分页结构和前后端协作字段

推荐阅读顺序：

1. 先看本文，确定路由和接口形态
2. 再看 [系统API契约参考.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/系统API契约参考.md)，确定返回体、错误码和分页协议

---

## 一、接口总决策

后续 RESTful 接口统一按照以下结论执行：

1. 接口优先按 `资源` 设计，而不是按 `动作` 设计。
2. 路由优先表达“资源是什么”，HTTP 方法表达“要做什么”。
3. 查询列表用 `GET`，创建用 `POST`，整体更新用 `PUT`，局部更新用 `PATCH`，删除用 `DELETE`。
4. `Admin`、`Surfer`、未来 `Terminal` 等入口词可以保留在路由前缀中，但不能替代资源本身。
5. 不再设计 `POST /list`、`POST /detail` 这类 RPC 风格接口。
6. 查询条件统一走 QueryString，复杂筛选仅在确有必要时才使用请求体。
7. 状态码、错误响应、分页参数、资源命名必须全系统统一。

这是本文档的最高原则。后续所有新建 API 和前端 `service` 封装，都必须服从这七条。

---

## 二、路由结构规则

### 1. 基本结构

当前项目允许保留入口视角前缀，因此推荐的基础结构为：

```text
/api/{entry}/{resource}
```

当前项目中的典型前缀：

- `/api/blog/admin`
- `/api/blog/surfer`
- `/api/system`
- 未来可扩展 `/api/mes-admin`、`/api/mes-terminal`

### 2. 资源始终放在入口前缀之后

推荐：

- `/api/blog/admin/articles`
- `/api/blog/admin/comments`
- `/api/blog/surfer/articles`
- `/api/system/users`

不推荐：

- `/api/blog/admin/article/list`
- `/api/blog/surfer/article/detail`
- `/api/system/get-user`

### 3. 子资源结构

当某个资源从属于另一个资源时，使用嵌套路由：

- `/api/blog/surfer/articles/{articleId}/comments`
- `/api/blog/surfer/categories/{categoryId}/articles`
- `/api/blog/surfer/tags/{tagId}/articles`

规则：

- 只有明确存在从属关系时才使用子资源
- 不要为了“看起来像 RESTful”滥用多层嵌套
- 一般不超过 2 层资源嵌套

---

## 三、资源命名规则

### 1. 路由资源名统一使用复数

推荐：

- `/articles`
- `/comments`
- `/categories`
- `/tags`
- `/users`
- `/roles`

不推荐：

- `/article`
- `/comment`
- `/getArticleList`

### 2. 路由资源名统一使用小写

推荐：

- `/api/blog/surfer/articles`
- `/api/system/users`

不推荐：

- `/api/blog/surfer/Articles`
- `/api/system/User`

### 3. 路由片段统一使用 `kebab-case`

适用于多词资源或动作片段：

- `/email-templates`
- `/reset-password`
- `/audit-logs`

不推荐：

- `/emailTemplates`
- `/ResetPassword`

---

## 四、HTTP 方法规则

### 1. 查询列表

统一使用 `GET /resources`

例如：

- `GET /api/blog/surfer/articles`
- `GET /api/blog/admin/comments`

### 2. 查询详情

统一使用 `GET /resources/{id}`

例如：

- `GET /api/blog/surfer/articles/{articleId}`
- `GET /api/system/users/{userId}`

### 3. 创建资源

统一使用 `POST /resources`

例如：

- `POST /api/blog/admin/articles`
- `POST /api/blog/surfer/comments`

### 4. 整体更新

统一使用 `PUT /resources/{id}`

适用场景：

- 客户端提交资源完整替换
- 语义上是整体覆盖

### 5. 局部更新

统一使用 `PATCH /resources/{id}`

适用场景：

- 修改单个字段
- 修改部分属性
- 状态切换

例如：

- `PATCH /api/blog/admin/articles/{articleId}`
- `PATCH /api/blog/admin/comments/{commentId}`

### 6. 删除资源

统一使用 `DELETE /resources/{id}`

例如：

- `DELETE /api/blog/admin/articles/{articleId}`
- `DELETE /api/blog/admin/comments/{commentId}`

---

## 五、动作型场景处理规则

RESTful 风格并不禁止动作，但动作必须在资源上下文中表达。

### 1. 优先把动作表达为资源状态变化

推荐：

- `PATCH /api/blog/admin/articles/{articleId}` with `{ "isTop": true }`
- `PATCH /api/blog/admin/comments/{commentId}` with `{ "status": "approved" }`
- `PATCH /api/system/users/{userId}` with `{ "isEnabled": false }`

不推荐：

- `PATCH /api/blog/admin/articles/{articleId}/top`
- `PATCH /api/blog/admin/comments/{commentId}/examine`
- `PATCH /api/system/users/{userId}/disable`

### 2. 只有确实无法自然表达为字段更新时，才使用动作子路径

允许例外：

- `POST /api/system/auth/login`
- `POST /api/system/auth/logout`
- `POST /api/blog/admin/files`
- `POST /api/blog/admin/images`

原因：

- 登录、登出、上传这类场景并不是普通资源 CRUD
- 它们本身就是明确动作或过程型接口

### 3. 删除动作不要设计成状态动作路由

推荐：

- `DELETE /api/blog/admin/comments/{commentId}`

不推荐：

- `PATCH /api/blog/admin/comments/{commentId}/delete`

如果存在“软删除”和“物理删除”两种语义，优先做法：

- 通过 QueryString 或请求体明确删除模式
- 或设计后台专用回收站资源

---

## 六、查询参数规则

### 1. 简单查询条件统一走 QueryString

例如：

```text
GET /api/blog/surfer/articles?pageNumber=1&pageSize=10&categoryId=2&tagId=5
GET /api/blog/admin/comments?pageNumber=1&pageSize=10&status=1
```

适用条件：

- 分页
- 排序
- 搜索词
- 分类、标签、状态筛选
- 日期区间

### 2. QueryString 统一使用 `camelCase`

推荐：

- `pageNumber`
- `pageSize`
- `categoryId`
- `tagId`
- `startDate`
- `endDate`
- `keyword`

### 3. 复杂筛选才允许使用请求体

例如：

- 筛选条件很多且层级复杂
- 查询对象已形成明确的查询模型

但即使如此，也应优先确认这是否真的是查询接口，还是报表/搜索任务接口。

---

## 七、分页规则

### 1. 分页参数统一

统一参数：

- `pageNumber`
- `pageSize`

不再新建：

- `current`
- `size`
- `page`
- `limit`

### 2. 分页返回结构统一

统一返回分页对象：

- `items`
- `pageNumber`
- `pageSize`
- `totalCount`

前端如需适配旧字段，可在 `service` 层做转换，不反向污染 API 设计。

### 3. 列表接口统一返回分页结果

即使是后台列表或前台搜索，也优先返回统一分页结构，而不是每个控制器自定义：

- `current`
- `pages`
- `total`
- `data`

这类结构不作为后续接口规范。

---

## 八、状态码规则

### 1. 成功响应

- `200 OK`：查询成功、更新成功、删除成功
- `201 Created`：创建成功，且确实产生了新资源
- `204 No Content`：删除成功且无需返回正文，可选使用

### 2. 客户端错误

- `400 Bad Request`：参数错误、请求格式错误
- `401 Unauthorized`：未登录或凭证无效
- `403 Forbidden`：已登录但无权限
- `404 Not Found`：资源不存在
- `409 Conflict`：资源冲突、状态冲突、重复创建
- `422 Unprocessable Entity`：业务校验失败，可作为扩展选项

### 3. 服务端错误

- `500 Internal Server Error`：未预期异常

规则：

- 不要把所有错误都包装成 `200`
- 不要出现“失败但 HTTP 状态仍然成功”的新接口
- 不再设计 `200 + success=false` 这类失败但 HTTP 状态仍然成功的接口

---

## 九、错误响应规则

### 1. 错误体结构统一

推荐统一保留：

- `success`
- `errorCode`
- `message`

当前项目已有 `ApiResponse<T>`，后续新接口优先复用统一响应模型。

### 2. 错误码要稳定

规则：

- 错误码用于前后端协作和日志定位
- 错误消息可读，错误码稳定
- 不要直接把后端异常文本暴露给前端

### 3. 校验错误要可定位

当字段校验失败时，建议补充：

- 字段名
- 错误原因

便于前端直接映射表单错误。

---

## 十、请求体与响应体规则

### 1. 创建和更新请求体使用明确模型

推荐：

- `CreateArticleRequest`
- `UpdateArticleRequest`
- `UpdateCommentStatusRequest`

如果直接复用应用层 `Command`，也要保证该模型语义清晰，不要让 Web 层直接暴露技术细节。

### 2. 不要为同一个资源同时维护多套新返回结构

同一资源详情接口应尽量统一返回同一类 DTO 风格，不要出现：

- 一套 `ApiResponse<ArticleDetailDto>`
- 一套自定义 `SurferArticleDetailResponse`

并行长期共存。

### 3. 时间、标识、布尔字段保持统一语义

例如：

- 主键统一 `id`
- 时间优先 `createdAt`、`updatedAt`
- 布尔字段优先 `isTop`、`isDeleted`、`isEnabled`

---

## 十一、入口词边界

### 1. 入口词可以保留在路由前缀

允许：

- `/api/blog/admin/articles`
- `/api/blog/surfer/articles`
- `/api/system/users`

### 2. 入口词不替代资源名

不推荐：

- `/api/blog/admin/article/list`
- `/api/blog/surfer/article/detail`

推荐：

- `/api/blog/admin/articles`
- `/api/blog/surfer/articles/{articleId}`

### 3. 未来新增 `MES` 沿用同一规则

例如：

- `/api/mes/admin/work-orders`
- `/api/mes/terminal/work-orders/{workOrderId}`

不是：

- `/api/mes/admin/work-order/list`
- `/api/mes/terminal/get-work-order-detail`

---

## 十二、前端 service 规则

前端 `service` 需要和 RESTful 接口一一对应。

推荐：

- 文件：`article.ts`
- 方法：`getArticleList`
- 方法：`getArticleDetail`
- 方法：`createArticle`
- 方法：`updateArticle`
- 方法：`deleteArticle`

不推荐：

- `getArticleListByPost`
- `articleDetailApi`
- `doDeleteArticle`

---

## 十三、落地检查清单

每次新建 API 前，先检查：

1. 这个路由表达的是资源，还是动作
2. 这个动作是否可以改写为标准 HTTP 方法 + 资源路径
3. 资源名是否为复数、小写、语义明确
4. 查询条件是否应该走 QueryString
5. 分页参数是否统一使用 `pageNumber`、`pageSize`
6. 是否错误地把失败结果包装成 `200`
7. 是否错误地设计了 `POST /list`、`POST /detail`
8. 前端 `service` 是否使用了统一语义方法名

---

## 十四、最终结论

- 新接口优先按 `资源 + HTTP 方法` 设计，不按动作式 RPC 设计
- 路由前缀可以保留 `Admin`、`Surfer` 等入口词，但资源名必须独立存在
- 资源名统一使用小写复数，复杂片段使用 `kebab-case`
- 查询条件统一优先走 QueryString，分页统一使用 `pageNumber`、`pageSize`
- 状态码、错误响应、分页结构必须全系统统一
- 不设计 `POST /list`、`POST /detail` 这类 RPC 风格接口
