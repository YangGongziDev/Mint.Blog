 <div align="center">
  <img src="https://img.yangmufa.cn/blog-system/mint-logo.svg" width="160" />
  <h1>mint-blog-v1-java Has stopped updating</h1>
  <h1>Welcome to experience the V2 version of Mint.Blog based on.Net DDD</h1>
  <h2>author：<a href="https://www.yangmufa.cn/blog/surfer/author">程序员-杨工子</a></h2>
  <span>English | <a href="./README.md">中文</a></span>
</div>

#### Description
Mint.Blog V1 (formerly RocBlog / Kunpeng Blog) is a blog system built on the **Java Spring Boot + Vue2** tech stack with separated frontend and backend. This branch is no longer maintained. Please visit the [main](https://github.com/YangMufa/Mint.Blog) branch for the .NET DDD-based V2 version.

**Core Features:**

- 📝 Article Management: Markdown editing, categories/tags, pinning, wiki
- 🖼️ Image Management: MinIO object storage
- 💬 Comments System: Article comments, email notifications
- 🔐 Auth & Authorization: Spring Security + JWT
- 📊 Admin Dashboard: Page views, article stats
- 📱 Responsive Layout: Mobile / desktop adaptation

#### Tech Stack

| Layer | Technology |
|------|------|
| Backend Framework | Spring Boot 2.x |
| ORM | Spring Data JPA |
| Database | MySQL |
| Object Storage | MinIO |
| Auth | Spring Security + JWT |
| API Docs | Knife4j (Swagger) |
| Frontend Framework | Vue 2 + Vue Router + Vuex |
| UI Components | Element UI |
| Build Tool | Maven (backend) / Vue CLI (frontend) |

#### Project Structure

```
mint-blog-v1-java/
├── Admin/                        # Spring Boot backend
│   └── src/main/java/cn/yangmufa/blog/
│       ├── admin/                # Admin module
│       └── blog/                 # Blog front-end module
├── Front/                        # Vue2 front-end
└── Blog-Admin/                   # Vue2 admin panel
```

#### Local Development

**Backend:**
```bash
cd Admin
mvn spring-boot:run
```

**Front-end:**
```bash
cd Front
npm install
npm run serve
```

**Admin Panel:**
```bash
cd Blog-Admin
npm install
npm run serve
```

#### Contribution

1. Fork the repository
2. Create `Feat_xxx` branch
3. Commit your code
4. Create Pull Request

## Demo
![](https://img.yangmufa.cn/blog-system/%E7%A7%BB%E5%8A%A8%E7%AB%AF_V1_%E6%96%87%E7%AB%A0%E8%AF%A6%E6%83%85.png)
![](https://img.yangmufa.cn/blog-system/PC_V1_Home.png)
![](https://img.yangmufa.cn/blog-system/PC_V1_%E6%96%87%E7%AB%A0%E8%AF%A6%E6%83%85.png)
