/*
 Navicat Premium Dump SQL

 Source Server         : Local_Docker-YangMufa666
 Source Server Type    : PostgreSQL
 Source Server Version : 180003 (180003)
 Source Host           : 127.0.0.1:5432
 Source Catalog        : Mint.Blog.T
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180003 (180003)
 File Encoding         : 65001

 Date: 13/10/2026 10:50:04
*/


-- ----------------------------
-- Sequence structure for blog_article_category_rel_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_article_category_rel_id_seq";
CREATE SEQUENCE "public"."blog_article_category_rel_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_article_category_rel_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_article_content_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_article_content_id_seq";
CREATE SEQUENCE "public"."blog_article_content_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_article_content_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_article_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_article_id_seq";
CREATE SEQUENCE "public"."blog_article_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_article_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_article_tag_rel_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_article_tag_rel_id_seq";
CREATE SEQUENCE "public"."blog_article_tag_rel_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_article_tag_rel_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_category_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_category_id_seq";
CREATE SEQUENCE "public"."blog_category_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_category_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_comment_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_comment_id_seq";
CREATE SEQUENCE "public"."blog_comment_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_comment_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_friend_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_friend_id_seq";
CREATE SEQUENCE "public"."blog_friend_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_friend_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_gallery_category_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_gallery_category_id_seq";
CREATE SEQUENCE "public"."blog_gallery_category_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_gallery_category_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_gallery_image_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_gallery_image_id_seq";
CREATE SEQUENCE "public"."blog_gallery_image_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_gallery_image_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_settings_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_settings_id_seq";
CREATE SEQUENCE "public"."blog_settings_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_settings_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_statistics_article_pv_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_statistics_article_pv_id_seq";
CREATE SEQUENCE "public"."blog_statistics_article_pv_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_statistics_article_pv_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_tag_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_tag_id_seq";
CREATE SEQUENCE "public"."blog_tag_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_tag_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_wiki_catalog_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_wiki_catalog_id_seq";
CREATE SEQUENCE "public"."blog_wiki_catalog_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_wiki_catalog_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for blog_wiki_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_wiki_id_seq";
CREATE SEQUENCE "public"."blog_wiki_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_wiki_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for sys_admin_record_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_admin_record_id_seq";
CREATE SEQUENCE "public"."sys_admin_record_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."sys_admin_record_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for sys_admin_record_id_seq1
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_admin_record_id_seq1";
CREATE SEQUENCE "public"."sys_admin_record_id_seq1" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."sys_admin_record_id_seq1" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for sys_permission_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_permission_id_seq";
CREATE SEQUENCE "public"."sys_permission_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."sys_permission_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for sys_permission_id_seq1
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_permission_id_seq1";
CREATE SEQUENCE "public"."sys_permission_id_seq1" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."sys_permission_id_seq1" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for sys_role_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_role_id_seq";
CREATE SEQUENCE "public"."sys_role_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."sys_role_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for sys_role_id_seq1
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_role_id_seq1";
CREATE SEQUENCE "public"."sys_role_id_seq1" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."sys_role_id_seq1" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for sys_user_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_user_id_seq";
CREATE SEQUENCE "public"."sys_user_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."sys_user_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for sys_user_role_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_user_role_id_seq";
CREATE SEQUENCE "public"."sys_user_role_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."sys_user_role_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Table structure for blog_article
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_article";
CREATE TABLE "public"."blog_article" (
  "id" int8 NOT NULL DEFAULT nextval('blog_article_id_seq'::regclass),
  "title" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "cover" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "summary" varchar(160) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0,
  "read_num" int4 NOT NULL DEFAULT 1,
  "weight" int4 NOT NULL DEFAULT 0,
  "visibility" int2 NOT NULL DEFAULT 1
)
;
ALTER TABLE "public"."blog_article" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_article"."id" IS '文章id';
COMMENT ON COLUMN "public"."blog_article"."title" IS '文章标题';
COMMENT ON COLUMN "public"."blog_article"."cover" IS '文章封面';
COMMENT ON COLUMN "public"."blog_article"."summary" IS '文章摘要';
COMMENT ON COLUMN "public"."blog_article"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."blog_article"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."blog_article"."is_deleted" IS '删除标志位：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."blog_article"."read_num" IS '被阅读次数';
COMMENT ON COLUMN "public"."blog_article"."weight" IS '文章权重，用于是否置顶（0: 未置顶；>0: 参与置顶，权重值越高越靠前）';
COMMENT ON COLUMN "public"."blog_article"."visibility" IS '1 ：公开可见
2 ：仅专栏可见';
COMMENT ON TABLE "public"."blog_article" IS '文章表';

-- ----------------------------
-- Records of blog_article
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "visibility") VALUES (2056031402947907584, 'Mint.Blog部署到Rocky Linux 8.10服务器', 'https://img.yanggongzi.dev/article-cover-temp/%E5%A5%B3%E7%A5%9Esnh48%E5%AE%8B%E6%98%95%E5%86%894k%E9%AB%98%E6%B8%85%E7%BE%8E%E5%A5%B3%E5%A3%81%E7%BA%B8_%E5%BD%BC%E5%B2%B8%E5%9B%BE%E7%BD%91.jpg', 'Mint.Blog前后端部署到Rocky Linux 8.10服务器,包括Docker安装Nginx,数据库等', '2026-03-12 15:17:40.327355', '2026-08-01 17:24:03.30129', 0, 178, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for blog_article_category_rel
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_article_category_rel";
CREATE TABLE "public"."blog_article_category_rel" (
  "id" int8 NOT NULL DEFAULT nextval('blog_article_category_rel_id_seq'::regclass),
  "article_id" int8 NOT NULL,
  "category_id" int8 NOT NULL
)
;
ALTER TABLE "public"."blog_article_category_rel" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_article_category_rel"."id" IS 'id';
COMMENT ON COLUMN "public"."blog_article_category_rel"."article_id" IS '文章id';
COMMENT ON COLUMN "public"."blog_article_category_rel"."category_id" IS '分类id';
COMMENT ON TABLE "public"."blog_article_category_rel" IS '文章所属分类关联表';

-- ----------------------------
-- Records of blog_article_category_rel
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (2086382992976121856, 2056031402947907584, 2059454849011027968);
COMMIT;

-- ----------------------------
-- Table structure for blog_article_content
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_article_content";
CREATE TABLE "public"."blog_article_content" (
  "id" int8 NOT NULL DEFAULT nextval('blog_article_content_id_seq'::regclass),
  "article_id" int8 NOT NULL,
  "content" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."blog_article_content" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_article_content"."id" IS '文章内容id';
COMMENT ON COLUMN "public"."blog_article_content"."article_id" IS '文章id';
COMMENT ON COLUMN "public"."blog_article_content"."content" IS '教程正文';
COMMENT ON TABLE "public"."blog_article_content" IS '文章内容表';

-- ----------------------------
-- Records of blog_article_content
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2056031402964684800, 2056031402947907584, '# Mint.Blog Rocky Linux 8.10 部署步骤

按此顺序部署：`.NET 10` -> Docker -> Nginx -> RustFS -> PostgreSQL -> 后端 -> 前端 -> systemd -> Nginx 代理 -> 验证。

## 前提

1.申请域名  

2.服务器安全组开放 80 和 443 端口  

3.约定路径：

```text
后端：/opt/mint-blog
前端：/opt/docker/nginx/html/blog
Nginx：/opt/docker/nginx
RustFS：/opt/docker/datas/RustFS
PostgreSQL：/opt/docker/datas/postgresql
后端端口：8000
RustFS：9000
RustFS后台UI：9001
PostgreSQL：5432
数据库：Mint.Blog
默认对象存储桶：blog-article
```

## 1. 安装 .NET 10 运行环境

```bash
sudo rpm -Uvh https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
sudo dnf clean all && sudo dnf makecache
sudo dnf install -y aspnetcore-runtime-10.0
dotnet --info
```

只运行后端装 runtime 即可；如需服务器编译，再装：

```bash
sudo dnf install -y dotnet-sdk-10.0
```

## 2. 安装 Docker

```bash
sudo dnf install -y yum-utils device-mapper-persistent-data lvm2
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker --now
docker --version
docker compose version
```

常用命令：

```bash
docker ps
docker logs -f 容器名
docker restart 容器名
docker rm -f 容器名
```

## 3. Docker 安装 Nginx 并挂载

```bash
sudo mkdir -p /opt/docker/nginx/{conf.d,cert,logs}
sudo mkdir -p /opt/docker/nginx/html/blog
```

路径映射：

```text
/opt/docker/nginx/nginx.conf -> /etc/nginx/nginx.conf
/opt/docker/nginx/conf.d     -> /etc/nginx/conf.d
/opt/docker/nginx/html       -> /usr/share/nginx/html
/opt/docker/nginx/cert       -> /etc/nginx/cert
/opt/docker/nginx/logs       -> /var/log/nginx
```

创建 `/opt/docker/nginx/nginx.conf`：

```nginx
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log warn;
pid /var/run/nginx.pid;
events { worker_connections 1024; }
http {
  include /etc/nginx/mime.types;
  default_type application/octet-stream;
  access_log /var/log/nginx/access.log;
  sendfile on;
  keepalive_timeout 65;
  client_max_body_size 100m;
  gzip on;
  include /etc/nginx/conf.d/*.conf;
}
```

创建 `/opt/docker/nginx/conf.d/default.conf`，这是 Docker Nginx 启动时的临时默认站点配置文件：

```nginx
server {
  listen 80 default_server;
  server_name _;
  location / { return 200 ''nginx is running''; }
}
```

启动：

```bash
docker run -d --name nginx --restart always \
  --add-host=host.docker.internal:host-gateway \
  -p 80:80 -p 443:443 \
  -v /opt/docker/nginx/nginx.conf:/etc/nginx/nginx.conf \
  -v /opt/docker/nginx/conf.d:/etc/nginx/conf.d \
  -v /opt/docker/nginx/html:/usr/share/nginx/html \
  -v /opt/docker/nginx/cert:/etc/nginx/cert \
  -v /opt/docker/nginx/logs:/var/log/nginx \
  nginx:stable
```

检查/重载：

```bash
docker exec nginx nginx -t
docker exec nginx nginx -s reload
```

## 4. Docker 安装 RustFS，创建桶并公开

```bash
sudo mkdir -p /opt/docker/datas/RustFS/{data,logs}
sudo chmod -R 777 /opt/docker/datas/RustFS
```

启动 RustFS，生产环境请替换强密码：

```bash
docker run -d \
  --name RustFS \
  --restart unless-stopped \
  -p 9000:9000 \
  -p 9001:9001 \
  -v /opt/docker/datas/RustFS/data:/data \
  -v /opt/docker/datas/RustFS/logs:/logs \
  -e RUSTFS_ACCESS_KEY=账号 \
  -e RUSTFS_SECRET_KEY=密码 \
  rustfs/rustfs:latest
```

> Rocky Linux 如果启用了 SELinux，且容器日志出现 `Permission denied (os error 13)`，可以将挂载参数改为 `-v /opt/docker/datas/RustFS/data:/data:Z` 和 `-v /opt/docker/datas/RustFS/logs:/logs:Z` 后重建容器。

RustFS 使用 S3 兼容协议，可用 Docker 版 `mc` 创建桶并设置公开读取。先创建 `mc` 配置目录并设置临时别名：

```bash
sudo mkdir -p /opt/docker/datas/mc
alias dmc=''docker run --rm -it --add-host=host.docker.internal:host-gateway -v /opt/docker/datas/mc:/root/.mc minio/mc''
```

配置 RustFS 连接：

```bash
dmc alias set rustfs http://host.docker.internal:9000 账号 密码
```

创建默认桶 `blog-article` 并设置公开下载：

```bash
dmc mb --ignore-existing rustfs/blog-article
dmc anonymous set download rustfs/blog-article
```

验证：

```bash
dmc ls rustfs
curl -I http://127.0.0.1:9000/blog-article/图片对象名
```

图片公开访问示例：`http://服务器IP:9000/blog-article/图片对象名`。

## 5. Docker 安装 PostgreSQL 18 并恢复数据

```bash
sudo mkdir -p /opt/docker/datas/postgresql/{data,backup}
sudo chown -R 999:999 /opt/docker/datas/postgresql/data
```

启动 PostgreSQL 18：

```bash
docker run -d --name postgresql18 --restart always \
  -p 5432:5432 \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=密码 \
  -e POSTGRES_DB=Mint.Blog \
  -v /opt/docker/datas/postgresql/data:/var/lib/postgresql/data \
  -v /opt/docker/datas/postgresql/backup:/backup \
  postgres:18
```

重建数据库：

```bash
docker exec -it postgresql18 psql -U postgres -d postgres -c "DROP DATABASE IF EXISTS \"Mint.Blog\";"
docker exec -it postgresql18 psql -U postgres -d postgres -c "CREATE DATABASE \"Mint.Blog\" OWNER postgres;"
docker exec -i postgresql18 psql -U postgres -d Mint.Blog < "/opt/docker/datas/postgresql/backup/Mint.Blog-数据库-结构+数据.sql"
```

验证：

```bash
docker exec -it postgresql18 psql -U postgres -d Mint.Blog -c "\dt"
```

上传数据库脚本：

```bash
scp "docs/Mint.Blog-数据库-结构+数据.sql" root@服务器IP:/opt/docker/datas/postgresql/backup/
```

恢复数据：

```bash
docker exec -i postgresql18 psql -U postgres -d Mint.Blog < "/opt/docker/datas/postgresql/backup/Mint.Blog-数据库-结构+数据.sql"
```

## 6. 打包 WebApi

本地执行：

```bash

# 本地打包（默认当前平台）
dotnet publish Mint.Blog.WebApi/Mint.Blog.WebApi.csproj -c Release

# 明确指定目标平台（推荐，确保兼容性）
dotnet publish Mint.Blog.WebApi/Mint.Blog.WebApi.csproj -c Release -r linux-x64

```

## 7. 创建 /opt/mint-blog，上传后端文件，设置生产配置

服务器：

```bash
sudo mkdir -p /opt/mint-blog
```

本地上传：  
上传本地`Mint.Blog.WebApi/bin/Release/net10.0/publish`目录里面的内容到服务器`/opt/mint-blog`文件夹。

> **配置说明**：`dotnet publish` 发布后的文件只有 `appsettings.json`，不包含 `appsettings.Development.json`。生产环境配置直接写在 `appsettings.json` 中。本地开发时由 `appsettings.Development.json` 覆盖，互不干扰。

编辑 `/opt/mint-blog/appsettings.json`：

```json
{
  "PostgreSql": {
    "ConnectionString": "Host=127.0.0.1;Port=5432;Database=Mint.Blog;Username=postgres;Password=CHANGE_ME_DB_PASSWORD"
  },
  "RustFS": {
    "Endpoint": "http://127.0.0.1:9000",
    "UseSsl": false,
    "PublicEndpoint": "https://img.example.com",
    "AccessKey": "账号",
    "SecretKey": "密码",
    "BucketName": "blog-article"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Warning",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "Jwt": {
    "Issuer": "Mint.Blog",
    "Audience": "Mint.Blog",
    "SecurityKey": "请替换为至少32位以上的生产密钥",
    "AccessTokenExpireMinutes": 120
  },
  "Smtp": {
    "Host": "smtp.qq.com",
    "Port": 465,
    "UserName": "你的邮箱@qq.com",
    "Password": "QQ邮箱授权码",
    "From": "你的邮箱@qq.com",
    "EnableSsl": true
  },
  "CommentNotification": {
    "Domain": "https://www.example.com/#"
  },
  "AllowedHosts": "*"
}
```

> **RustFS 配置说明**：
> - `Endpoint`：后端直连 RustFS 的地址。WebApi 运行在宿主机时可填 `http://127.0.0.1:9000`；如果 WebApi 也容器化并与 RustFS 同属 Docker 网络，可填容器名或内网地址
> - `UseSsl`：`Endpoint` 用 HTTPS 时设为 `true`，内网 HTTP 为 `false`
> - `PublicEndpoint`：浏览器访问图片的公网地址，如 `https://img.example.com`。最终图片 URL = `PublicEndpoint` + 桶名 + 文件名

前台测试：

```bash
cd /opt/mint-blog
ASPNETCORE_ENVIRONMENT=Production ASPNETCORE_URLS=http://0.0.0.0:8000 dotnet Mint.Blog.WebApi.dll
```

停止按 `Ctrl + C`。

## 8. 设置前端 API 请求路径并打包

配置 `Mint.Blog.Vue/.env.production`。

同域名反代：

```env
VITE_BASE_URL=/
VITE_APP_TITLE=Mint.Blog
VITE_SERVICE_BASE_URL=http://服务器IP或域名:8000/api/
```

打包：

```bash
cd Mint.Blog.Vue
pnpm install
pnpm build:prod
```

修改 `.env.production` 后必须重新打包。

## 9. 创建 /opt/docker/nginx/html/blog 上传前端文件

服务器：

```bash
sudo mkdir -p /opt/docker/nginx/html/blog
```

本地上传：

```bash
rsync -avz Mint.Blog.Vue/dist/ root@服务器IP:/opt/docker/nginx/html/blog/
```

Nginx 容器内路径：`/usr/share/nginx/html/blog`。

## 10. 后台运行后端项目、停止和重启

创建 `/etc/systemd/system/mint-blog-api.service`：

```shell
sudo vim /etc/systemd/system/mint-blog-api.service
```

```ini
[Unit]
Description=Mint Blog WebApi
After=network.target

[Service]
WorkingDirectory=/opt/mint-blog
ExecStart=/usr/bin/dotnet /opt/mint-blog/Mint.Blog.WebApi.dll
Restart=always
RestartSec=5
KillSignal=SIGINT
SyslogIdentifier=mint-blog-api
User=root
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=ASPNETCORE_URLS=http://0.0.0.0:8000

[Install]
WantedBy=multi-user.target
```

启动：

```bash
sudo systemctl daemon-reload          # 重新加载 systemd 配置（新建/修改 service 文件后必须执行）
sudo systemctl enable mint-blog-api   # 设置开机自启
sudo systemctl start mint-blog-api    # 立即启动服务
sudo systemctl status mint-blog-api   # 查看服务运行状态
```

常用命令：

```bash
sudo systemctl start mint-blog-api    # 启动
sudo systemctl stop mint-blog-api     # 停止
sudo systemctl restart mint-blog-api  # 重启
sudo journalctl -u mint-blog-api -f   # 实时查看日志(按 Ctrl + C 即可退出)
```

> **修改配置后**：编辑 `/opt/mint-blog/appsettings.json`，执行 `sudo systemctl restart mint-blog-api` 即可生效。

误用前台运行时停止 8000：

```bash
sudo fuser -k 8000/tcp
```

## 11. 配置 Nginx 转发代理监听域名

本节所有配置文件都放在宿主机目录：

```text
/opt/docker/nginx/conf.d
```

Nginx 主配置文件完整路径是：

```text
/opt/docker/nginx/nginx.conf
```

Docker Nginx 容器内会把 `/opt/docker/nginx/conf.d` 挂载为 `/etc/nginx/conf.d`，所以站点配置文件会被 `nginx.conf` 中的 `include /etc/nginx/conf.d/*.conf;` 自动加载。

### 11.1 关键配置：Docker 容器访问宿主机后端

Docker 容器内的 Nginx 访问宿主机后端时，**不能使用 `127.0.0.1`**（指向容器自身），需要用宿主机在 Docker 桥接网络中的网关 IP。

```bash
# 查看 Docker bridge 网关 IP
ip addr show docker0 | grep inet
# 输出示例: inet 172.17.0.1/16
```

然后 Nginx 配置中使用该 IP：

```nginx
proxy_pass http://172.17.0.1:8000;
```

### 11.2 HTTPS 多域名重定向 + 前后端同域

编辑 Nginx 配置文件完整路径：

```bash
sudo vim /opt/docker/nginx/conf.d/blog-https.conf
```

证书放到：

```text
/opt/docker/nginx/cert/fullchain.example.com.pem
/opt/docker/nginx/cert/private.example.com.key
```

> 证书路径在 Nginx 容器内是 `/etc/nginx/cert/...`，对应宿主机 `/opt/docker/nginx/cert/...`。

如果之前保留了 `/opt/docker/nginx/conf.d/default.conf`，正式配置完成后建议删除或改名，避免默认站点干扰：

```bash
sudo rm -f /opt/docker/nginx/conf.d/default.conf
```

**完整 Nginx 配置（多域名 → www.example.com）：**

```nginx
# HTTP：将所有域名重定向到 HTTPS
server {
    listen 80;
    listen [::]:80;
    server_name example.com www.example.com rocblog.example.com blog.example.com;
    return 301 https://www.example.com$request_uri;
}
```
**HTTPS：非 www 域名重定向到 www**
```nginx
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;
    server_name example.com rocblog.example.com blog.example.com;

    ssl_certificate /etc/nginx/cert/fullchain.example.com.pem;
    ssl_certificate_key /etc/nginx/cert/private.example.com.key;

    return 301 https://www.example.com$request_uri;
}
```

**HTTPS：主站点（www.example.com）**
```nginx
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;
    server_name www.example.com;
    client_max_body_size 50M;

    ssl_certificate /etc/nginx/cert/fullchain.example.com.pem;
    ssl_certificate_key /etc/nginx/cert/private.example.com.key;
    ssl_session_timeout 500m;
    ssl_ciphers ''ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!aNULL:!MD5:!ADH:!RC4:!NULL'';
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;

    # 前端静态文件
    location / {
        try_files $uri $uri/ @router;
        root /usr/share/nginx/html/blog_v2/;
        index index.html index.htm;
    }

    # Vue Router History 模式回退
    location @router {
        rewrite ^.*$ /index.html last;
    }

    # 后端 API 反向代理
    # 注意：proxy_pass 末尾无 /，保留 /api/ 前缀原样转发
    # 因为后端 Controller 使用 [Route("api/...")] 路由
    location /api/ {
        proxy_pass http://172.17.0.1:8000;          # ← 无末尾斜杠，保留 /api/ 前缀
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;

        proxy_connect_timeout 600s;
        proxy_read_timeout 600s;
        proxy_send_timeout 600s;
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html/blog_v2;
    }
}
```

**proxy_pass 末尾斜杠规则：**

> 有 `/` 会替换掉 location 前缀，无 `/` 保留完整路径。

> location /api/ { proxy_pass http://host:8000;   }   → /api/system/auth/login → /api/system/auth/login ✅

> location /api/ { proxy_pass http://host:8000/;  }   → /api/system/auth/login → /system/auth/login   ❌

> 后端 Controller 路由为 `[Route("api/system/auth")]`，必须保留 `/api/` 前缀，所以用无斜杠版本。

### 11.3 验证和重启 Nginx

```bash
# 检查 Nginx 配置语法
docker exec Nginx127 nginx -t

# 重启 Nginx 使其生效
docker restart Nginx127
```

### 11.4 Docker 容器无法访问宿主机端口的排查

如果浏览器访问 API 返回 404 或连接超时，按以下顺序排查：

**1. 确认宿主机后端正常运行：**

```bash
curl http://127.0.0.1:8000/api/system/auth/login
# 应返回 JSON（非空），表示后端正常
```

**2. 查看 Docker bridge 网关 IP：**

```bash
ip addr show docker0 | grep inet
# 输出: inet 172.17.0.1/16
```

**3. 从容器内测试能否访问宿主机：**

```bash
docker exec Nginx127 curl -s -o /dev/null -w "%{http_code}" http://172.17.0.1:8000/api/system/auth/login
# 应返回 405（Method Not Allowed，因为 login 是 POST），表示网络已通
```

**4. 如果容器 curl 卡住无响应：** 可能是 CentOS/Rocky 的 bridge-netfilter 内核参数在拦截：

```bash
# 临时关闭 bridge iptables 过滤
echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables

# 再次测试容器内访问
docker exec Nginx127 curl -s -o /dev/null -w "%{http_code}" http://172.17.0.1:8000/api/system/auth/login

# 确认可用后永久生效
echo "net.bridge.bridge-nf-call-iptables = 0" >> /etc/sysctl.d/99-docker-bridge.conf
sysctl -p /etc/sysctl.d/99-docker-bridge.conf
```

### 11.5 RustFS 图片域名代理

编辑 RustFS 图片访问域名配置文件完整路径：

```bash
sudo vim /opt/docker/nginx/conf.d/rustfs-https.conf
```

如果后端 `RustFS:PublicEndpoint` 为 `https://image.example.com`，Nginx 将该域名反向代理到 RustFS 的 `9000` 端口：

```nginx
server {
  listen 443 ssl;
  listen [::]:443 ssl;
  http2 on;
  server_name image.example.com;
  ssl_certificate /etc/nginx/cert/image.example.com/fullchain.pem;
  ssl_certificate_key /etc/nginx/cert/image.example.com/privkey.pem;
  client_max_body_size 100m;
  location / {
    proxy_pass http://host.docker.internal:9000;
    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto https;
  }
}
```

检查并重载。每次修改 `/opt/docker/nginx/nginx.conf` 或 `/opt/docker/nginx/conf.d/*.conf` 后，都需要先检查再重载：

```bash
docker exec nginx nginx -t
docker exec nginx nginx -s reload
```

防火墙建议只开放 80/443：

```bash
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```

## 12. 验证

```bash
docker ps
sudo systemctl status mint-blog-api
curl http://127.0.0.1:8000/health
docker exec nginx nginx -t
```

验证数据库：

```bash
docker exec -it postgresql18 psql -U postgres -d Mint.Blog -c "\dt"
```

验证访问：

```text
http://www.example.com
https://www.example.com
http://www.example.com/api/health
https://api.example.com/health
http://服务器IP:9000/blog-article/图片对象名
https://image.example.com/blog-article/图片对象名
```

常见问题：

- 后端失败：`sudo journalctl -u mint-blog-api -f`
- Nginx 502：确认 `curl http://127.0.0.1:8000/health` 正常
- 前端接口地址错：改 `.env.production` 后重新 `pnpm build:prod` 并重新上传
- 图片无法访问：确认 RustFS 桶 `blog-article` 已设置匿名下载，且 `RustFS:PublicEndpoint` 浏览器可访问');
COMMIT;

-- ----------------------------
-- Table structure for blog_article_draft
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_article_draft";
CREATE TABLE "public"."blog_article_draft" (
  "id" int8 NOT NULL,
  "article_id" int8,
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "summary" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "cover" text COLLATE "pg_catalog"."default" NOT NULL,
  "category_id" int8,
  "create_time" timestamp(6) NOT NULL,
  "update_time" timestamp(6) NOT NULL,
  "visibility" int2 NOT NULL DEFAULT '1'::smallint
)
;
ALTER TABLE "public"."blog_article_draft" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_article_draft"."visibility" IS '1 ：公开可见
2 ：仅专栏可见';

-- ----------------------------
-- Records of blog_article_draft
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for blog_article_draft_content
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_article_draft_content";
CREATE TABLE "public"."blog_article_draft_content" (
  "id" int8 NOT NULL,
  "draft_id" int8 NOT NULL,
  "content" text COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."blog_article_draft_content" OWNER TO "postgres";

-- ----------------------------
-- Records of blog_article_draft_content
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for blog_article_draft_tag
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_article_draft_tag";
CREATE TABLE "public"."blog_article_draft_tag" (
  "id" int8 NOT NULL,
  "draft_id" int8 NOT NULL,
  "tag_id" int8 NOT NULL
)
;
ALTER TABLE "public"."blog_article_draft_tag" OWNER TO "postgres";

-- ----------------------------
-- Records of blog_article_draft_tag
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for blog_article_tag_rel
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_article_tag_rel";
CREATE TABLE "public"."blog_article_tag_rel" (
  "id" int8 NOT NULL DEFAULT nextval('blog_article_tag_rel_id_seq'::regclass),
  "article_id" int8 NOT NULL,
  "tag_id" int8 NOT NULL
)
;
ALTER TABLE "public"."blog_article_tag_rel" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_article_tag_rel"."id" IS 'id';
COMMENT ON COLUMN "public"."blog_article_tag_rel"."article_id" IS '文章id';
COMMENT ON COLUMN "public"."blog_article_tag_rel"."tag_id" IS '标签id';
COMMENT ON TABLE "public"."blog_article_tag_rel" IS '文章对应标签关联表';

-- ----------------------------
-- Records of blog_article_tag_rel
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (383, 2056031402947907584, 2060923875604172801);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (384, 2056031402947907584, 2060913466704793601);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (385, 2056031402947907584, 2060923875612561409);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (386, 2056031402947907584, 2060907705270407168);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (387, 2056031402947907584, 2068309963293462528);
COMMIT;

-- ----------------------------
-- Table structure for blog_category
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_category";
CREATE TABLE "public"."blog_category" (
  "id" int8 NOT NULL DEFAULT nextval('blog_category_id_seq'::regclass),
  "name" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0,
  "articles_total" int4 NOT NULL DEFAULT 0,
  "sort" int8
)
;
ALTER TABLE "public"."blog_category" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_category"."id" IS '分类id';
COMMENT ON COLUMN "public"."blog_category"."name" IS '分类名称';
COMMENT ON COLUMN "public"."blog_category"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."blog_category"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."blog_category"."is_deleted" IS '逻辑删除标志位：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."blog_category"."articles_total" IS '此分类下文章总数';
COMMENT ON COLUMN "public"."blog_category"."sort" IS '排序';
COMMENT ON TABLE "public"."blog_category" IS '文章分类表';

-- ----------------------------
-- Records of blog_category
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059454849011027968, 'Mint.Blog', '2026-05-27 02:01:13.482286', '2026-05-27 02:01:13.482286', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838377930067968, 'Algorithms', '2026-10-13 02:47:22.846351', '2026-10-13 02:47:22.846351', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838425866768384, 'Architecture', '2026-10-13 02:47:34.286127', '2026-10-13 02:47:34.286127', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838457894473728, 'Browser', '2026-10-13 02:47:41.922889', '2026-10-13 02:47:41.922889', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838494888235008, 'C#.Net', '2026-10-13 02:47:50.742299', '2026-10-13 02:47:50.742299', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838526987243520, 'Databases', '2026-10-13 02:47:58.395275', '2026-10-13 02:47:58.395275', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838566002659328, 'Desktop', '2026-10-13 02:48:07.696955', '2026-10-13 02:48:07.696955', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838602233057280, 'DevOps', '2026-10-13 02:48:16.335839', '2026-10-13 02:48:16.335839', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838650698240000, 'DevTools', '2026-10-13 02:48:27.89066', '2026-10-13 02:48:27.89066', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838684609187840, 'Learning', '2026-10-13 02:48:35.974998', '2026-10-13 02:48:35.974998', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838723070955520, 'Middleware', '2026-10-13 02:48:45.144992', '2026-10-13 02:48:45.144992', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838762946203648, 'NetBeans', '2026-10-13 02:48:54.652681', '2026-10-13 02:48:54.652681', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838806650851328, 'OpenLibrary', '2026-10-13 02:49:05.0725', '2026-10-13 02:49:05.0725', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838850502299648, 'ProblemRecord', '2026-10-13 02:49:15.527749', '2026-10-13 02:49:15.527749', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2109838882488061952, 'Safety', '2026-10-13 02:49:23.153577', '2026-10-13 02:49:23.153577', 0, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for blog_column
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_column";
CREATE TABLE "public"."blog_column" (
  "id" int8 NOT NULL DEFAULT nextval('blog_wiki_id_seq'::regclass),
  "title" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "cover" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "summary" varchar(160) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0,
  "weight" int4 NOT NULL DEFAULT 0,
  "is_publish" int2 NOT NULL DEFAULT 1,
  "sort" int8
)
;
ALTER TABLE "public"."blog_column" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_column"."id" IS 'id';
COMMENT ON COLUMN "public"."blog_column"."title" IS '标题';
COMMENT ON COLUMN "public"."blog_column"."cover" IS '封面';
COMMENT ON COLUMN "public"."blog_column"."summary" IS '摘要';
COMMENT ON COLUMN "public"."blog_column"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."blog_column"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."blog_column"."is_deleted" IS '删除标志位：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."blog_column"."weight" IS '权重，用于是否置顶（0: 未置顶；>0: 参与置顶，权重值越高越靠前）';
COMMENT ON COLUMN "public"."blog_column"."is_publish" IS '是否发布：0：未发布 1：已发布';
COMMENT ON COLUMN "public"."blog_column"."sort" IS '排序';
COMMENT ON TABLE "public"."blog_column" IS '知识库表';

-- ----------------------------
-- Records of blog_column
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (2095086327090515968, 'Mint.Blog开发部署文档', 'https://img.yanggongzi.dev/blog-system/mint-logo.svg', '开发文档', '2024-11-19 08:53:28', '2026-09-02 09:49:58.083063', 0, 7, 1, 11);
COMMIT;

-- ----------------------------
-- Table structure for blog_column_catalog
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_column_catalog";
CREATE TABLE "public"."blog_column_catalog" (
  "id" int8 NOT NULL DEFAULT nextval('blog_wiki_catalog_id_seq'::regclass),
  "column_id" int8 NOT NULL,
  "article_id" int8,
  "title" text COLLATE "pg_catalog"."default" NOT NULL,
  "level" int2 NOT NULL DEFAULT 1,
  "parent_id" int8,
  "sort" int2 NOT NULL DEFAULT 1,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0
)
;
ALTER TABLE "public"."blog_column_catalog" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_column_catalog"."id" IS 'id';
COMMENT ON COLUMN "public"."blog_column_catalog"."column_id" IS '知识库id';
COMMENT ON COLUMN "public"."blog_column_catalog"."article_id" IS '文章id';
COMMENT ON COLUMN "public"."blog_column_catalog"."title" IS '标题';
COMMENT ON COLUMN "public"."blog_column_catalog"."level" IS '目录层级';
COMMENT ON COLUMN "public"."blog_column_catalog"."parent_id" IS '父目录id';
COMMENT ON COLUMN "public"."blog_column_catalog"."sort" IS '排序';
COMMENT ON COLUMN "public"."blog_column_catalog"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."blog_column_catalog"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."blog_column_catalog"."is_deleted" IS '删除标志位：0：未删除 1：已删除';
COMMENT ON TABLE "public"."blog_column_catalog" IS '知识库目录表';

-- ----------------------------
-- Records of blog_column_catalog
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (1, 2095086327090515968, NULL, '部署', 1, 0, 1, '2026-05-29 01:55:04.986448', '2026-05-29 01:55:04.986448', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (2, 2095086327090515968, 2056031402947907584, 'Mint.Blog部署到Rocky Linux 8.10服务器', 2, 59, 1, '2026-05-29 01:55:04.987278', '2026-05-29 01:55:04.987278', 0);
COMMIT;

-- ----------------------------
-- Table structure for blog_comment
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_comment";
CREATE TABLE "public"."blog_comment" (
  "id" int8 NOT NULL DEFAULT nextval('blog_comment_id_seq'::regclass),
  "content" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "avatar" varchar(160) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "nickname" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "mail" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "website" varchar(60) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "router_url" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0,
  "reply_comment_id" int8,
  "parent_comment_id" int8,
  "reason" varchar(300) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" int2 NOT NULL DEFAULT 1
)
;
ALTER TABLE "public"."blog_comment" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_comment"."id" IS 'id';
COMMENT ON COLUMN "public"."blog_comment"."content" IS '评论内容';
COMMENT ON COLUMN "public"."blog_comment"."avatar" IS '头像';
COMMENT ON COLUMN "public"."blog_comment"."nickname" IS '昵称';
COMMENT ON COLUMN "public"."blog_comment"."mail" IS '邮箱';
COMMENT ON COLUMN "public"."blog_comment"."website" IS '网站地址';
COMMENT ON COLUMN "public"."blog_comment"."router_url" IS '评论所属的路由';
COMMENT ON COLUMN "public"."blog_comment"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."blog_comment"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."blog_comment"."is_deleted" IS '删除标志位：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."blog_comment"."reply_comment_id" IS '回复的评论 ID';
COMMENT ON COLUMN "public"."blog_comment"."parent_comment_id" IS '父评论 ID';
COMMENT ON COLUMN "public"."blog_comment"."reason" IS '原因描述';
COMMENT ON COLUMN "public"."blog_comment"."status" IS '1: 待审核；2：正常；3：审核未通过;';
COMMENT ON TABLE "public"."blog_comment" IS '评论表';

-- ----------------------------
-- Records of blog_comment
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (8, '我问问', NULL, '', '', NULL, '', '2025-09-14 15:54:50.972091', '2025-09-14 15:54:50.972091', 0, NULL, NULL, '', 1);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (9, '呜呜呜呜', NULL, '', '', NULL, '', '2025-09-14 15:54:55.225906', '2025-09-14 15:54:55.225906', 0, NULL, NULL, '', 1);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (11, '呜呜呜呜呜呜', NULL, '', '', NULL, '', '2025-09-14 15:55:01.317563', '2025-09-14 15:55:01.317563', 0, NULL, NULL, '', 1);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (13, '呜呜呜呜呜呜呜', NULL, '', '', NULL, '', '2025-09-14 15:55:07.928365', '2025-09-14 15:55:07.928365', 0, NULL, NULL, '', 1);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (7, '放大发的发对对对大发', '', '我问问三四十岁', 'ya三十岁gnmufa@qq.com', '我对对对问问', '/surfer/article/1', '2025-09-14 23:54:16.525481', '2025-10-06 15:26:55.102678', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (17, '😂', '', '快乐小狗', '123@qq.com', '', '/surfer/wiki/3', '2026-04-29 23:14:00.233568', '2026-04-29 23:14:00.233707', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (18, '时间打开方式', '', '痛苦小狗', '123@qq.com', '', '/surfer/wiki/3', '2026-04-29 23:14:22.513093', '2026-04-29 23:14:22.514797', 0, 17, 17, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (19, '试试顶顶顶顶', '', '忧郁小狗', '123@qq.com', '', '/surfer/wiki/3', '2026-04-29 23:14:34.770037', '2026-04-29 23:14:34.770458', 0, 18, 17, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (20, '你说说你', '', '忧郁小狗', '123@qq.com', '', '/surfer/articles/8', '2026-04-29 23:15:03.561187', '2026-04-29 23:15:03.562158', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (21, '上帝视角可抵扣', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/8', '2026-04-29 23:15:27.588651', '2026-04-29 23:15:27.588723', 0, 20, 20, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (22, '上帝视角可抵扣', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/8', '2026-04-29 23:15:32.186479', '2026-04-29 23:15:32.187475', 0, 20, 20, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (23, '😃🙄🤩🙄🤭', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/8', '2026-04-29 23:35:05.827832', '2026-04-29 23:35:05.827574', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (24, '😘u😏uu', '', '忧郁大狗', '123@qq.com', '', '/surfer/wiki/3', '2026-04-29 23:35:23.359664', '2026-04-29 23:35:23.359611', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (10, '吾问无为谓', NULL, '', '', NULL, '', '2025-09-14 15:54:58.612195', '2025-09-14 15:54:58.612195', 1, NULL, NULL, '', 1);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2049542703598931968, '试试水', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/10', '2026-04-29 17:33:53.847692', '2026-04-29 17:33:53.847692', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2049542732141170688, '多少多少', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/10', '2026-04-29 17:34:00.661583', '2026-04-29 17:34:00.661583', 0, 2049542703598932000, 2049542703598932000, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2049542786654539776, '顶顶顶顶', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/10', '2026-04-29 17:34:13.658662', '2026-04-29 17:34:13.658662', 0, 2049542703598932000, 2049542703598932000, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2049542953378123776, '顶顶顶顶', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/10', '2026-04-29 17:34:53.408738', '2026-04-29 17:34:53.408738', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2049543712240963584, '试试水', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/10', '2026-04-29 17:37:54.32871', '2026-04-29 17:37:54.32871', 0, 2049542953378123776, 2049542953378123776, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2049867309782274048, '哈哈哈', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/19', '2026-04-30 15:03:45.982564', '2026-04-30 15:03:45.982564', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2049867354892013568, ';了;;', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/19', '2026-04-30 15:03:56.756714', '2026-04-30 15:03:56.756714', 0, 2049867309782274048, 2049867309782274048, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2051358351064961024, '阶段7自动化评论验证 1777916917', '', '阶段7测试用户', 'phase7-1777916917@example.com', 'https://example.com', '/surfer/articles/8', '2026-05-04 17:48:37.940402', '2026-05-04 17:48:37.940402', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2, '三十岁', '', '我问问', 'yanggongzi@163.com', '我问问', '/surfer/wiki/3', '2025-08-31 19:57:45', '2025-08-31 11:57:44', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (3, '三十岁1', '', '我问问', 'yanggongzi@163.com', '我问问', '/surfer/wiki/3', '2025-08-31 19:57:52', '2025-08-31 11:57:52', 0, 2, 2, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (5, '放大发的', '', '我问问', 'yanggongzi@163.com', '我问问', '/surfer/article/1', '2025-09-14 23:53:59.692747', '2025-09-14 23:53:59.697841', 0, NULL, NULL, '系统自动拦截，包含敏感词：[的]', 3);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (6, '放大发的发大发', '', '我问问', 'yanggongzi@163.com', '我问问', '/surfer/article/1', '2025-09-14 23:54:05.372051', '2025-09-14 23:54:05.374887', 0, NULL, NULL, '系统自动拦截，包含敏感词：[的]', 3);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (15, '对对对对对', '', '你猜', 'yanggongzi@163.com', '你猜', '/surfer/articles/28', '2026-04-26 19:04:26.997428', '2026-04-26 19:04:26.998016', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (16, '😱👌😂😃😱😭😵', '', '你猜', 'yanggongzi@163.com', '你猜', '/surfer/articles/28', '2026-04-26 19:05:15.569971', '2026-04-26 19:05:15.570115', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2088809334233501696, '你很棒👍', '', '中华小子', 'yangtiezhu@163.com', '', '/blog/surfer/article/2056031402947907584', '2026-08-16 02:05:28.136857', '2026-08-16 02:05:28.136857', 0, NULL, NULL, '', 2);
COMMIT;

-- ----------------------------
-- Table structure for blog_friend
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_friend";
CREATE TABLE "public"."blog_friend" (
  "id" int4 NOT NULL DEFAULT nextval('blog_friend_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default",
  "description" text COLLATE "pg_catalog"."default",
  "url" varchar(500) COLLATE "pg_catalog"."default",
  "avatar" varchar(500) COLLATE "pg_catalog"."default",
  "status" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'pending'::character varying,
  "create_time" timestamp(0) DEFAULT CURRENT_TIMESTAMP,
  "category" varchar(50) COLLATE "pg_catalog"."default" DEFAULT 'personal'::character varying,
  "is_top" bool DEFAULT false,
  "email" varchar(100) COLLATE "pg_catalog"."default",
  "sort" int4 DEFAULT 0,
  "is_deleted" int2 DEFAULT 0,
  "update_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "public"."blog_friend" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_friend"."id" IS '友链ID，主键自增';
COMMENT ON COLUMN "public"."blog_friend"."name" IS '友链名称';
COMMENT ON COLUMN "public"."blog_friend"."description" IS '友链描述';
COMMENT ON COLUMN "public"."blog_friend"."url" IS '友链地址';
COMMENT ON COLUMN "public"."blog_friend"."avatar" IS '友链头像URL';
COMMENT ON COLUMN "public"."blog_friend"."status" IS '友链状态：active-正常，inactive-停用，pending-待审核';
COMMENT ON COLUMN "public"."blog_friend"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."blog_friend"."category" IS 'tech技术类 tools工具类 avigation导航类 news新闻类 aggregate聚合类 life生活类 rocblogRocBlog优秀站点';
COMMENT ON COLUMN "public"."blog_friend"."is_top" IS '是否置顶';
COMMENT ON COLUMN "public"."blog_friend"."email" IS '联系邮箱';
COMMENT ON COLUMN "public"."blog_friend"."sort" IS '排序权重';
COMMENT ON COLUMN "public"."blog_friend"."is_deleted" IS '删除标志位：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."blog_friend"."update_time" IS '更新时间，自动更新';
COMMENT ON TABLE "public"."blog_friend" IS '友情链接表';

-- ----------------------------
-- Records of blog_friend
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (19, '程序员杨工子', '我是程序员杨工子；练习编程两年半，C#.Net全栈工程师、Mint.Blog(薄荷博客)作者。', 'https://www.yanggongzi.dev', 'https://img.yanggongzi.dev/blog-system/author-avatar.jpg', 'active', '2026-10-13 02:30:37', 'tech', 't', '', 0, 0, '2026-10-13 02:30:40.912146');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (20, '张三', '我是张三；练习编程两年半，C#.Net全栈工程师、Mint.Blog(薄荷博客)作者。', 'https://www.yanggongzi.dev', 'https://img.yanggongzi.dev/blog-system/author-avatar.jpg', 'pending', '2026-10-13 02:32:33', 'tech', 'f', '', 0, 0, '2026-10-13 02:32:40.182763');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (21, '李四', '我是李四；练习编程两年半，C#.Net全栈工程师、Mint.Blog(薄荷博客)作者。', 'https://www.yanggongzi.dev', 'https://img.yanggongzi.dev/blog-system/author-avatar.jpg', 'inactive', '2026-10-13 02:33:17', 'tech', 'f', '', 0, 0, '2026-10-13 02:33:21.51712');
COMMIT;

-- ----------------------------
-- Table structure for blog_gallery_category
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_gallery_category";
CREATE TABLE "public"."blog_gallery_category" (
  "id" int8 NOT NULL DEFAULT nextval('blog_gallery_category_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "sort" int4 NOT NULL DEFAULT 0,
  "enabled" bool NOT NULL DEFAULT true,
  "create_time" timestamp(6) NOT NULL DEFAULT now(),
  "update_time" timestamp(6) NOT NULL DEFAULT now()
)
;
ALTER TABLE "public"."blog_gallery_category" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_gallery_category"."id" IS '画廊分类主键ID';
COMMENT ON COLUMN "public"."blog_gallery_category"."name" IS '分类名称';
COMMENT ON COLUMN "public"."blog_gallery_category"."description" IS '分类描述';
COMMENT ON COLUMN "public"."blog_gallery_category"."sort" IS '排序值，数值越大越靠前';
COMMENT ON COLUMN "public"."blog_gallery_category"."enabled" IS '是否启用，true启用，false停用';
COMMENT ON COLUMN "public"."blog_gallery_category"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."blog_gallery_category"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."blog_gallery_category" IS '博客画廊分类表';

-- ----------------------------
-- Records of blog_gallery_category
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_gallery_category" ("id", "name", "description", "sort", "enabled", "create_time", "update_time") VALUES (4, '代码氛围', '开发、终端与工作台', 996, 't', '2026-07-05 13:03:44.050905', '2026-07-05 13:03:44.050905');
INSERT INTO "public"."blog_gallery_category" ("id", "name", "description", "sort", "enabled", "create_time", "update_time") VALUES (2, '风景', '', 998, 't', '2026-07-05 13:01:23.235311', '2026-07-18 05:29:55.87638');
INSERT INTO "public"."blog_gallery_category" ("id", "name", "description", "sort", "enabled", "create_time", "update_time") VALUES (1, '美女', '', 999, 't', '2026-07-05 13:00:38.584362', '2026-07-18 05:30:00.711554');
INSERT INTO "public"."blog_gallery_category" ("id", "name", "description", "sort", "enabled", "create_time", "update_time") VALUES (3, '动物', '', 997, 't', '2026-07-05 13:02:10.120531', '2026-07-18 05:30:44.946364');
INSERT INTO "public"."blog_gallery_category" ("id", "name", "description", "sort", "enabled", "create_time", "update_time") VALUES (5, '科幻', '', 0, 't', '2026-07-05 13:04:11.459266', '2026-07-18 05:31:13.345746');
COMMIT;

-- ----------------------------
-- Table structure for blog_gallery_image
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_gallery_image";
CREATE TABLE "public"."blog_gallery_image" (
  "id" int8 NOT NULL DEFAULT nextval('blog_gallery_image_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "category_id" int8 NOT NULL,
  "resolution" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "ratio" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "image_time" timestamp(6) NOT NULL,
  "url" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "source_type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'local'::character varying,
  "bucket_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "object_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "file_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "sort" int4 NOT NULL DEFAULT 0,
  "enabled" bool NOT NULL DEFAULT true,
  "create_time" timestamp(6) NOT NULL DEFAULT now(),
  "update_time" timestamp(6) NOT NULL DEFAULT now(),
  "size" int4 NOT NULL
)
;
ALTER TABLE "public"."blog_gallery_image" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_gallery_image"."id" IS '画廊图片主键ID';
COMMENT ON COLUMN "public"."blog_gallery_image"."name" IS '图片名称';
COMMENT ON COLUMN "public"."blog_gallery_image"."category_id" IS '所属画廊分类ID，关联blog_gallery_category.id';
COMMENT ON COLUMN "public"."blog_gallery_image"."resolution" IS '图片分辨率，例如4K、1920x1080';
COMMENT ON COLUMN "public"."blog_gallery_image"."ratio" IS '图片比例，例如16:9、4:3、9:16';
COMMENT ON COLUMN "public"."blog_gallery_image"."image_time" IS '图片时间或拍摄/收集日期';
COMMENT ON COLUMN "public"."blog_gallery_image"."url" IS '图片访问链接，本地上传时由对象存储自动生成，外部引用时为第三方图片链接';
COMMENT ON COLUMN "public"."blog_gallery_image"."source_type" IS '图片来源类型，local表示本地上传，external表示外部引用';
COMMENT ON COLUMN "public"."blog_gallery_image"."bucket_name" IS '本地上传图片所在对象存储桶名称，外部引用时为空';
COMMENT ON COLUMN "public"."blog_gallery_image"."object_name" IS '本地上传图片在对象存储中的对象名称，外部引用时为空';
COMMENT ON COLUMN "public"."blog_gallery_image"."file_name" IS '原始文件名或显示文件名';
COMMENT ON COLUMN "public"."blog_gallery_image"."sort" IS '排序值，数值越大越靠前';
COMMENT ON COLUMN "public"."blog_gallery_image"."enabled" IS '是否启用，true启用，false停用';
COMMENT ON COLUMN "public"."blog_gallery_image"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."blog_gallery_image"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."blog_gallery_image"."size" IS '图片大小(M)';
COMMENT ON TABLE "public"."blog_gallery_image" IS '博客画廊图片表';

-- ----------------------------
-- Records of blog_gallery_image
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_gallery_image" ("id", "name", "category_id", "resolution", "ratio", "image_time", "url", "source_type", "bucket_name", "object_name", "file_name", "sort", "enabled", "create_time", "update_time", "size") VALUES (3, '1515879218367-8466d910aaa4', 4, '1400x935', '3:2', '2026-07-18 00:00:00', 'https://images.unsplash.com/photo-1515879218367-8466d910aaa4?auto=format&fit=crop&w=1400&q=85', 'external', '', '', '', 0, 't', '2026-07-18 05:34:10.628879', '2026-07-18 05:52:27.7356', 1);
INSERT INTO "public"."blog_gallery_image" ("id", "name", "category_id", "resolution", "ratio", "image_time", "url", "source_type", "bucket_name", "object_name", "file_name", "sort", "enabled", "create_time", "update_time", "size") VALUES (2, '1555066931-4365d14bab8c', 4, '1400x933', '3:2', '2026-07-18 00:00:00', 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=1400&q=85', 'external', '', '', '', 0, 't', '2026-07-18 05:33:16.124899', '2026-07-18 05:52:40.043375', 1);
INSERT INTO "public"."blog_gallery_image" ("id", "name", "category_id", "resolution", "ratio", "image_time", "url", "source_type", "bucket_name", "object_name", "file_name", "sort", "enabled", "create_time", "update_time", "size") VALUES (6, 'IMG_2786', 1, '1080x1920', '5:9', '2026-07-18 00:00:00', 'https://img.yanggongzi.dev/gallery/IMG_2786.jpeg', 'local', 'gallery', '', '', 0, 't', '2026-07-18 05:36:05.854838', '2026-07-18 05:36:05.854838', 1);
INSERT INTO "public"."blog_gallery_image" ("id", "name", "category_id", "resolution", "ratio", "image_time", "url", "source_type", "bucket_name", "object_name", "file_name", "sort", "enabled", "create_time", "update_time", "size") VALUES (8, 'IMG_2788', 1, '1206x1197', '1:1', '2026-07-18 00:00:00', 'https://img.yanggongzi.dev/gallery/IMG_2788.jpeg', 'local', 'gallery', '', '', 0, 't', '2026-07-18 05:36:37.775003', '2026-07-18 05:36:37.775003', 1);
INSERT INTO "public"."blog_gallery_image" ("id", "name", "category_id", "resolution", "ratio", "image_time", "url", "source_type", "bucket_name", "object_name", "file_name", "sort", "enabled", "create_time", "update_time", "size") VALUES (7, 'IMG_2787', 1, '1280x2275', '5:9', '2026-07-18 00:00:00', 'https://img.yanggongzi.dev/gallery/IMG_2787.jpeg', 'local', 'gallery', '', '', 0, 't', '2026-07-18 05:36:23.521067', '2026-07-18 05:36:23.521067', 1);
COMMIT;

-- ----------------------------
-- Table structure for blog_message
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_message";
CREATE TABLE "public"."blog_message" (
  "id" int8 NOT NULL,
  "nickname" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(200) COLLATE "pg_catalog"."default",
  "website" varchar(500) COLLATE "pg_catalog"."default",
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "color" varchar(20) COLLATE "pg_catalog"."default" NOT NULL DEFAULT '#18b57f'::character varying,
  "is_published" bool NOT NULL DEFAULT true,
  "create_time" timestamptz(6) NOT NULL DEFAULT now(),
  "update_time" timestamptz(6) NOT NULL DEFAULT now()
)
;
ALTER TABLE "public"."blog_message" OWNER TO "postgres";

-- ----------------------------
-- Records of blog_message
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_message" ("id", "nickname", "email", "website", "content", "color", "is_published", "create_time", "update_time") VALUES (10001, '小明', 'xiaoming@example.com', 'https://xiaoming.dev', '很棒的博客！文章质量很高，学到了很多 .NET 相关的知识。', '#18b57f', 't', '2026-04-01 02:00:00+00', '2026-04-01 02:00:00+00');
INSERT INTO "public"."blog_message" ("id", "nickname", "email", "website", "content", "color", "is_published", "create_time", "update_time") VALUES (10002, 'Lucy', NULL, NULL, '从掘金过来的，界面很清新，期待更多文章！', '#e67e22', 't', '2026-04-03 06:30:00+00', '2026-04-03 06:30:00+00');
INSERT INTO "public"."blog_message" ("id", "nickname", "email", "website", "content", "color", "is_published", "create_time", "update_time") VALUES (10003, 'TechGuru', 'guru@tech.io', 'https://techguru.io', 'The DDD architecture is clean and well-structured. Would love to see more about the CQRS pattern.', '#3498db', 't', '2026-04-05 01:15:00+00', '2026-04-05 01:15:00+00');
INSERT INTO "public"."blog_message" ("id", "nickname", "email", "website", "content", "color", "is_published", "create_time", "update_time") VALUES (10004, '前端小菜', NULL, 'https://fe-newbie.cn', '前端部分也做得很棒，Ant Design Vue 搭配 TailwindCSS 真好用！', '#9b59b6', 't', '2026-04-08 08:45:00+00', '2026-04-08 08:45:00+00');
INSERT INTO "public"."blog_message" ("id", "nickname", "email", "website", "content", "color", "is_published", "create_time", "update_time") VALUES (10005, 'Anonymous', NULL, NULL, '感谢开源，已经 star 了！希望项目越来越好。', '#95a5a6', 't', '2026-04-10 03:00:00+00', '2026-04-10 03:00:00+00');
INSERT INTO "public"."blog_message" ("id", "nickname", "email", "website", "content", "color", "is_published", "create_time", "update_time") VALUES (10006, '老张', 'laozhang@163.com', NULL, '内容很有深度，尤其是 Wiki 知识库的部分，整理得很系统。', '#1abc9c', 't', '2026-04-12 12:00:00+00', '2026-04-12 12:00:00+00');
INSERT INTO "public"."blog_message" ("id", "nickname", "email", "website", "content", "color", "is_published", "create_time", "update_time") VALUES (10007, 'Sarah', 'sarah@mail.com', 'https://sarah.codes', 'Love the dark mode and the mint green theme! Beautiful design.', '#2ecc71', 't', '2026-04-15 00:30:00+00', '2026-04-15 00:30:00+00');
INSERT INTO "public"."blog_message" ("id", "nickname", "email", "website", "content", "color", "is_published", "create_time", "update_time") VALUES (10008, '代码诗人', NULL, NULL, '留言墙功能上线了，来踩一脚 👣', '#e74c3c', 't', '2026-04-18 04:00:00+00', '2026-04-18 04:00:00+00');
INSERT INTO "public"."blog_message" ("id", "nickname", "email", "website", "content", "color", "is_published", "create_time", "update_time") VALUES (10009, 'David', 'david@dev.co', 'https://david.dev', 'Great project! The separation between Surfer and Blog controllers is really smart.', '#f39c12', 't', '2026-04-20 07:00:00+00', '2026-04-20 07:00:00+00');
INSERT INTO "public"."blog_message" ("id", "nickname", "email", "website", "content", "color", "is_published", "create_time", "update_time") VALUES (10010, '小雨', NULL, NULL, '博主加油！从 B 站视频过来的，教程做的很好 👍', '#00bcd4', 't', '2026-04-22 10:30:00+00', '2026-04-22 10:30:00+00');
INSERT INTO "public"."blog_message" ("id", "nickname", "email", "website", "content", "color", "is_published", "create_time", "update_time") VALUES (10011, 'NextGenDev', 'next@gen.dev', 'https://nextgen.dev', 'The .NET 10 + Vue 3 stack is exactly what I was looking for. Thanks for sharing!', '#8e44ad', 't', '2026-04-25 13:00:00+00', '2026-04-25 13:00:00+00');
INSERT INTO "public"."blog_message" ("id", "nickname", "email", "website", "content", "color", "is_published", "create_time", "update_time") VALUES (10012, '小明同学', NULL, NULL, '又来了，每次看都有新收获，已推荐给朋友~', '#18b57f', 't', '2026-04-28 02:00:00+00', '2026-04-28 02:00:00+00');
COMMIT;

-- ----------------------------
-- Table structure for blog_settings
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_settings";
CREATE TABLE "public"."blog_settings" (
  "id" int8 NOT NULL DEFAULT nextval('blog_settings_id_seq'::regclass),
  "name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "logo" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "author" varchar(200) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "avatar" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "introduction" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "copyright_declaration" text COLLATE "pg_catalog"."default",
  "github_homepage" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "csdn_homepage" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "gitee_homepage" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "zhihu_homepage" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "douyin_homepage" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "mail" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "is_comment_sensi_word_open" bool NOT NULL,
  "is_comment_examine_open" bool NOT NULL,
  "is_auto_theme" bool
)
;
ALTER TABLE "public"."blog_settings" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_settings"."id" IS 'id';
COMMENT ON COLUMN "public"."blog_settings"."name" IS '博客名称';
COMMENT ON COLUMN "public"."blog_settings"."logo" IS '博客Logo';
COMMENT ON COLUMN "public"."blog_settings"."author" IS '作者名';
COMMENT ON COLUMN "public"."blog_settings"."avatar" IS '作者头像';
COMMENT ON COLUMN "public"."blog_settings"."introduction" IS '介绍语';
COMMENT ON COLUMN "public"."blog_settings"."copyright_declaration" IS '版权声明';
COMMENT ON COLUMN "public"."blog_settings"."github_homepage" IS 'GitHub 主页访问地址';
COMMENT ON COLUMN "public"."blog_settings"."csdn_homepage" IS 'CSDN 主页访问地址';
COMMENT ON COLUMN "public"."blog_settings"."gitee_homepage" IS 'Gitee 主页访问地址';
COMMENT ON COLUMN "public"."blog_settings"."zhihu_homepage" IS '知乎主页访问地址';
COMMENT ON COLUMN "public"."blog_settings"."douyin_homepage" IS '抖音主页访问地址';
COMMENT ON COLUMN "public"."blog_settings"."mail" IS '博主邮箱地址';
COMMENT ON COLUMN "public"."blog_settings"."is_comment_sensi_word_open" IS '是否开启评论敏感词过滤, 0:不开启；1：开启';
COMMENT ON COLUMN "public"."blog_settings"."is_comment_examine_open" IS '是否开启评论审核, 0: 未开启；1：开启';
COMMENT ON COLUMN "public"."blog_settings"."is_auto_theme" IS '是否根据时间自动调整白天黑夜主题';
COMMENT ON TABLE "public"."blog_settings" IS '博客设置表';

-- ----------------------------
-- Records of blog_settings
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_settings" ("id", "name", "logo", "author", "avatar", "introduction", "copyright_declaration", "github_homepage", "csdn_homepage", "gitee_homepage", "zhihu_homepage", "douyin_homepage", "mail", "is_comment_sensi_word_open", "is_comment_examine_open", "is_auto_theme") VALUES (1, '薄荷博客', 'https://img.yanggongzi.dev/blog-system/mint-logo.svg', '程序员杨工子', 'https://img.yangmufa.cn/blog-system/author-avatar.jpg', '大家好，我是"程序员杨工子"，练习编程三年半，喜欢 CV、Tab、Agent。', '本文为 程序员杨工子 原创文章，遵循 CC BY 4.0 版权协议，转载请附上原文出处和链接。
如您认为本文内容侵犯了您的合法权益，请通过以下方式提供书面证明材料，我将在核实后24小时内处理。
📧 联系邮箱：YangGongziDev@163.com', 'https://github.com/YangGongziDev', 'https://blog.csdn.net/YangGongziDev', 'https://gitee.com/YangGongziDev', 'https://www.zhihu.com/people/YangGongziDev', 'https://v.douyin.com/8r27sSQYrz0', 'YangGongzi@163.com', 't', 'f', 't');
COMMIT;

-- ----------------------------
-- Table structure for blog_statistics_article_pv
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_statistics_article_pv";
CREATE TABLE "public"."blog_statistics_article_pv" (
  "id" int8 NOT NULL DEFAULT nextval('blog_statistics_article_pv_id_seq'::regclass),
  "pv_date" date NOT NULL,
  "pv_count" int8 NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "public"."blog_statistics_article_pv" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_statistics_article_pv"."id" IS 'id';
COMMENT ON COLUMN "public"."blog_statistics_article_pv"."pv_date" IS '被统计的日期';
COMMENT ON COLUMN "public"."blog_statistics_article_pv"."pv_count" IS 'pv访问量';
COMMENT ON COLUMN "public"."blog_statistics_article_pv"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."blog_statistics_article_pv"."update_time" IS '最后一次更新时间';
COMMENT ON TABLE "public"."blog_statistics_article_pv" IS '统计表 - 文章 PV (访问量)';

-- ----------------------------
-- Records of blog_statistics_article_pv
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (187, '2025-09-01', 0, '2025-08-31 02:18:36', '2025-08-31 02:18:36');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (189, '2025-09-12', 0, '2025-09-11 23:00:00.008798', '2025-09-11 23:00:00.008798');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (190, '2025-09-15', 0, '2025-09-14 23:23:39.237248', '2025-09-14 23:23:39.237248');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (191, '2025-09-19', 42, '2025-09-18 22:59:59.978008', '2025-09-18 22:59:59.978008');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (192, '2025-09-21', 7, '2025-09-20 23:00:00.017366', '2025-09-20 23:00:00.017366');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (193, '2025-09-23', 23, '2025-09-22 23:00:00.009551', '2025-09-22 23:00:00.009551');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (194, '2025-09-26', 7, '2025-09-25 23:38:58.456187', '2025-09-25 23:38:58.456187');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (195, '2025-10-02', 0, '2025-10-01 22:59:59.893081', '2025-10-01 22:59:59.893081');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (196, '2025-10-07', 49, '2025-10-06 00:04:48.182743', '2025-10-06 00:04:48.182743');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (197, '2025-10-09', 0, '2025-10-08 23:00:00.012131', '2025-10-08 23:00:00.012131');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (198, '2025-10-15', 0, '2025-10-14 22:59:59.943897', '2025-10-14 22:59:59.943897');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (199, '2025-12-18', 36, '2025-12-17 22:59:59.970538', '2025-12-17 22:59:59.970538');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (200, '2025-12-24', 0, '2025-12-23 22:59:58.054141', '2025-12-23 22:59:58.054141');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (201, '2026-04-17', 0, '2026-04-16 14:38:00.818778', '2026-04-16 14:38:00.818817');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (202, '2026-04-18', 0, '2026-04-17 14:55:55.595459', '2026-04-17 14:55:55.595486');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (203, '2026-04-19', 0, '2026-04-18 00:06:04.212749', '2026-04-18 00:06:04.212769');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (204, '2026-04-20', 0, '2026-04-19 05:04:25.128199', '2026-04-19 05:04:25.128292');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (205, '2026-04-21', 0, '2026-04-20 00:25:44.08496', '2026-04-20 00:25:44.08496');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (206, '2026-04-22', 0, '2026-04-21 00:25:44.452727', '2026-04-21 00:25:44.452728');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (207, '2026-04-23', 0, '2026-04-22 00:29:32.731105', '2026-04-22 00:29:32.731162');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (208, '2026-04-24', 0, '2026-04-23 01:32:25.711285', '2026-04-23 01:32:25.711344');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (209, '2026-04-25', 0, '2026-04-24 03:57:58.837166', '2026-04-24 03:57:58.837166');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (210, '2026-04-26', 0, '2026-04-25 16:12:13.000193', '2026-04-25 16:12:13.000236');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (229, '2026-05-18', 3, '2026-05-17 05:02:52.991962', '2026-05-18 17:42:03.410965');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (231, '2026-05-20', 0, '2026-05-19 13:59:55.460538', '2026-05-19 13:59:55.460582');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (214, '2026-05-02', 266, '2026-05-01 00:19:49.267137', '2026-05-02 15:35:28.992389');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (228, '2026-05-16', 10, '2026-05-16 07:07:45.059276', '2026-05-16 15:06:11.403123');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (223, '2026-05-12', 17, '2026-05-11 13:09:22.329923', '2026-05-12 14:47:11.483675');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (217, '2026-05-05', 143, '2026-05-04 03:13:33.172784', '2026-05-05 11:52:04.364731');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (219, '2026-05-08', 0, '2026-05-07 13:08:27.442026', '2026-05-07 13:08:27.442072');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (211, '2026-04-30', 32, '2026-04-29 15:46:25.731988', '2026-04-30 19:30:46.409308');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (216, '2026-05-04', 91, '2026-05-03 00:19:50.298288', '2026-05-04 17:48:12.521057');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (218, '2026-05-06', 0, '2026-05-05 08:45:27.393919', '2026-05-05 08:45:27.393948');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (212, '2026-04-29', 46, '2026-04-29 17:19:49.290496', '2026-04-29 18:24:51.131246');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (213, '2026-05-01', 0, '2026-04-30 11:39:41.21098', '2026-04-30 11:39:41.211019');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (215, '2026-05-03', 98, '2026-05-02 00:19:49.646413', '2026-05-03 17:07:55.501733');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (220, '2026-05-07', 28, '2026-05-07 14:30:59.143729', '2026-05-07 15:49:47.318007');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (222, '2026-05-10', 9, '2026-05-10 16:01:47.957639', '2026-05-10 17:38:06.967999');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (221, '2026-05-11', 1, '2026-05-10 13:17:11.256083', '2026-05-11 16:48:50.56198');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (224, '2026-05-13', 160, '2026-05-12 05:53:02.230803', '2026-05-13 16:50:02.864013');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (226, '2026-05-15', 0, '2026-05-14 01:32:05.010943', '2026-05-14 01:32:05.010992');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (225, '2026-05-14', 7, '2026-05-13 00:52:48.792054', '2026-05-14 15:58:03.116066');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (227, '2026-05-17', 50, '2026-05-16 06:52:22.749708', '2026-05-17 17:48:47.533376');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (230, '2026-05-19', 0, '2026-05-18 15:21:14.783154', '2026-05-18 15:21:14.783197');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (238, '2026-05-27', 32, '2026-05-26 00:15:20.798052', '2026-05-27 14:48:52.874019');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (246, '2026-06-04', 3, '2026-06-03 00:01:49.807984', '2026-06-04 05:53:53.598734');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (249, '2026-06-07', 0, '2026-06-06 00:01:49.786179', '2026-06-06 00:01:49.786179');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (248, '2026-06-06', 1, '2026-06-05 00:01:49.79889', '2026-06-06 16:57:28.278367');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (239, '2026-05-28', 6, '2026-05-27 00:15:20.856031', '2026-05-28 01:22:24.55023');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (251, '2026-06-09', 0, '2026-06-08 00:01:49.787043', '2026-06-08 00:01:49.787043');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (250, '2026-06-08', 1, '2026-06-07 00:01:49.787029', '2026-06-08 10:51:50.189623');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (233, '2026-05-21', 15, '2026-05-21 13:15:20.817646', '2026-05-21 19:32:36.482734');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (232, '2026-05-22', 1, '2026-05-21 01:58:24.42557', '2026-05-22 07:12:13.015968');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (271, '2026-06-29', 5, '2026-06-28 00:53:45.465637', '2026-06-29 15:48:50.040619');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (262, '2026-06-20', 68, '2026-06-19 00:01:49.796983', '2026-06-20 23:05:19.373435');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (252, '2026-06-10', 4, '2026-06-09 00:01:49.808977', '2026-06-10 08:40:23.879115');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (264, '2026-06-22', 0, '2026-06-21 00:53:45.486228', '2026-06-21 00:53:45.486261');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (272, '2026-06-30', 1, '2026-06-29 00:53:45.465503', '2026-06-30 15:15:35.631756');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (273, '2026-07-01', 1, '2026-06-30 00:53:45.481847', '2026-07-01 10:09:51.607189');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (240, '2026-05-29', 66, '2026-05-28 00:15:20.929128', '2026-05-29 16:59:22.35487');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (236, '2026-05-25', 29, '2026-05-24 00:02:23.456951', '2026-05-25 23:49:55.951678');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (237, '2026-05-26', 1, '2026-05-25 00:38:56.755608', '2026-05-26 07:15:44.276086');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (263, '2026-06-21', 4, '2026-06-20 00:59:26.640035', '2026-06-21 11:25:44.216421');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (234, '2026-05-23', 20, '2026-05-22 00:05:31.676011', '2026-05-23 18:18:43.199795');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (258, '2026-06-16', 10, '2026-06-15 00:01:49.798493', '2026-06-16 16:44:14.006536');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (243, '2026-06-01', 32, '2026-05-31 00:40:31.907689', '2026-06-01 16:41:28.624771');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (241, '2026-05-30', 6, '2026-05-29 00:15:20.792482', '2026-05-30 12:41:24.468967');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (259, '2026-06-17', 1, '2026-06-16 00:01:49.787138', '2026-06-17 01:04:10.692599');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (260, '2026-06-18', 1, '2026-06-17 00:01:49.800977', '2026-06-18 01:44:14.02926');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (275, '2026-07-03', 0, '2026-07-02 00:53:45.465516', '2026-07-02 00:53:45.465516');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (265, '2026-06-23', 2, '2026-06-22 00:53:45.476187', '2026-06-23 05:18:35.810483');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (288, '2026-07-16', 47, '2026-07-15 00:54:01.423449', '2026-07-16 15:52:32.709067');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (274, '2026-07-02', 2, '2026-07-01 00:53:45.475254', '2026-07-02 07:22:50.523515');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (276, '2026-07-04', 0, '2026-07-03 00:53:45.484413', '2026-07-03 00:53:45.484413');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (253, '2026-06-11', 21, '2026-06-10 00:01:49.786597', '2026-06-11 15:08:14.171411');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (254, '2026-06-12', 2, '2026-06-11 00:01:49.799524', '2026-06-12 03:50:13.490415');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (235, '2026-05-24', 80, '2026-05-23 00:05:31.644511', '2026-05-24 16:45:16.37926');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (242, '2026-05-31', 69, '2026-05-30 00:43:27.610409', '2026-05-31 22:25:38.774571');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (244, '2026-06-02', 18, '2026-06-01 00:07:06.829534', '2026-06-02 06:54:26.604762');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (281, '2026-07-09', 3, '2026-07-08 00:54:01.400666', '2026-07-09 02:41:12.703316');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (266, '2026-06-24', 7, '2026-06-23 00:53:45.46542', '2026-06-24 12:09:13.021817');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (255, '2026-06-13', 3, '2026-06-12 00:01:49.786376', '2026-06-13 13:00:04.086978');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (257, '2026-06-15', 0, '2026-06-14 00:01:49.790347', '2026-06-14 00:01:49.790347');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (245, '2026-06-03', 5, '2026-06-02 00:07:06.841593', '2026-06-03 08:04:53.910286');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (247, '2026-06-05', 0, '2026-06-04 00:01:49.802225', '2026-06-04 00:01:49.802225');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (268, '2026-06-26', 0, '2026-06-25 00:53:45.45977', '2026-06-25 00:53:45.45977');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (277, '2026-07-05', 2, '2026-07-04 00:53:45.465843', '2026-07-05 12:54:08.642879');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (267, '2026-06-25', 2, '2026-06-24 00:53:45.465108', '2026-06-25 08:36:37.302163');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (256, '2026-06-14', 3, '2026-06-13 00:01:49.798566', '2026-06-14 11:39:24.190376');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (269, '2026-06-27', 0, '2026-06-26 00:53:45.470395', '2026-06-26 00:53:45.470395');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (261, '2026-06-19', 16, '2026-06-18 00:01:49.786945', '2026-06-19 18:34:37.144778');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (270, '2026-06-28', 0, '2026-06-27 00:53:45.47811', '2026-06-27 00:53:45.47811');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (283, '2026-07-11', 0, '2026-07-10 00:54:01.422515', '2026-07-10 00:54:01.422516');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (278, '2026-07-06', 2, '2026-07-05 00:53:45.471019', '2026-07-06 08:06:46.533438');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (280, '2026-07-08', 0, '2026-07-07 00:54:01.399685', '2026-07-07 00:54:01.399685');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (284, '2026-07-12', 0, '2026-07-11 00:54:01.405098', '2026-07-11 00:54:01.405098');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (285, '2026-07-13', 0, '2026-07-12 00:54:01.40064', '2026-07-12 00:54:01.40064');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (279, '2026-07-07', 2, '2026-07-06 00:54:01.425942', '2026-07-07 13:39:17.023266');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (282, '2026-07-10', 0, '2026-07-09 00:54:01.418306', '2026-07-09 00:54:01.418306');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (286, '2026-07-14', 0, '2026-07-13 00:54:01.400532', '2026-07-13 00:54:01.400532');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (287, '2026-07-15', 0, '2026-07-14 00:54:01.401195', '2026-07-14 00:54:01.401195');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (289, '2026-07-17', 42, '2026-07-16 00:54:01.400846', '2026-07-17 13:11:25.216339');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (290, '2026-07-18', 70, '2026-07-17 00:54:01.400313', '2026-07-18 14:33:23.265988');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (291, '2026-07-19', 1, '2026-07-18 00:18:41.988473', '2026-07-19 15:32:53.665323');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (293, '2026-07-21', 0, '2026-07-20 00:45:53.994783', '2026-07-20 00:45:53.994783');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (292, '2026-07-20', 1, '2026-07-19 00:45:54.021948', '2026-07-20 00:59:08.975442');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (295, '2026-07-23', 0, '2026-07-22 00:45:53.994243', '2026-07-22 00:45:53.994243');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (294, '2026-07-22', 36, '2026-07-21 00:45:54.006275', '2026-07-22 12:38:31.060791');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (296, '2026-07-24', 1, '2026-07-23 00:37:00.356328', '2026-07-24 10:19:23.561101');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (297, '2026-07-25', 1, '2026-07-24 00:37:00.338325', '2026-07-25 06:07:37.470896');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (298, '2026-07-26', 9, '2026-07-25 00:37:00.329435', '2026-07-26 02:31:21.644204');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (300, '2026-07-28', 0, '2026-07-27 00:37:00.33003', '2026-07-27 00:37:00.33003');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (299, '2026-07-27', 3, '2026-07-26 00:37:00.333292', '2026-07-27 04:14:36.348023');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (301, '2026-07-29', 0, '2026-07-28 00:37:00.329657', '2026-07-28 00:37:00.329657');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (302, '2026-07-30', 0, '2026-07-29 00:37:00.342419', '2026-07-29 00:37:00.342419');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (303, '2026-07-31', 0, '2026-07-30 00:37:00.329328', '2026-07-30 00:37:00.329328');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (304, '2026-08-01', 0, '2026-07-31 00:37:00.329542', '2026-07-31 00:37:00.329542');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (305, '2026-08-02', 0, '2026-08-01 00:37:00.328937', '2026-08-01 00:37:00.328937');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (306, '2026-08-03', 1, '2026-08-02 00:37:00.329606', '2026-08-03 01:25:07.194732');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (307, '2026-08-04', 1, '2026-08-03 00:37:00.340321', '2026-08-04 07:46:37.388476');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (311, '2026-08-08', 35, '2026-08-07 00:37:00.365448', '2026-08-08 18:33:30.912441');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (313, '2026-08-10', 0, '2026-08-09 00:24:14.1189', '2026-08-09 00:24:14.1189');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (336, '2026-09-02', 3, '2026-09-01 00:33:41.928004', '2026-09-02 10:22:00.01546');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (308, '2026-08-05', 5, '2026-08-04 00:37:00.363356', '2026-08-05 02:53:18.764093');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (337, '2026-09-03', 1, '2026-09-02 00:33:41.949187', '2026-09-03 14:42:10.172005');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (338, '2026-09-04', 1, '2026-09-03 00:57:37.55744', '2026-09-04 03:48:24.286369');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (339, '2026-09-05', 1, '2026-09-04 00:57:37.531608', '2026-09-05 00:35:47.548671');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (340, '2026-09-06', 0, '2026-09-05 00:57:37.52273', '2026-09-05 00:57:37.52273');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (341, '2026-09-07', 1, '2026-09-06 00:57:37.542074', '2026-09-07 14:58:46.868715');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (356, '2026-09-22', 0, '2026-09-21 00:57:37.517662', '2026-09-21 00:57:37.517662');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (357, '2026-09-23', 0, '2026-09-22 00:57:37.552245', '2026-09-22 00:57:37.552245');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (342, '2026-09-08', 3, '2026-09-07 00:57:37.553987', '2026-09-08 17:07:50.998677');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (343, '2026-09-09', 2, '2026-09-08 00:57:37.547897', '2026-09-09 01:35:27.676656');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (344, '2026-09-10', 1, '2026-09-09 00:57:37.523284', '2026-09-10 07:59:42.805822');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (309, '2026-08-06', 18, '2026-08-05 00:37:00.347812', '2026-08-06 12:45:10.864343');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (358, '2026-09-24', 1, '2026-09-23 00:57:37.546338', '2026-09-24 01:52:44.777531');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (360, '2026-09-26', 0, '2026-09-25 00:57:37.57001', '2026-09-25 00:57:37.57001');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (359, '2026-09-25', 1, '2026-09-24 00:57:37.549734', '2026-09-25 14:30:46.487321');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (345, '2026-09-11', 6, '2026-09-10 00:57:37.576788', '2026-09-11 06:34:00.521071');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (362, '2026-09-28', 0, '2026-09-27 00:57:37.556942', '2026-09-27 00:57:37.556942');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (312, '2026-08-09', 28, '2026-08-08 00:33:24.390413', '2026-08-09 14:06:29.164532');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (347, '2026-09-13', 0, '2026-09-12 00:57:37.516872', '2026-09-12 00:57:37.516872');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (346, '2026-09-12', 2, '2026-09-11 00:57:37.516778', '2026-09-12 01:10:00.815754');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (348, '2026-09-14', 0, '2026-09-13 00:57:37.530901', '2026-09-13 00:57:37.530901');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (314, '2026-08-11', 4, '2026-08-10 00:19:05.808068', '2026-08-11 08:10:17.296395');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (310, '2026-08-07', 19, '2026-08-06 00:37:00.340239', '2026-08-07 16:55:06.377977');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (361, '2026-09-27', 1, '2026-09-26 00:57:37.52678', '2026-09-27 12:50:23.455853');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (315, '2026-08-12', 5, '2026-08-11 00:19:05.807561', '2026-08-12 09:18:06.695636');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (317, '2026-08-14', 0, '2026-08-13 00:19:05.817938', '2026-08-13 00:19:05.817938');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (349, '2026-09-15', 3, '2026-09-14 00:57:37.522991', '2026-09-15 17:46:58.944205');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (316, '2026-08-13', 3, '2026-08-12 00:19:05.819201', '2026-08-13 07:25:01.515286');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (350, '2026-09-16', 1, '2026-09-15 00:57:37.567235', '2026-09-16 01:36:31.369841');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (364, '2026-09-30', 0, '2026-09-29 00:57:37.55383', '2026-09-29 00:57:37.55383');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (318, '2026-08-15', 5, '2026-08-14 00:19:05.811133', '2026-08-15 08:12:42.041615');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (363, '2026-09-29', 2, '2026-09-28 00:57:37.541416', '2026-09-29 23:57:01.333365');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (365, '2026-10-01', 0, '2026-09-30 00:57:37.521959', '2026-09-30 00:57:37.521959');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (366, '2026-10-02', 1, '2026-10-01 00:57:37.53243', '2026-10-02 04:16:03.72944');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (368, '2026-10-04', 0, '2026-10-03 00:57:37.561339', '2026-10-03 00:57:37.561339');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (367, '2026-10-03', 1, '2026-10-02 00:57:37.552455', '2026-10-03 16:29:22.301324');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (319, '2026-08-16', 9, '2026-08-15 00:19:05.821212', '2026-08-16 16:22:55.595268');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (320, '2026-08-17', 1, '2026-08-16 00:19:05.818189', '2026-08-17 08:45:31.38142');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (369, '2026-10-05', 1, '2026-10-04 00:57:37.539872', '2026-10-05 05:05:05.594963');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (321, '2026-08-18', 3, '2026-08-17 00:33:41.964911', '2026-08-18 07:58:25.110275');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (323, '2026-08-20', 0, '2026-08-19 00:33:41.950962', '2026-08-19 00:33:41.950962');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (322, '2026-08-19', 1, '2026-08-18 00:33:41.944844', '2026-08-19 09:43:33.126446');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (324, '2026-08-21', 0, '2026-08-20 00:33:41.959572', '2026-08-20 00:33:41.959573');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (325, '2026-08-22', 0, '2026-08-21 00:33:41.956267', '2026-08-21 00:33:41.956267');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (326, '2026-08-23', 0, '2026-08-22 00:33:41.930115', '2026-08-22 00:33:41.930115');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (327, '2026-08-24', 0, '2026-08-23 00:33:41.925466', '2026-08-23 00:33:41.925466');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (329, '2026-08-26', 0, '2026-08-25 00:33:41.956534', '2026-08-25 00:33:41.956534');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (328, '2026-08-25', 1, '2026-08-24 00:33:41.955231', '2026-08-25 14:02:37.659056');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (330, '2026-08-27', 3, '2026-08-26 00:33:41.932244', '2026-08-27 17:52:33.157381');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (332, '2026-08-29', 0, '2026-08-28 00:33:41.925542', '2026-08-28 00:33:41.925542');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (370, '2026-10-06', 3, '2026-10-05 00:57:37.579544', '2026-10-06 07:47:20.588297');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (371, '2026-10-07', 1, '2026-10-06 00:57:37.568956', '2026-10-07 08:18:11.276815');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (373, '2026-10-09', 0, '2026-10-08 00:57:37.560187', '2026-10-08 00:57:37.560187');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (331, '2026-08-28', 5, '2026-08-27 00:33:41.958564', '2026-08-28 04:08:50.970905');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (333, '2026-08-30', 0, '2026-08-29 00:33:41.95782', '2026-08-29 00:33:41.95782');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (334, '2026-08-31', 1, '2026-08-30 00:33:41.955771', '2026-08-31 07:06:07.398739');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (372, '2026-10-08', 1, '2026-10-07 00:57:37.548245', '2026-10-08 05:43:41.438153');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (335, '2026-09-01', 3, '2026-08-31 00:33:41.924633', '2026-09-01 10:24:10.464797');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (374, '2026-10-10', 3, '2026-10-09 00:57:37.561913', '2026-10-10 12:57:25.807904');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (376, '2026-10-12', 0, '2026-10-11 00:57:37.567136', '2026-10-11 00:57:37.567136');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (351, '2026-09-17', 27, '2026-09-16 00:57:37.527556', '2026-09-17 17:10:59.184625');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (375, '2026-10-11', 3, '2026-10-10 00:57:37.546973', '2026-10-11 18:01:25.732861');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (352, '2026-09-18', 3, '2026-09-17 00:57:37.524673', '2026-09-18 16:21:23.323054');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (354, '2026-09-20', 0, '2026-09-19 00:57:37.523051', '2026-09-19 00:57:37.523051');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (353, '2026-09-19', 2, '2026-09-18 00:57:37.52167', '2026-09-19 01:25:55.761531');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (355, '2026-09-21', 1, '2026-09-20 00:57:37.51672', '2026-09-21 00:55:22.852883');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (378, '2026-10-14', 0, '2026-10-13 00:57:37.545885', '2026-10-13 00:57:37.545885');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (377, '2026-10-13', 1, '2026-10-12 00:57:37.524775', '2026-10-13 02:49:35.969574');
COMMIT;

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_tag";
CREATE TABLE "public"."blog_tag" (
  "id" int8 NOT NULL DEFAULT nextval('blog_tag_id_seq'::regclass),
  "name" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0,
  "articles_total" int4 NOT NULL DEFAULT 0,
  "sort" int8
)
;
ALTER TABLE "public"."blog_tag" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_tag"."id" IS '标签id';
COMMENT ON COLUMN "public"."blog_tag"."name" IS '标签名称';
COMMENT ON COLUMN "public"."blog_tag"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."blog_tag"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."blog_tag"."is_deleted" IS '逻辑删除标志位：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."blog_tag"."articles_total" IS '此标签下文章总数';
COMMENT ON COLUMN "public"."blog_tag"."sort" IS '排序';
COMMENT ON TABLE "public"."blog_tag" IS '文章标签表';

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875566424064, 'GitHub Actions', '2026-05-31 03:18:36.70665', '2026-05-31 03:18:36.70665', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875604172800, 'Jenkins', '2026-05-31 03:18:36.715179', '2026-05-31 03:18:36.715179', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875604172801, 'Docker', '2026-05-31 03:18:36.71514', '2026-05-31 03:18:36.71514', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060394685679144960, 'Vue', '2026-05-29 16:15:48.000069', '2026-05-29 16:15:48.000069', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060394685700116480, 'SCSS', '2026-05-29 16:15:48.010762', '2026-05-29 16:15:48.010762', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060907705274601473, 'ASP.NET Web', '2026-05-31 02:14:21.405572', '2026-05-31 02:14:21.405572', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060907705274601472, 'ASP.NET Web API', '2026-05-30 18:14:21.408016', '2026-05-31 02:14:55.928917', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060908105616723970, 'Knife4j', '2026-05-31 02:15:56.857645', '2026-05-31 02:15:56.857645', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060908105616723969, 'Swashbuckle', '2026-05-31 02:15:56.857332', '2026-05-31 02:15:56.857332', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060908105616723968, 'NSwag', '2026-05-31 02:15:56.857057', '2026-05-31 02:15:56.857057', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060908105616723971, 'EntryFramework', '2026-05-31 02:15:56.857668', '2026-05-31 02:15:56.857668', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060909793954107392, 'Java', '2026-05-31 02:22:39.388166', '2026-05-31 02:22:39.388166', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2052375606020149248, 'C#', '2026-05-06 21:10:50.420397', '2026-05-31 02:22:45.411134', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059455068285046785, 'TypeScript', '2026-05-27 02:02:05.76163', '2026-05-31 02:28:57.750351', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466696404993, 'Memcached', '2026-05-31 02:37:15.038597', '2026-05-31 02:37:15.038597', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466696404992, 'Spanner', '2026-05-31 02:37:15.038244', '2026-05-31 02:37:15.038244', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466688016384, 'Minio', '2026-05-31 02:37:15.036802', '2026-05-31 02:37:15.036802', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466700599299, 'NoSQL', '2026-05-31 02:37:15.039597', '2026-05-31 02:37:15.039597', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466704793600, 'MySQL', '2026-05-31 02:37:15.040217', '2026-05-31 02:37:15.040217', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466700599302, 'SQLite', '2026-05-31 02:37:15.039896', '2026-05-31 02:37:15.039896', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466692210688, 'InfluxDB', '2026-05-31 02:37:15.037825', '2026-05-31 02:37:15.037825', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466700599301, 'SQL', '2026-05-31 02:37:15.039896', '2026-05-31 02:37:15.039896', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466700599300, 'Redis', '2026-05-31 02:37:15.039597', '2026-05-31 02:37:15.039597', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466700599296, 'HBase', '2026-05-31 02:37:15.038957', '2026-05-31 02:37:15.038957', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466704793601, 'PostgreSQL', '2026-05-31 02:37:15.040217', '2026-05-31 02:37:15.040217', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466700599297, 'MongoDB', '2026-05-31 02:37:15.039264', '2026-05-31 02:37:15.039264', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466700599298, 'Neo4j', '2026-05-31 02:37:15.03932', '2026-05-31 02:37:15.03932', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466818039808, 'SQLserver', '2026-05-31 02:37:15.067445', '2026-05-31 02:37:15.067445', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060913466885148672, 'Oracle', '2026-05-31 02:37:15.083688', '2026-05-31 02:37:15.083688', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697656856580, 'ElementPlus', '2026-05-31 02:50:05.359931', '2026-05-31 02:50:05.359931', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697656856578, 'Vite', '2026-05-31 02:50:05.359564', '2026-05-31 02:50:05.359564', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697652662273, 'Node.js', '2026-05-31 02:50:05.358194', '2026-05-31 02:50:05.358194', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697656856579, 'Ant Design of React', '2026-05-31 02:50:05.359914', '2026-05-31 02:50:05.359914', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697652662272, 'HTML', '2026-05-31 02:50:05.358194', '2026-05-31 02:50:05.358194', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697656856576, 'React', '2026-05-31 02:50:05.359061', '2026-05-31 02:50:05.359061', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697656856577, 'Webpack', '2026-05-31 02:50:05.359564', '2026-05-31 02:50:05.359564', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697661050884, 'Vant', '2026-05-31 02:50:05.360883', '2026-05-31 02:50:05.360883', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697661050880, 'Ionicons', '2026-05-31 02:50:05.36024', '2026-05-31 02:50:05.36024', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697661050881, 'Ant Design of Vue', '2026-05-31 02:50:05.360436', '2026-05-31 02:50:05.360436', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697661050883, 'ECharts', '2026-05-31 02:50:05.360742', '2026-05-31 02:50:05.360742', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697661050882, 'Pinia', '2026-05-31 02:50:05.360595', '2026-05-31 02:50:05.360595', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060916697665245184, 'Tsparticles', '2026-05-31 02:50:05.361219', '2026-05-31 02:50:05.361219', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060920950798553088, 'Apigee', '2026-05-31 03:06:59.387141', '2026-05-31 03:06:59.387141', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060920950798553089, 'Kong', '2026-05-31 03:06:59.387106', '2026-05-31 03:06:59.387106', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060921645824086016, 'Apache HTTP Server', '2026-05-31 03:09:45.094839', '2026-05-31 03:09:45.094839', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060921645832474626, 'RocketMQ', '2026-05-31 03:09:45.096342', '2026-05-31 03:09:45.096342', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060921645828280322, 'Nacos', '2026-05-31 03:09:45.095521', '2026-05-31 03:09:45.095521', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060921645828280325, 'PostgreSQL Proxy', '2026-05-31 03:09:45.095831', '2026-05-31 03:09:45.095831', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060921645828280321, 'Zookeeper', '2026-05-31 03:09:45.09531', '2026-05-31 03:09:45.09531', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060921645828280324, 'RabbitMQ', '2026-05-31 03:09:45.095831', '2026-05-31 03:09:45.095831', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060921645828280320, 'Etcd', '2026-05-31 03:09:45.095174', '2026-05-31 03:09:45.095174', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060921645832474624, 'ActiveMQ', '2026-05-31 03:09:45.096092', '2026-05-31 03:09:45.096092', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060921645832474625, 'Kafka', '2026-05-31 03:09:45.096092', '2026-05-31 03:09:45.096092', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060921645828280323, 'MySQL Proxy', '2026-05-31 03:09:45.095555', '2026-05-31 03:09:45.095555', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060922150373691392, 'Rider', '2026-05-31 03:11:45.388313', '2026-05-31 03:11:45.388313', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060922150373691396, 'WebStorm', '2026-05-31 03:11:45.38886', '2026-05-31 03:11:45.38886', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060922150373691395, 'VisualStudio', '2026-05-31 03:11:45.388581', '2026-05-31 03:11:45.388581', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060922150373691394, 'IntelliJ IDEA', '2026-05-31 03:11:45.388581', '2026-05-31 03:11:45.388581', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060922150373691393, 'VSCoode', '2026-05-31 03:11:45.388309', '2026-05-31 03:11:45.388309', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060922150369497088, 'Notepad', '2026-05-31 03:11:45.387899', '2026-05-31 03:11:45.387899', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060922150369497089, 'Markdon', '2026-05-31 03:11:45.387899', '2026-05-31 03:11:45.387899', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875604172802, 'Git', '2026-05-31 03:18:36.715504', '2026-05-31 03:18:36.715504', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875604172803, 'Kubernetes', '2026-05-31 03:18:36.715834', '2026-05-31 03:18:36.715834', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875608367104, 'MacOS', '2026-05-31 03:18:36.716149', '2026-05-31 03:18:36.716149', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875612561415, 'VisualBox', '2026-05-31 03:18:36.717892', '2026-05-31 03:18:36.717892', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875608367108, 'SVN', '2026-05-31 03:18:36.716862', '2026-05-31 03:18:36.716862', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875608367105, 'SFTP', '2026-05-31 03:18:36.716454', '2026-05-31 03:18:36.716454', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875612561408, 'Nginx', '2026-05-31 03:18:36.717078', '2026-05-31 03:18:36.717078', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875612561411, 'Unix', '2026-05-31 03:18:36.717366', '2026-05-31 03:18:36.717366', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875612561412, 'Windows', '2026-05-31 03:18:36.71762', '2026-05-31 03:18:36.71762', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875612561409, 'Linux', '2026-05-31 03:18:36.717146', '2026-05-31 03:18:36.717146', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875612561410, 'OpenHarmonyMS', '2026-05-31 03:18:36.717366', '2026-05-31 03:18:36.717366', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875612561414, 'Parallels Desktop', '2026-05-31 03:18:36.717892', '2026-05-31 03:18:36.717892', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875612561413, 'OpenHarmonyPC', '2026-05-31 03:18:36.717658', '2026-05-31 03:18:36.717658', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875633532928, 'FTP', '2026-05-31 03:18:36.722598', '2026-05-31 03:18:36.722598', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875608367107, 'VMWare', '2026-05-31 03:18:36.716745', '2026-05-31 03:18:36.716745', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060923875608367106, 'Tomcat', '2026-05-31 03:18:36.716592', '2026-05-31 03:18:36.716592', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060981605832462336, 'C/C++', '2026-05-31 07:08:00.674547', '2026-05-31 07:08:00.674547', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060992059724140544, 'Network', '2026-05-31 07:49:33.076561', '2026-05-31 07:49:33.076561', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060992736181489665, 'WPF', '2026-05-31 07:52:14.356509', '2026-05-31 07:52:14.356509', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060992736181489664, 'WinFrom', '2026-05-31 07:52:14.356509', '2026-05-31 07:52:14.356509', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060992736181489666, 'Avalonia', '2026-05-31 07:52:14.356943', '2026-05-31 07:52:14.356943', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2061627082869444608, 'SqlSugar', '2026-06-02 01:52:54.391594', '2026-06-02 01:52:54.391594', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060907705270407168, '.Net', '2026-05-30 18:14:21.406541', '2026-06-02 01:53:06.624649', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2067992442828886016, 'AllinSSL', '2026-06-19 07:26:34.468014', '2026-06-19 15:36:32.108449', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2068309963293462528, 'RustFS', '2026-06-20 12:28:17.246347', '2026-06-20 12:28:17.246347', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2077756628832227328, 'English', '2026-07-16 14:05:57.821251', '2026-07-16 14:05:57.821251', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2079836577395249152, 'CertBot', '2026-07-22 07:50:56.200819', '2026-07-22 07:50:56.200819', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2079843242735702016, 'Let''sEncrypt', '2026-07-22 08:17:25.344694', '2026-07-22 08:17:25.344694', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2100496363606380544, 'NPOI', '2026-09-17 08:05:33.075317', '2026-09-17 08:05:33.075317', 0, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for sys_admin_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_admin_record";
CREATE TABLE "public"."sys_admin_record" (
  "id" int8 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1
),
  "resource" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "data" jsonb NOT NULL,
  "create_time" timestamptz(6) NOT NULL DEFAULT now(),
  "update_time" timestamptz(6) NOT NULL DEFAULT now()
)
;
ALTER TABLE "public"."sys_admin_record" OWNER TO "postgres";

-- ----------------------------
-- Records of sys_admin_record
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_permission";
CREATE TABLE "public"."sys_permission" (
  "id" int8 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1
),
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "code" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::text,
  "resource" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "action" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "type" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'menu'::character varying,
  "parent_id" int8,
  "path" text COLLATE "pg_catalog"."default",
  "component" text COLLATE "pg_catalog"."default",
  "icon" text COLLATE "pg_catalog"."default",
  "sort" int4 NOT NULL DEFAULT 0,
  "status" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'active'::character varying,
  "visible" bool NOT NULL DEFAULT true
)
;
ALTER TABLE "public"."sys_permission" OWNER TO "postgres";

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (1, '所有权限', '*', '', '*', '*', 'menu', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (2, '仪表盘', 'dashboard.view', '', 'dashboard', 'view', 'menu', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (3, '部门管理', 'system.dept.view', '', 'dept', 'view', 'menu', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (4, '用户管理', 'system.user.view', '', 'user', 'view', 'menu', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (5, '角色管理', 'system.role.view', '', 'role', 'view', 'menu', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (6, '权限管理', 'system.permission.view', '', 'permission', 'view', 'menu', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (7, '配置管理', 'system.config.view', '', 'config', 'view', 'menu', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (8, '字典管理', 'system.dict.view', '', 'dict', 'view', 'menu', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (9, '文件管理', 'system.file.view', '', 'file', 'view', 'menu', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (10, '日志管理', 'system.log.view', '', 'log', 'view', 'menu', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (11, 'user.add', 'system.user.add', '', 'user', 'add', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (12, 'user.edit', 'system.user.edit', '', 'user', 'edit', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (13, 'user.delete', 'system.user.delete', '', 'user', 'delete', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (14, 'user.upload', 'system.user.upload', '', 'user', 'upload', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (15, 'user.clear', 'system.user.clear', '', 'user', 'clear', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (16, 'role.add', 'system.role.add', '', 'role', 'add', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (17, 'role.edit', 'system.role.edit', '', 'role', 'edit', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (18, 'role.delete', 'system.role.delete', '', 'role', 'delete', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (19, 'role.upload', 'system.role.upload', '', 'role', 'upload', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (20, 'role.clear', 'system.role.clear', '', 'role', 'clear', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (21, 'permission.add', 'system.permission.add', '', 'permission', 'add', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (22, 'permission.edit', 'system.permission.edit', '', 'permission', 'edit', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (23, 'permission.delete', 'system.permission.delete', '', 'permission', 'delete', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (24, 'permission.upload', 'system.permission.upload', '', 'permission', 'upload', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (25, 'permission.clear', 'system.permission.clear', '', 'permission', 'clear', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (26, 'dept.add', 'system.dept.add', '', 'dept', 'add', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (27, 'dept.edit', 'system.dept.edit', '', 'dept', 'edit', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (28, 'dept.delete', 'system.dept.delete', '', 'dept', 'delete', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (29, 'dept.upload', 'system.dept.upload', '', 'dept', 'upload', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (30, 'dept.clear', 'system.dept.clear', '', 'dept', 'clear', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (31, 'dict.add', 'system.dict.add', '', 'dict', 'add', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (32, 'dict.edit', 'system.dict.edit', '', 'dict', 'edit', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (33, 'dict.delete', 'system.dict.delete', '', 'dict', 'delete', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (34, 'dict.upload', 'system.dict.upload', '', 'dict', 'upload', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (35, 'dict.clear', 'system.dict.clear', '', 'dict', 'clear', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (36, 'config.add', 'system.config.add', '', 'config', 'add', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (37, 'config.edit', 'system.config.edit', '', 'config', 'edit', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (38, 'config.delete', 'system.config.delete', '', 'config', 'delete', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (39, 'config.upload', 'system.config.upload', '', 'config', 'upload', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (40, 'config.clear', 'system.config.clear', '', 'config', 'clear', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (41, 'file.add', 'system.file.add', '', 'file', 'add', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (42, 'file.edit', 'system.file.edit', '', 'file', 'edit', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (43, 'file.delete', 'system.file.delete', '', 'file', 'delete', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (44, 'file.upload', 'system.file.upload', '', 'file', 'upload', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (45, 'file.clear', 'system.file.clear', '', 'file', 'clear', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (46, 'log.add', 'system.log.add', '', 'log', 'add', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (47, 'log.edit', 'system.log.edit', '', 'log', 'edit', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (48, 'log.delete', 'system.log.delete', '', 'log', 'delete', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (49, 'log.upload', 'system.log.upload', '', 'log', 'upload', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
INSERT INTO "public"."sys_permission" ("id", "name", "code", "description", "resource", "action", "type", "parent_id", "path", "component", "icon", "sort", "status", "visible") VALUES (50, 'log.clear', 'system.log.clear', '', 'log', 'clear', 'button', NULL, NULL, NULL, NULL, 0, 'active', 't');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role";
CREATE TABLE "public"."sys_role" (
  "id" int8 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1
),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "code" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::text,
  "create_time" timestamptz(6) NOT NULL DEFAULT now(),
  "update_time" timestamptz(6) NOT NULL DEFAULT now()
)
;
ALTER TABLE "public"."sys_role" OWNER TO "postgres";

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_role" ("id", "name", "code", "description", "create_time", "update_time") VALUES (1, '超级管理员', 'ROLE_SUPER', '', '2026-10-12 02:42:44.893779+00', '2026-10-12 02:42:44.893779+00');
INSERT INTO "public"."sys_role" ("id", "name", "code", "description", "create_time", "update_time") VALUES (4, '演示管理员', 'ROLE_VISITOR', '', '2026-10-12 02:42:44.893779+00', '2026-10-12 02:42:44.893779+00');
INSERT INTO "public"."sys_role" ("id", "name", "code", "description", "create_time", "update_time") VALUES (2, '一般管理员', 'ROLE_ADMIN', '', '2026-10-12 02:42:44.893779+00', '2026-10-12 02:42:44.893779+00');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role_permission";
CREATE TABLE "public"."sys_role_permission" (
  "role_id" int8 NOT NULL,
  "permission_id" int8 NOT NULL
)
;
ALTER TABLE "public"."sys_role_permission" OWNER TO "postgres";

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (1, 1);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 2);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 3);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 4);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 5);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 6);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 7);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 8);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 9);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 10);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 11);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 12);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 13);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 14);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 15);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 16);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 17);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 18);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 19);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 20);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 21);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 22);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 23);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 24);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 25);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 26);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 27);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 28);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 29);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 30);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 31);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 32);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 33);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 34);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 35);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 36);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 37);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 38);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 39);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 40);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 41);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 42);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 43);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 44);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 45);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 46);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 47);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 48);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 49);
INSERT INTO "public"."sys_role_permission" ("role_id", "permission_id") VALUES (2, 50);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user";
CREATE TABLE "public"."sys_user" (
  "id" int8 NOT NULL DEFAULT nextval('sys_user_id_seq'::regclass),
  "username" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "display_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "password" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "is_deleted" int2 NOT NULL DEFAULT 0,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "status" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'active'::character varying,
  "email" varchar(254) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "phone" varchar(32) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "avatar" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::text,
  "gender" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "birth_date" varchar(32) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "bio" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::text
)
;
ALTER TABLE "public"."sys_user" OWNER TO "postgres";
COMMENT ON COLUMN "public"."sys_user"."id" IS 'id';
COMMENT ON COLUMN "public"."sys_user"."username" IS '用户名';
COMMENT ON COLUMN "public"."sys_user"."display_name" IS '对外显示名称';
COMMENT ON COLUMN "public"."sys_user"."password" IS '密码';
COMMENT ON COLUMN "public"."sys_user"."is_deleted" IS '逻辑删除：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."sys_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_user"."update_time" IS '最后一次更新时间';
COMMENT ON TABLE "public"."sys_user" IS '用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_user" ("id", "username", "display_name", "password", "is_deleted", "create_time", "update_time", "status", "email", "phone", "avatar", "gender", "birth_date", "bio") VALUES (2, 'VisitorAdmin', '演示管理员', '$2a$12$qx/tQ8.Ix2t8If2eAHstduQn6prcfwVfWjjgwYHqzOoTXs9.Y3gS6', 0, '2025-08-25 11:39:10', '2026-05-16 12:39:09.819159', 'active', '', '', '', '', '', '');
INSERT INTO "public"."sys_user" ("id", "username", "display_name", "password", "is_deleted", "create_time", "update_time", "status", "email", "phone", "avatar", "gender", "birth_date", "bio") VALUES (1, 'SuperAdmin', '超级管理员', '$2a$12$qx/tQ8.Ix2t8If2eAHstduQn6prcfwVfWjjgwYHqzOoTXs9.Y3gS6', 0, '2023-07-03 11:57:18', '2023-09-24 16:23:29', 'active', '', '', '', '', '', '');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_refresh_token";
CREATE TABLE "public"."sys_user_refresh_token" (
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "token_hash" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "expires_at" timestamptz(6) NOT NULL,
  "is_revoked" int4 NOT NULL DEFAULT 0,
  "revoked_at" timestamptz(6),
  "create_time" timestamptz(6) NOT NULL DEFAULT now()
)
;
ALTER TABLE "public"."sys_user_refresh_token" OWNER TO "postgres";

-- ----------------------------
-- Records of sys_user_refresh_token
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2107790916659056640, 4, '8821540EADAB761E5D463E54CC5EF0A4190A68EC9E2EA96CEEE3D0BA4A116090', '2026-10-14 11:11:30.017818+00', 1, '2026-10-10 09:33:36.227961+00', '2026-10-07 11:11:30.034068+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2108853443815936000, 4, '801E1894A920806BE54A93F7568CCD75CE4D7AD5FABBD6C2F67C52FB6238BE94', '2026-10-17 09:33:36.227961+00', 1, '2026-10-10 12:46:36.437957+00', '2026-10-10 09:33:36.231063+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2108902014598647808, 4, '6DA6E3DD091BC3050400967575420158A236D44F625BFEED115A3F91588AA07B', '2026-10-17 12:46:36.437957+00', 1, '2026-10-11 02:47:01.294819+00', '2026-10-10 12:46:36.440369+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2109113511950028800, 4, '9D7D7CFC17A7B11CAE19A2BC60CC7041645AE0C45065E499249FBFFC98C76951', '2026-10-18 02:47:01.294819+00', 1, '2026-10-11 17:48:11.739367+00', '2026-10-11 02:47:01.313736+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2109340299854745600, 4, '7B4315108338E5921390E47E33287F0F96B2EDE4DABC616BDA8F75C43F48CC79', '2026-10-18 17:48:11.739367+00', 1, '2026-10-13 01:59:33.763009+00', '2026-10-11 17:48:11.767205+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2109826344140541952, 4, 'A29F634478E478840B3DDE2A16E3E658AB7CF5028292E9CFDF24DB91B40615D1', '2026-10-20 01:59:33.734865+00', 0, NULL, '2026-10-13 01:59:33.747952+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2109832332914593792, 1, '07178E161301A00AAF25C9C2A0592C3FFEBC02EEB13FA16B9B1C039C061BCC16', '2026-10-20 02:23:21.559379+00', 0, NULL, '2026-10-13 02:23:21.577202+00');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_role";
CREATE TABLE "public"."sys_user_role" (
  "id" int8 NOT NULL DEFAULT nextval('sys_user_role_id_seq'::regclass),
  "username" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "role" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "user_id" int8 NOT NULL,
  "role_id" int8 NOT NULL
)
;
ALTER TABLE "public"."sys_user_role" OWNER TO "postgres";
COMMENT ON COLUMN "public"."sys_user_role"."id" IS 'id';
COMMENT ON COLUMN "public"."sys_user_role"."username" IS '用户名';
COMMENT ON COLUMN "public"."sys_user_role"."role" IS '角色';
COMMENT ON COLUMN "public"."sys_user_role"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."sys_user_role" IS '用户角色表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_user_role" ("id", "username", "role", "create_time", "user_id", "role_id") VALUES (2, 'VisitorAdmin', 'ROLE_VISITOR', '2023-07-07 01:23:33', 2, 4);
INSERT INTO "public"."sys_user_role" ("id", "username", "role", "create_time", "user_id", "role_id") VALUES (1, 'SuperAdmin', 'ROLE_SUPER', '2023-07-07 01:21:15', 1, 1);
COMMIT;

-- ----------------------------
-- Function structure for update_friends_updated_time
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_friends_updated_time"();
CREATE FUNCTION "public"."update_friends_updated_time"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
    NEW.update_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."update_friends_updated_time"() OWNER TO "postgres";

-- ----------------------------
-- Function structure for update_modified_column
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_modified_column"();
CREATE FUNCTION "public"."update_modified_column"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
    NEW.update_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."update_modified_column"() OWNER TO "postgres";

-- ----------------------------
-- Function structure for update_r_friends_time
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_r_friends_time"();
CREATE FUNCTION "public"."update_r_friends_time"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
    NEW.update_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."update_r_friends_time"() OWNER TO "postgres";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_article_category_rel_id_seq"
OWNED BY "public"."blog_article_category_rel"."id";
SELECT setval('"public"."blog_article_category_rel_id_seq"', 163, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_article_content_id_seq"
OWNED BY "public"."blog_article_content"."id";
SELECT setval('"public"."blog_article_content_id_seq"', 32, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_article_id_seq"
OWNED BY "public"."blog_article"."id";
SELECT setval('"public"."blog_article_id_seq"', 32, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_article_tag_rel_id_seq"
OWNED BY "public"."blog_article_tag_rel"."id";
SELECT setval('"public"."blog_article_tag_rel_id_seq"', 308, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_category_id_seq"
OWNED BY "public"."blog_category"."id";
SELECT setval('"public"."blog_category_id_seq"', 28, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_comment_id_seq"
OWNED BY "public"."blog_comment"."id";
SELECT setval('"public"."blog_comment_id_seq"', 14, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_friend_id_seq"
OWNED BY "public"."blog_friend"."id";
SELECT setval('"public"."blog_friend_id_seq"', 21, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_gallery_category_id_seq"
OWNED BY "public"."blog_gallery_category"."id";
SELECT setval('"public"."blog_gallery_category_id_seq"', 5, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_gallery_image_id_seq"
OWNED BY "public"."blog_gallery_image"."id";
SELECT setval('"public"."blog_gallery_image_id_seq"', 8, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."blog_settings_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_statistics_article_pv_id_seq"
OWNED BY "public"."blog_statistics_article_pv"."id";
SELECT setval('"public"."blog_statistics_article_pv_id_seq"', 200, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_tag_id_seq"
OWNED BY "public"."blog_tag"."id";
SELECT setval('"public"."blog_tag_id_seq"', 25, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_wiki_catalog_id_seq"
OWNED BY "public"."blog_column_catalog"."id";
SELECT setval('"public"."blog_wiki_catalog_id_seq"', 732, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_wiki_id_seq"
OWNED BY "public"."blog_column"."id";
SELECT setval('"public"."blog_wiki_id_seq"', 16, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_admin_record_id_seq"
OWNED BY "public"."sys_admin_record"."id";
SELECT setval('"public"."sys_admin_record_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_admin_record_id_seq1"
OWNED BY "public"."sys_admin_record"."id";
SELECT setval('"public"."sys_admin_record_id_seq1"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_permission_id_seq"
OWNED BY "public"."sys_permission"."id";
SELECT setval('"public"."sys_permission_id_seq"', 50, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_permission_id_seq1"
OWNED BY "public"."sys_permission"."id";
SELECT setval('"public"."sys_permission_id_seq1"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_role_id_seq"
OWNED BY "public"."sys_role"."id";
SELECT setval('"public"."sys_role_id_seq"', 5, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_role_id_seq1"
OWNED BY "public"."sys_role"."id";
SELECT setval('"public"."sys_role_id_seq1"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."sys_user_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_user_role_id_seq"
OWNED BY "public"."sys_user_role"."id";
SELECT setval('"public"."sys_user_role_id_seq"', 3, true);

-- ----------------------------
-- Indexes structure for table blog_article
-- ----------------------------
CREATE INDEX "idx_create_time" ON "public"."blog_article" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_article
-- ----------------------------
ALTER TABLE "public"."blog_article" ADD CONSTRAINT "blog_article_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table blog_article_category_rel
-- ----------------------------
CREATE INDEX "idx_category_id" ON "public"."blog_article_category_rel" USING btree (
  "category_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uni_article_id" ON "public"."blog_article_category_rel" USING btree (
  "article_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_article_category_rel
-- ----------------------------
ALTER TABLE "public"."blog_article_category_rel" ADD CONSTRAINT "blog_article_category_rel_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table blog_article_content
-- ----------------------------
CREATE INDEX "idx_article_id" ON "public"."blog_article_content" USING btree (
  "article_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_article_content
-- ----------------------------
ALTER TABLE "public"."blog_article_content" ADD CONSTRAINT "blog_article_content_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table blog_article_draft
-- ----------------------------
ALTER TABLE "public"."blog_article_draft" ADD CONSTRAINT "blog_article_draft_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table blog_article_draft_content
-- ----------------------------
ALTER TABLE "public"."blog_article_draft_content" ADD CONSTRAINT "blog_article_draft_content_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table blog_article_draft_tag
-- ----------------------------
ALTER TABLE "public"."blog_article_draft_tag" ADD CONSTRAINT "blog_article_draft_tag_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table blog_article_tag_rel
-- ----------------------------
CREATE INDEX "idx_article_id_tag" ON "public"."blog_article_tag_rel" USING btree (
  "article_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_tag_id" ON "public"."blog_article_tag_rel" USING btree (
  "tag_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_article_tag_rel
-- ----------------------------
ALTER TABLE "public"."blog_article_tag_rel" ADD CONSTRAINT "blog_article_tag_rel_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table blog_category
-- ----------------------------
CREATE INDEX "idx_create_time_category" ON "public"."blog_category" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uk_name" ON "public"."blog_category" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_category
-- ----------------------------
ALTER TABLE "public"."blog_category" ADD CONSTRAINT "blog_category_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table blog_column
-- ----------------------------
CREATE INDEX "idx_create_time_wiki" ON "public"."blog_column" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uk_title_wiki" ON "public"."blog_column" USING btree (
  "title" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_column
-- ----------------------------
ALTER TABLE "public"."blog_column" ADD CONSTRAINT "blog_wiki_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table blog_column_catalog
-- ----------------------------
CREATE INDEX "idx_parent_id_catalog" ON "public"."blog_column_catalog" USING btree (
  "parent_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sort" ON "public"."blog_column_catalog" USING btree (
  "sort" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_wiki_id" ON "public"."blog_column_catalog" USING btree (
  "column_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uk_article_id_catalog" ON "public"."blog_column_catalog" USING btree (
  "article_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_column_catalog
-- ----------------------------
ALTER TABLE "public"."blog_column_catalog" ADD CONSTRAINT "blog_wiki_catalog_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table blog_comment
-- ----------------------------
CREATE INDEX "idx_create_time_comment" ON "public"."blog_comment" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_parent_comment_id" ON "public"."blog_comment" USING btree (
  "parent_comment_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_reply_comment_id" ON "public"."blog_comment" USING btree (
  "reply_comment_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_router_url" ON "public"."blog_comment" USING btree (
  "router_url" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_comment
-- ----------------------------
ALTER TABLE "public"."blog_comment" ADD CONSTRAINT "blog_comment_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table blog_friend
-- ----------------------------
ALTER TABLE "public"."blog_friend" ADD CONSTRAINT "blog_friend_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table blog_gallery_category
-- ----------------------------
CREATE INDEX "idx_blog_gallery_category_sort" ON "public"."blog_gallery_category" USING btree (
  "sort" "pg_catalog"."int4_ops" DESC NULLS FIRST,
  "create_time" "pg_catalog"."timestamp_ops" DESC NULLS FIRST
);

-- ----------------------------
-- Primary Key structure for table blog_gallery_category
-- ----------------------------
ALTER TABLE "public"."blog_gallery_category" ADD CONSTRAINT "blog_gallery_category_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table blog_gallery_image
-- ----------------------------
CREATE INDEX "idx_blog_gallery_image_category_id" ON "public"."blog_gallery_image" USING btree (
  "category_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_blog_gallery_image_sort" ON "public"."blog_gallery_image" USING btree (
  "sort" "pg_catalog"."int4_ops" DESC NULLS FIRST,
  "create_time" "pg_catalog"."timestamp_ops" DESC NULLS FIRST
);

-- ----------------------------
-- Primary Key structure for table blog_gallery_image
-- ----------------------------
ALTER TABLE "public"."blog_gallery_image" ADD CONSTRAINT "blog_gallery_image_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table blog_message
-- ----------------------------
CREATE INDEX "idx_blog_message_published_create_time" ON "public"."blog_message" USING btree (
  "create_time" "pg_catalog"."timestamptz_ops" DESC NULLS FIRST
) WHERE is_published = true;

-- ----------------------------
-- Primary Key structure for table blog_message
-- ----------------------------
ALTER TABLE "public"."blog_message" ADD CONSTRAINT "blog_message_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table blog_settings
-- ----------------------------
ALTER TABLE "public"."blog_settings" ADD CONSTRAINT "blog_settings_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table blog_statistics_article_pv
-- ----------------------------
CREATE UNIQUE INDEX "uk_pv_date" ON "public"."blog_statistics_article_pv" USING btree (
  "pv_date" "pg_catalog"."date_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_statistics_article_pv
-- ----------------------------
ALTER TABLE "public"."blog_statistics_article_pv" ADD CONSTRAINT "blog_statistics_article_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table blog_tag
-- ----------------------------
CREATE INDEX "idx_create_time_tag" ON "public"."blog_tag" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uk_name_tag" ON "public"."blog_tag" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_tag
-- ----------------------------
ALTER TABLE "public"."blog_tag" ADD CONSTRAINT "blog_tag_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for sys_admin_record
-- ----------------------------
SELECT setval('"public"."sys_admin_record_id_seq1"', 1, false);

-- ----------------------------
-- Indexes structure for table sys_admin_record
-- ----------------------------
CREATE INDEX "ix_sys_admin_record_resource" ON "public"."sys_admin_record" USING btree (
  "resource" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "ux_admin_config_key" ON "public"."sys_admin_record" USING btree (
  (data ->> 'key'::text) COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE resource::text = 'config'::text;
CREATE UNIQUE INDEX "ux_admin_dict_type" ON "public"."sys_admin_record" USING btree (
  (data ->> 'code'::text) COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE resource::text = 'dictType'::text;
CREATE UNIQUE INDEX "ux_admin_dict_value" ON "public"."sys_admin_record" USING btree (
  (data ->> 'typeCode'::text) COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  (data ->> 'value'::text) COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE resource::text = 'dictData'::text;

-- ----------------------------
-- Checks structure for table sys_admin_record
-- ----------------------------
ALTER TABLE "public"."sys_admin_record" ADD CONSTRAINT "sys_admin_record_resource_check" CHECK (resource::text = ANY (ARRAY['dept'::character varying::text, 'dictType'::character varying::text, 'dictData'::character varying::text, 'config'::character varying::text, 'file'::character varying::text, 'loginLog'::character varying::text, 'operationLog'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table sys_admin_record
-- ----------------------------
ALTER TABLE "public"."sys_admin_record" ADD CONSTRAINT "sys_admin_record_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for sys_permission
-- ----------------------------
SELECT setval('"public"."sys_permission_id_seq1"', 1, false);

-- ----------------------------
-- Uniques structure for table sys_permission
-- ----------------------------
ALTER TABLE "public"."sys_permission" ADD CONSTRAINT "sys_permission_code_key" UNIQUE ("code");

-- ----------------------------
-- Checks structure for table sys_permission
-- ----------------------------
ALTER TABLE "public"."sys_permission" ADD CONSTRAINT "sys_permission_type_check" CHECK (type::text = ANY (ARRAY['menu'::character varying::text, 'button'::character varying::text, 'api'::character varying::text]));
ALTER TABLE "public"."sys_permission" ADD CONSTRAINT "sys_permission_status_check" CHECK (status::text = ANY (ARRAY['active'::character varying::text, 'inactive'::character varying::text]));
ALTER TABLE "public"."sys_permission" ADD CONSTRAINT "sys_permission_check" CHECK (parent_id <> id);

-- ----------------------------
-- Primary Key structure for table sys_permission
-- ----------------------------
ALTER TABLE "public"."sys_permission" ADD CONSTRAINT "sys_permission_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for sys_role
-- ----------------------------
SELECT setval('"public"."sys_role_id_seq1"', 1, false);

-- ----------------------------
-- Uniques structure for table sys_role
-- ----------------------------
ALTER TABLE "public"."sys_role" ADD CONSTRAINT "sys_role_code_key" UNIQUE ("code");

-- ----------------------------
-- Primary Key structure for table sys_role
-- ----------------------------
ALTER TABLE "public"."sys_role" ADD CONSTRAINT "sys_role_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_role_permission
-- ----------------------------
ALTER TABLE "public"."sys_role_permission" ADD CONSTRAINT "sys_role_permission_pkey" PRIMARY KEY ("role_id", "permission_id");

-- ----------------------------
-- Indexes structure for table sys_user
-- ----------------------------
CREATE UNIQUE INDEX "ux_sys_user_username" ON "public"."sys_user" USING btree (
  "username" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_user
-- ----------------------------
ALTER TABLE "public"."sys_user" ADD CONSTRAINT "sys_user_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_user_refresh_token
-- ----------------------------
CREATE INDEX "idx_sys_user_refresh_token_user_id" ON "public"."sys_user_refresh_token" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uk_sys_user_refresh_token_token_hash" ON "public"."sys_user_refresh_token" USING btree (
  "token_hash" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_user_refresh_token
-- ----------------------------
ALTER TABLE "public"."sys_user_refresh_token" ADD CONSTRAINT "sys_user_refresh_token_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_user_role
-- ----------------------------
CREATE INDEX "idx_username" ON "public"."sys_user_role" USING btree (
  "username" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "ux_sys_user_role" ON "public"."sys_user_role" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "role_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_user_role
-- ----------------------------
ALTER TABLE "public"."sys_user_role" ADD CONSTRAINT "sys_user_role_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table blog_gallery_image
-- ----------------------------
ALTER TABLE "public"."blog_gallery_image" ADD CONSTRAINT "blog_gallery_image_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "public"."blog_gallery_category" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table sys_permission
-- ----------------------------
ALTER TABLE "public"."sys_permission" ADD CONSTRAINT "sys_permission_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "public"."sys_permission" ("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table sys_role_permission
-- ----------------------------
ALTER TABLE "public"."sys_role_permission" ADD CONSTRAINT "sys_role_permission_permission_id_fkey" FOREIGN KEY ("permission_id") REFERENCES "public"."sys_permission" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."sys_role_permission" ADD CONSTRAINT "sys_role_permission_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."sys_role" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table sys_user_role
-- ----------------------------
ALTER TABLE "public"."sys_user_role" ADD CONSTRAINT "sys_user_role_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."sys_role" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."sys_user_role" ADD CONSTRAINT "sys_user_role_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."sys_user" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
