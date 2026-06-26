<div align="center">
  <img src="./Mint.Blog.Vue/public/favicon.svg" width="160" />
  <h1>Mint.Blog V2</h1>
  <h2>Author: <a href="https://www.yangmufa.cn/surfer/my">Coder-YangGongZi</a></h2>
  <span><a href="./README.md">中文</a> | English</span>
</div>

---
<h3>Original RocBlog (RocBlog) renamed to Mint.Blog V1</h3>
<h3>Code merged into the Mint.Blog repository under the <a href="https://github.com/YangMufa/Mint.Blog/tree/mint-blog-v1-java">mint-blog-v1-java</a> branch</h3>

---

[![license](https://img.shields.io/badge/license-MIT-green.svg)](./LICENSE)
[![github stars](https://img.shields.io/github/stars/YangMufa/Mint.Blog)](https://github.com/YangMufa/Mint.Blog)
[![github forks](https://img.shields.io/github/forks/YangMufa/Mint.Blog)](https://github.com/YangMufa/Mint.Blog)
[![gitee stars](https://gitee.com/YangMufa/Mint.Blog/badge/star.svg)](https://gitee.com/YangMufa/Mint.Blog)

## Star History

[![Star History Chart](https://api.star-history.com/chart?repos=YangMufa/Mint.Blog&type=date&legend=top-left)](https://www.star-history.com/?type=date&repos=YangMufa%2FMint.Blog)

> [!NOTE]
> If you find `Mint.Blog` helpful or simply enjoy the project, please give it a ⭐️ on GitHub or Gitee. Your support is the driving force behind continuous improvements and new features. Thank you for your support!

## Project Structure

- `Mint.Blog.Domain`: Backend - Domain Layer
- `Mint.Blog.Application`: Backend - Application Layer
- `Mint.Blog.Infrastructure`: Backend - Infrastructure Layer
- `Mint.Blog.WebApi`: Backend - API Layer
- `Mint.Blog.Vue`: Frontend

## Tech Stack
Backend: `.NET DDD + SqlSugar + PostgreSQL`  
Frontend: `TypeScript + Vue + AntDesignVue + TailwindCSS`  


## Introduction

[`Mint.Blog`](https://github.com/YangMufa/Mint.Blog)
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

- [https://www.yangmufa.cn/blog/surfer/column/1](https://www.yangmufa.cn/blog/surfer/column/1)

## Screenshots
### Mobile
![](https://img.yangmufa.cn/blog-system/%E7%A7%BB%E5%8A%A8%E7%AB%AF_%E8%8F%9C%E5%8D%95.png)
![](https://img.yangmufa.cn/blog-system/%E7%A7%BB%E5%8A%A8%E7%AB%AF_%E9%A6%96%E9%A1%B5.png)
![](https://img.yangmufa.cn/blog-system/%E7%A7%BB%E5%8A%A8%E7%AB%AF_%E6%96%87%E7%AB%A0%E8%AF%A6%E6%83%85.png)
### Desktop
![](https://img.yangmufa.cn/blog-system/%E4%BB%A3%E7%A0%81%E6%9E%B6%E6%9E%84.png)
![](https://img.yangmufa.cn/blog-system/PC_%E7%9C%8B%E6%9D%BF.png)
![](https://img.yangmufa.cn/blog-system/PC_%E9%A6%96%E9%A1%B5.png)
![](https://img.yangmufa.cn/blog-system/PC_%E6%96%87%E7%AB%A0_Banner.png)
![](https://img.yangmufa.cn/blog-system/PC_%E6%96%87%E7%AB%A0_%E8%AF%A6%E6%83%85.png)
![](https://img.yangmufa.cn/blog-system/PC_%E6%96%87%E7%AB%A0_%E5%BA%95%E9%83%A8.png)
![](https://img.yangmufa.cn/blog-system/PC_%E4%B8%93%E6%A0%8F.png)
![](https://img.yangmufa.cn/blog-system/PC_%E6%96%87%E7%AB%A0_%E5%88%86%E7%B1%BB.png)
![](https://img.yangmufa.cn/blog-system/PC_%E6%96%87%E7%AB%A0%E7%AE%A1%E7%90%86.png)
![](https://img.yangmufa.cn/blog-system/PC_%E5%9B%BE%E7%89%87%E7%AE%A1%E7%90%86.png)
![](https://img.yangmufa.cn/blog-system/PC_%E4%B8%93%E6%A0%8F%E7%AE%A1%E7%90%86.png)

## Usage

**Environment Setup**

Ensure your environment meets the following requirements:

- **git**: You need git to clone and manage project versions.
- **NodeJS**: >=18.12.0, recommended 18.19.0 or higher.
- **pnpm**: >= 8.7.0, recommended 8.14.0 or higher.

**Clone the Project**

```bash
# github
git clone https://github.com/YangMufa/Mint.Blog.git
# gitee
git clone https://gitee.com/YangMufa/Mint.Blog.git
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

- [Mint.Admin](https://github.com/YangMufa/Mint.Admin): A .NET DDD rapid development framework for admin systems, rebuilt based on Mint.Blog V2.


## How to Contribute

We warmly welcome and appreciate all forms of contributions. If you have any ideas or suggestions, feel free to share them by submitting [pull requests](https://github.com/YangMufa/Mint.Blog/pulls) or creating a GitHub [issue](https://github.com/YangMufa/Mint.Blog/issues/new).

## Git Commit Convention

It is recommended to use the [Conventional Commits](https://www.conventionalcommits.org/) specification for organizing commit messages, making it easier to auto-generate changelogs and manage releases.


## Browser Support

It is recommended to use the latest version of Chrome for development to get the best experience.

| [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/archive/internet-explorer_9-11/internet-explorer_9-11_48x48.png" alt="IE" width="24px" height="24px"  />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/edge/edge_48x48.png" alt=" Edge" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/firefox/firefox_48x48.png" alt="Firefox" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/chrome/chrome_48x48.png" alt="Chrome" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) | [<img src="https://raw.githubusercontent.com/alrra/browser-logos/master/src/safari/safari_48x48.png" alt="Safari" width="24px" height="24px" />](http://godban.github.io/browsers-support-badges/) |
| --- | --- | --- | --- | --- |
| not support | last 2 versions | last 2 versions | last 2 versions | last 2 versions |

## Contributors

Thank you to all contributors for their efforts. If you'd like to contribute to this project, please refer to [How to Contribute](#how-to-contribute).

<a href="https://github.com/YangMufa/Mint.Blog/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=YangMufa/Mint.Blog" />
</a>

## Disclaimer

1. This project is open-sourced under [2026 Coder·YangGongZi © GPL3.0](./LICENSE) for learning and reference purposes only. To protect the original author's rights, commercial use or secondary open-sourcing must retain the original author's copyright information and comply with the GPL3.0 license. The author promises that once the GitHub repository reaches 2,000 stars, this project will be re-licensed under the MIT license.

2. The frontend of this project draws inspiration from the following projects. Please support them as well:
- [soybean-admin-antd](https://github.com/soybeanjs/soybean-admin-antd)  
- [ThriveX-Blog](https://github.com/LiuYuYang01/ThriveX-Blog)
