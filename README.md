<div align="center">
  <img src="./Docs/PageImages/system-logo.svg" width="160" />
  <h1>Mint.Blog</h1>
  <p>
   <br />
   <a href="[https://petdex.dev](https://github.com/YangGongziDev/Mint.Blog)"><strong>Mint.Blog</strong></a>是一个面向个人博客场景的前后端分离项目，由 .NET Web API、Vue 管理后台和 Nuxt 博客前台组成，覆盖内容发布、读者互动、资源导航和后台管理。
  </p>
  <span>中文 | <a href="./README.en_US.md">English</a></span>
</div>

---

<p align="center">
  <a href="./LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg" alt="license" /></a>
  <a href="https://github.com/YangGongziDev/Mint.Blog"><img src="https://img.shields.io/github/stars/YangGongziDev/Mint.Blog" alt="github stars" /></a>
  <a href="https://github.com/YangGongziDev/Mint.Blog"><img src="https://img.shields.io/github/forks/YangGongziDev/Mint.Blog" alt="github forks" /></a>
  <a href="https://gitee.com/YangGongziDev/Mint.Blog"><img src="https://gitee.com/YangGongziDev/Mint.Blog/badge/star.svg" alt="gitee stars" /></a>
  <a href="https://gitee.com/YangGongziDev/Mint.Blog"><img src="https://gitee.com/YangGongziDev/Mint.Blog/badge/fork.svg" alt="gitee forks" /></a>
</p>

> [!NOTE]
> 如果您觉得 `Mint.Blog` 对你有所帮助，或者您喜欢这个项目，请在 GitHub、Gitee 上给我一个 ⭐️。你的支持是我持续改进和增加新功能的动力！感谢你的支持！

## 项目结构

| 目录 | 职责 |
| --- | --- |
| `Mint.Blog.Common` | 通用响应、异常、JWT、密码哈希、邮件与对象存储适配 |
| `Mint.Blog.Model` | 数据实体、请求 DTO、响应 VO、配置 Options |
| `Mint.Blog.Repository` | 仓储接口及实现、SqlSugar 数据访问、工作单元与事务 |
| `Mint.Blog.Service` | 业务接口及实现、后台任务、通知与统计队列 |
| `Mint.Blog.WebApi` | ASP.NET Core 入口、控制器、中间件、鉴权和依赖注入 |
| `Mint.Blog.Admin.Vue` | Vue 管理后台 |
| `Mint.Blog.Web.Nuxt` | Nuxt 博客前台 |
| `Docs` | 系统介绍、数据库、部署说明及截图 |

## 技术栈

| 部分 | 主要技术 |
| --- | --- |
| 后端 | .NET / ASP.NET Core 10、SqlSugar 5、PostgreSQL、JWT、Serilog、Scalar OpenAPI |
| 管理后台 | Vue 3.5、Vite 8、TypeScript 6、Ant Design Vue 4、Pinia、Tailwind CSS 4 |
| 博客前台 | Nuxt 4、Vue 3.5、TypeScript 6、markdown-it、sanitize-html |
| 存储与通知 | RustFS / S3 兼容对象存储、SMTP 邮件 |

数据库结构脚本导出自 PostgreSQL 17.2；其他版本请自行验证兼容性。具体依赖版本以各项目文件和锁文件为准。

## 特性

- **内容管理**：文章发布、资源、标签、专栏与 Markdown 内容展示。
- **资源导航**：按技术标签、版本及资源类型检索外链资源。
- **读者互动**：评论、友情链接及邮件通知。
- **博客展示**：画廊、装备、关于项目与作者等页面，支持日间／夜间主题和响应式布局。
- **后台管理**：用户、角色、权限、站点配置、文件管理与管理审计。
- **统计与任务**：访问统计及后台队列任务。
- **分层与工程化**：后端五项目分层，前后台独立构建并提供类型检查命令。

## 项目文档

- 文档：[https://www.yanggongzi.dev/columns/1](https://www.yanggongzi.dev/columns/1)
- 演示：[https://www.yanggongzi.dev](https://www.yanggongzi.dev)(账号密码会自动输入)

## 页面截图

### PC 端前台

#### 看板
![](./Docs/PageImages/DesktopFront/dashboard.png)

#### 首页
![](./Docs/PageImages/DesktopFront/home.png)

#### 专栏
![](./Docs/PageImages/DesktopFront/column.png)

#### 专栏详情
![](./Docs/PageImages/DesktopFront/column-detail.png)

#### 分类
![](./Docs/PageImages/DesktopFront/category.png)

#### 画廊
![](./Docs/PageImages/DesktopFront/gallery.png)

#### 友链
![](./Docs/PageImages/DesktopFront/friend.png)

#### 文章详情
![](./Docs/PageImages/DesktopFront/article-detail2.png)

#### 评论
![](./Docs/PageImages/DesktopFront/comment.png)

#### 夜间主题
![](./Docs/PageImages/DesktopFront/nighttime-theme.png)
![](./Docs/PageImages/DesktopFront/nighttime-theme2.png)
![](./Docs/PageImages/DesktopFront/nighttime-theme3.png)
![](./Docs/PageImages/DesktopFront/nighttime-theme4.png)

### PC 端后台

#### 后台首页
![](./Docs/PageImages/DesktopBackstage/home.png)

#### 图片管理
![](./Docs/PageImages/DesktopBackstage/gallery.png)

#### 博客设置
![](./Docs/PageImages/DesktopBackstage/settings.png)

### 移动端

#### 首页
<img src="./Docs/PageImages/Mobile/home.png" alt="移动端首页" width="230" />

#### 菜单
<img src="./Docs/PageImages/Mobile/menu-list.png" alt="移动端菜单" width="230" />

#### 文章目录
<img src="./Docs/PageImages/Mobile/article-ontents.png" alt="移动端文章目录" width="230" />

#### 文章详情
<img src="./Docs/PageImages/Mobile/article-detail.png" alt="移动端文章详情" width="230" />

#### 画廊
<img src="./Docs/PageImages/Mobile/gallery.png" alt="移动端画廊" width="230" />

## 本地开发

### 环境准备

- Git、.NET 10 SDK。
- 推荐 Node.js 24 LTS，至少 `24.15.0`，以满足当前前后台依赖要求。
- 管理后台使用 pnpm，版本至少 `10.30.3`；前台以下使用 npm，与其 Docker 构建保持一致。
- PostgreSQL；涉及文件上传时还需准备 RustFS 或 S3 兼容存储，邮件通知需配置 SMTP。

### 获取源码

```bash
git clone https://github.com/YangGongziDev/Mint.Blog.git
cd Mint.Blog
```

也可从 Gitee 获取：<https://gitee.com/YangGongziDev/Mint.Blog>。

以下命令除特别说明外均从仓库根目录开始执行，三个服务需在独立终端中启动。

### 一、启动后端WebApi

#### 数据库初始化

1. 创建目标数据库，并向新库导入 [Docs\Database.sql](./Docs/Database.sql)。
2. 配置后端连接字符串及其他服务参数后再启动。

> **注意：结构脚本包含删除表和序列的语句，且对象所有者使用 `postgres`。不要直接向已有业务数据库导入；请先备份并核对权限及脚本内容。**

#### 配置数据库和RustFS等

按环境修改 `Mint.Blog.WebApi/appsettings.Development.json`，或通过环境变量覆盖配置。

| 配置节 | 用途及主要字段 |
| --- | --- |
| `PostgreSql` | `ConnectionString`：PostgreSQL 连接字符串 |
| `Jwt` | `Issuer`、`Audience`、`SecurityKey`、`AccessTokenExpireMinutes` |
| `RustFS` | `Endpoint`、`UseSsl`、`PublicEndpoint`、`AccessKey`、`SecretKey`、`BucketName` |
| `Smtp` | `Host`、`Port`、`UserName`、`Password`、`From`、`EnableSsl` |
| `Site` | `Url`、`FeedUrl`：站点及订阅地址 |
| `CommentNotification` | `Domain`：评论通知相关配置 |

启动命令
```shell
cd Mint.Blog.WebApi
dotnet run
```

后端监听端口：<http://localhost:7000>。
- [健康检查<http://localhost:7000/api/health>](http://localhost:7000/api/health)：开发环境/生产环境。
- [Scalar 接口文档<http://localhost:7000/api/docs>](http://localhost:7000/api/docs)：仅 `Development` 环境开放。
- [OpenAPI JSON<http://localhost:7000/api/openapi/v1.json>](http://localhost:7000/api/openapi/v1.json)：仅 `Development` 环境开放。

### 二、启动前端Admin

检查 `.env.development` 中的 `VITE_SERVICE_BASE_URL`（后端 API）与 `VITE_BLOG_WEB_URL`（博客前台）。生产环境的 `/api/` 地址需要部署侧反向代理支持,或者使用默认配置。

```bash
cd Mint.Blog.Admin.Vue
pnpm install --frozen-lockfile
pnpm dev
```

后台地址：<http://localhost:7100>。

#### 初始账号密码

| 角色 | 账号 | 密码 |
| --- | --- | --- |
| 超级管理员 | `SuperAdmin` | `SuperAdmin` |
| 普通管理员 | `GenerallyAdmin` | `GenerallyAdmin` |
| 访客用户 | `VisitorAdmin` | `VisitorAdmin` |
> 以上账号仅供开发环境使用，请勿在生产环境保留默认密码。

### 三、启动前端Surfer

启动前，请按本地环境修改 `Mint.Blog.Web.Nuxt/nuxt.config.ts` 中的 `runtimeConfig`，配置后端 API、博客前台、管理后台及资源访问地址,或者使用默认配置。

```bash
cd Mint.Blog.Web.Nuxt
npm ci
pnpm dev
```

前台地址：<http://localhost:8080>，Nuxt 服务端默认连接到 `http://localhost:7000/api`。

## Docker 部署

仓库提供后端和博客前台各自的 Compose 文件，不是包含所有依赖的一键完整部署栈。需另行准备 PostgreSQL、对象存储及反向代理，并按环境调整配置。

博客前台容器通过 `Mint.Blog.Web.Nuxt/compose.yaml` 的 `environment` 设置以下 Nuxt 运行时配置，覆盖 `nuxt.config.ts` 中的默认值：

| 环境变量 | 用途 |
| --- | --- |
| `NUXT_API_BASE` | Nuxt 服务端访问后端的 API 地址，可使用容器网络地址 |
| `NUXT_PUBLIC_SITE_URL` | 博客前台公开地址，应与后端 `Site:Url` 一致 |
| `NUXT_PUBLIC_ADMIN_SITE_URL` | 浏览器可访问的管理后台地址 |
| `NUXT_PUBLIC_ASSET_BASE_URL` | 浏览器可访问的资源公开地址 |

以上变量也可用于非容器环境；这里只说明 Compose 部署时的配置位置。

更多步骤见 [Docker 部署说明](./Docs/Docker部署流程.md)，实际参数以当前 Compose 和 Dockerfile 为准。
- [Mint.Blog Docker 部署](https://www.yanggongzi.dev/columns/1)，实际参数以当前 Compose 和 Dockerfile 为准。

## 周边生态

- [Mint.Forge](https://github.com/YangGongziDev/Mint.Forge)：基于`Mint.Blog`重新构建并独立维护的`.Net微服务中后台快速开发框架`。
- [Mint.Forge.Vue](https://github.com/YangGongziDev/Mint.Forge.Vue)：基于`Mint.Blog.Vue`重新构建并独立维护的`前端Admin通用前端管理界面`，用于配套`Mint.Forge`后端。


## 如何贡献

我们热烈欢迎并感谢所有形式的贡献。如果您有任何想法或建议，欢迎通过提交 [pull requests](https://github.com/YangGongziDev/Mint.Blog/pulls) 或创建 GitHub [issue](https://github.com/YangGongziDev/Mint.Blog/issues/new) 来分享。

## Git 提交规范

建议使用 [Conventional Commits](https://www.conventionalcommits.org/) 规范来组织提交信息，便于自动生成变更日志与版本管理。


## 浏览器支持

推荐使用最新版的 Chrome 浏览器进行开发，以获得更好的体验。

| [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/archive/internet-explorer_9-11/internet-explorer_9-11_48x48.png" alt="IE" width="24px" height="24px"  />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/edge/edge_48x48.png" alt=" Edge" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/firefox/firefox_48x48.png" alt="Firefox" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/chrome/chrome_48x48.png" alt="Chrome" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/safari/safari_48x48.png" alt="Safari" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) |
| --- | --- | --- | --- | --- |
| not support | last 2 versions | last 2 versions | last 2 versions | last 2 versions |

## 声明

本项目基于 [2026 程序员杨工子 © MIT](./LICENSE) 协议开源。