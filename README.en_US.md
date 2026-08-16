<div align="center">
  <img src="./Docs/PageImages/system-logo.svg" width="160" />
  <h1>Mint.Blog</h1>
  <h2>Author: <a href="https://www.yanggongzi.dev/blog/surfer/author">YangGongzi</a></h2>
  <span><a href="./README.md">中文</a> | English</span>
</div>

---

[![license](https://img.shields.io/badge/license-MIT-green.svg)](./LICENSE)[![github stars](https://img.shields.io/github/stars/YangGongziDev/Mint.Blog)](https://github.com/YangGongziDev/Mint.Blog)[![github forks](https://img.shields.io/github/forks/YangGongziDev/Mint.Blog)](https://github.com/YangGongziDev/Mint.Blog)[![gitee stars](https://gitee.com/YangGongziDev/Mint.Blog/badge/star.svg)](https://gitee.com/YangGongziDev/Mint.Blog)[![gitee forks](https://gitee.com/YangGongziDev/Mint.Blog/badge/fork.svg)](https://gitee.com/YangGongziDev/Mint.Blog)

> [!NOTE]
> If you find `Mint.Blog` helpful or simply enjoy the project, please give it a ⭐️ on GitHub or Gitee. Your support is the driving force behind continuous improvements and new features. Thank you for your support!

## Project Structure (DDD Architecture)

- `Mint.Blog.Domain`: Backend - Domain Layer
- `Mint.Blog.Application`: Backend - Application Layer
- `Mint.Blog.Infrastructure`: Backend - Infrastructure Layer
- `Mint.Blog.WebApi`: Backend - API Layer
- `Mint.Blog.Vue`: Frontend

## Tech Stack
Backend: `.NET 10 + SqlSugar 5.0 + PostgreSQL 18`  
Frontend: `TypeScript 8 + Vue3 + AntDesignVue 3 + TailwindCSS 4`  


## Introduction

[`Mint.Blog`](https://github.com/YangGongziDev/Mint.Blog)
is a clean and elegant blog template; built with cutting-edge technology stack; well-structured and easy to get started; designed to help you dive into business development with minimal learning cost. Core features include theme configuration, common page components, routing and permission solutions, and internationalization support — truly out-of-the-box. It is also an excellent practice ground for learning the latest tech stack.

## Features

- **Clean Architecture**: Discarding redundant abstraction layers, the code organization follows minimal principles. Each module has a single responsibility and follows naming conventions, making it easy for newcomers to locate code and understand logic. Whether you're a beginner or a seasoned developer, you can start business development in no time.
- **Elegant UI**: Rich color schemes and a modern UI style that aligns with contemporary aesthetics.
- **Mobile Adaptation**: Full mobile support with responsive layout.
- **Comprehensive Engineering**: ESLint, type checking (vue-tsc), and unified script commands.
- **Themes & Layouts**: Built-in theme configuration and layout capabilities, paired with Tailwind CSS4 for rapid page building.
- **Permissions & Routing**: Route and permission management, covering common admin scenarios.
- **Internationalization**: Built-in i18n solution for easy multi-language extension.
- **Rich Components**: Built-in common pages and components, including error pages and other frequently used features.

## Documentation

- Documentation: [https://www.yanggongzi.dev/blog/surfer/column/1](https://www.yanggongzi.dev/blog/surfer/column/1)
- Demo: [https://www.yanggongzi.dev](https://www.yanggongzi.dev)

## Screenshots

### Desktop Frontend

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

#### Friends
![](./Docs/PageImages/DesktopFront/friend.png)

#### Article Details
![](./Docs/PageImages/DesktopFront/article-detail2.png)

#### Comments
![](./Docs/PageImages/DesktopFront/comment.png)

#### Dark Theme
![](./Docs/PageImages/DesktopFront/nighttime-theme.png)

### Desktop Admin

#### Admin Home
![](./Docs/PageImages/DesktopBackstage/home.png)

#### Image Management
![](./Docs/PageImages/DesktopBackstage/gallery.png)

#### Blog Settings
![](./Docs/PageImages/DesktopBackstage/settings.png)

### Mobile

#### Menu
<img src="./Docs/PageImages/Mobile/menu-list.png" alt="Mobile menu" width="360" />

#### Home
<img src="./Docs/PageImages/Mobile/home.png" alt="Mobile home" width="360" />

#### Article Contents
<img src="./Docs/PageImages/Mobile/article-ontents.png" alt="Mobile article contents" width="360" />

#### Article Details
<img src="./Docs/PageImages/Mobile/article-detail.png" alt="Mobile article details" width="360" />

#### Gallery
<img src="./Docs/PageImages/Mobile/gallery.png" alt="Mobile gallery" width="360" />

## Usage

**Environment Setup**

Ensure your environment meets the following requirements:

- **git**: You need git to clone and manage project versions.
- **NodeJS**: >=18.12.0, recommended 18.19.0 or higher.
- **pnpm**: >= 8.7.0, recommended 8.14.0 or higher.

**Clone the Project**

```bash
# github
git clone https://github.com/YangGongziDev/Mint.Blog.git
# gitee
git clone https://gitee.com/YangGongziDev/Mint.Blog.git
```

**Install Dependencies**

```bash
pnpm install
```

**Start Development Server**

```bash
pnpm run dev
```

**Build for Production**

```bash
pnpm build
```

## Ecosystem

- [Mint.Admin](https://github.com/YangGongziDev/Mint.Admin): A .NET DDD rapid development framework for admin systems, rebuilt based on Mint.Blog V2.


## How to Contribute

We warmly welcome and appreciate all forms of contributions. If you have any ideas or suggestions, feel free to share them by submitting [pull requests](https://github.com/YangGongziDev/Mint.Blog/pulls) or creating a GitHub [issue](https://github.com/YangGongziDev/Mint.Blog/issues/new).

## Git Commit Convention

It is recommended to use the [Conventional Commits](https://www.conventionalcommits.org/) specification for organizing commit messages, making it easier to auto-generate changelogs and manage releases.


## Browser Support

It is recommended to use the latest version of Chrome for development to get the best experience.

| [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/archive/internet-explorer_9-11/internet-explorer_9-11_48x48.png" alt="IE" width="24px" height="24px"  />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/edge/edge_48x48.png" alt=" Edge" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/firefox/firefox_48x48.png" alt="Firefox" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/chrome/chrome_48x48.png" alt="Chrome" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/safari/safari_48x48.png" alt="Safari" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) |
| --- | --- | --- | --- | --- |
| not support | last 2 versions | last 2 versions | last 2 versions | last 2 versions |

## Contributors

Thank you to all contributors for their efforts. If you'd like to contribute to this project, please refer to [How to Contribute](#how-to-contribute).

<a href="https://github.com/YangGongziDev/Mint.Blog/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=YangGongziDev/Mint.Blog" />
</a>

## Disclaimer

1. This project is open-sourced under [2026 YangGongziDev © GPL3.0](./LICENSE) for learning and reference purposes only. To protect the original author's rights, commercial use or secondary open-sourcing must retain the original author's copyright information and comply with the GPL3.0 license. The author promises that once the GitHub repository reaches 2,000 stars, this project will be re-licensed under the MIT license.

2. The frontend of this project draws inspiration from the following projects. Please support them as well:
- [soybean-admin-antd](https://github.com/soybeanjs/soybean-admin-antd)  
- [ThriveX-Blog](https://github.com/LiuYuYang01/ThriveX-Blog)
