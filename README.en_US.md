<div align="center">
  <img src="./Docs/PageImages/system-logo.svg" width="160" />
  <h1>Mint.Blog</h1>
  <p>
   <br />
   <a href="https://github.com/YangGongziDev/Mint.Blog"><strong>Mint.Blog</strong></a> is a personal blogging project with a decoupled frontend and backend. It consists of a .NET Web API, a Vue admin dashboard and a Nuxt blog frontend, covering content publishing, reader interaction, resource navigation and administration.
  </p>
  <span><a href="./README.md">中文</a> | English</span>
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
> If you find `Mint.Blog` helpful or enjoy this project, please give it a star on GitHub or Gitee. Your support motivates me to keep improving it and adding new features. Thank you for your support!

## Project Structure

| Directory | Responsibilities |
| --- | --- |
| `Mint.Blog.Common` | Common responses, exceptions, JWT, password hashing, email and object storage adapters |
| `Mint.Blog.Model` | Data entities, request DTOs, response VOs, configuration Options |
| `Mint.Blog.Repository` | Repository interfaces and implementations, SqlSugar data access, units of work and transactions |
| `Mint.Blog.Service` | Business interfaces and implementations, background jobs, notification and statistics queues |
| `Mint.Blog.WebApi` | ASP.NET Core entry point, controllers, middleware, authentication and authorization, and dependency injection |
| `Mint.Blog.Admin.Vue` | Vue admin dashboard |
| `Mint.Blog.Web.Nuxt` | Nuxt blog frontend |
| `Docs` | System introduction, database scripts, deployment instructions and screenshots |


## Technology Stack

| Component | Main Technologies |
| --- | --- |
| Backend | .NET / ASP.NET Core 10, SqlSugar 5, PostgreSQL, JWT, Serilog, Scalar OpenAPI |
| Admin Dashboard | Vue 3.5, Vite 8, TypeScript 6, Ant Design Vue 4, Pinia, Tailwind CSS 4 |
| Blog Frontend | Nuxt 4, Vue 3.5, TypeScript 6, markdown-it, sanitize-html |
| Storage and Notifications | RustFS / S3-compatible object storage, SMTP email |

The database schema script was exported from PostgreSQL 17.2; please verify compatibility with other versions yourself. Refer to each project's files and lockfiles for exact dependency versions.

## Features

- **Content Management**: Article publishing, resources, tags, columns and Markdown content rendering.
- **Resource Navigation**: Search external resources by technology tag, version and resource type.
- **Reader Interaction**: Comments, friend links and email notifications.
- **Blog Presentation**: Gallery, gear, project and author information pages, with light/dark themes and responsive layouts.
- **Administration**: Users, roles, permissions, site configuration, file management and administrative auditing.
- **Statistics and Jobs**: Visit statistics and background queue jobs.
- **Layered Architecture and Tooling**: A backend organized into five projects, with independent builds and type-checking commands for the blog frontend and admin dashboard.

## Project Documentation

- Documentation: [https://www.yanggongzi.dev/columns/1](https://www.yanggongzi.dev/columns/1)
- Demo: [https://www.yanggongzi.dev](https://www.yanggongzi.dev) (the username and password are filled in automatically)

## Screenshots

### Desktop Blog Frontend

#### Dashboard
![](./Docs/PageImages/DesktopFront/dashboard.png)

#### Home
![](./Docs/PageImages/DesktopFront/home.png)

#### Columns
![](./Docs/PageImages/DesktopFront/column.png)

#### Column Details
![](./Docs/PageImages/DesktopFront/column-detail.png)

#### Categories
![](./Docs/PageImages/DesktopFront/category.png)

#### Gallery
![](./Docs/PageImages/DesktopFront/gallery.png)

#### Friend Links
![](./Docs/PageImages/DesktopFront/friend.png)

#### Article Details
![](./Docs/PageImages/DesktopFront/article-detail2.png)

#### Comments
![](./Docs/PageImages/DesktopFront/comment.png)

#### Dark Theme
![](./Docs/PageImages/DesktopFront/nighttime-theme.png)
![](./Docs/PageImages/DesktopFront/nighttime-theme2.png)
![](./Docs/PageImages/DesktopFront/nighttime-theme3.png)
![](./Docs/PageImages/DesktopFront/nighttime-theme4.png)

### Desktop Admin Dashboard

#### Admin Home
![](./Docs/PageImages/DesktopBackstage/home.png)

#### Image Management
![](./Docs/PageImages/DesktopBackstage/gallery.png)

#### Blog Settings
![](./Docs/PageImages/DesktopBackstage/settings.png)

### Mobile

#### Home
<img src="./Docs/PageImages/Mobile/home.png" alt="Mobile home page" width="230" />

#### Menu
<img src="./Docs/PageImages/Mobile/menu-list.png" alt="Mobile menu" width="230" />

#### Article Table of Contents
<img src="./Docs/PageImages/Mobile/article-ontents.png" alt="Mobile article table of contents" width="230" />

#### Article Details
<img src="./Docs/PageImages/Mobile/article-detail.png" alt="Mobile article details" width="230" />

#### Gallery
<img src="./Docs/PageImages/Mobile/gallery.png" alt="Mobile gallery" width="230" />

## Local Development

### Prerequisites

- Git and the .NET 10 SDK.
- Node.js 24 LTS is recommended, with a minimum version of `24.15.0` to meet the current dependencies of the blog frontend and admin dashboard.
- The admin dashboard uses pnpm, version `10.30.3` or later; the blog frontend instructions below use npm to match its Docker build.
- PostgreSQL; file uploads also require RustFS or S3-compatible storage, and email notifications require SMTP configuration.

### Get the Source Code

```bash
git clone https://github.com/YangGongziDev/Mint.Blog.git
cd Mint.Blog
```

You can also get the source code from Gitee: <https://gitee.com/YangGongziDev/Mint.Blog>.

Unless otherwise noted, run the following commands from the repository root. Start the three services in separate terminals.

### 1. Start the Backend WebApi

#### Initialize the Database

1. Create the target database and import [Docs\Database.sql](./Docs/Database.sql) into the new database.
2. Configure the backend connection string and other service settings before starting the backend.

> **Warning: The schema script contains statements that drop tables and sequences, and uses `postgres` as the object owner. Do not import it directly into an existing application database; back up your data and review permissions and the script contents first.**

#### Configure the Database, RustFS and Other Services

Update `Mint.Blog.WebApi/appsettings.Development.json` for your environment, or override the configuration using environment variables.

| Configuration Section | Purpose and Main Fields |
| --- | --- |
| `PostgreSql` | `ConnectionString`: PostgreSQL connection string |
| `Jwt` | `Issuer`, `Audience`, `SecurityKey`, `AccessTokenExpireMinutes` |
| `RustFS` | `Endpoint`, `UseSsl`, `PublicEndpoint`, `AccessKey`, `SecretKey`, `BucketName` |
| `Smtp` | `Host`, `Port`, `UserName`, `Password`, `From`, `EnableSsl` |
| `Site` | `Url`, `FeedUrl`: Site and feed URLs |
| `CommentNotification` | `Domain`: Configuration related to comment notifications |

Start command
```shell
cd Mint.Blog.WebApi
dotnet run
```

The backend listens at <http://localhost:7000>.
- [Health Check<http://localhost:7000/api/health>](http://localhost:7000/api/health): Development/Production environment.
- [Scalar API Documentation<http://localhost:7000/api/docs>](http://localhost:7000/api/docs): Available only in the `Development` environment.
- [OpenAPI JSON<http://localhost:7000/api/openapi/v1.json>](http://localhost:7000/api/openapi/v1.json): Available only in the `Development` environment.

### 2. Start the Admin Frontend

Check `VITE_SERVICE_BASE_URL` (backend API) and `VITE_BLOG_WEB_URL` (blog frontend) in `.env.development`. The `/api/` URL in production requires reverse proxy support in your deployment, or you can use the default configuration.

```bash
cd Mint.Blog.Admin.Vue
pnpm install --frozen-lockfile
pnpm dev
```

Admin dashboard URL: <http://localhost:7100>.

#### Initial Accounts and Passwords

| Role | Username | Password |
| --- | --- | --- |
| Super Administrator | `SuperAdmin` | `SuperAdmin` |
| Regular Administrator | `GenerallyAdmin` | `GenerallyAdmin` |
| Guest User | `VisitorAdmin` | `VisitorAdmin` |
> These accounts are for development use only. Do not retain the default passwords in production.

### 3. Start the Surfer Frontend

Before starting, update `runtimeConfig` in `Mint.Blog.Web.Nuxt/nuxt.config.ts` for your local environment to configure the backend API, blog frontend, admin dashboard and resource URLs, or use the default configuration.

```bash
cd Mint.Blog.Web.Nuxt
npm ci
pnpm dev
```

Blog frontend URL: <http://localhost:8080>. The Nuxt server connects to `http://localhost:7000/api` by default.

## Docker Deployment

The repository provides separate Compose files for the backend and blog frontend, not a complete one-click deployment stack with all dependencies included. Prepare PostgreSQL, object storage and a reverse proxy separately, and adjust the configuration for your environment.

The blog frontend container sets the following Nuxt runtime configuration through `environment` in `Mint.Blog.Web.Nuxt/compose.yaml`, overriding the defaults in `nuxt.config.ts`:

| Environment Variable | Purpose |
| --- | --- |
| `NUXT_API_BASE` | Backend API URL accessed by the Nuxt server; a container network address can be used |
| `NUXT_PUBLIC_SITE_URL` | Public blog frontend URL; should match the backend's `Site:Url` |
| `NUXT_PUBLIC_ADMIN_SITE_URL` | Admin dashboard URL accessible from the browser |
| `NUXT_PUBLIC_ASSET_BASE_URL` | Public resource URL accessible from the browser |

These variables also apply to non-container environments; this section only explains where to configure them for Compose deployments.

For more steps, see the [Docker Deployment Guide](./Docs/Docker部署流程.md). Refer to the current Compose files and Dockerfiles for the actual parameters.
- [Mint.Blog Docker Deployment](https://www.yanggongzi.dev/columns/1). Refer to the current Compose files and Dockerfiles for the actual parameters.

## Ecosystem

- [Mint.Forge](https://github.com/YangGongziDev/Mint.Forge): A `.NET microservices rapid development framework for middle and back-office applications`, rebuilt from `Mint.Blog` and maintained independently.
- [Mint.Forge.Vue](https://github.com/YangGongziDev/Mint.Forge.Vue): A `The front-end Admin is a universal front-end management interface`, rebuilt from `Mint.Blog.Vue` and maintained independently, designed to work with the `Mint.Forge` backend.


## How to Contribute

We warmly welcome and appreciate contributions of all kinds. If you have any ideas or suggestions, please share them by submitting [pull requests](https://github.com/YangGongziDev/Mint.Blog/pulls) or opening a GitHub [issue](https://github.com/YangGongziDev/Mint.Blog/issues/new).

## Git Commit Guidelines

We recommend following [Conventional Commits](https://www.conventionalcommits.org/) for commit messages to facilitate automated changelog generation and version management.


## Browser Support

We recommend using the latest version of Chrome for development to get the best experience.

| [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/archive/internet-explorer_9-11/internet-explorer_9-11_48x48.png" alt="IE" width="24px" height="24px"  />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/edge/edge_48x48.png" alt=" Edge" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/firefox/firefox_48x48.png" alt="Firefox" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/chrome/chrome_48x48.png" alt="Chrome" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/safari/safari_48x48.png" alt="Safari" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) |
| --- | --- | --- | --- | --- |
| not support | last 2 versions | last 2 versions | last 2 versions | last 2 versions |

## Declaration
This project is based on the MIT license and is open source.
