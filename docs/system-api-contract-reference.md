# Mint 接口协作规范

## 目的

本文档用于统一 `Mint` 系统接口返回体、错误码、分页结构和前后端协作规则，适用于当前已有的 `Blog`、`System`，以及未来扩展的 `MES` 等业务域。

本规范只做一件事：

- 让整个系统按照同一套接口协作语言长期演进，而不是每个控制器、每个前端模块各自定义返回结构和错误约定。

适用范围：

- `Mint.Blog.Application/Abstractions`
- `Mint.Blog.WebApi`
- `Mint.Blog.Vue/src/service`
- 后续新增的 `MES` 或其他业务域 API

参考来源：

- [ApiResponse.cs](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Application/Abstractions/ApiResponse.cs)
- [ErrorCodes.cs](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Application/Abstractions/ErrorCodes.cs)
- [PagedResult.cs](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Application/Blog/Article/Queries/GetArticleList/PagedResult.cs)
- [GlobalExceptionMiddleware.cs](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.WebApi/Middleware/GlobalExceptionMiddleware.cs)

关联文档：

- [system-restful-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-restful-reference.md)
  - 关联文档负责“接口怎么设计”，包括资源、路由、HTTP 方法和查询参数
  - 本文负责“接口怎么协作”，包括统一返回体、错误码、分页结构和前后端消费规则

推荐阅读顺序：

1. 先看 [system-restful-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-restful-reference.md)，确定接口路径和动作语义
2. 再看本文，确定 `ApiResponse<T>`、错误码、分页返回和前后端协作字段

---

## 一、协作总决策

后续接口协作统一按照以下结论执行：

1. 成功响应、失败响应、分页响应统一使用同一套返回语言。
2. 后端统一返回 `ApiResponse<T>` 风格，不再为不同控制器单独发明一套响应壳。
3. 错误码统一由后端维护，前端消费，不在页面层临时拼字符串判断错误。
4. 分页结构统一使用同一组字段，前端 `service` 如需适配展示层，只在适配层转换。
5. 错误码要求稳定、可枚举、可定位，不允许同一业务错误在不同接口返回不同错误码。
6. HTTP 状态码负责表达请求结果类别，`ApiResponse<T>` 负责表达业务结果详情。
7. 前后端协作优先依赖稳定字段，不依赖临时消息文案。

这是本文档的最高原则。后续所有新建接口、错误处理和前端 `service` 封装，都必须服从这七条。

---

## 二、统一返回体规则

### 1. 标准返回体

当前项目统一返回体为：

```csharp
public sealed record ApiResponse<T>(
    bool Success,
    T? Data,
    string? ErrorCode = null,
    string? Message = null
);
```

字段含义：

- `success`：本次业务处理是否成功
- `data`：成功时返回业务数据，失败时通常为 `null` 或默认值
- `errorCode`：业务错误码，成功时为 `null`
- `message`：提示信息，可用于前端展示或日志辅助

### 2. 成功返回规则

成功时统一使用：

- `success = true`
- `errorCode = null`
- `message = null` 或明确提示

推荐：

```json
{
  "success": true,
  "data": {
    "id": 1,
    "title": "RESTful 设计"
  },
  "errorCode": null,
  "message": null
}
```

### 3. 失败返回规则

失败时统一使用：

- `success = false`
- `errorCode` 必填
- `message` 必填
- `data` 通常为空

推荐：

```json
{
  "success": false,
  "data": null,
  "errorCode": "article_not_found",
  "message": "Article not found"
}
```

### 4. 不允许的做法

- 成功时返回 `success = false`
- 失败时不返回 `errorCode`
- 同一控制器自定义另一套壳结构，如 `code`, `msg`, `result`
- 一个系统里并存多套长期使用的统一返回体

---

## 三、`ApiResponse<T>` 使用规则

### 1. 控制器统一使用工厂方法

推荐：

```csharp
return Ok(ApiResponse<ArticleDetailDto>.Ok(article));
return BadRequest(ApiResponse<object>.Fail(ErrorCodes.ArticleTitleInvalid, "Article title is invalid."));
```

不要直接在控制器里手工构造不同风格 JSON。

### 2. `Ok()` 只用于成功

统一使用：

- `ApiResponse<T>.Ok(data)`

适用场景：

- 查询成功
- 创建成功
- 更新成功
- 删除成功

### 3. `Fail()` 只用于失败

统一使用：

- `ApiResponse<T>.Fail(errorCode, message)`

适用场景：

- 参数非法
- 资源不存在
- 业务校验失败
- 状态冲突

### 4. `message` 的使用规则

- `message` 可以给前端提示，但不作为业务判断依据
- 前端业务判断统一依赖 `success`、`errorCode`、HTTP 状态码
- 不允许前端在页面层用文案字符串做核心判断

---

## 四、错误码规范

### 1. 错误码来源统一

当前错误码统一维护在 [ErrorCodes.cs](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Application/Abstractions/ErrorCodes.cs)。

后续统一要求：

- 新错误码统一在同一处维护
- 不允许控制器或前端页面直接硬编码错误码字符串

### 2. 错误码命名规则

统一使用：

- 小写
- 下划线分隔
- `资源或领域 + 错误语义`

推荐：

- `article_not_found`
- `comment_content_invalid`
- `user_password_invalid`
- `internal_server_error`

不推荐：

- `ArticleNotFound`
- `articleNotFound`
- `error_1001`
- `invalid`

### 3. 错误码应表达稳定业务语义

推荐表达：

- 资源不存在
- 字段非法
- 状态非法
- 权限非法
- 凭证无效

不推荐表达：

- 页面行为细节
- 前端按钮语义
- 临时流程节点名

### 4. 同一错误只保留一个主错误码

例如：

- “文章不存在”统一使用 `article_not_found`
- 不要在不同接口中分别返回：
- `article_not_found`
- `article_missing`
- `blog_article_not_found`

### 5. 错误码和错误消息的关系

- 错误码稳定
- 错误消息可调整
- 前端程序逻辑依赖错误码
- 前端展示文案可直接用 `message`，也可按 `errorCode` 做本地化映射

---

## 五、错误码分层使用规则

### 1. 领域校验错误

例如：

- `article_title_invalid`
- `comment_content_invalid`
- `friend_url_invalid`

适用场景：

- 值对象校验失败
- 领域规则不满足

### 2. 资源不存在错误

例如：

- `article_not_found`
- `comment_not_found`
- `user_not_found`

适用场景：

- 根据标识查询资源失败

### 3. 认证与授权错误

例如：

- `unauthorized`
- `token_expired`
- `login_invalid`

适用场景：

- 未登录
- Token 失效
- 登录凭证错误

### 4. 系统错误

例如：

- `internal_server_error`

适用场景：

- 未预期异常
- 不向前端暴露内部实现细节

---

## 六、HTTP 状态码与返回体配合规则

### 1. 成功类状态码

- `200 OK`：查询成功、更新成功、删除成功
- `201 Created`：创建成功
- `204 No Content`：无正文成功响应，可选使用

### 2. 失败类状态码

- `400 Bad Request`：参数错误、业务校验失败
- `401 Unauthorized`：未登录或凭证失效
- `403 Forbidden`：已登录但无权限
- `404 Not Found`：资源不存在
- `409 Conflict`：状态冲突或重复创建
- `500 Internal Server Error`：系统异常

### 3. 协作规则

- HTTP 状态码表达“请求结果大类”
- `ApiResponse<T>` 表达“业务结果详情”
- 前端先看 HTTP 状态码，再看 `success` 和 `errorCode`

### 4. 全局异常处理规则

当前全局异常处理中：

- `BusinessException` 统一映射为 `400`
- 未处理异常统一映射为 `500`

后续统一要求：

- 业务异常必须带错误码
- 系统异常统一返回 `internal_server_error`
- 不直接把异常堆栈返回给前端

---

## 七、分页返回规范

### 1. 标准分页结构

当前项目分页模型为：

```csharp
public sealed record PagedResult<T>(
    IReadOnlyCollection<T> Items,
    int PageNumber,
    int PageSize,
    int TotalCount
);
```

后续统一字段含义：

- `items`：当前页数据集合
- `pageNumber`：当前页码
- `pageSize`：每页条数
- `totalCount`：总条数

### 2. 分页返回推荐结构

当接口返回分页结果时，统一建议：

```json
{
  "success": true,
  "data": {
    "items": [],
    "pageNumber": 1,
    "pageSize": 10,
    "totalCount": 0
  },
  "errorCode": null,
  "message": null
}
```

### 3. 前端分页适配规则

前端页面如果组件库需要：

- `current`
- `size`
- `total`

统一在 `service` 或页面适配层转换，不反向要求后端改字段。

### 4. 分页数据为空的规则

列表为空时仍视为成功：

- `success = true`
- `items = []`
- `totalCount = 0`

不要把“列表为空”当成错误返回。

---

## 八、创建、更新、删除响应规范

### 1. 创建成功

推荐返回：

- 资源标识
- 或完整资源 DTO

例如：

```json
{
  "success": true,
  "data": { "id": 1001 },
  "errorCode": null,
  "message": null
}
```

### 2. 更新成功

推荐返回：

- `id`
- 或更新后的资源
- 或 `null`

但同类接口应尽量保持一致。

### 3. 删除成功

推荐返回：

- `id`
- 或空对象
- 或 `null`

规则：

- 同一资源的删除接口返回风格尽量统一
- 不为了“看起来简洁”让部分接口返回空字符串、部分返回对象、部分返回 `true`

---

## 九、前端 service 协作规则

### 1. 页面不直接消费原始异常

统一由 `service` 或请求拦截层处理：

- HTTP 状态码
- `success`
- `errorCode`
- `message`

页面层优先拿到已经标准化的业务结果。

### 2. 页面层不直接硬编码错误码字符串

不推荐：

```ts
if (error.message === 'Article not found') {
  // ...
}
```

推荐：

```ts
if (response.errorCode === 'article_not_found') {
  // ...
}
```

更推荐做法：

- 在 `service` 或错误处理层集中映射

### 3. 分页适配只放在前端边界层

例如后端返回：

- `items`
- `pageNumber`
- `pageSize`
- `totalCount`

前端如果 UI 组件需要：

- `current`
- `size`
- `total`

就在 `service` 或 view-model 层转换，不改后端协议。

---

## 十、字段稳定性规则

### 1. 以下字段视为稳定协作字段

- `success`
- `data`
- `errorCode`
- `message`
- `items`
- `pageNumber`
- `pageSize`
- `totalCount`

### 2. 稳定字段的含义不能随意变化

例如：

- `errorCode` 不允许一会儿是字符串，一会儿是数字
- `data` 不允许一会儿是对象，一会儿是 `success` 包裹体
- `totalCount` 不允许一会儿表达总数，一会儿表达总页数

### 3. 字段新增优于字段重定义

如果需要扩展协议：

- 优先新增字段
- 不要直接改变已有字段含义

---

## 十一、禁止项

以下做法不应继续出现在新接口中：

- 控制器自定义另一套响应壳
- 失败响应缺少 `errorCode`
- 前端通过 `message` 文案判断业务分支
- 分页接口各自定义不同字段
- 同一错误使用多个不同错误码
- 直接向前端暴露内部异常堆栈

---

## 十二、落地检查清单

每次新建接口或前端 `service` 前，先检查：

1. 是否统一使用了 `ApiResponse<T>`
2. 失败时是否返回了稳定的 `errorCode`
3. 是否错误地在页面层硬编码了错误码或错误文案判断
4. 分页是否统一使用 `items`、`pageNumber`、`pageSize`、`totalCount`
5. 列表为空时是否仍然返回成功结构
6. 是否把 HTTP 状态码和业务返回体职责混在一起
7. 是否新增了另一套返回壳结构

---

## 十三、最终结论

- 后续接口统一使用 `ApiResponse<T>` 作为标准返回壳
- 错误码统一集中维护，命名使用小写下划线风格
- 前端程序逻辑优先依赖 `errorCode`，不依赖 `message` 文案
- 分页返回统一使用 `items`、`pageNumber`、`pageSize`、`totalCount`
- HTTP 状态码表达请求结果类别，返回体表达业务结果详情
- 前端展示层需要的字段转换，只放在 `service` 或适配层，不反向污染后端协议
