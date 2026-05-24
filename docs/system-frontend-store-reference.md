# Mint 前端 Store 规范

## 目的

本文档用于统一 `Mint.Blog.Vue/src/store` 的职责、目录结构、模块边界和使用方式，适用于当前已有的 `Blog`、`System`，以及未来扩展的 `MES` 等业务域前端模块。

本规范只做一件事：

- 让整个前端按照同一套状态管理边界长期演进，而不是每个页面、每个模块随意决定哪些状态放进 `Pinia`，哪些状态留在页面。

适用范围：

- `Mint.Blog.Vue/src/store`
- `Mint.Blog.Vue/src/views`
- `Mint.Blog.Vue/src/layouts`
- `Mint.Blog.Vue/src/composables`
- `Mint.Blog.Vue/src/service`

参考来源：

- [store/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/index.ts)
- [app/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/modules/app/index.ts)
- [theme/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/modules/theme/index.ts)
- [auth/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/modules/admin/system/auth/index.ts)
- [route/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/modules/admin/system/route/index.ts)
- [tab/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/modules/tab/index.ts)
- [content/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/modules/surfer/blog/content/index.ts)
- [article-list.vue](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/views/blog-admin/article-list.vue)
- [plugins/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/plugins/index.ts)

关联文档：

- [ddd-code-structure-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/ddd-code-structure-reference.md)
- [system-frontend-layout-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-frontend-layout-reference.md)
- [system-frontend-service-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-frontend-service-reference.md)
- [system-naming-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-naming-reference.md)

推荐阅读顺序：

1. 先看 [ddd-code-structure-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/ddd-code-structure-reference.md)，确定业务边界
2. 再看 [system-frontend-service-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-frontend-service-reference.md)，确定接口访问边界
3. 再看 [system-frontend-layout-reference.md](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/docs/system-frontend-layout-reference.md)，确定壳层边界
4. 最后看本文，确定什么状态应该进 `store`、怎么组织和怎么使用

---

## 一、Store 总决策

后续 `Mint.Blog.Vue/src/store` 统一按照以下结论执行：

1. `store` 只管理跨页面、跨布局、跨组件复用的长期状态，不承接页面局部临时状态。
2. 页面查询条件、弹窗开关、单页表格 loading、表单输入中间态，默认留在页面或 composable，不放进 `store`。
3. `store` 是前端状态边界层，不是接口调用堆放区，也不是页面脚本杂物间。
4. `store` 按“全局壳层状态”和“业务入口状态”组织，不按页面文件组织。
5. 需要跨路由共享、需要缓存恢复、需要布局联动、需要权限联动的状态，优先考虑进入 `store`。
6. `store` 中的异步动作应围绕“状态维护”展开，不应退化成单纯转发 `service` 调用。
7. 后续新增 `MES` 时，继续沿用同一套 `store` 分层规则，而不是重新发明另一套状态管理方式。

这是本文档的最高原则。后续所有新建 `store`、页面状态管理和跨模块状态设计，都必须服从这七条。

---

## 二、当前 Store 结构

当前 `src/store` 目录结构：

```text
src/store/
  index.ts
  plugins/
    index.ts
  modules/
    app/
      index.ts
    theme/
      index.ts
      shared.ts
    tab/
      index.ts
      shared.ts
    admin/
      system/
        auth/
          index.ts
          shared.ts
        route/
          index.ts
          shared.ts
    surfer/
      blog/
        index.ts
        content/
          index.ts
        discovery/
          index.ts
        site/
          index.ts
```

统一理解：

- `store/index.ts` 负责注册 `Pinia`
- `plugins/index.ts` 负责 `setup store` 的通用插件能力
- `modules/app`、`modules/theme`、`modules/tab` 是全局壳层状态
- `modules/admin/system/*` 是后台管理入口相关状态
- `modules/surfer/blog/*` 是前台跨页内容状态

---

## 三、Store 的职责边界

### 1. `store` 负责什么

`store` 适合承接以下状态：

- 登录态
- 当前用户信息
- 动态路由和菜单
- 页签状态
- 全局主题配置
- 布局折叠状态
- 语言切换
- 跨页共享的前台内容数据
- 需要缓存恢复的状态

### 2. `store` 不负责什么

`store` 不应承接以下状态：

- 单页列表查询条件
- 单页表格 loading
- 单页弹窗显示隐藏
- 表单输入中间态
- 一次性页面数据
- 只在一个组件内部使用的局部状态

### 3. 判断是否该进 Store 的标准

如果一个状态满足以下任意条件，可以考虑进入 `store`：

- 需要跨多个页面共享
- 刷新后需要恢复
- 需要和布局、主题、路由联动
- 多个组件需要同时读写
- 业务上本身就是“全局会话状态”

如果都不满足，默认不要放进 `store`。

---

## 四、全局壳层 Store 规则

### 1. `app store`

[app/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/modules/app/index.ts) 负责：

- `isMobile`
- 页面刷新标记
- 全内容区开关
- 横向滚动开关
- 侧边栏折叠
- 主题抽屉显隐
- 语言切换

这类状态的特点：

- 与布局和页面壳层强相关
- 会影响多个页面
- 需要跨页面持续存在

### 2. `theme store`

[theme/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/modules/theme/index.ts) 负责：

- 主题模式
- 主题色
- antd 主题对象
- 布局模式
- 灰度模式和色弱模式
- 主题配置持久化

这类状态必须在 `store` 中，而不是散在布局组件中。

### 3. `tab store`

[tab/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/modules/tab/index.ts) 负责：

- 页签集合
- 当前激活页签
- 首页页签
- 页签缓存恢复
- admin / surfer 两个入口的页签隔离

这类状态天然具有跨页面和跨导航共享特性，应由 `store` 统一管理。

---

## 五、业务入口 Store 规则

### 1. `auth store`

[auth/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/modules/admin/system/auth/index.ts) 负责：

- Token 状态
- 用户信息
- 是否登录
- 登录动作
- 初始化用户信息
- 登录失败后的重置流程

统一要求：

- 认证状态必须集中在认证 `store`
- 页面不直接复制一份 `token/userInfo/isLogin`

### 2. `route store`

[route/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/modules/admin/system/route/index.ts) 负责：

- 动态路由集合
- 全局菜单
- 面包屑
- 缓存路由
- 当前入口模块的菜单切换

统一要求：

- 动态路由、菜单和面包屑属于导航状态，必须集中管理
- 不允许每个布局、每个页面自己重新推导一套菜单树

### 3. `surfer/blog/* store`

例如 [content/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/modules/surfer/blog/content/index.ts) 负责：

- 首页摘要
- 文章卡片集合
- 文章详情
- 前台首页初始化状态

适合进入 `store` 的原因：

- 同一批前台内容可能被多个区块复用
- 首页和详情页之间存在共享内容语义
- 页面刷新前后和切换过程中存在复用价值

统一要求：

- 前台公共展示数据可以进入 `store`
- 但后台列表页面的纯查询结果，不要默认照搬这种模式

---

## 六、页面状态与 Store 的边界

### 1. 页面局部状态留在页面

例如 [article-list.vue](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/views/blog-admin/article-list.vue) 中这类状态，留在页面是合理的：

- `loading`
- `tableData`
- `total`
- `deleteModalVisible`
- `currentDeleteArticle`
- `query`

原因：

- 生命周期只属于当前页面
- 离开页面后通常不需要继续保留
- 与其他页面没有共享必要

### 2. 不要把“为了复用一点点代码”当作建 Store 的理由

如果只是：

- 两三个页面都要发一次列表请求
- 两个弹窗都要共享一个布尔值

优先考虑：

- composable
- service
- 局部组件抽离

而不是直接新建一个 `store`。

### 3. Store 不替代 composable

`store` 适合持久状态和共享状态。

`composable` 更适合：

- 表单流程封装
- 列表查询流程封装
- 页面内交互逻辑复用
- 纯函数式状态组合

---

## 七、Store 与 Service 的边界

### 1. `service` 负责接口协议

`service` 负责：

- 请求路径
- 请求参数
- 返回类型
- 协议适配

### 2. `store` 负责状态维护

`store` 负责：

- 保存结果
- 提供计算状态
- 对外暴露加载动作
- 控制初始化和重置

### 3. 不要让 Store 退化成“接口转发层”

不推荐写法：

- `store` 里只有一堆 `return await service.xxx()`
- 没有任何状态
- 页面仍然自己管理所有结果

这种情况应直接使用 `service`，不必新增 `store`。

---

## 八、Store 与 Layouts 的边界

### 1. 壳层级状态放 Store

例如：

- `isMobile`
- `themeDrawerVisible`
- `siderCollapse`
- `layout mode`
- `tabs`

这类状态与布局直接相关，应统一由 `store` 管理。

### 2. 布局组件只消费 Store，不发明平行状态

布局组件统一通过：

- `useAppStore()`
- `useThemeStore()`
- `useTabStore()`
- `useRouteStore()`

读取状态。

不推荐在 `layout/index.vue` 内再额外维护一套与 `store` 平行的长期状态。

---

## 九、Store 与路由的边界

### 1. 路由状态统一由 `route store` 收口

包括：

- 菜单树
- 面包屑
- 缓存路由
- 路由是否准备完成

### 2. 页面不直接复制导航派生逻辑

例如：

- 当前激活菜单
- 面包屑数组
- 搜索菜单结构

应直接从 `route store` 获取，而不是页面临时自己算一遍。

### 3. 路由切换副作用集中在 Store 或守卫

例如：

- 登录后初始化路由
- 路由切换后更新菜单模块
- 初始化首页页签

这类副作用应放在 `route store` 或路由守卫，而不是散在页面中。

---

## 十、初始化、重置与持久化规则

### 1. Store 需要明确初始化入口

例如当前已有：

- `initUserInfo()`
- `initAuthRoute()`
- `initHomeTab()`
- `initHome()`

统一要求：

- 需要初始化的 `store` 必须有清晰入口
- 不要依赖页面随机访问顺序触发隐式初始化

### 2. Store 需要明确重置策略

例如当前已有：

- `resetStore()`
- `resetRouteCache()`
- `clearAuthStorage()`

统一要求：

- 登录态、路由态、主题态、页签态都应有可预期的重置方式

### 3. 持久化只持久化“值得持久化”的状态

适合持久化：

- token
- theme settings
- tabs
- language

不适合持久化：

- 临时 loading
- 弹窗显隐
- 页面表单输入过程
- 瞬时接口错误

---

## 十一、命名与组织规则

### 1. 目录组织

统一按语义组织：

- `modules/app`
- `modules/theme`
- `modules/tab`
- `modules/admin/system/auth`
- `modules/admin/system/route`
- `modules/surfer/blog/content`

### 2. Store 命名

统一使用：

- `useAppStore`
- `useThemeStore`
- `useAuthStore`
- `useRouteStore`
- `useTabStore`
- `useSurferBlogContentStore`

规则：

- 统一以 `use` 开头
- 统一以 `Store` 结尾
- 中间用完整业务语义，不用缩写

### 3. 动作命名

统一使用明确动作名：

- `initUserInfo`
- `resetStore`
- `loadArticles`
- `loadArticleDetail`
- `changeLocale`
- `toggleSiderCollapse`

不推荐：

- `getData`
- `handle`
- `doSomething`

---

## 十二、什么时候新建 Store

满足以下任意两条，才建议新建 `store`：

1. 状态需要跨页面共享
2. 状态需要跨刷新恢复
3. 多个组件需要共同读写
4. 状态需要与路由、布局、主题联动
5. 需要统一初始化、重置和缓存策略

如果只满足一条，优先考虑：

- 页面局部状态
- composable
- service

---

## 十三、未来新增 MES 怎么做

后续新增 `MES` 时，继续沿用当前结构思路：

```text
src/store/modules/
  admin/
    system/
      auth/
      route/
  surfer/
    blog/
      content/
  mes/
    admin/
      dashboard/
      work-order/
    terminal/
      workstation/
```

原则：

- 先按业务域和入口组织
- 再按状态语义拆分模块
- 不按页面名新建 `store`

例如：

- `MES` 的工作台全局状态可以进 `store`
- `MES` 某个工单列表页的筛选弹窗状态不必进 `store`

---

## 十四、插件规则

[plugins/index.ts](file:///Users/yangmufa/UserDevelopment/CSharp/Mint.Blog/Mint.Blog.Vue/src/store/plugins/index.ts) 当前提供了：

- setup 语法 `store` 的 `$reset` 能力

统一要求：

- 通用型 `store` 增强能力放到 `plugins`
- 不把某个业务模块的特殊逻辑塞进全局 `Pinia` 插件

适合放插件的能力：

- 通用重置
- 通用持久化包装
- 通用日志或调试增强

不适合：

- 文章模块业务逻辑
- 用户模块权限逻辑

---

## 十五、禁止项

以下做法不应继续出现在新代码中：

- 把单页查询条件全部塞进 `store`
- 把弹窗开关、临时 loading 默认塞进 `store`
- 页面和 `store` 同时维护一份长期重复状态
- 新建一个没有状态、只转发接口的 `store`
- 在 `store` 中直接拼页面 UI 文案流程
- 按页面名组织 `store`
- 遇到复用需求就第一反应新建 `store`

---

## 十六、落地检查清单

每次准备新增一个 `store` 模块前，先检查：

1. 这个状态是否真的跨页面或跨组件共享
2. 刷新后是否真的需要恢复
3. 是否更适合放在页面局部状态
4. 是否更适合提取为 composable
5. 是否只是接口调用，根本不需要 `store`
6. 是否已经有现成 `store` 可以承接
7. 初始化、重置、持久化策略是否明确

---

## 十七、最终结论

- `store` 只管理跨页面、跨布局、跨组件复用的长期状态，不承接页面局部临时状态
- 页面查询条件、弹窗开关、单页 loading、表单输入中间态，默认留在页面或 composable
- `store` 是前端状态边界层，不是接口转发层，也不是页面脚本杂物间
- `store` 按全局壳层状态和业务入口状态组织，不按页面组织
- 需要跨路由共享、需要缓存恢复、需要布局联动、需要权限联动的状态，优先考虑进入 `store`
- 后续新增 `MES` 时，继续沿用同一套 `store` 分层规则
