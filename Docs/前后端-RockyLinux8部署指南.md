# Mint.Blog Rocky Linux 8.10 部署步骤

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
  location / { return 200 'nginx is running'; }
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
alias dmc='docker run --rm -it --add-host=host.docker.internal:host-gateway -v /opt/docker/datas/mc:/root/.mc minio/mc'
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
    ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!aNULL:!MD5:!ADH:!RC4:!NULL';
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
- 图片无法访问：确认 RustFS 桶 `blog-article` 已设置匿名下载，且 `RustFS:PublicEndpoint` 浏览器可访问