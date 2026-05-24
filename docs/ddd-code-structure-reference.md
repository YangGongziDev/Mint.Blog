# Mint.Blog DDD 新建代码规范

## 目的

本文档用于统一 `Mint.Blog` 后续新建代码时的 DDD 分层、目录和命名规则，避免再次回到“按页面、按接口入口、按临时需求堆代码”的方式。

本规范只做一件事：

- 让整个项目按照同一套 DDD 结构长期演进，而不是每个模块各自决定目录和边界。

适用范围：

- `Mint.Blog.Domain`
- `Mint.Blog.Application`
- `Mint.Blog.Infrastructure`
- `Mint.Blog.WebApi`
- `Mint.Blog.Vue/src/service`

---

## 一、架构总决策

后续新建代码统一按照以下结论执行：

1. 核心层按 `业务域 + 业务模块` 组织，不按后台/前台入口组织。
2. `Domain` 只表达领域模型和领域规则，不承载技术实现和 HTTP 语义。
3. `Application` 只表达用例编排，不直接访问数据库和 ORM。
4. `Infrastructure` 只表达技术实现，不承载核心业务决策。
5. `WebApi` 和前端 `service` 才允许保留 `Admin`、`Surfer` 这类入口视角。
6. 一切核心业务状态变化，尽量先收口到聚合行为，再由应用层编排、基础设施层持久化。
7. 后续新增 `MES` 或其他业务域时，沿用同一套规则，不单独发明新分层结构。

这是本文档的最高原则。后续所有目录、新建模块、命名方式和代码落位，都必须服从这七条。

---

## 二、分层结构

### 1. Domain

`Domain` 负责表达业务本身，包含：

- 聚合根、实体、值对象
- 领域事件
- 仓储接口
- 不依赖外部技术的领域服务
- 不变量和状态迁移规则

`Domain` 不允许包含：

- ORM 模型
- SQL、数据库上下文
- HTTP DTO
- 控制器参数模型
- 第三方 SDK 依赖

判断标准：

- 如果脱离 HTTP、数据库后，这段逻辑依然成立，它优先属于 `Domain`。

### 2. Application

`Application` 负责表达“这个用例怎么执行”，包含：

- `Command`
- `Query`
- `Handler`
- DTO
- 仓储调用
- 事务边界
- 权限和流程编排

`Application` 不允许包含：

- 直接访问 ORM
- 写 SQL
- 大量核心业务规则
- 控制器路由与响应包装

判断标准：

- 如果逻辑重点是“执行流程”，它优先属于 `Application`。

### 3. Infrastructure

`Infrastructure` 负责表达技术落地，包含：

- 仓储实现
- ORM 持久化模型
- 第三方服务实现
- 对象存储、通知、缓存、队列、后台任务

`Infrastructure` 不允许包含：

- 聚合业务决策
- 暴露给上层直接使用的 `DataModel`
- 为了省事把应用层流程塞进仓储实现

判断标准：

- 如果它依赖具体框架、中间件或外部系统，它通常属于 `Infrastructure`。

### 4. WebApi

`WebApi` 负责表达 HTTP 适配，包含：

- Controller
- 路由
- 鉴权、授权
- 请求参数绑定
- 请求到应用层命令/查询的转换
- 返回结果包装

`WebApi` 不允许包含：

- 数据库访问
- 领域规则
- 仓储实例化细节

判断标准：

- 控制器只做“接请求、调应用、回响应”。

### 5. Vue service

前端 `service` 负责表达接口消费分组，包含：

- API 请求封装
- 参数和返回值适配

它不参与后端领域模型设计，不反向决定后端目录结构。

---

## 三、目录总规则

### 1. 第一层按业务域划分

当前项目统一保留以下一级业务域：

- `Blog`
- `System`
- `MES`

含义：

- `Blog` 表示博客核心业务
- `System` 表示用户、权限、菜单、角色等系统能力
- `MES` 表示未来独立业务域预留

### 2. 核心层按业务模块划分

核心层指：

- `Domain`
- `Application`
- `Infrastructure`

这些层统一按 `业务域 -> 业务模块` 组织，而不是按 `Admin`、`Surfer` 组织。

正确示例：

```text
Application/
  Blog/
    Article/
    Comment/
    Friend/
  System/
    User/
    Role/
```

不允许示例：

```text
Application/
  Blog/
    Admin/
      Comment/
    Surfer/
      Comment/
```

### 3. 入口层允许保留入口视角

只有以下两处允许保留 `Admin`、`Surfer` 等入口视角：

- `Mint.Blog.WebApi/Controllers`
- `Mint.Blog.Vue/src/service`

推荐结构：

```text
Mint.Blog.WebApi/Controllers/
  Blog/Admin/
  Blog/Surfer/
  System/
  MES/

Mint.Blog.Vue/src/service/
  Blog/Admin/
  Blog/Surfer/
  System/
  MES/
```

---

## 四、目录模板

### Domain

```text
Mint.Blog.Domain/
  Blog/
    Article/{Entities,ValueObjects,Events,Services,Repositories}
    Category/{Entities,ValueObjects,Events,Services,Repositories}
    Tag/{Entities,ValueObjects,Events,Services,Repositories}
    Comment/{Entities,ValueObjects,Events,Services,Repositories}
    Friend/{Entities,ValueObjects,Events,Services,Repositories}
    Message/{Entities,ValueObjects,Events,Services,Repositories}
    Setting/{Entities,ValueObjects,Events,Services,Repositories}
    Wiki/{Entities,ValueObjects,Events,Services,Repositories}
    Statistics/{Entities,ValueObjects,Events,Services,Repositories}
  System/
    User/{Entities,ValueObjects,Events,Services,Repositories}
  MES/
  Common/{Entity,AggregateRoot,ValueObject,DomainEvent}
```

### Application

```text
Mint.Blog.Application/
  Blog/
    Article/{Commands,Queries,Dtos}
    Category/{Commands,Queries,Dtos}
    Tag/{Commands,Queries,Dtos}
    Comment/{Commands,Queries,Dtos,Notifications}
    Friend/{Commands,Queries,Dtos}
    Message/{Commands,Queries,Dtos}
    Setting/{Commands,Queries,Dtos}
    Wiki/{Commands,Queries,Dtos}
    Statistics/{Commands,Queries,Dtos}
  System/
    Auth/{Commands,Queries,Dtos}
    User/{Commands,Queries,Dtos}
    Menu/{Commands,Queries,Dtos}
    Role/{Commands,Queries,Dtos}
  MES/
  Abstractions/
```

### Infrastructure

```text
Mint.Blog.Infrastructure/
  Blog/
    Article/{Repositories,Persistence}
    Category/{Repositories,Persistence}
    Tag/{Repositories,Persistence}
    Comment/{Repositories,Persistence,SensitiveWords,Notifications,BackgroundJobs}
    Friend/{Repositories,Persistence}
    Message/{Repositories,Persistence}
    Setting/{Repositories,Persistence}
    Wiki/{Repositories,Persistence}
    Statistics/{Repositories,Persistence,BackgroundJobs}
    Persistence/{ISqlSugarDbContext,SqlSugarDbContext,SqlSugarUnitOfWork}
  System/
    Auth/
    User/{Repositories,Persistence}
  MES/
  DependencyInjection/
  Options/
  Resources/
```

### WebApi

```text
Mint.Blog.WebApi/Controllers/
  Blog/Admin/
  Blog/Surfer/
  System/
  MES/
```

### Vue service

```text
Mint.Blog.Vue/src/service/
  Blog/Admin/
  Blog/Surfer/
  System/
  MES/
  axios.ts
```

---

## 五、`Admin` / `Surfer` 边界

### 允许出现的位置

- `WebApi` 控制器目录
- 前端 `service` 目录
- `Application` 用例名称

### 不允许出现的位置

- `Domain` 目录
- `Domain` 实体名、值对象名、领域服务名
- `Infrastructure` 模块主目录
- 仓储接口和仓储实现的核心命名

### 规则

- `Admin` / `Surfer` 是入口视角，不是稳定领域边界
- 它们可以表达“谁在调用”
- 但不能表达“核心层怎么组织”

### 示例

正确：

```text
Application/Blog/Comment/Queries/GetAdminCommentPageListQuery.cs
WebApi/Controllers/Blog/Admin/CommentController.cs
Mint.Blog.Vue/src/service/Blog/Admin/comment.ts
```

不正确：

```text
Domain/Blog/Admin/Comment/
Infrastructure/Blog/Surfer/Comment/
Domain/Blog/Entities/AdminComment.cs
```

---

## 六、聚合与模块判断规则

### 1. 是否应该建一个聚合

如果满足以下大多数条件，通常应该建模为聚合或聚合根：

1. 有独立身份标识和生命周期
2. 维护一组必须同时满足的一致性规则
3. 外部应通过统一入口修改内部状态
4. 发布、审核、删除、禁用、恢复等行为围绕它展开

### 2. 当前项目建议

- `Article`、`Comment`、`Friend`、`User` 优先按聚合理解
- `Setting` 需要先判断是否有独立业务规则
- `Statistics` 更可能是读模型，而不是强领域聚合

### 3. 状态变化规则

核心业务状态变化统一遵循：

1. 先加载聚合
2. 在聚合内执行行为
3. 再由仓储持久化

不建议：

- 在 `Application` 里直接改实体原始字段
- 在仓储里直接拼命令式状态更新来代替聚合行为

---

## 七、命名规则

### 1. 目录命名

- 优先使用单数：`Article`、`Comment`、`Friend`、`User`
- 固有名词保持原样：`Statistics`
- 不使用角色复数目录：`Admins`、`Surfers`

### 2. 类型命名

- 实体：`Comment`
- 值对象：`CommentContent`、`EmailAddress`
- 领域事件：`CommentPublishedDomainEvent`
- 仓储接口：`ICommentRepository`
- Command：`CreateCommentCommand`
- Query：`GetAdminCommentPageListQuery`
- Handler：`CreateCommentCommandHandler`
- 控制器：`CommentController`

### 3. 禁止命名

- `BlogAdminCommentService`
- `SurferCommentManager`
- `CommentHelper`
- `CommonService`
- `BaseManager`

这些命名通常意味着职责不清或分层错误。

---

## 八、最小落地模板

以 `Blog/Comment` 为例，一个较完整的业务模块建议最小骨架如下：

```text
Mint.Blog.Domain/Blog/Comment/
  Entities/Comment.cs
  ValueObjects/CommentContent.cs
  ValueObjects/Nickname.cs
  Events/CommentPublishedDomainEvent.cs
  Repositories/ICommentRepository.cs

Mint.Blog.Application/Blog/Comment/
  Commands/PublishComment/PublishCommentCommand.cs
  Commands/PublishComment/PublishCommentCommandHandler.cs
  Queries/GetBlogCommentList/GetBlogCommentListQuery.cs
  Queries/GetBlogCommentList/GetBlogCommentListQueryHandler.cs
  Dtos/CommentDto.cs

Mint.Blog.Infrastructure/Blog/Comment/
  Repositories/CommentRepository.cs
  Persistence/CommentDataModel.cs

Mint.Blog.WebApi/Controllers/Blog/
  Admin/CommentController.cs
  Surfer/CommentController.cs
```

说明：

- 后台分页、审核、删除走 `Admin` Controller
- 前台发布、查询走 `Surfer` Controller
- 但它们共同复用 `Application/Blog/Comment` 和 `Domain/Blog/Comment`

---

## 九、后续新增 `MES` 怎么做

### 1. 基本原则

`MES` 不是挂在 `Blog` 下面的新目录，而是和 `Blog`、`System` 并列的业务域。

不允许：

```text
Blog/MES/
Application/Blog/MES/
Blog/Admin/MES/
```

应当：

```text
Mint.Blog.Domain/
  Blog/
  System/
  MES/

Mint.Blog.Application/
  Blog/
  System/
  MES/

Mint.Blog.Infrastructure/
  Blog/
  System/
  MES/

Mint.Blog.WebApi/Controllers/
  Blog/
  System/
  MES/
```

### 2. 什么时候算独立业务域

如果满足以下大多数条件，应视为独立业务域：

- 有独立业务术语
- 有独立核心流程和规则
- 有独立聚合和生命周期
- 与 `Blog` 关联较弱
- 后续会持续扩展多个模块

### 3. 新增 `MES` 的目录策略

先按业务模块拆，不按页面拆。

例如：

```text
MES/
  WorkOrder/
  Equipment/
  Report/
  ProductionOrder/
```

再映射到各层：

```text
Mint.Blog.Domain/MES/
  WorkOrder/
    Entities/
    ValueObjects/
    Events/
    Repositories/

Mint.Blog.Application/MES/
  WorkOrder/
    Commands/
    Queries/
    Dtos/
```

### 4. 新增 `MES` 的入口规则

如果未来 `MES` 有后台端、终端、看板端：

- 核心层仍按业务模块划分
- 入口差异只体现在 `WebApi`、前端 `service` 和应用层用例命名中

例如：

```text
Application/MES/WorkOrder/Queries/GetAdminWorkOrderPageListQuery.cs
Application/MES/WorkOrder/Queries/GetTerminalWorkOrderListQuery.cs
WebApi/Controllers/MES/Admin/WorkOrderController.cs
WebApi/Controllers/MES/Terminal/WorkOrderController.cs
```

---

## 十、落地检查清单

每次新增文件、模块或目录前，先检查：

1. 这个功能属于哪个业务域：`Blog`、`System` 还是 `MES`
2. 这个文件属于 `Domain`、`Application`、`Infrastructure` 还是 `WebApi`
3. 这个逻辑是在表达规则、编排流程、技术实现，还是 HTTP 适配
4. 是否错误地把 `Admin` / `Surfer` 放进了核心层目录
5. 是否已经存在相近聚合或模块，应该复用而不是重复创建
6. 是否把 `DTO`、`DataModel`、`Entity` 混在一起了
7. 是否把聚合行为错误地下沉到仓储或上提到控制器

---

## 十一、目录不好放时怎么判断

如果一个新文件不知道该放哪里，按下面顺序判断：

1. 它是不是业务规则
2. 如果是业务规则，优先放 `Domain`
3. 如果是用例编排，放 `Application`
4. 如果依赖数据库或第三方 SDK，放 `Infrastructure`
5. 如果只是接口接入和参数转换，放 `WebApi`

优先避免两种错误：

- 不要把技术实现塞进 `Domain`
- 不要把业务规则塞进 `Controller` 或仓储实现

---

## 十二、最终结论

- 核心层按 `业务域 + 业务模块` 组织，不按后台/前台入口组织
- `Admin` / `Surfer` 只作为入口视角存在于 `WebApi`、前端 `service` 和用例命名中
- 一切核心业务状态变化，尽量先收口到聚合行为，再由应用层编排、基础设施层持久化
- 目录划分优先服务于“领域清晰、职责清晰、依赖方向清晰”，而不是服务于“页面看起来方便分类”
- 后续如果新增 `MES` 或其他业务域，也按本文同样原则执行，不单独发明新分层规则
