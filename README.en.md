 <div align="center">
  <img src="https://img.yangmufa.cn/blog-system/mint-logo.svg" width="160" />
  <h1>mint-blog-v1-java Has stopped updating</h1>
  <h1>Welcome to experience the V2 version of Mint.Blog based on.Net DDD</h1>
  <h2>author：<a href="https://www.yangmufa.cn/blog/surfer/author">程序员-杨工子</a></h2>
  <span>English | <a href="./README.md">中文</a></span>
</div>

#### Description
mint-blog-v1-java (formerly RocBlog / Kunpeng Blog) is a blog system built on the **Java Spring Boot + Vue3** tech stack with separated frontend and backend.  
This branch is no longer maintained. Please visit the [main](https://github.com/YangMufa/Mint.Blog) branch for the .NET DDD-based V2 version.

**Core Features:**

- 📝 Article Management: Markdown editing, categories/tags, pinning, wiki
- 🖼️ Image Management: MinIO object storage
- 💬 Comments System: Article comments, email notifications
- 🔐 Auth & Authorization: Spring Security + JWT
- 📊 Admin Dashboard: Page views, article stats
- 📱 Responsive Layout: Mobile / desktop adaptation

#### Tech Stack

| Layer | Technology                           |
|------|--------------------------------------|
| Backend Framework | Spring Boot 2.x                      |
| ORM | Spring Data JPA                      |
| Database | MySQL                                |
| Object Storage | MinIO                                |
| Auth | Spring Security + JWT                |
| API Docs | Knife4j (Swagger)                    |
| Frontend Framework | Vue 3 + Vue Router + Vuex            |
| UI Components | Element UI                           |
| Build Tool | Maven (backend) / Vue CLI (frontend) |

#### Project Structure

```
mint-blog-v1-java/
├── Admin/                        # Admin backend module
├── Surfer/                       # Blog frontend backend module
├── Common/                       # Shared common module
├── Jwt/                          # JWT authentication module
├── Search/                       # Site search module
├── Vue3/                         # Vue3 + Vite frontend (site and admin panel)
├── Docs/                         # Deployment docs and database scripts
└── pom.xml                       # Maven multi-module parent project
```

#### Local Development

**Backend:**
```bash
mvn clean install
mvn -pl Admin spring-boot:run
```

**Frontend:**
```bash
cd Vue3
pnpm install
pnpm dev
```

> If pnpm is not installed, you can also use npm according to the scripts in `Vue3/package.json`, for example `npm install` and `npm run dev`.

#### Contribution

1. Fork the repository
2. Create `Feat_xxx` branch
3. Commit your code
4. Create Pull Request

## Demo
![](https://img.yangmufa.cn/blog-system/%E7%A7%BB%E5%8A%A8%E7%AB%AF_V1_%E6%96%87%E7%AB%A0%E8%AF%A6%E6%83%85.png)
![](https://img.yangmufa.cn/blog-system/PC_V1_Home.png)
![](https://img.yangmufa.cn/blog-system/PC_V1_%E6%96%87%E7%AB%A0%E8%AF%A6%E6%83%85.png)
