 <div align="center">
  <img src="https://img.yangmufa.cn/blog-system/mint-logo.svg" width="160" />
  <h1>mint-blog-v1-java 已停止更新</h1>
  <h1>欢迎体验基于 .Net DDD 的 Mint.Blog V2 版本</h1>
  <h2>作者：<a href="https://www.yangmufa.cn/blog/surfer/author">程序员-杨工子</a></h2>
  <span>中文 | <a href="./README.en.md">English</a></span>
</div>


#### 介绍
Mint.Blog V1（原 RocBlog 鲲鹏博客）基于 **Java Spring Boot + Vue2** 技术栈构建，是一款前后端分离的博客系统。当前分支已停止更新，请移步 [main](https://github.com/YangMufa/Mint.Blog) 分支体验基于 .NET DDD 的 V2 版本。

**核心特性：**

- 📝 文章管理：Markdown 编辑、分类 / 标签、置顶、知识库
- 🖼️ 图片管理：MinIO 对象存储
- 💬 评论系统：文章评论、邮件通知
- 🔐 认证授权：Spring Security + JWT
- 📊 后台看板：访问量、文章量统计
- 📱 响应式布局：移动端 / 桌面端适配

#### 技术栈

| 层级 | 技术 |
|------|------|
| 后端框架 | Spring Boot 2.x |
| ORM | Spring Data JPA |
| 数据库 | MySQL |
| 对象存储 | MinIO |
| 认证 | Spring Security + JWT |
| 接口文档 | Knife4j (Swagger) |
| 前端框架 | Vue 2 + Vue Router + Vuex |
| UI 组件 | Element UI |
| 构建工具 | Maven (后端) / Vue CLI (前端) |

#### 项目结构

```
mint-blog-v1-java/
├── Admin/                        # Spring Boot 后端
│   └── src/main/java/cn/yangmufa/blog/
│       ├── admin/                # 管理后台模块
│       └── blog/                 # 博客前台模块
├── Front/                        # Vue2 前台
└── Blog-Admin/                   # Vue2 管理后台

```

#### 本地运行

**后端：**
```bash
cd Admin
mvn spring-boot:run
```

**前台：**
```bash
cd Front
npm install
npm run serve
```

**管理后台：**
```bash
cd Blog-Admin
npm install
npm run serve
```

#### 参与贡献

1. Fork 本仓库
2. 新建 `Feat_xxx` 分支
3. 提交代码
4. 新建 Pull Request


## 演示
![](https://img.yangmufa.cn/blog-system/%E7%A7%BB%E5%8A%A8%E7%AB%AF_V1_%E6%96%87%E7%AB%A0%E8%AF%A6%E6%83%85.png)
![](https://img.yangmufa.cn/blog-system/PC_V1_Home.png)
![](https://img.yangmufa.cn/blog-system/PC_V1_%E6%96%87%E7%AB%A0%E8%AF%A6%E6%83%85.png)
