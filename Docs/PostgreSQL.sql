/*
 Navicat Premium Dump SQL

 Source Server         : Local_Docker-YangMufa666
 Source Server Type    : PostgreSQL
 Source Server Version : 180003 (180003)
 Source Host           : 127.0.0.1:5432
 Source Catalog        : Mint.Blog
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180003 (180003)
 File Encoding         : 65001

 Date: 01/11/2026 14:17:18
*/


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
-- Sequence structure for blog_resource_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_resource_id_seq";
CREATE SEQUENCE "public"."blog_resource_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_resource_id_seq" OWNER TO "postgres";

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
-- Sequence structure for blog_tag_version_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."blog_tag_version_id_seq";
CREATE SEQUENCE "public"."blog_tag_version_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."blog_tag_version_id_seq" OWNER TO "postgres";

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
  "visibility" int2 NOT NULL DEFAULT 1,
  "tag_id" int8 NOT NULL,
  "tag_version_id" int8 NOT NULL
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
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "visibility", "tag_id", "tag_version_id") VALUES (2060392182262665216, '系统介绍', 'https://img.yanggongzi.dev/blog-article-detail-banner-original/default-article-detail-image1.jpeg', '介绍系统功能和前后端技术栈', '2026-04-20 16:05:51.144279', '2026-10-31 22:16:37.585', 0, 137, 1, 1, 2113187978510733313, 95);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "visibility", "tag_id", "tag_version_id") VALUES (2060905063282511872, '.Net-Core-Framework的历史及web和MVC的关系', 'https://img.yanggongzi.dev/article-cover-temp/.net-core-Framework%E5%85%B3%E7%B3%BB%E5%9B%BE.png', '.Net-Core-Framework的历史及web和MVC的关系', '2026-05-27 02:03:51.502184', '2026-05-29 10:17:12.293762', 0, 10, 0, 1, 2052375606020149248, 1);
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
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2068016047285473280, 2068016047268696064, '# AllinSSL 安装部署与配置

SSL 证书有效期的缩短（目前已普遍为**90天**）让多网站证书管理变得愈发繁琐。AllinSSL 作为一款开源免费的 SSL 证书自动化管理平台，正是为解决这一痛点而生。本文将手摸手教你完成 AllinSSL 的安装部署与基础配置。

------

## 一、AllinSSL 是什么？

AllinSSL 是一款集**证书申请、部署、监控、续期**于一体的开源工具（AGPL-3.0 协议）。它支持 Let''s Encrypt、ZeroSSL 等多 CA 机构，能将证书一键部署到阿里云、腾讯云、宝塔面板、1Panel 及传统服务器（通过 SSH）等目标，并提供直观的 Web 界面供统一管理。对于个人开发者或中小企业而言，使用它可以将证书管理从“每周耗时数小时”变为“首次配置后零维护”。

------

## 二、部署方式选择与对比

AllinSSL 提供两种主流部署方式，你可以根据自己的环境和习惯选择：

| 部署方式        | 适用场景                         | 优点                                        |
| :-------------- | :------------------------------- | :------------------------------------------ |
| **Docker 部署** | 服务器已安装 Docker 环境         | 环境隔离、一键部署、易于迁移和卸载          |
| **二进制安装**  | 不具备 Docker 环境或偏好传统方式 | 直接运行于宿主机，资源占用低（内存 < 50MB） |

------

## 三、准备工作

无论选择哪种方式，在开始前请确认以下事项：

1. **系统要求**：Linux 操作系统（推荐 CentOS 7+, Ubuntu 18.04+, Debian 9+）。
2. **开放端口**：AllinSSL 默认使用 **7979** 端口。云服务器需在安全组放行该端口。
3. **DNS 服务商凭证（必须）**：由于申请泛域名证书或使用 DNS 验证方式时需调用 API，建议提前准备好 DNS 服务商的 **AccessKey ID** 和 **AccessKey Secret**。

------

## 四、安装步骤

这是最快捷的方式。直接执行以下命令即可：

**1.创建挂载文件夹**
```bash
mkdir -p /opt/docker/allinssl/cert
```
**2.开放文件夹访问权限**：
```bash
chmod -R 777 /opt/docker/allinssl/cert
```
**3.运行容器：**
```bash
docker run -itd \
  --name allinssl \
  -p 7979:8888 \
  -v /opt/docker/allinssl/cert:/www/allinssl/data \
  -e ALLINSSL_USER=allinssl \
  -e ALLINSSL_PWD=allinssldocker \
  -e ALLINSSL_URL=allinssl \
  allinssl/allinssl:latest
```
**4.验证挂载**：容器启动后，可通过以下命令检查是否挂载成功：
```bash
docker inspect allinssl | grep -A 5 Mounts
```
***参数说明***：
- `-p 7979:8888`：将宿主机的 7979 端口映射到容器内的 8888 端口。
- `-v /opt/docker/allinssl/cert:/www/allinssl/data`：将容器数据持久化到宿主机，防止容器删除后数据丢失。
- `-e ALLINSSL_USER` 与 `-e ALLINSSL_PWD`：设置 Web 界面的**登录用户名和密码**。
- `-e ALLINSSL_URL`：设置 Web 界面的**访问入口路径**（如设置为 `allinssl`，则访问地址为 `http://IP:7979/allinssl`）。

如果 Docker 拉取镜像较慢，可在宝塔面板的 Docker 应用商店中一键安装。

## 五、基础配置与使用

>安装完成后，通过浏览器访问 `http://服务器IP:7979/allinssl`（入口路径根据你设置的环境变量而定），使用预设的用户名密码登录。

### 1.授权API管理
#### (一)、创建AccessKey(阿里云举例) 
进入阿里云控制台,在左侧菜单栏找到 **授权API管理** 或 **DNS提供商** 配置页面。
![](https://img.yangmufa.cn/blog-article/image-470b096b-0afd-4584-85ea-df5e93f75934.png)
#### (二)、添加授权API
![](https://img.yangmufa.cn/blog-article/image-2d964561-a3ba-4b55-9e0c-b039226e6631.png)

### 2. 创建自动化部署工作流

这是 AllinSSL 的核心功能。通过创建工作流，可串联“申请-部署-通知”全流程。

#### (一)、添加自动化部署
选择高级自定义模板（可选择快速部署）。
![](https://img.yangmufa.cn/blog-article/image-3f2c5d41-0601-41df-b73d-73972c1a7cd5.png)
#### (二)、设置自动执行和申请证书：
![](https://img.yangmufa.cn/blog-article/image-e172ac79-c286-409f-9648-0873e97d315b.png)
![](https://img.yangmufa.cn/blog-article/image-a16674d4-951b-4ea6-90e2-76771307c8c8.png)
![](https://img.yangmufa.cn/blog-article/image-fd0e0fce-fd4e-4c1c-a93a-ec24e1c2e27d.png)
#### (三)、部署
![](https://img.yangmufa.cn/blog-article/image-1a20abae-166c-4ac4-a41a-941bea2191e3.png)
![](https://img.yangmufa.cn/blog-article/image-54ef3910-bfd1-4b5d-beda-be2dd5ae2027.png)
#### (四)、删除通知和保存
![](https://img.yangmufa.cn/blog-article/image-924fe60e-ffac-45ae-bde1-e6c41e7db71c.png)
### 3. 验证与执行
![](https://img.yangmufa.cn/blog-article/image-2d964561-a3ba-4b55-9e0c-b039226e6633.png)
![](https://img.yangmufa.cn/blog-article/image-10edb38d-bb8a-4b28-bcb1-e90030afb72c.png)
### 4. 查看Docker容器挂载目录。
![](https://img.yangmufa.cn/blog-article/image-e7d68750-c546-41a8-a65c-0c836dc4d7e9.png)
------

## 六、故障排除

- **无法访问 Web 界面**：检查服务器防火墙（iptables/firewalld）和云服务商安全组是否放行 **7979** 端口。
- **DNS 验证失败**：检查 API 密钥权限是否正确（需具备 DNS 解析记录增删改权限）；若使用阿里云，确认已通过 RAM 子账号授权 `AliyunDNSFullAccess` 策略。
- **证书申请超时**：若使用 Let''s Encrypt 且服务器在国内，建议在证书申请时选择 **LiteSSL** CA 机构，其验证节点在国内，速度更快。

------

## 总结

AllinSSL 通过**可视化的工作流**和**开放的 API 集成**，将原本分散且重复的证书管理工作系统化。无论你使用 Docker 还是二进制部署，其核心都在于正确配置 DNS 服务商的 API 凭证，然后通过“创建自动化流程”实现“一次配置，自动续期”。对于国内用户，配合 **LiteSSL** 证书提供商使用，能获得更稳定的验证体验。立即着手尝试，让网站安全管理从此“省心省力”。');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060980252791934976, 2060980252787740672, '建议：需要配置MySQL同学请先把本文
        从头到尾看一遍再决定要不要采取本文，
        一是可以熟悉安装路数、二是如果不适
        合自己的实际情况则可以节约时间，
        去找更好的实例。
    （
    2018年5月13日
    03:37: - - 
    ）

**第一步：**把下载Zip包解压-
[下载地址：https://dev.mysql.com/downloads/mysql/](https://dev.mysql.com/downloads/mysql/)
![](https://img.yangmufa.cn/blog-article/26f51acda6034fff89025d124751d7c0.png)
![](https://img.yangmufa.cn/blog-article/4f6b3eb15c7d47989b6ca0d87995a53b.png)
![](https://img.yangmufa.cn/blog-article/0cca0f1e3c9f4502a155acb18bd29986.png)
**第二步：**解压到指定盘符-
![](https://img.yangmufa.cn/blog-article/e899530522494386be1448e75efc4f90.png)
解压后，（解压地址稍后会用）![在这里插入图片描述](https://i-blog.csdnimg.cn/blog_migrate/274ab3acb6446b7b035ce7f716399622.png)
**第三步：**解压过后根目录 创建一个名为“ my.ini  ” 的文件，然后用记事本打开编辑 加入 如下代码
```
[mysqld]
basedir = E:\mysql-8.0.16-winx64
datadir = F:\mysqlData-8.0.16-winx64\data
port = 3306
```
![](https://img.yangmufa.cn/blog-article/2aacb305712443438e6c83550a8bb823.png)
第四步：配置环境变量-
（1）-复制配置环境需要的路径值
		1、找到mysql安装复制路径精确到bin，即解压的路径。（例如  E:\mysql-8.0.16-winx64\bin）
![](https://img.yangmufa.cn/blog-article/5eea18a6e27d402e892e9ead7dcc1796.png)
（2）-开始配置环境变量
![](https://img.yangmufa.cn/blog-article/7b4100813de249df9886cd0d433ca686.png)
1、找到 我的电脑 右击 ，点击 属性
2、点击 高级系统设置
3、点击环境变量
4、点击系统变量里面的 Path
5、点击 编辑
6、点击新建
7、设置值为 mysql 安装路径精确到bin目录 即刚才复制得解压路径（例如  1、找到 我的电脑 右击 ，点击 属性）
![](https://img.yangmufa.cn/blog-article/416cc9cf59a34477a069c742b2e2ec94.png)
第五步：用管理员方式打开dos命令行进行安装操作-
（1）用管理员打开命令行的方法：
      1、win + R 输入 com 回车
      ![](https://img.yangmufa.cn/blog-article/f084e1f991ae4faaa6287b2d5b603b20.png)
      2、在任务栏知道dos''命令运行图标把鼠标移动到该位置右键，然后把鼠标移动到命令提示符上再右键及可以看见 以管理员身份运行 点		击他即可，（如下图）
      、
      ![](https://img.yangmufa.cn/blog-article/c881742257f54bafaf1919e5b5d76192.png)
（2）、
		1、进入后  输入 “  E:  ” 把路径切换到 E 盘，（具体是哪个看自己的实际安装路径）如下图：
		![](https://img.yangmufa.cn/blog-article/f12e7b0f917a402999800759c77818fc.png)
     2、输入 “  `cd  E:\mysql-8.0.16-winx64\bin`  ”  ，cd后面为安装路径（精确到 bin 目录，例如  具体是哪个看自己的实际安装路径）如下图
     ![](https://img.yangmufa.cn/blog-article/a20f90c9426a45459204c623db0427ca.png)
     3、    
     【1】、在命令行中进入bin目录后，输入“ mysqld --initialize --console  ”进行初始化数据库，正确的返回应为以下信息，注意 root@localhost后的字符串需要记下来他是root初始密码，非常重要，非常，非常，非常！，后边要用到。
    .
		执行 ‘  mysqld --initialize --console  '' 如下图
![](https://img.yangmufa.cn/blog-article/6906ddfaee0145f3bc0651b8465adc64.png)
	【2】、注意：在“  mysqld --initialize --console  ”，回车后这时会在‘mysql-8.0.15-winx64''目录下生成一个‘data''目录(我的当初设置在 	F:\mysqlData-8.0.16-winx64 )：如下图
![](https://img.yangmufa.cn/blog-article/382ace942d2c45f18145980eca3030a4.png)
3、登录  
       1、执行命令  mysql -u root -p
        2、输入密码     详情如下图：
       ![](https://img.yangmufa.cn/blog-article/a6a86c4c2e864ca6aa236fd5704b3459.png)
			注意：如果在执行登录操作时在保证密码没有错误的情况下出现   
			ERROR 2003 (HY000): Can''t connect to MySQL server on ''localhost'' (10061) 错误
			即：错误2003 (HY000):不能连接到MySQL服务器“localhost”(10061)
			![](https://img.yangmufa.cn/blog-article/3d51245cca464f4eba698fd439ea34bd.png)
			则可能是因为mysql服务没有开启，开启服务命令：   net start mysql  
            ![](https://img.yangmufa.cn/blog-article/4d596b5a0352463f92734e028fdc6a31.png)
			3、执行  net start mysql 命令成功启动服务后在保证密码没有输入错误的情况下依然存在 
			ERROR 2003 (HY000): Can''t connect to MySQL server on ''localhost'' (10061) 错误
	如果成功启动了服务并登输入密码正确的情况下依然登录，则可能是注册表服务冲突这需要删除注册里以前安装MySQL时残留的注册表相关服务，再重新安装MySQL服务

   4、安装服务
		接下来安装服务，使用mysqld --install [服务名]，这里服务可以不写，默认为mysql，如果电脑上安装有多个服务，这里就可以进行不       同的命名进行区分或删除其他同名不需要的服务，安装成功提示如下图：
	 ![](https://img.yangmufa.cn/blog-article/0b61ac161dbf425a8c9413652476b791.png)
5、登录：输入mysql -u root -p  然后在password： 后面输入 密码 回车即可（密码为上面步骤的初始密码）
![](https://img.yangmufa.cn/blog-article/1a45235380724a4bab76725064187fd6.png)

6、如果成功启动且安装了服务还是 ERROR 2003 (HY000): Can''t connect to MySQL server on ''localhost'' (10061) 错误需要删除注册表再安装服务再尝试登陆，删除支持表如下：
		
		（1）、注册表删除， win + R 输入  regedit   回车打开注册表 ，如下图依次点开然后往下翻，找到前缀为 MySQL 的全部右键点击删掉，一个不留。
![](https://img.yangmufa.cn/blog-article/f4a807d6f36e4f559d027177ff361830.png)


（2）、保证删除干净后再次重新安装服务 命令行执行 `mysqld --install`  
![](https://img.yangmufa.cn/blog-article/e14a4ee270a4486086c3d2657c30f2c5.png)
The service already exists!
The current server installed: E:\MySQL-8.0.16-winx64\bin\mysqld MySQL
表示注册表服务安装成功！
然后关闭注册表再次按上图步骤打开则可看见注册表里再次出现了MySQL
![](https://img.yangmufa.cn/blog-article/c13372dd96e5434a8f4f899d9510d755.png)
则说明注册表上午安装成功！

第六步：登陆：-（在经过这么多问题折腾后选择应该是没问题了接下来开始登陆吧，哈哈）
1、在命令行执行   `mysql -u root -p`  然后输入密码   如下图则是登陆成功的
![](https://img.yangmufa.cn/blog-article/fc57a8c492fc4411b357a093d9f9839e.png)
2、修改密码
		下面直接演示正确修改root密码的步骤：
　　二、使用ALTER修改root用户密码,方法为 
　　ALTER user ''root''@''localhost'' IDENTIFIED BY ''新密码'' 
　　代码命令如下：

    ALTER user ''root''@''localhost'' IDENTIFIED BY ''Cliu123#'';

 		
 如果提示 Query OK, 0 rows affected (0.27 sec) 则表示修改成功 如下图
		![](https://img.yangmufa.cn/blog-article/0d524530c48948648db431d28158c7ef.png)

　　**修改成功； 重新使用用户名密码登录即可；**


**此处有两点需要注意：**

1、不需要`flush privileges`来刷新权限。
2、密码要包含大写字母，小写字母，数字，特殊符号。
3、哎哟还有请一定记得在操作时记得要注意 空格 和 -  的使用，上文很多的地方都存在有，特此提醒！
4、还有一定不要采取如下形式该密码：

    use mysql; 
        update user set authentication_string="newpassword" where user="root";

至此，安装mysql和修改root密码告一段落。

    **总结**
    
    以上所述是小编给大家介绍的安装
    mysql 8.0.16、分析和处理遇到
    的问题以及修改root密码。
   由于是新手在此过程中遇
   到问题需要花大半夜的时间
   找解决方案和验证 
   希望对大家有所帮助，
    如果大家有任何疑问
    或建议请给我留言，
    在此也非常感谢大家的支持！');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060980770339688448, 2060980770335494144, '**建议：**  

1、手机上图片无法显示时可转用电脑打开即可。  

2、当手机端显示不全，可 左右 来回 滑动屏幕。  

3、需要配置MySQL同学请先把本文从头到尾的  

看一遍再决定要不要采取本文，一是可以熟悉安装路数、  

二是如果不适合自己的实际情况则可以节约时间，去找更好的案例。  
（
2018年5月13日
03:37: - -
）  
**第一步：把下载Zip包解压**  
下载地址：https://dev.mysql.com/downloads/mysql/ 
![](https://img.yangmufa.cn/blog-article/b609bc35b16b47a6a5bdb4dd13e373ee.png)
![](https://img.yangmufa.cn/blog-article/96563e775ee043aca7777488302dac53.png)
![](https://img.yangmufa.cn/blog-article/3da0e6f4bd654968bf5801201509c4db.png)
**第二步：解压到指定盘符-**  
解压后，（解压地址稍后会用）
![](https://img.yangmufa.cn/blog-article/d049b3aba1334dca9674b3b4b6f6c42f.png)
**第三步：解压过后根目录 创建一个名为“ my.ini  ” 的文件，然后用记事本打开编辑 加入 如下代码**  
[mysqld]
basedir = E:\mysql-8.0.16-winx64
datadir = F:\mysqlData-8.0.16-winx64\data
port = 3306
![](https://img.yangmufa.cn/blog-article/a1fca23d9bb34a00ba03f3ecb9b5e06f.png)
![](https://img.yangmufa.cn/blog-article/2afa239b15254e0ba652474cbf46f98b.png)
**第四步：配置环境变量-**  
（1）-复制配置环境需要的路径值  
1、找到mysql安装复制路径精确到bin，即解压的路径。（例如  E:\mysql-8.0.16-winx64\bin）
![](https://img.yangmufa.cn/blog-article/12b2a4b877bc45f6903d9d646e67c1c2.png)
（2）-开始配置环境变量  
![](https://img.yangmufa.cn/blog-article/2203254a58014ecbb26ed04d56595e76.png)
1、找到 我的电脑 右击 ，点击 属性  
2、点击 高级系统设置  
3、点击环境变量  
4、点击系统变量里面的 Path  
5、点击 编辑  
6、点击新建  
7、设置值为 mysql 安装路径精确到bin目录 即刚才复制得解压路径（例如  1、找到 我的电脑 右击 ，点击 属性）
![](https://img.yangmufa.cn/blog-article/10ff6687d666467cbf11871b05086962.png)
**第五步：用管理员方式打开dos命令行进行安装操作-**  
（1）用管理员打开命令行的方法：  
1、win + R 输入 com 回车  
![](https://img.yangmufa.cn/blog-article/6cd1fbfc052c488f9081dc429704cb68.png)
2、在任务栏知道dos''命令运行图标把鼠标移动到该位置右键，然后把鼠标移动到命令提示符上再右键及可以看见 以管理员身份运行 点        击他即可，（如下图）
![](https://img.yangmufa.cn/blog-article/72c1bf1efc1b4b5ea11bfa62985f8ef2.png)
（2）、  
1、进入后  输入 “  E:  ” 把路径切换到 E 盘，（具体是哪个看自己的实际安装路径）如下图：  
![](https://img.yangmufa.cn/blog-article/1afb083909e84091a6bf1ca84820e36e.png)
2、’ 输入 ：
```shell
cd  E:\mysql-8.0.16-winx64\bin
```
cd后面为安装路径（精确到 bin 目录，例如  具体是哪个看自己的实际安装路径）如下图 ‘
![](https://img.yangmufa.cn/blog-article/01fc7c922c5744be9e9aac0d6145bac0.png)
3、  
【1】、在命令行中进入bin目录后，输入“ mysqld --initialize --console  ”进行初始化数据库，正确的返回应为以下信息，注意 root@localhost后的字符串需要记下来他是root初始密码，非常重要，非常，非常，非常！，后边要用到。  
执行  
```sql
mysqld --initialize --console
```
如下图 ''
![](https://img.yangmufa.cn/blog-article/0a76fec1bf8245ee8048d2b4b936df24.png)
【2】、注意：在“  mysqld --initialize --console  ”，回车后这时会在‘mysql-8.0.15-winx64''目录下生成一个‘data''目录(我的当初设置在     F:\mysqlData-8.0.16-winx64 )：如下图
![](https://img.yangmufa.cn/blog-article/10d9e77ea1af42088a2bd450a3933928.png)
3、登录  
1、执行命令  
```sql
mysql -u root -p
```
2、输入密码     详情如下图：
![](https://img.yangmufa.cn/blog-article/ee804f4d59e54095bf7430372ac12d7d.png)
注意：如果在执行登录操作时在保证密码没有错误的情况下出现
ERROR 2003 (HY000): Can''t connect to MySQL server on ''localhost'' (10061) 错误
即：错误2003 (HY000):不能连接到MySQL服务器“localhost”(10061)
![](https://img.yangmufa.cn/blog-article/c158afae1feb4c41855529925b96a77d.png)
则可能是因为mysql服务没有开启，开启服务命令：   net start mysql
![](https://img.yangmufa.cn/blog-article/eb2c672b48c1442a8ce34f673aa792fd.png)
3、执行  net start mysql 命令成功启动服务后在保证密码没有输入错误的情况下依然存在
ERROR 2003 (HY000): Can''t connect to MySQL server on ''localhost'' (10061) 错误
如果成功启动了服务并登输入密码正确的情况下依然登录，则可能是注册表服务冲突这需要删除注册里以前安装MySQL时残留的注册表相关服务，再重新安装MySQL服务

4、安装服务
接下来安装服务，使用mysqld --install [服务名]，这里服务可以不写，默认为mysql，如果电脑上安装有多个服务，这里就可以进行不       同的命名进行区分或删除其他同名不需要的服务，安装成功提示如下图：
![](https://img.yangmufa.cn/blog-article/da4914d86e8941ad8399b646e252625e.png)

5、登录：输入mysql -u root -p  然后在password： 后面输入 密码 回车即可（密码为上面步骤的初始密码）
![](https://img.yangmufa.cn/blog-article/b24545fb50fa4a1ab14a523002956c7a.png)

6、如果成功启动且安装了服务还是 ERROR 2003 (HY000): Can''t connect to MySQL server on ''localhost'' (10061) 错误需要删除注册表再安装服务再尝试登陆，删除支持表如下：

（1）、注册表删除， win + R 输入  regedit   回车打开注册表 ，如下图依次点开然后往下翻，找到前缀为 MySQL 的全部右键点击删掉，一个不留。
![](https://img.yangmufa.cn/blog-article/6497786d76204c43be216d4c741003ab.png)
（2）、保证删除干净后再次重新安装服务 命令行执行    mysqld --install
![](https://img.yangmufa.cn/blog-article/dc8f63238b9c4d1cbff2b06017f34227.png)
The service already exists!
The current server installed: E:\MySQL-8.0.16-winx64\bin\mysqld MySQL
表示注册表服务安装成功！
然后关闭注册表再次按上图步骤打开则可看见注册表里再次出现了MySQL
![](https://img.yangmufa.cn/blog-article/5fea625dc30643e09ae65289e63ff5b2.png)
则说明注册表上午安装成功！
![](https://img.yangmufa.cn/blog-article/f7132b74bbc84a85804d7b7accd9031b.png)
**第六步：登陆：-**  
1、在命令行执行  
```sql
mysql -u root -p
``` 
然后输入密码   如下图则是登陆成功的
![](https://img.yangmufa.cn/blog-article/a5659878e6014d95a3d6e5b0eb432888.png)
2、修改密码  
下面直接演示正确修改root密码的步骤：
二、使用ALTER修改root用户密码,方法为  
ALTER user ''root''@''localhost'' IDENTIFIED BY ''新密码''
代码命令如下：

ALTER user ''root''@''localhost'' IDENTIFIED BY ''Cliu123#'';

如果提示 Query OK, 0 rows affected (0.27 sec) 则表示修改成功 如下图
![](https://img.yangmufa.cn/blog-article/43589c9c3a7541deb8465a98954613ca.png)
修改成功； 重新使用用户名密码登录即可；

此处有两点需要注意：

1、不需要`flush privileges`来刷新权限。  
2、密码要包含大写字母，小写字母，数字，特殊符号。  
3、哎哟还有请一定记得在操作时记得要注意 空格 和 -  的使用，上文很多的地方都存在有，特此提醒！  
4、还有一定不要采取如下形式该密码：  

use mysql;
update user set authentication_string="newpassword" where user="root";

​');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060905063295094784, 2060905063282511872, '# .Net-Core-Framework的历史及web和MVC的关系

## .Net/.Net Core/.Net Framework 的历史

![](https://img.yangmufa.cn/article-cover-temp/.net-core-Framework%E5%85%B3%E7%B3%BB%E5%9B%BE.png)
![](https://img.yangmufa.cn/blog-article/.Net%E6%9E%B6%E6%9E%84%E5%9B%BE.webp)


.NET Framework、.NET Core 和 .NET 是 Microsoft 开发的不同版本的软件开发平台。它们有一些共同的特性，但也有一些重要的区别。

1. **.NET Framework**:
    - .NET Framework 是最早推出的版本，最初发布于 2002 年。它是一个用于构建和运行 Windows 应用程序的框架。
    - .NET Framework 依赖于 Windows 操作系统，并且只能在 Windows 上运行。
    - 它提供了广泛的类库和功能，包括 Windows Forms、[ASP.NET](http://asp.net/)、[ADO.NET](http://ado.net/) 等，以支持各种类型的应用程序开发。
    - 最终版本是 .NET Framework 4.8，发布于2019年4月，是 .NET Framework 的最后一个主要版本。Microsoft 宣布不会发布更高版本的 .NET Framework，未来主要集中在 .NET Core 和 .NET 5+ 上的开发。
2. **.NET Core**:
    - .NET Core 是微软于2016年推出的全新开源的跨平台框架。
    - [与.NET](http://xn--jhq.net/) Framework不同，.NET Core 可以在 Windows、macOS 和 Linux 等多个平台上运行。
    - .NET Core 更加轻量化、模块化，并且具有更快的性能。它专注于云原生应用程序和微服务架构。
    - .NET Core 的最终版本是 .NET Core 3.1，发布于2019年12月。这是 .NET Core 项目的最后一个稳定长期支持版本（LTS）。随后，.NET Core 项目合并到 .NET 5+ 中，形成统一的 .NET 平台。
3. **.NET**:
    - .NET 是一个更广泛的术语，用来指代整个 .NET 平台生态系统，包括 .NET Framework、.NET Core 和其他相关工具、技术和语言。
    - 在未来的版本中，微软可能会进一步整合 .NET Framework 和 .NET Core，使得它们更加统一，以提供更好的开发体验和跨平台支持。
4. **.NET 5**:
    - .NET 5 是 .NET Core 3.1 之后的第一个发布版本，于2020年11月发布。随后的版本为 .NET 6、.NET 7 等。从 .NET 5 开始，Microsoft 将 .NET Core、.NET Framework 和 Xamarin 合并为一个单一平台，统称为 .NET。

总的来说，.NET Framework 主要用于传统的 Windows 应用程序开发，而 .NET Core 则更适合于跨平台和云原生应用程序开发。随着时间的推移，微软正逐渐将开发重心转移到 .NET Core

### 关系与演化路径

- **ASP 到 ASP.NET**: ASP.NET是对ASP的彻底重写，提供了更强大的功能和现代化编程支持，完全基于.NET Framework。
- **ASP.NET 到 ASP.NET Core**: ASP.NET Core是对ASP.NET的重写，基于.NET Core，具备跨平台、高性能、现代化开发特性。ASP.NET Core与ASP.NET虽然在名字上相似，但它们的底层实现和架构有很大区别。
- **.NET Framework 到 .NET Core**: .NET Core是.NET Framework的跨平台版本，解决了后者只能在Windows上运行的局限性，并进一步提升了性能和灵活性。

### .NET Framework 版本历史

.NET Framework 是微软推出的一个全面的开发平台，用于构建和运行各种类型的应用程序，包括桌面应用、Web应用、移动应用等。以下是 .NET Framework 的版本历史及命名方式.

1. **.NET Framework 1.0**
    - **发布日期**: 2002年2月13日
    - **主要特性**: 初次发布，包含CLR（公共语言运行时）、基础类库、ASP.NET和ADO.NET。
2. **.NET Framework 1.1**
    - **发布日期**: 2003年4月24日
    - **主要特性**: 增加了移动设备支持和OOP（面向对象编程）的改进。
3. **.NET Framework 2.0**
    - **发布日期**: 2005年11月7日
    - **主要特性**: 引入了泛型、匿名方法、部分类和数据绑定等功能。
4. **.NET Framework 3.0**
    - **发布日期**: 2006年11月6日
    - **主要特性**: 引入了WPF（Windows Presentation Foundation）、WCF（Windows Communication Foundation）、WF（Windows Workflow Foundation）和CardSpace。
5. **.NET Framework 3.5**
    - **发布日期**: 2007年11月19日
    - **主要特性**: 增加了LINQ（语言集成查询）、表达式树和扩展方法。
6. **.NET Framework 4.0**
    - **发布日期**: 2010年4月12日
    - **主要特性**: 引入了并行编程和动态语言运行时。
7. **.NET Framework 4.5**
    - **发布日期**: 2012年8月15日
    - **主要特性**: 改进了异步编程模型，引入了ASP.NET Web API和增强的WPF、WCF功能。
8. **.NET Framework 4.5.1**
    - **发布日期**: 2013年10月17日
    - **主要特性**: 进一步增强了性能和调试工具。
9. **.NET Framework 4.5.2**
    - **发布日期**: 2014年5月5日
    - **主要特性**: 小幅改进，增强了稳定性和性能。
10. **.NET Framework 4.6**
    - **发布日期**: 2015年7月20日
    - **主要特性**: 引入了RyuJIT编译器和新的加密API。
11. **.NET Framework 4.6.1**
    - **发布日期**: 2015年11月30日
    - **主要特性**: 增强了WPF、WCF和ASP.NET的功能。
12. **.NET Framework 4.6.2**
    - **发布日期**: 2016年8月2日
    - **主要特性**: 改进了.NET Core兼容性和高DPI支持。
13. **.NET Framework 4.7**
    - **发布日期**: 2017年4月5日
    - **主要特性**: 增加了对Windows 10新特性的支持，改进了性能。
14. **.NET Framework 4.7.1**
    - **发布日期**: 2017年10月17日
    - **主要特性**: 改进了对.NET Standard 2.0的支持。
15. **.NET Framework 4.7.2**
    - **发布日期**: 2018年4月30日
    - **主要特性**: 增强了诊断工具和性能改进。
16. **.NET Framework 4.8**
    - **发布日期**: 2019年4月18日
    - **主要特性**: 增强了高DPI支持、访问控制和性能。

#### 命名规则

- **版本号**: .NET Framework 的版本号通常由三部分组成，例如：`4.7.2`，其中`4`代表主版本号，`7`代表次版本号，`2`代表修订号。
- **累积更新**: 在某些主版本和次版本之间，微软会发布累积更新（如4.5.1，4.5.2）以包含新特性和修复。

#### 总结

- **早期版本（1.x - 3.5）**: 主要是功能的初步实现和基础设施的搭建，如CLR、ASP.NET、WPF、WCF等。
- **4.x 系列**: 主要是性能提升和与现代开发需求的对齐，如异步编程、并行编程、跨平台兼容性等。
- **命名方式**: 使用清晰的版本号表示版本的演进和特性的增加，从而帮助开发者了解每个版本的新增功能和改进。

.NET Framework 提供了一个全面而稳健的平台，用于构建各种类型的应用程序。随着 .NET Core 的发展和统一，.NET 平台继续向跨平台和高性能方向发展。

### .NET Core 版本历史

.NET Core 是微软为实现跨平台支持和现代化开发需求推出的跨平台、高性能框架。`在2020年11月发布的 .NET 5 之后，.NET Core 与 .NET Framework 统一为 .NET`。以下是 .NET Core 和 .NET 的版本历史及命名方式.

1. **.NET Core 1.0**
    - **发布日期**: 2016年6月27日
    - **主要特性**: 首次推出，支持Windows、Linux和macOS，包含基础库和运行时。
2. **.NET Core 1.1**
    - **发布日期**: 2016年11月16日
    - **主要特性**: 增加了对更多APIs的支持，改进性能和工具。
3. **.NET Core 2.0**
    - **发布日期**: 2017年8月14日
    - **主要特性**: 大幅扩展API集合，引入.NET Standard 2.0，提升库的兼容性和移植性。
4. **.NET Core 2.1**
    - **发布日期**: 2018年5月30日
    - **主要特性**: 长期支持版本（LTS），改进性能，增加新工具（如gRPC支持）和APIs。
5. **.NET Core 2.2**
    - **发布日期**: 2018年12月4日
    - **主要特性**: 增强性能和诊断功能，引入健康检查API。
6. **.NET Core 3.0**
    - **发布日期**: 2019年9月23日
    - **主要特性**: 支持Windows桌面应用（WinForms和WPF），改进了.NET Core中的gRPC、C# 8.0特性和EF Core 3.0。
7. **.NET Core 3.1**
    - **发布日期**: 2019年12月3日
    - **主要特性**: 长期支持版本（LTS），修复了3.0中的一些问题并改进了性能和稳定性。

#### .NET 版本历史（统一后的版本）

1. **.NET 5**
    - **发布日期**: 2020年11月10日
    - **主要特性**: 统一了.NET Core和.NET Framework，引入了单一的SDK、库和运行时，提高性能，支持更多的应用类型。
2. **.NET 6**
    - **发布日期**: 2021年11月8日
    - **主要特性**: 长期支持版本（LTS），增强跨平台支持和性能，引入了更多的语言特性和开发工具，改进了MAUI（跨平台UI框架）。
3. **.NET 7**
    - **发布日期**: 2022年11月8日
    - **主要特性**: 继续改进性能和工具链，增强云原生应用支持，引入了更多的APIs和改进的开发体验。
4. **.NET 8**
    - **预计发布日期**: 2023年11月
    - **主要特性**: 进一步提升性能，改进开发者体验，增强对现代化应用架构（如微服务和容器）的支持。

#### 命名规则

- **.NET Core 1.x - 3.x**: 使用版本号，如1.0, 1.1, 2.0, 2.1, 2.2, 3.0, 3.1。
- **.NET 5 及之后**: 直接使用数字版本号，不再使用“Core”后缀，如.NET 5, .NET 6, .NET 7, .NET 8。

#### 总结

- **.NET Core 1.0 - 3.1**: 是.NET跨平台化和现代化的起点，命名为.NET Core。
- **.NET 5 及之后**: 统一命名为.NET，简化了版本号，并融合了.NET Framework和.NET Core的功能，提供单一的开发平台。

这种命名和版本演进反映了微软从早期的独立平台逐步走向跨平台统一的战略。

### .NET Framework 和 NET Core生态成员

#### .NET Framework 平台包含的组件和特性

.NET Framework 是一个用于 Windows 的开发平台，它包含以下主要组件和特性：

1. **CLR (Common Language Runtime)**
    - 管理代码执行，提供垃圾收集、异常处理、类型安全、线程管理和安全性。
2. **BCL (Base Class Library)**
    - 基础类库，提供了常用功能，如集合、I/O、字符串处理、网络、XML处理和数据访问。
3. **ASP.NET**
    - 用于构建动态网页和 Web 应用程序的框架。
4. **ADO.NET**
    - 数据访问技术，用于与数据库进行交互。
5. **WPF (Windows Presentation Foundation)**
    - 用于构建桌面应用程序的图形子系统，支持丰富的用户界面、图形和媒体内容。
6. **WinForms (Windows Forms)**
    - 用于构建桌面应用程序的图形界面库。
7. **WCF (Windows Communication Foundation)**
    - 用于构建分布式和服务导向应用程序的框架。
8. **WF (Windows Workflow Foundation)**
    - 用于构建工作流和业务流程的框架。
9. **Entity Framework**
    - 对象关系映射（ORM）框架，用于数据访问。
10. **Visual Studio IDE**
    - 开发工具，用于创建、调试和部署 .NET 应用程序。

#### .NET Core 平台包含的组件和特性

.NET Core 是一个跨平台、开源的开发平台，支持 Windows、macOS 和 Linux。它包含以下主要组件和特性：

1. **CoreCLR**
    - .NET Core 的运行时，提供垃圾收集、JIT 编译和类型系统。
2. **CoreFX**
    - 基础类库，类似于 .NET Framework 的 BCL，提供常用功能，如集合、I/O、字符串处理、网络、XML处理和数据访问。
3. **ASP.NET Core**
    - 用于构建现代 Web 应用程序和服务的跨平台框架。
4. **Entity Framework Core**
    - 跨平台的 ORM 框架，用于数据访问。
5. **CLI (Command Line Interface)**
    - 用于创建、构建、运行和发布 .NET Core 应用程序的命令行工具。
6. **跨平台支持**
    - 支持在 Windows、macOS 和 Linux 上运行和开发。
7. **NuGet 包管理**
    - 用于管理和分发 .NET Core 库和依赖项。
8. **轻量级和模块化**
    - 允许开发者只包含应用程序所需的库和组件，减少应用程序的体积。
9. **高性能和云优化**
    - 针对云原生应用和微服务架构进行了优化。
10. **Visual Studio Code 和 Visual Studio IDE**
    - 跨平台的开发工具，支持 .NET Core 的开发、调试和部署。

#### 对比和总结

- **平台依赖**:
    - .NET Framework 主要用于 Windows 平台。
    - .NET Core 是跨平台的，支持 Windows、macOS 和 Linux。
- **应用类型**:
    - .NET Framework 适合现有的 Windows 桌面应用和企业级应用。
    - .NET Core 适合现代化的云原生应用、微服务和跨平台应用。
- **性能和扩展性**:
    - .NET Core 具有更好的性能和扩展性，适合高性能和大规模分布式系统。
- **开源和社区**:
    - .NET Core 是完全开源的，拥有活跃的社区支持和贡献。
- **未来方向**:
    - .NET Core 是未来的发展方向，.NET 5 开始统一 .NET Framework 和 .NET Core，形成一个统一的 .NET 平台。

通过对比可以看出，.NET Core 在现代应用开发中的优势更加明显，尤其是在跨平台和高性能应用方面，而 .NET Framework 仍然在需要紧密集成 Windows 的传统应用中占有一席之地。

### 安装

#### 安装 .NET Framework 组件

.NET Framework 通常作为一个整体安装包进行安装，包含了所有必要的组件。以下是安装步骤：

1. **从官方网站下载 .NET Framework 安装程序**：
    - 访问微软官方网站（[.NET Download](https://dotnet.microsoft.com/download/dotnet-framework)）下载适合的 .NET Framework 版本。
2. **运行安装程序**：
    - 下载后，运行安装程序并按照屏幕提示进行安装。安装程序将自动安装所有必需的组件，如 CLR、BCL、ASP.NET 等。
3. **使用 Visual Studio 安装**：
    - 如果使用 Visual Studio 开发环境，可以通过 Visual Studio 安装程序选择并安装适合的 .NET Framework 版本。Visual Studio 会自动配置和安装所需的组件。

#### 安装 .NET Core / .NET 5+ 组件

.NET Core 和 .NET 5+ 是统一安装的 SDK（Software Development Kit），包含了所有必要的工具和组件。以下是安装步骤：

1. **从官方网站下载 .NET SDK**：

    - 访问微软官方网站（[.NET Download](https://dotnet.microsoft.com/download)）下载适合的 .NET SDK 版本。

2. **运行安装程序**：

    - 下载后，运行安装程序并按照屏幕提示进行安装。安装程序将自动安装所有必需的组件，如 CoreCLR、CoreFX、ASP.NET Core 等。

3. **使用命令行工具安装**：

    - 安装后，可以通过命令行工具 `dotnet` 进行开发和管理。例如，创建新项目、添加依赖项、编译和运行应用程序等。

    - 示例命令：

      ```
      bashCopy codedotnet new console -o MyApp    # 创建新的控制台应用程序
      dotnet build MyApp             # 编译应用程序
      dotnet run MyApp               # 运行应用程序
      ```

4. **使用 Visual Studio Code 或 Visual Studio 安装**：

    - 安装 .NET SDK 后，可以使用 Visual Studio Code 或 Visual Studio 进行开发。两者都提供了良好的支持和集成。
    - 在 Visual Studio 中，选择适合的 .NET Core 或 .NET 5+ 项目模板进行创建。

#### 安装特定组件  

- NuGet 包管理器：  

    - .NET Core 和 .NET 5+ 使用 NuGet 包管理器来管理额外的库和依赖项。可以通过命令行或 IDE 内置的 NuGet 管理工具来安装。

    - 示例命令：

      ```
      bash
      Copy code
      dotnet add package Newtonsoft.Json    # 安装 Newtonsoft.Json 库
      ```

#### 统一安装 vs 分别安装  

- **.NET Framework**：
    - 作为整体安装包进行安装，一次性包含所有组件。
- **.NET Core / .NET 5+**：
    - 通过统一的 SDK 安装，包含所有核心组件和工具。额外的库和依赖项可以通过 NuGet 单独安装。

#### 总结  

- **.NET Framework** 是一个整体安装包，包含所有核心组件，适合 Windows 平台。
- **.NET Core / .NET 5+** 通过统一的 SDK 安装，包含核心组件和工具，支持跨平台开发。额外的库和依赖项可以通过 NuGet 管理。

这使得安装和管理 .NET Core / .NET 5+ 更加灵活和模块化，适应现代开发需求。


## ASP.NET Web 和 MVC 的关系  
Web 是一个宽泛的术语,而 asp.net web就是为了实现web的一直开发框架集其中包含了Web Forms、 Web Pages等,MVC和前后端分离等都是在使用开发框架时的一种开发模式.

### Web 

在Java生态中实现Web这个概率的技术为spring和jsp等，在C#生态中实现Web这个概率的技术为 [ASP.NET](http://asp.net/) Web 。  
具体来说，[ASP.NET](http://asp.net/) Web 可以指代几种不同的技术和框架，主要包括：

#### [ASP.NET](http://asp.net/) Web Forms：
    - 基于事件驱动的 Web 应用程序开发模型。
    - 使用 **.aspx后缀名** 文件作为视图，并包含后台代码文件通常是 **.aspx.cs 或 .aspx.vb 后缀名**。
    - 提供丰富的服务器控件和事件模型，适合快速开发和复杂的用户交互。
    - **为什么是Forms(窗体界面)**: 早期微软的.net framework 只支持Windows平台,所以web前端就是窗体界面。
#### [ASP.NET](http://asp.net/) Web Pages：
    - 使用 Razor 语法(**.cshtml后缀名的文件**)的一种轻量级 Web 开发模型，类似于 PHP 或 Classic ASP。
    - 允许直接在 **.cshtml文件后缀名** 文件中的HTML代码中嵌入 C# 代码，并生成动态内容。
### MVC
**他本身不是什么技术**而是基于模型-视图-控制器（MVC）的**架构模式**,在ASP.NET Web Forms和ASP.NET Web Pages同样可以使用MVC模式来开发,同理JavaWeb中的jsp和spring等也可以使用这种方式来开发。
#### [ASP.NET](http://asp.net/) MVC：
    
    - 分离关注点，通过控制器处理用户请求并选择适当的视图来呈现数据。
    - 使用 Razor 视图引擎(**.cshtml后缀名**)创建动态视图，推崇良好的代码组织和可测试性。
#### [ASP.NET](http://asp.net/) Core MVC：
    - [ASP.NET](http://asp.net/) Core 框架中的 MVC 实现，具有跨平台、高性能和现代化的特点。
    - 提供了与传统 [ASP.NET](http://asp.net/) MVC 相似的开发模式和特性，但具有更轻量级、更灵活和更高性能的优势。

[ASP.NET](http://asp.net/) Web 技术是 Microsoft 提供的一系列工具和框架，用于构建现代化、高性能的 Web 应用程序。开发者可以根据项目需求和技术偏好选择合适的 [ASP.NET](http://asp.net/) Web 技术栈来开发应用程序。


## ASP.NET Web 技术的各种文件后缀名
### .asp 后缀的文件  
    - .asp 文件是经典 ASP（Active Server Pages）的文件扩展名。ASP 是一种由微软开发的服务器端脚本技术，用于动态生成和交互式地展示网页。ASP 使用 VBScript 或 JavaScript 作为服务器端脚本语言。通常，ASP 文件包含 HTML 和服务器端代码的混合，这些代码可以生成动态内容并与数据库或其他服务器资源交互。
    - .asp 基于经典 ASP 技术，使用 VBScript 或 JavaScript。
    - .asp 在早期 Web 开发中使用较多，现在多数已被 ASP.NET 取代。

### .aspx 后缀的文件  
    - .aspx 文件是 ASP.NET 的文件扩展名。ASP.NET 是微软推出的用于构建动态 Web 应用程序的技术框架。与经典 ASP 不同，ASP.NET 使用 C#、VB.NET 等编程语言作为服务器端脚本语言。.aspx 文件包含 HTML、ASP.NET 控件以及服务器端代码，这些代码通过事件驱动模型响应用户交互和其他请求。
    - .aspx 基于 ASP.NET 框架，使用 C#、VB.NET 等作为服务器端脚本语言。
    - .aspx 是 ASP.NET 应用程序中最常见的文件类型，用于构建复杂的 Web 应用程序。
### .cshtml 后缀的文件  
    - .cshtml 文件是 Razor 视图引擎使用的文件扩展名。Razor 是 ASP.NET MVC 框架中的一种视图引擎，允许将 C# 代码和 HTML 代码混合在同一个文件中。.cshtml 文件通常包含 HTML 结构和 Razor 语法，Razor 语法允许在 HTML 中嵌入 C# 代码，以便动态生成内容并显示在客户端。
    - .cshtml 是 Razor 视图引擎的文件扩展名，结合了 C# 代码和 HTML 结构。
    - .cshtml 是 ASP.NET MVC 或 Razor Pages 中用来渲染视图的文件类型，支持通过 Razor 语法混合 C# 和 HTML。

所有这些文件类型都支持动态生成内容，但使用不同的服务器端脚本语言和技术。

总体而言，这些文件扩展名代表了不同时期和技术栈下的服务器端 Web 开发方式，各自有着特定的用途和优势。

### Razor  
Razor 文件后缀名是 **.cshtml**, 是由 Microsoft 开发的一种用于创建动态 Web 页面的视图引擎。它最初是为 ASP.NET MVC 框架设计的，但后来也被整合到 ASP.NET Core 中使用。
#### 主要特点和用途：
- 语法简洁性：
Razor 提供了一种简洁、直观的语法，允许开发者在 HTML 中嵌入 C# 代码，使得页面的动态内容生成和控制变得更加自然和简单。

- 代码混编：
Razor 允许在 HTML 页面中直接嵌入 C# 代码，使用 @ 符号标识，这使得数据绑定、条件逻辑和循环等操作可以直接在页面上进行。

- 强类型视图：
Razor 支持强类型视图，即通过将视图与特定的数据模型绑定，可以在视图中直接访问模型的属性和方法，提高了代码的可维护性和安全性。

- 部分视图和布局：
Razor 支持部分视图（Partial Views）和布局视图（Layout Views），使得页面结构的重用和管理变得更加方便和灵活。

- 集成性：
Razor 能够与不同版本的 ASP.NET 框架集成使用，包括 ASP.NET MVC、ASP.NET Core MVC 等，为开发者提供统一的视图渲染体验。

#### Razor 的工作原理：
Razor 通过识别 @ 符号后的 C# 代码段，并将其转换为合适的代码来处理。在 Razor 视图中，可以通过 @ 符号插入 C# 表达式、代码块或者调用服务和组件。以下是 Razor 的一些基本语法示例：

- 插入表达式：
```.cshtml
<p>Welcome, @User.Name!</p>
```

代码块：
```.cshtml
@if (User.IsLoggedIn){
    <p>Welcome back!</p>
}
```
- 循环：
```.cshtml
<ul>
    @foreach (var item in Model.Items)
    {
        <li>@item.Name</li>
    }
</ul>
```
- 部分视图：
```.cshtml
@Html.Partial("_PartialViewName")
```

通过这些语法，Razor 提供了一种优雅而强大的方式来创建动态的、高效的 Web 页面，同时保持了视图和逻辑的清晰分离。

## Web和传统开发模式与MVC开发模式关系总结  
Web和MVC都是概念,只不过MVC这个概念通常被用来服务Web这个概念,也就是说MVC这个理念是为了更好的理解和实现Web这个理念而存在的另一种新新思想,  
并且他们都有着实现这对应的技术框架,  
早期实现Web这个技术概念的是ASP.NET Web Pages、ASP.NET Web Forms等等  
而后期又发明了一种新的概念,而这个新的概念是在Web基础上升级而来的,他就是MVC,MVC同样也是一种概念

三者关系类似于一个顶级接口一个二级接口:

```text
Web 思想的接口
 |
 |
 | -----> 传统开发模式: 采用 ASP.NET Web Pages、ASP.NET Web Forms等技术框架 (实现了Web思想接口)
 |
 ----MVC 思想的接口 (继承了Web思想的接口的内容并且加入了自己额外的东西和修改)
      |
      |
      -----> MVC开发模式: 采用 ASP.NET MVC 技术框架 (实现了MVC接口-同时也间接实现了Web接口)
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060986300261076992, 2060986300256882688, '```c++
		int day,month,year=2019,i,sum=0;
		int months[12]={31,28,31,30,31,30,31,31,30,31,30,31};
		printf("1到12月的天数分别是：");
		for(i=0;i<12;i++){
			sum+=months[i];
			printf(" %d -",months[i]);
		}
		printf("共： %d 天\n\n",sum);
		if(sum!=365){
			printf("X 错误！！！年份的月数总天数与平润年的总天数不符！\n\n");
			return 0;
		}else sum=0;
		printf("input month(int):");
		scanf_s("%d",&month);
		printf("input day(int):");
		scanf_s("%d",&day);
		for(i=0;i<month-1;i++){
			sum+=months[i];
		}
		printf("\n2019这一年的第 %d 月的第 %d 天，\
			是这一年的第 %d 天。\n\n",month,day,sum+day);

```
结果（情况一）：  
![](https://img.yangmufa.cn/blog-article/34b7e20f8c36477cbaf7f16437332865.png)
结果（情况二）：  
![](https://img.yangmufa.cn/blog-article/03dfc55af3fa4768bccf3f33380b8a0a.png)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2100624243791368192, 2100624243778785280, '# NPOI 2.8.0 导出 Excel 图表：X、Y 轴标题不显示的排查与修复

使用 NPOI 导出 `.xlsx` 文件时，图表能够生成，但横、纵坐标轴标题没有显示。代码明明调用了 `SetTitle()`，后来又直接设置了底层 `CT_Title`，仍然没有生效。

通过检查 NPOI 2.8.0 的序列化实现，最终将轴标题改为“单元格引用 + 字符串缓存”，修复了标题 XML 的输出问题。


## 一、问题场景

使用 `XSSFWorkbook` 生成 Excel 文件，并通过 `XSSFDrawing` 创建折线图，预期显示以下内容：

| 元素 | 内容 |
| --- | --- |
| 图表标题 | 每周阅读统计 |
| X 轴标题 | 周次 |
| Y 轴标题 | 阅读页数(页) |
| 数据系列名称 | 示例阅读记录 |
| 工作表名称 | ChartData |


问题现象是：生成文件后打开图表，看不到 X、Y 轴标题。这里需要区分图表标题、坐标轴标题和数据系列名称，设置其中一个不会自动设置其他元素。

## 二、修改前：调用 SetTitle，并补写底层标题对象

### 有问题的实现

如下代码先调用 `SetTitle()`，再手动构造富文本标题。

```csharp
using System;
using System.Collections.Generic;
using System.IO;
using NPOI.OpenXmlFormats.Dml;
using NPOI.SS.Util;
using NPOI.XDDF.UserModel.Chart;
using NPOI.XSSF.UserModel;
using DmlChart = NPOI.OpenXmlFormats.Dml.Chart;

internal static class Program {
	private static void Main(){
		using var workbook = new XSSFWorkbook();
		var sheet = (XSSFSheet)workbook.CreateSheet("ChartData");
		var header = sheet.CreateRow(0);
		header.CreateCell(0).SetCellValue("周次");
		header.CreateCell(1).SetCellValue("阅读页数(页)");

		double[] weeks = { 1, 2, 3, 4, 5 };
		double[] pagesRead = { 30, 45, 40, 60, 75 };
		for (int i = 0; i < weeks.Length; i++) {
			var row = sheet.CreateRow(i + 1);
			row.CreateCell(0).SetCellValue(weeks[i]);
			row.CreateCell(1).SetCellValue(pagesRead[i]);
		}

		var drawing = (XSSFDrawing)sheet.CreateDrawingPatriarch();
		var chart = drawing.CreateChart(drawing.CreateAnchor(0, 0, 0, 0, 3, 1, 15, 21));
		chart.SetTitleText("每周阅读统计");

		var xAxis = chart.CreateCategoryAxis(AxisPosition.Bottom);
		var yAxis = chart.CreateValueAxis(AxisPosition.Left);
		xAxis.SetTitle("周次");
		yAxis.SetTitle("阅读页数(页)");
		yAxis.Crosses = AxisCrosses.AutoZero;
		xAxis.CrossAxis(yAxis);
		yAxis.CrossAxis(xAxis);

		var xValues = XDDFDataSourcesFactory.FromNumericCellRange(sheet, new CellRangeAddress(1, weeks.Length, 0, 0));
		var yValues = XDDFDataSourcesFactory.FromNumericCellRange(sheet, new CellRangeAddress(1, weeks.Length, 1, 1));
		var data = (XDDFLineChartData<double, double>)chart.CreateData<double, double>(ChartTypes.LINE, xAxis, yAxis);
		var series = (XDDFLineChartData<double, double>.Series)data.AddSeries(xValues, yValues);
		series.SetTitle("示例阅读记录", null);
		series.SetMarkerStyle(MarkerStyle.Circle);
		series.SetSmooth(true);
		chart.Plot(data);

		// 问题路径：用手动构造的富文本覆盖轴标题。
		var axes = chart.GetCTChart().plotArea;
		axes.catAx[0].title = CreateBrokenTitle("周次");
		axes.valAx[0].title = CreateBrokenTitle("阅读页数(页)");

		using var output = File.Create("axis-title-before.xlsx");
		workbook.Write(output, true);
		Console.WriteLine("已生成 axis-title-before.xlsx");
	}

	private static DmlChart.CT_Title CreateBrokenTitle(string text){
		return new DmlChart.CT_Title {
			overlay = new DmlChart.CT_Boolean { val = 0 },
			tx = new DmlChart.CT_Tx {
				rich = new CT_TextBody {
					bodyPr = new CT_TextBodyProperties(),
					lstStyle = new CT_TextListStyle(),
					p = new List<CT_TextParagraph> {
						new() {
							// 直接给 r 赋值，没有维护序列化使用的 items。
							r = new List<CT_RegularTextRun> {
								new() { t = text }
							}
						}
					}
				}
			}
		};
	}
}
```

从 C# 对象看，标题字符串已经赋值。但 `.xlsx` 最终保存的是 XML：对象中有文字，不等于文件里一定写出了符合格式要求的标题。

## 三、根因：文字集合和 XML 命名空间都有问题

### 1. 直接给 r 集合赋值，文字没有正确参与序列化

检查本地 NPOI 2.8.0 DLL 的实现后发现，`CT_TextParagraph.Write` 写出段落内容时遍历的是内部 `items` 集合。

原代码只给 `r` 属性赋值，没有同步维护 `items`，因此虽然可以在对象上看到文字，序列化时却没有按预期写出文本运行节点。

如果采用富文本方式构造段落，应使用 `AddNewR()` 这类方法维护相关集合，不能仅凭公开属性可赋值就假定写入路径完整。

但本次问题还有第二层原因，仅调整文本运行节点的创建方法仍然不够。

### 2. rich 节点使用了错误的命名空间

在本次检查的版本中，`CT_Tx.Write` 调用 `CT_TextBody.Write` 写出富文本，而后者使用了固定的 `a` 前缀，导致标题富文本容器输出为 `a:rich`。

图表标题需要的容器则是 `c:rich`。下面是符合预期的富文本结构示意(并非最终修复方案)：

```xml
<c:title
    xmlns:c="http://schemas.openxmlformats.org/drawingml/2006/chart"
    xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
  <c:tx>
    <c:rich>
      <a:bodyPr />
      <a:lstStyle />
      <a:p>
        <a:r>
          <a:t>周次</a:t>
        </a:r>
      </a:p>
    </c:rich>
  </c:tx>
</c:title>
```

`c:rich` 属于图表命名空间，内部段落和文本属于 DrawingML 主命名空间。

严格来说，决定 XML 元素身份的是命名空间 URI 和本地名称，而不是前缀字母本身。这里的 `a:rich` 和 `c:rich` 绑定到不同的 URI，因此不是单纯换了一个前缀。

这解释了为什么只反复调用 `SetTitle()`、改变调用顺序或继续覆盖 `CT_Title`，不能解决当前问题：最终仍然经过存在问题的富文本写出路径。

## 四、解决方案：使用单元格引用和字符串缓存

图表标题除了富文本，还可以通过 `c:strRef` 引用工作表单元格。如下代码是直接复用表头作为标题来源：

| 坐标轴 | 引用单元格 | 单元格内容 |
| --- | --- | --- |
| X 轴 | A1 | 周次 |
| Y 轴 | B1 | 阅读页数(页) |

同时在 `strCache` 中写入一条标题缓存。这样既保留了有效的标题来源，也提供了可直接读取的缓存文字，并避开 `tx.rich` 的序列化路径。

### 1. 修复后的实现

```csharp
using System;
using System.Collections.Generic;
using System.IO;
using NPOI.SS.Util;
using NPOI.XDDF.UserModel.Chart;
using NPOI.XSSF.UserModel;
using DmlChart = NPOI.OpenXmlFormats.Dml.Chart;

internal static class Program {
	private static void Main(){
		using var workbook = new XSSFWorkbook();
		var sheet = (XSSFSheet)workbook.CreateSheet("ChartData");
		const string xTitle = "周次";
		const string yTitle = "阅读页数(页)";
		var header = sheet.CreateRow(0);
		header.CreateCell(0).SetCellValue(xTitle);
		header.CreateCell(1).SetCellValue(yTitle);

		double[] weeks = { 1, 2, 3, 4, 5 };
		double[] pagesRead = { 30, 45, 40, 60, 75 };
		for (int i = 0; i < weeks.Length; i++) {
			var row = sheet.CreateRow(i + 1);
			row.CreateCell(0).SetCellValue(weeks[i]);
			row.CreateCell(1).SetCellValue(pagesRead[i]);
		}

		var drawing = (XSSFDrawing)sheet.CreateDrawingPatriarch();
		var chart = drawing.CreateChart(drawing.CreateAnchor(0, 0, 0, 0, 3, 1, 15, 21));
		chart.SetTitleText("每周阅读统计");

		var xAxis = chart.CreateCategoryAxis(AxisPosition.Bottom);
		var yAxis = chart.CreateValueAxis(AxisPosition.Left);
		yAxis.Crosses = AxisCrosses.AutoZero;
		xAxis.CrossAxis(yAxis);
		yAxis.CrossAxis(xAxis);

		var xValues = XDDFDataSourcesFactory.FromNumericCellRange(sheet, new CellRangeAddress(1, weeks.Length, 0, 0));
		var yValues = XDDFDataSourcesFactory.FromNumericCellRange(sheet, new CellRangeAddress(1, weeks.Length, 1, 1));
		var data = (XDDFLineChartData<double, double>)chart.CreateData<double, double>(ChartTypes.LINE, xAxis, yAxis);
		var series = (XDDFLineChartData<double, double>.Series)data.AddSeries(xValues, yValues);
		series.SetTitle("示例阅读记录", null);
		series.SetMarkerStyle(MarkerStyle.Circle);
		series.SetSmooth(true);
		chart.Plot(data);

		// 引用表头 A1、B1，并处理工作表名称转义和绝对引用。
		var xFormula = new CellReference(sheet.SheetName, 0, 0, true, true).FormatAsString();
		var yFormula = new CellReference(sheet.SheetName, 0, 1, true, true).FormatAsString();
		var axes = chart.GetCTChart().plotArea;
		axes.catAx[0].title = BuildReferencedAxisTitle(xTitle, xFormula);
		axes.valAx[0].title = BuildReferencedAxisTitle(yTitle, yFormula);

		using var output = File.Create("axis-title-after.xlsx");
		workbook.Write(output, true);
		Console.WriteLine("已生成 axis-title-after.xlsx");
	}

	private static DmlChart.CT_Title BuildReferencedAxisTitle(
	string text, string cellFormula){
		return new DmlChart.CT_Title {
			overlay = new DmlChart.CT_Boolean { val = 0 },
			tx = new DmlChart.CT_Tx {
				strRef = new DmlChart.CT_StrRef {
					f = cellFormula,
					strCache = new DmlChart.CT_StrData {
						ptCount = new DmlChart.CT_UnsignedInt { val = 1 },
						pt = new List<DmlChart.CT_StrVal> {
							new() { idx = 0, v = text }
						}
					}
				}
			}
		};
	}
}
```

几个字段的含义：

- `f`：引用标题单元格的公式。
- `ptCount = 1`：缓存中只有一个字符串点。
- `idx = 0`：缓存点索引从零开始。
- `v`：实际标题文字。
- `overlay = 0`：请求标题不覆盖绘图区，由查看器参与布局。

`overlay` 不是本次根因的修复点；关键是改用 `strRef`，绕开错误的富文本输出。

### 2. 生成安全的单元格引用

不要手动拼接工作表名称，因为名称可能包含中文、空格或单引号。使用 `CellReference` 生成公式，可处理名称转义和绝对引用。

NPOI 的行列索引从零开始，因此示例中的 `(0, 0)` 对应 A1，`(0, 1)` 对应 B1。数值数据从第 2 行开始，标题引用不会影响曲线数据范围。

如果使用已有模板，应更新已有标签单元格，避免重新创建整行覆盖其他内容。

该示例适用于一条分类轴、一条数值轴的折线图。组合图或带次坐标轴的图表，应按轴 ID 和关联关系定位目标轴，不能一概使用集合的第一个元素。

### 3. 修复后的 XML 结构

以名为 `ChartData` 的工作表为例，X 轴标题结构如下：

```xml
<c:title xmlns:c="http://schemas.openxmlformats.org/drawingml/2006/chart">
  <c:tx>
    <c:strRef>
      <c:f>ChartData!$A$1</c:f>
      <c:strCache>
        <c:ptCount val="1" />
        <c:pt idx="0">
          <c:v>周次</c:v>
        </c:pt>
      </c:strCache>
    </c:strRef>
  </c:tx>
  <c:overlay val="0" />
</c:title>
```

Y 轴引用 `ChartData!$B$1`，缓存文字为“阅读页数(页)”。如果将来修改标题，必须同时更新引用单元格和缓存文字，避免不同查看器读取不同来源时出现不一致。

## 五、修改前后对比

| 对比项 | 修改前 | 修改后 |
| --- | --- | --- |
| 标题内容形式 | `tx.rich` 富文本 | `tx.strRef` 单元格引用 |
| 文字来源 | 手动构造段落和文本运行集合 | 表头单元格内容及字符串缓存 |
| 序列化风险 | `r` 与 `items` 不同步，`rich` 命名空间错误 | 绕开当前版本的富文本写出路径 |
| 工作表名称处理 | 不涉及公式 | 使用 `CellReference` 处理转义 |
| 验证重点 | 对象属性已赋值 | 实际文件中的标题节点、公式和缓存 |


## 六、检查真正生成的 xlsx

`.xlsx` 本质上是 ZIP 包。排查图表问题时，可以解包检查 `xl/charts/chart1.xml`；文件中有多个图表时，应根据工作表和绘图部件的关系找到对应图表。

验证时应创建真实工作簿，保存后再读取 ZIP 中的 XML，而不只是检查内存中的标题对象。

修复后的检查内容包括：

1. 分类轴和数值轴均包含 `c:title`。
2. 标题采用 `c:tx/c:strRef` 结构，命名空间正确。
3. 引用公式分别指向 `ChartData!$A$1` 和 `ChartData!$B$1`。
4. 缓存点数量为 1、索引为 0，文字分别为“周次”和“阅读页数(页)”。
5. `overlay` 值为 0。
6. 重新打开工作簿后，标题来源单元格内容仍然正确。

## 七、总结经验

遇到“代码已经设置，但 Excel 没显示”的问题，应把检查重点从内存对象延伸到实际输出文件。

先确认自己设置的是轴标题，而不是图表标题或系列名称；再检查图表 XML 是否包含文字、命名空间是否正确，以及引用关系是否有效。只有结构输出正确后，才有依据继续排查字体、布局空间或查看器兼容性。

对于 NPOI 这类包含底层 XML 模型的库，公开集合属性和辅助创建方法未必有相同的序列化效果。此次 `r` 与 `items` 的差异就是一个例子。

后续升级 NPOI 时，应重新验证相应序列化路径，确认富文本问题是否已修复，再决定是否继续保留单元格引用方案。');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060982328649453568, 2060982328641064960, '```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>	
#include <ctype.h>
#include <math.h>
#define IO 996
#define N 10

//本文的各案例是以多个代码块形式集合在一个主函数中，
//统一共享头文件和宏定义常量。

void main(){

	{
		//一、数值型：主要用于解决数学问题进行一些数值运算以及科学和工程计算等。
		//交换法
		// 1、 采用一个中间变量把one和ten的值交换（不考虑直接赋值）

		int one=1;
		int ten =10;
		int c;
		printf("交换前：one=%d ten=%d",one,ten);
		c=one;
		one=ten;
		ten=c;
		printf("\n交换后：one=%d ten=%d\n",one,ten);
	}


	{
		// 2、 任意读入三个数然后对其进行逆序和顺序排列。

		int one,two,three,temporary;
		scanf("%d%d%d",&one,&two,&three);
		printf("交换前：one=%d two=%d three=%d\n",one,two,three);
		if(one>two){temporary=one;one=two;two=temporary;}
		if(one>three){temporary=one;one=three;three=temporary;}
		if(two>three){temporary=two;two=three;three=temporary;}
		printf("交换后：one=%d two=%d three=%d \n",one,two,three);
		
	}


	{
		// 3、 累加法:
		//计算1~任意大小整数步长为一的累加
		//(如：1+2+3~+99+100+N)

		int i=1;
		int temporary;
		int sum = 0;
		scanf("%d",&temporary);
		while(i<temporary+1){
			sum+=i;
			i+=1;
		}
		printf("1~%d步长为一的累加 和为：%d\n",temporary,sum);
	}


	{
		// 4、 累乘法
		//计算1~15以内整数步长为一的累乘（超出long可能数据溢出越界为0）
		//(如：1x2x3~x14x15)

		int i=1;
		int temporary=1;
		long sum=1;
		scanf("%d",&temporary);
		while(i<=temporary){
			sum*=i;
			i+=1;
		}
		printf("1~%d步长为一的累乘 为：%d\n",temporary,sum);
	}


	{
		//二、非数值型：主要用于比较和逻辑运算以及模式识别、人工智能、数学定律、语言翻译等。
		//穷举法（枚举法）:
		// 5、 用枚举法输出输入的随机三位正整数内所有的水仙花数。

		int i=0;
		int temporary;
		int aindividual,ten,hundred;
		scanf("%d",&temporary);
		for(i=100;i<=temporary;i++){
			aindividual=i%10;//求个位数
			ten=(i/10)%10;//求十位数
			hundred=i/100;//求百位数
			if(aindividual*aindividual*aindividual\
				+ten*ten*ten+hundred*hundred*hundred==i){
				printf("%d的水仙花数有：%d\n",temporary,i);
				
			}
		}

		//总结出取某个数的某个位的方法：
		//(取多少位就除多少，最后固定模10，取最高位时直接除于最高位的1）
		//printf("%d\n",56789/1%10);
		//printf("%d\n",56789/10%10);
		//printf("%d\n",56789/100%10);
		//printf("%d\n",56789/1000%10);
		//printf("%d\n",56789/10000);

	}


	{
		// 6、 用枚举法输出输入的随机三位正整数内所有的水仙花数方法二（只考虑三位数）。
		//对分别输入的个十百为数，依次以步长为一循环到最高值，将组成的三位正整数与
		//每一组的三个数的立方和进行比较，一旦相等就说明为水仙花数即后输出。
		int tmpG,tmpS,tmpB;//输入每个位的最高值
		int g,s,b;//循环变量
		scanf("%d%d%d",&tmpG,&tmpS,&tmpB);
		for(b=1;b<=tmpB;b++){//循环每个最高位数
			for(s=0;s<=tmpS;s++){
				for(g=0;g<=tmpG;g++){
					if(g*g*g+s*s*s+b*b*b==g+s*10+b*100){//得到各位的立方和后与各数进行判断取True和False
						printf("鲜花数有：%d\n",g+s*10+b*100);
					}else{
						printf("没有水仙花数！\n");
					}
				}
			}
		}
	}

	
	{
		//排序算法
		// 7、 冒泡排序

		int i,j,temporary,arry[N];
		for(i=0;i<N;i++){//从键盘输入N个数依次从零赋值给N-1个位置。
			scanf("%d",&arry[i]);
		}
		for(j=1;j<=N-1;j++){//外循环控制趟数
			for(i=0;i<=N-1-j;i++){//内循环控制每趟的次数
				if(arry[i]>arry[i+1]){//判断大小并按要求交换
					temporary=arry[i];
					arry[i]=arry[i+1];
					arry[i+1]=temporary;
				}
			}
		}
		for(i=0;i<N;i++){printf("%d \n",arry[i]);}//验证结果
    }


	{
		// 8、 选择法排序
		//选择法排序是对冒泡法的一种改进

		int arry[N],i,j,k,temp;
		for(i=0;i<N;i++){scanf("%d",&arry[i]);}
		for(i=0;i<N-1;i++){//处理N-1趟
			k=i;//存储每次最小值（假定未排序序列的第一个元素就是最小元素）
			for(j=i+1;j<N;j++){//每一趟从未排序后的位置开始查找最小的数
				if(arry[j]<arry[k]){k=j;}//与前面一个相比较，记录最小值的位置
			}
			if(k!=i){//交换（如果他们俩相等就没必要交换）
				temp=arry[i];
				arry[i]=arry[k];
				arry[k]=temp;
			}
		}
		for(i=0;i<N;i++){printf("%d	 ",arry[i]);}
	}


	{
		// 9、 插入法排序
		//插入法排序是将一个数目插入某占据的位置（只考虑已排序的序列）。

		int arry[N]={11,22,33,44,55,66,77,88,99},x,j,k;
		scanf("%d",&x);
		if(x>arry[N-2]){
			arry[N-1]=x;//x如果大于插入前序列最后一个数，则这插入在最最后面
		}else{
			j=0;
			while(j<=N-2&&x>arry[j]){
				j++;//查找待插入的位置
			}
			for(k=N-2;k>=j;k--){
				arry[k+1]=arry[k];//从j处把所有位置往后移
			}
			arry[j]=x;//从j位置插入X
		}
		for(j=0;j<N;j++){printf("%d	",arry[j]);}

	}


	{
		// 10、 插入法排序
		//随机输入10个数，实现在输入每一个数时将其用插入法按降序动态排列。

		int arry[N],i,j,k,x;
		scanf("%d",&arry[0]);//把读入的第一个数直接放在arry[0]中。
		for(j=1;j<N;j++){
			scanf("%d",&x);//陆续将第2~10个一一插入并实时排序
			if(x<arry[j-1]){
				arry[j]=x;//比原数列最后一个数小则直接插入最后位。
			}else{//寻找待插入的位置
				i=0;
				while(x<arry[i]&&i<=j-1){i++;}
				//以下循环从最后一个数开始直到待插入的位置上的数依次后移一位。
				for(k=j-1;k>=i;k--){
					arry[k+1]=arry[k];//后移
				}
				arry[i]=x;//插入
			}
		}
		for(j=0;j<N;j++){printf("%d	",arry[j]);}
	}


	{
		// 11、 归并排序
		//有一个还有六个数字的顺序序列和一个含有4个数的升序序列，
		//将二者合并成一个十个数字的新序列。
		//[缺点]：两序列必须是相同顺序方式且后存完的剩下的一截无法参与整个新序列前段的排序。
#define SIX 6
#define FOUR 4
		int arry[SIX+FOUR],i,j,k;
		int tempArrySIX[SIX]={-3,6,19,26,168,100};
		int tempArryFOUR[FOUR]={8,10,12,22};
		i=j=k=0;
		while(i<SIX&&j<FOUR){
			//将tempArrySIX和tempArryFOUR数组中最小的依次存在arry[]中。
			if(tempArrySIX[i]<tempArryFOUR[j]){
				arry[k]=tempArrySIX[i];
				i++;
			}else{
				arry[k]=tempArryFOUR[j];
				j++;
			}
			k++;
		}
		while(i>=SIX&&j<FOUR){
			//若tempArrySIX全部存放完毕则把tempArryFOUR许下的全部放在arry中
			arry[k]=tempArryFOUR[j];
			k++;
			j++;
		}
		while(j>=FOUR&&i<SIX){
			//若tempArryFOUR全部存放完毕则把tempArrySIX许下的全部放在arry中
			arry[k]=tempArrySIX[i];
			k++;
			i++;
		}
		for(i=0;i<SIX+FOUR;i++){printf("%d  ",arry[i]);}

	}

	
	{
		//查找算法
		// 12、 顺序查找（线性查找）

		int arry[N],i,x;
		printf("请输入源数组序列：\n");
		for(i=0;i<N;i++){scanf("%d",&arry[i]);}
		printf("接下来输入需要查找的数看看是否存在于上列这些数中：");
		scanf("%d",&x);//输入需要查找的数
		for(i=0;i<N;i++){
			if(x==arry[i]){//循环查找输入的数看是否存在于arry数组中
				printf("\n%d 存在于上列数组中！\n",x);
				break;
			}else if(i==N-1&&x!=arry[i]){
				printf("\n%d 不存在于上列数组中！\n",x);
				break;
			}
		}
	}


	{
		// 13、 折半查找（二分查找）
		//使用二分查找的前提是数列必须是顺序的。
		int arry[N]={2,34,57,88,99,135,255,666,2455,5636},high,low,mid,x;
		printf("输入需要查找的数：");
		scanf("%d",&x);
		high=N-1;
		low=0;
		mid=(high+low)/2;
		while(arry[mid]!=x&&low<high){//判断查找范围不为0时，循环！
			if(x<arry[mid]){//确定左子表范围
				high=mid-1;
			}else{
				low=mid+1;//确定右子表范围
			}
			mid=(high+low)/2;//从新计算之间值
		}
		if(x==arry[mid]){//如果查找的数等于之间数则查找成功
			printf("\nfound!\n\n");
		}else{printf("\nNot found!\n\n");}

	}


	{
		//进制转换算法
		// 14、 十进制转换为其他进制数(当下只考虑16进制及以下)
		//任意输入一个十进制数将其转换为二、八、十六任意进制的字符串数。

		int i=0,j=0,yu=0,ji,yuan;
		char jieguo[1000],slArry[]="0123456789ABCDEF";
		printf("输入进制基数(...三十二进制32...二进制2):_");
		scanf("%d",&ji);
		printf("输入待转数（任意十进制正整数）：");
		scanf("%d",&yuan);
		do{
			yu=yuan%ji;//求余
			jieguo[i]=slArry[yu];//将十进制以上的结果超出9的数字以大写字母代替
			yuan/=ji;//取自身求商
			i++;
		}while(ji>=2&&ji<=16&&yuan>0);
		for(j=i-1;j>=0;j--){printf(" %c ",jieguo[j]);}
		printf(" \n ");
	}


	{	
//#include <math.h> (代码块中不能有math.h头文件)
		// 15、 其他进制数转十进制(当下只考虑16进制及以下)
		//任意输入一个任意进制数（二、八、十六）将其转换为十进制的字符串数。

		int ji,i,yu,len,temp;long long shi;char yuan[N*10];
		shi=yu=ji=i=len=temp=0;
		printf("输入一个将被用来转换为十进制数的N进制数\n \
			   （例如二进制110011,十六进制12E8F4）：");
		gets(yuan);		//输入被转的字符型数列
		strupr(yuan);   //将yuan中的小写字母转换成大写字母
		printf("\n上面输入的是几进制数(例如二进制输入2,八进制8)：");
		scanf_s("%d",&ji);
		 len=strlen(yuan);
		 for(i=0;i<len;i++){//按权位展开数组长度等于权位数
			 //判断输入的数据和进制数是否相符
			 if ( (yuan[i]-''0''>=ji&&yuan[i]<''A'')||(yuan[i]-''A''+10>=ji) ){
			//(yuan[i]-''0''求的是yuan[i]字符数字对应的十进制数)
			//(yuan[i]-''A''+10求的是yuan[i]字母相对应的十进制数)
				 printf("输入的数据和进制数不相符!!");
				 exit(0);		 //退出程序
			 }
			 if (yuan[i]>=''0''&& yuan[i]<=''9''){  //判断是否为数字
				 temp=yuan[i]-''0'';   //求出字符数字所代表的十进制数
			 }
			 else if (ji>=11&&(yuan[i]>=''A''&&yuan[i]<=''A''+ji-10)){//判断是否为字母
				temp=yuan[i]-''A''+10; //求出字母所代表的十进制数
			 }
			 shi=shi*ji+temp; //求出最终转换成的十进制数(其中shi=shi*ji是进位)
		 }
		 printf("\n原 %d 进制数:",ji);
		 for(i=0;i<len;i++){printf(" %c ",yuan[i]);}
		 printf("转换为十进制数为: %lld \n\n",shi);

		//二进制转十进制基础算法
		//while(yuan!=0){
		//	yu=yuan%10;//求余
		//	yuan/=10;//取本身的商
		//	pow函数的功能是计算ji的i次方默认返回值为double型，在#include <math.h> 中
		//	shi+=(int)yu*pow(ji,i);
		//	++i;
		//}
		//printf("原 %d 进制数 %s 转换为十进制数为: %ld \n\n",ji,puts(yuan),shi);

		}
		
		
	{
		//字符串处理
		// 16、 字符统计
		//对字符串中各个字符出现的次数进行统计（此处暂且只论小写字母）
		char arry[N*10];
		int i,statistical[26]={i=0};
		printf("输入原字符串（小写）：");
		gets(arry);
		for(;arry[i]!=''\0'';i++){
			//statistical[0]中存放''a''的个数，statistical[1]中存放''b''的，类推
			statistical[arry[i]-''a'']+=1;
			//arry[i]-''a''中各字符的ascii码值减去''a''的ascii码值，
			//刚好得到对应的计数器下标(i)
		}
		for(i=0;i<26;i++){
			if(statistical[i]!=0){
				printf(" %c 出现了 %d 次 ！\n",i+''a'',statistical[i]);
			}
		}
	}
	

	{
		// 17、 字符加密
		//对任意一个含有英文字母的字符串，将每一个字母用其后的
		//第三个字母代替（xyz对应abc）,ascii码的规律是（arry[i]-26 +3）
		int i;
		char arry[N*10];
		gets(arry);
		for(i=0;i<strlen(arry);i++){
			if(arry[i]>=''x''&&arry[i]<=''z''||arry[i]>=''X''&&arry[i]<=''Z''){
				arry[i]=arry[i]-26+3;//
			}else{
				arry[i]=arry[i]+3;
			}
		}
		puts(arry);
	}


	{
		// 18、 获取整数各个位上的数
		//
		long number;
		scanf("%ld",&number);
		if(number<0){
			printf("— ");
			number=-number;//如果是负数及转为正数
		}
		do{
			printf("%ld_",number%10);//取个位
			number/=10;//递减十倍
		}while(number!=0);
		printf("\n\n");
	}

 
	{
		// 19、 辗转相除法（欧几里德算法）方法一
		//其是一种用来求最大公约数的有效算法
		//(1)最大公约数：能同时被两个整数整除的最大公约数。
		//(2)最大公约数 = 小数 与 （大数%小数） 的最大公约数。
		int a,b,remainder,d;

		printf("输入俩正整数：");
			scanf(" %d%d",&a,&b);
			//if(a<b){t=a;a=b;b=t;}
		remainder=a%b;
		d=a*b;
		while(remainder!=0){//辗转相除法循环
			a=b;
			b=remainder;
			remainder=a%b;
			//上面的算法remainder=0时b这时的值就是最大公约数
		}
		printf("\n最大公约数：%d\n",b);
		printf("最小公倍数：%d\n\n",d/b);
		//两数的积除以最大公约数就是最小公倍数了

	}


	{
		// 20、求最大公约数和最小公倍数 方法二
		int x,y,z,m,t;

		printf("输入两个正整数：");
		scanf("%d%d",&x,&y);
		if(x<y){
			t=x;
			x=y;
			y=t;
		}
		m=x*y;
		z=x%y;
		while(z != 0){
			x=y;
			y=z;
			z=x%y;
		}
		printf("最大公约数是：%d \n",y);
		printf("最小公倍数是：%d \n",m/y);

	}
	

	{
		//21、 有四个水渠要向水池灌水，单开a渠需要3天，单开b渠需要1天，
		//单开c渠需要4天，单开d渠需要5天，同时放水则需要多少天。
		float a=3,b=1,c=4,d=5;
		float day=1/((1/b)+(1/a)+(1/c)+(1/d));
		printf("需要 %f 天\n",day);
	}


	{
		//22、 输入年数判断是平年还是润年。
		int year=0;
		printf("输入年份吧：");
		scanf("%d",&year);
		//（能被4整除并且不能被一百整除的）或者（能被400整除的）是为闰年。
		if((year%4==0&&year%100!=0)||(year%400==0)){
			printf("%d 为润年！\n",year);
		}else{
			printf("%d 为平年\n",year);
		}
	}


	{
		//23、 倒三角九九乘法表
//#define IO 996 代码块中不能宏定义,故已定义在文头
		const int ii =0;
		int yy=99;
		char m=''y'';
		char mm=''f'';
		int x=1;
		int y=1;
		unsigned u = 9810;
		yy=4*IO;
		for(x=9;x>0;x--){
			for(y=1;y<=x;y++){
				printf("%d * %d = %d    ",y,x,x*y);
			}
			printf("\n");
		}
		printf("%d \a",yy);
		printf("%d %d %d %d %d %d",sizeof(short),sizeof(int),\
			sizeof(long),sizeof(char),sizeof(float),sizeof(double));
	}
	

	{
		
		//24、 有4个字符串，首先将他们按照字符串中的字符个数由小到大排列，
		  //再分别取出每个字符串的第三个字母并合成一个新的字符串输出，
		  //（若少于3个字符的则输出空格）。要求：利用字符串指针和数组指针实现。

		int i,j,k;char str[5],*p;
		char *strarr[4]={"yang","mu","fa","haoshuai"};
		//按照从小到大排序
		for(i=0;i<4;i++){
			for(k=i,j=k+1;j<4;j++)
				if(strlen(strarr[k]) > strlen(strarr[j]) ){
					k=j;
				}
				if(k!=i){//交换位置
					p=strarr[k];
					strarr[k]=strarr[i];
					strarr[i]=p;
				}
		}
		//分别取出每个字符串的第三个字母并合成一个新的字符串输出
		for(j=i=0;i<4;i++) 
			str[j++]=strlen(strarr[i])>2 ? *(strarr[i]+2) :'' '';
			str[j]=''\0'';
			printf("The result is : %s\n",str);
	}

	
	{
		//25、 已知一个整形数组x[4],他的4个元素值分别为 3、10、4和20.
			//使用指针表示法编程，求出该数组各个元素的乘积。
	
		int i=0;
		int x[]={3,10,4,20};
		int *p=x;
		for(i=0;i<3;i++){
		printf("%d和%d的乘积=%d\n\n",*(p+i),*(p+i+1),*(p+i)* *(p+i+1));
		}
	}

}  // main函数结尾


/*

//26、函数subString()

	int substring(char *str,char *str1){
		int i=0;int j=0;int number=0;
		for(i=0;str[i]!=''\0'';i++){
			for(j=0;str[i+j]!=''\0''&&str1[j]!=''\0'';j++){
				if(str[i+j]!=str1[j])
					break;
			}
			if(str1[j]==''\0'')
				number++;
		}
		return number;
	}

*/



/*
//
	//27、输入八个整数，并将其中最小的与最第一个交换，把最大的数与最后一个对换。
//
#include <stdio.h>
#include <stdlib.h>
void Exchange(int l,int *min,int *max,int *Array);
void forinput(int l,int *Array);
void traverse_size(int l,int *min,int *max,int *Array);

void main(){
	int l=3,i;
	int *min=(int *)malloc(sizeof(int));
	int *max=(int *)malloc(sizeof(int));
	int *Array=(int *)malloc(sizeof(int)*8);
	printf("请输入词组个数：");
	scanf_s("%d",&l);
	printf("接下来请输入%d个任意大小的数：\n",l);
	for(i=0;i<l;i++){
		printf("第-%d-个随机数字：",i+1);
		scanf_s("%d",&Array[i]);
	    }
	    printf("交换前的顺序为：");
        forinput(l,Array);
        traverse_size(l,min,max,Array);
		printf("Max，Min 分别为；%d %d\n",*max,*min);
	    Exchange(l,min,max,Array);        
        printf("交换后的顺序为：");
        forinput(l,Array);
	    printf("\n");
}
//
//调用exchange函数对数字指定数字按要求将
//最小的与最第一个交换，把最大的数与最后一个对换，
void Exchange(int l,int *min,int *max,int *Array){
    int i;
	//printf("交换前顺序为：");
	//forinput(l,Array);
	printf("开始把最小的与原最第一个交换，把最大的数与最后一个对换，moment.....\n");
	for(i=0;i<l;i++){
		if(i==0){
			Array[i]=*min;
		}
		if(i==l-1){
			Array[i]=*max;
		}
	}
}
//
//遍历_打印输出
void forinput(int l,int *Array){
	int i;
  for(i=0;i<l;i++){
    printf("%d ",Array[i]);
  }
  printf("\n");
}
//
//遍历_求大小
 void traverse_size(int l,int *min,int *max,int *Array){
     int i;
	 *max=Array[0];*min=Array[0];
     *max=Array[0],*min=Array[0];
     for(i=0;i<l;i++){
     if(*min>Array[i]){
			 *min=Array[i];
		 }
     if(*max<Array[i]){
			 *max=Array[i];
		 }
        }
    //    printf("Max，Min 分别为；%d %d\n",*max,*min);
 }

 */



/*
//
	//28、定义一个动态数组，长度为变量n，用随机数给数组各元素赋值，
	//然后给数组个单元排序，定义swap()函数交换数据单元，要求参数使用指针传递。
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
void CreateArray(int,int *);
void Swap(int,int *);
void pint(int,int *);
//
void main(){
	int n=0;
	int *arr=NULL;
	//srand((unsigned int)time(NULL));//设置当前时间为种子 
	//n=(n = (rand()%100+1)/10)+5;//产生1~100的随机数 
	CreateArray(n,arr);
	Swap(n,arr);
	pint(n,arr);
}
//
//创建动态数组
void CreateArray(int n,int *arr){
	printf("确认过眼神：CreateArray\n");
	//srand((unsigned int)time(NULL));//设置当前时间为种子 
	printf("请输入数组的长度:");
	scanf_s("%d",&n);
	arr=(int *)malloc(sizeof(int)*n);
	//用随机数给数组各元素赋值
	int p= 0;
	while( p< n ){
		printf("请输入随机数为数组元素赋值:");
		//arr[I]=(rand()%100+1);//产生1~100的随机数 

		scanf_s("%d",&arr[p]);
		p++;
	}
}
//
//定义swap()函数交换数据单元（从小到大）
	void Swap(int n,int *Parr){
		printf("确认过眼神： Swap\n");
		int I=0,J=0,K=0,temporary;
			for(I=0;I<n;I++){
				for(K=I,J=K+1;J<n;J++){
					if(Parr[I]<Parr[J])
						K=J;
					if(K!=I){
						temporary=Parr[K];
						Parr[K]=Parr[I];
						Parr[I]=temporary;
					}
				}
			}
	}
	//
	//打印	
	void pint(int n,int *parameter){
		printf("确认过眼神：pint\n");
		int I=0;
		for(I=0;I<n;I++){
			printf("%d ",parameter[I]);
		}
		printf("\n");	
	}

	*/



```');
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
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060911456341331968, 2060911456337137664, '# JASS 数据类型对照表

### Java/TypeScript/C#

|    Java 数据类型     |        C# 数据类型         |  TypeScript 数据类型   |
| :------------------: | :------------------------: | :--------------------: |
|        `int`         |           `int`            |        `number`        |
|        `long`        |           `long`           | `number`(with BigInt)  |
|       `float`        |          `float`           |        `number`        |
|       `double`       |          `double`          |        `number`        |
|      `boolean`       |           `bool`           |       `boolean`        |
|        `char`        |           `char`           | `string` (single-char) |
|       `String`       |          `string`          |        `string`        |
|      `List<T>`       |         `List<T>`          |       `Array<T>`       |
|     `Map<K, V>`      |     `Dictionary<K, V>`     |     `Record<K, V>`     |
|       `Set<T>`       |        `HashSet<T>`        |        `Set<T>`        |
|       `Tuple`        |       `Tuple types`        |     `Tuple types`      |
|        `enum`        |           `Enum`           |         `Enum`         |
|       `Object`       |          `object`          |         `any`          |
|        `void`        |           `void`           |         `void`         |
| `null` / `undefined` |    `null` / `undefined`    |  `null` / `undefined`  |
| `java.sql.Timestamp` | `java.time.LocalDateTime ` |       `DateTime`       |
|                      |                            |                        |

### Java Compare table with data type

|           Java            |   MySQL    |          PostgreSQL           |       Oracle        | SQL Server  |  InfluxDB  |
| :-----------------------: | :--------: | :---------------------------: | :-----------------: | :---------: | :--------: |
|    `java.lang.Boolean`    | `BOOLEAN`  |           `BOOLEAN`           |     `NUMBER(1)`     |    `BIT`    | `BOOLEAN`  |
|     `java.lang.Byte`      | `TINYINT`  |          `SMALLINT`           |     `NUMBER(3)`     |  `TINYINT`  |            |
|     `java.lang.Short`     | `SMALLINT` |          `SMALLINT`           |     `NUMBER(5)`     | `SMALLINT`  |            |
|      `java.lang.Int`      |   `INT`    |           `INTEGER`           |    `NUMBER(10)`     |    `INT`    |            |
|     `java.lang.Long`      |  `BIGINT`  |           `BIGINT`            |    `NUMBER(19)`     |  `BIGINT`   |   `INT`    |
|     `java.lang.Float`     |  `FLOAT`   |            `REAL`             | `NUMBER`(带小数点)  |   `REAL`    |            |
|    `java.lang.Double`     |  `DOUBLE`  |      `DOUBLE PRECISION`       | `NUMBER`(带小数点)  |   `FLOAT`   |   `REAL`   |
|    `java.lang.String`     | `VARCHAR`  |            `TEXT`             | `VARCHAR` 或 `TEXT` | `VARCHAR2`  |   `CLOB`   |
|  `java.math.BigDecimal`   | `DECIMAL`  |           `NUMERIC`           |      `NUMERIC`      |  `NUMBER`   | `DECIMAL`  |
|      `java.sql.Date`      |   `DATE`   |            `DATE`             |       `DATE`        |   `DATE`    |            |
|      `java.sql.Time`      |   `TIME`   |            `TIME`             | `DATE`(仅时间部分)  |   `TIME`    |            |
|   `java.sql.Timestamp`    | `DATETIME` |          `TIMESTAMP`          |     `TIMESTAMP`     | `TIMESTAMP` | `DATETIME` |
|     `java.sql.Array`      |  `ARRAY`   |            `ARRAY`            |       `TABLE`       |   `TABLE`   |            |
|      `java.sql.Blob`      |   `BLOB`   |            `BYTEA`            |       `BLOB`        | `VARBINARY` |            |
|      `java.sql.Clob`      |   `CLOB`   |            `TEXT`             |       `CLOB`        |   `TEXT`    |            |
|    `java.time.Instant`    |            |                               |                     |             |   `TIME`   |
| `java.time.LocalDateTime` |            | `timestamp without time zone` |                     |             |            |

### C# Compare table with data type

|              C#              |              MySQL              |          PostgreSQL           |        Oracle        |     SQL Server     |   InfluxDB   |
| :--------------------------: | :-----------------------------: | :---------------------------: | :------------------: | :----------------: | :----------: |
|            `bool`            |             `BOOL`              |         `TINYINT(1)`          |      `BOOLEAN`       |    `NUMBER(1)`     |    `BIT`     |
|            `byte`            |       `TINYINT UNSIGNED`        |          `SMALLINT`           |     `NUMBER(3)`      |     `TINYINT`      |              |
|           `short`            |           `SMALLINT`            |          `SMALLINT`           |     `NUMBER(5)`      |     `SMALLINT`     |              |
|            `int`             |              `INT`              |           `INTEGER`           |     `NUMBER(10)`     |       `INT`        | `INT` `TIME` |
|            `long`            |            `BIGINT`             |           `BIGINT`            |     `NUMBER(19)`     |      `BIGINT`      |              |
|           `float`            |             `FLOAT`             |            `REAL`             | `NUMBER`（带小数点） |       `REAL`       |   `FLOAT`    |
|           `double`           |            `DOUBLE`             |      `DOUBLE PRECISION`       | `NUMBER`（带小数点） |      `FLOAT`       |    `REAL`    |
|          `decimal`           |            `DECIMAL`            |           `NUMERIC`           |      `NUMERIC`       |      `NUMBER`      |  `DECIMAL`   |
|           `string`           |            `VARCHAR`            |            `TEXT`             |      `VARCHAR`       |       `TEXT`       |  `VARCHAR2`  |
|            `char`            |             `CHAR`              |            `CHAR`             |     `VARCHAR(1)`     |       `CHAR`       |    `CHAR`    |
|          `DateTime`          |           `DATETIME`            |          `TIMESTAMP`          |     `TIMESTAMP`      |       `DATE`       | `TIMESTAMP`  |
|           `byte[]`           |             `BLOB`              |            `BYTEA`            |        `BLOB`        |    `VARBINARY`     |              |
|            `Guid`            |           `CHAR(36)`            |            `UUID`             |      `RAW(16)`       | `UNIQUEIDENTIFIER` |              |
|            `Enum`            |             `ENUM`              |    `ENUM`(PostgreSQL 8.3+)    |      `VARCHAR2`      |      `NUMBER`      |    `INT`     |
|    `System.Net.IPAddress`    |         `VARBINARY(16)`         |   `INET`(PostgreSQL 9.4+）    |       `RAW(4)`       |  `VARBINARY(16)`   |              |
| `System.Net.IPAddressRange`  |                -                |   `CIDR`（PostgreSQL 9.4+）   |          -           |         -          |              |
| `System.Numerics.BigInteger` |            `DECIMAL`            |           `NUMERIC`           |      `NUMERIC`       |      `NUMBER`      |  `DECIMAL`   |
|            `json`            | `System.Text.Json.JsonDocument` |            `JSON`             |       `JSONB`        |       `JSON`       |   `JSONB`    |
|          `DateTime`          |                                 | `TIMESTAMP WITHOUT TIME ZONE` |                      |                    |              |');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060914908756840448, 2060914908748451840, '# Vue 3

### Options API

`TIP1:`  选项式API中,有两种常见的方式来导出组件：使用 `export default {}` 和 `export default defineComponent({})`,这两种方式在功能上是等效的，但在语法上有些差别.

`TIP2:`  选项式API为Vue2的用法,虽然 Vue3 也支持在选项式 API 中使用并支持TypeScript，但官方更推荐使用组合式 API,因为它提供了更简单、高效和可靠的类型推导.

`TIP3:` 选项式API的配置项Vue3和Vue2的生命周期不同所有配置项也有所不同.

#### export default {}
```vue
<template>
  <div>
   我好帅!
  </div>
</template>

<script>
import userTool from "@/uitils/UserToolClass"; //引入其他依赖或插件
export default {
  name: "componentName" //组件名
  components: { //声明子组件
    MyComponent,
  },
  props: { //定义父组件传递过来的数据格式,也可用数组形式 props:["property","method"],
    disabled: {
    typeof: Boolean,
       default: false
    }
  },
   methods: { //方法
     increment() {
       this.count++;
     }
   },
   data() { //数据
    return {
      count: this.initialCount
    };
   },
  computed: { 
    doubleCount() {
      return this.count * 2;
    }
  },
  watch: { //监听数据的变化，并进行相应的操作
    count(newCount, oldCount) {
      console.log(`计数变化，新值为 ${newCount}，旧值为 ${oldCount}`);
    }
  },
  onMounted() { //定义计算属性，这些属性的值会根据依赖变化而变化
    console.log(''组件已挂载到 DOM'');
  }
}
</script>

<style scoped lang="scss">

</style>
```
### Composition API

`TIP1:`  组合式API有两种主要写法,

#### export default defineComponent(\{\})
#### 

```vue
<template>
    <div>
   我好帅!
  </div>
</template>

<script>
import { defineComponent } from ''vue''; //默认需要导入
import userTool from "@/uitils/UserToolClass"; //引入其他依赖或插件
export default defineComponent({
  components: { //定义子组件
    ChildComponent,
  },
  props: { //定义父组件传递过来的数据格式,也可用数组形式 props:["property","method"],
    disabled: {
    typeof: Boolean,
       default: false
    }
  },
  emits: [''incremented''],
  setup(props, { emit }) { //可接 context 和props
    const increment = () => {
      emit(''incremented'');
    };
    let a = "bl";
    return {
      increment,
      a,
    };
  },
});
</script>

<style scoped lang="scss" >
/* 样式 */
</style>
```

#### `<script setup>`语法糖写法
#### 

`TIP1:`  在 Vue 3 的 `<script setup>` 中，之前
```vue
export default defineComponent({

  	setup(props, context) {}
});
```

中的 `context` 对象和``context`部分被拆分成如下:

props部分变为了:
```vue
defineProps({

    message: String,
});
```


context对象的:

- `attrs`：包含组件传递的所有非 props 属性。
- `slots`：包含所有插槽内容。
- `emit`：用于触发组件的自定义事件(导入的时候用 )。
- `expose`：暴露一些内部变量和方法给父组件。

部分则拆分成了多个对象:

- `defineProps`：用于定义组件接收的props属性。通过这个函数定义的props可以在模板中直接使用，而不需要通过`props`选项来声明.
-

```vue
<script setup>
import { defineProps } from ''vue'';

const props = defineProps({
  title: String,
  count: {
    type: Number,
    default: 0
  }
});
</script>
```

- `defineSlots`：用于定义插槽,通过这个函数定义的插槽可以在模板中直接使用,而不需要通过`$slots`来访问.

  ```vue
  <script setup>
  import { defineSlots } from ''vue'';
  
  const slots = defineSlots();
  </script>
  ```

- `defineEmits`：用于定义组件触发的事件,通过这个函数定义的事件可以在模板中直接使用，而不需要通过`$emit`来触发.

  ```vue
  <script setup>
  import { defineEmits } from ''vue'';
  
  const emits = defineEmits([''update:title'', ''click'']);
  </script>
  ```

- `defineExpose`：用于暴露组件的方法或数据。通过这个函数暴露的方法或数据可以在父组件中直接访问.

  ```vue
  <script setup>
  import { defineExpose } from ''vue'';
  
  const data = ''example'';
  
  const method = () => {
    console.log(''Example method'');
  };
  
  defineExpose({
    data,
    method
  });
  </script>
  ```

- `useAttrs`：用于获取父组件传递给子组件的非props属性.

  ```vue
  <template>
    <child-component v-bind="$attrs" />
  </template>
  
  <script setup>
  import { useAttrs } from ''vue'';
  
  const attrs = useAttrs();
  </script>
  ```

- `useSlots`：用于获取父组件传递给子组件的插槽内容.

  ```vue
  <template>
    <slot v-bind="slots" />
  </template>
  
  <script setup>
  import { useSlots } from ''vue'';
  
  const slots = useSlots();
  slots.default //如果父组件没有使用该插槽则slots.slotName为undefined否则为一个箭头函数
  </script>
  ```

综合案例如下:

```vue
<template>
  <!-- 模板内容 -->
</template>

<script setup>
import { ref, computed,defineProps,defineSlots,defineEmits,defineExpose,useAttrs,useSlots,} from ''vue''; 
// 声明 props
const props = defineProps({ //接收
  message: String,
});
// 声明 context部分和使用
const { nonProp } = attrs;
const emits = defineEmits([''custom-event'']);
console.log(slots.slot);
expose({ count, myMethod }); //将count变量、doubledCount函数都暴露给了父级组件,父组件就可以通过当前组件的实例来访问

// 定义响应式数据
const count = ref(0);
// 定义计算属性
const doubledCount = computed(() => count.value * 2);
// 定义方法
function increment() {
  count.value++;
}
onMounted(()=>{ //生命周期函数
  console.log("onMounted 执行");
  treeControlSwitch(isCollapse.value);
  setChart();
}); 

// 无需return手动返回    
    
</script>

<style>
/* 样式 */
</style>
```

#### export default \{\}
#####` tips` 虽然Vue3也支持Vue2这种写法,但是不建议用这种方式

```vue
<template>
  <!-- 模板内容 -->
</template>

<script>
import { ref, computed } from ''vue'';

export default {
  components: { //定义子组件
    ChildComponent,
  },
  props: { //定义父组件传递过来的数据格式,也可用数组形式 props:["property","method"],
    disabled: {
    typeof: Boolean,
       default: false
    }
  },
  setup(props, context) {
    onst vmodel = ref(false);  //响应式变量
    const handleClose = (done, iconClose) => {}; //方法
	watch( //监视器
      () => props.height,
      (newVal, oldVal) => {
        top.value = calcHeight();
      }
    );
    onMounted() { //定义计算属性，这些属性的值会根据依赖变化而变化
      console.log(''组件已挂载到 DOM'');
 	}
    return {
      count: ref(0),
      vmodel,
      handleClose
    }; 
  }
};
</script>

<style>
/* 样式 */
</style>
```

####

### API

```javascript
setup({
    //钩子
    //function
    //data
    true
    return{
    	//dataName
    	//functionName
	}
}) //组合式API
const instance = getCurrentInstance(); // 获取当前组件实例
instance.mittBus.emit(''mittFn'',{name: formInline.username}) //触发总线上指定的事件
const message = ref(instance.appContext.config.globalProperties.message); // 获取全局属性的值
```

自定义事件和事件总线

```JavaScript
emitter.emit(''事件名'', 参数) //触发总线上指定的事件
emitter.off(''事件名'') //清除总线上指定事件
emitter.all.clear() //清除总线上绑定的所有事件
onMounted(() => {
	emitter.on(''event1'', showInfo)
}) //绑定事件



```

### 深度作用选择器
```vue
<!--总结: 尽量避免使用 /deep/ .child){} 和 ::v-deep .child {} , 推荐使用 :deep (.child) {} 来实现深度作用选择器。-->

/* ::v-deep (.child) {} , 写法:  */
<template>
  <div class="parent" >
    <child-component class="child"></child-component>
  </div>
</template>

<style scoped lang="SCSS">
:deep(.child){
    color: red;
}
</style>
```

```vue
/* ::v-deep .child {} 已废弃, 
与 /deep/ 类似，它可以修改子组件中的样式。不过，它只会影响被包裹在带有 scoped 属性的样式中的选择器: */
<template>
  <div class="parent" >
    <child-component class="child"></child-component>
  </div>
</template>
<style scoped lang="SCSS">
  ::v-deep .child {
    color: red;
  }
::deep(.child){
    color: red;
}
</style>

```
```vue
/* /deep/ .some-class {} 已废弃，
它可以穿透子组件，应用样式到所有后代元素: */
<template>
  <div>
    <child-component></child-component>
  </div>
</template>

<style scoped lang="SCSS" >
  /deep/ .some-class {
    color: red;
  }
</style>
```

### 插槽

让父组件可以向子组件指定位置插入html结构,也是一种组件间通信的方式，适用于 父组件 ===> 子组件 ,在Vue 3中,引入了新的插槽语法,包括默认插槽\具名插槽和作用域插槽.

**`注意`**

1.作用域插槽的scope="prognav" 写法已过时 , 由 v-slot=slotName="prognav" 代替

2.当一个组件同时接收默认插槽和具名插槽时,所有位于顶级的非 `<template>` 节点都被隐式地视为默认插槽的内容

#### 1.默认插槽（Default Slot）

默认插槽是指在父组件中没有具名插槽时，默认将内容传递给子组件的插槽。在父组件中使用`<template v-slot:default>`或简写为`<template #default>`来定义默认插槽。在子组件中使用`<slot></slot>`来渲染默认插槽的内容。

父组件：

父组件：

```vue
<ChildComponent>
  <template v-slot:default>
    <p>默认插槽的内容</p>
  </template>
</ChildComponent>
```

子组件：

```vue
<template>
  <div>
    <slot></slot>
  </div>
</template>
```

#### 2.具名插槽（Named Slot）

具名插槽用于在父组件中定义多个命名的插槽，并且子组件根据名称选择性地接收和渲染插槽内容。在父组件中使用`<template v-slot:slotName>`或简写为`<template #slotName>`来定义具名插槽。在子组件中使用`<slot name="slotName"></slot>`来渲染对应名称的插槽内容。

父组件：

```vue
<ChildComponent>
  <template v-slot:header>
    <h1>Header插槽的内容</h1>
  </template>
  <template v-slot:footer>
    <p>Footer插槽的内容</p>
  </template>
</ChildComponent>
```

子组件：

```vue
<template>
  <div>
    <slot name="header"></slot>
    <slot name="footer"></slot>
  </div>
</template>
```

#### 3.作用域插槽（Scoped Slot）

作用域插槽 是一种非 常强大的 组件通信方式，可以让组件之间更加灵活地共享数据和交互,有具名作用域插槽和默认作用域插槽,他们允许**父组件将数据传递给子组件的插槽，并在插槽内部进行处理**。

**`注意`** `<slot :content="defaultData"></slot>`中的`content`是一个插槽属性名，用于向子组件传递数据。它可以是任意你定义的属性名，用来表示将要传递给子组件的数据。

##### 3.1.具名作用域插槽（Named Scoped Slot）

允许父组件向子组件传递数据，并在子组件内部使用该数据进行处理。通过具名插槽，可以定义多个不同的插槽，并在父组件中选择性地传递数据给每个插槽。在父组件中，使用`<template v-slot:mySlotName="slotProps">`或简写为`<template #mySlotName="slotProps">`来定义一个具名插槽，并将数据通过`slotProps`传递给子组件。在子组件中，使用`<slot :title="headerData"></slot>`将数据接收并在插槽内使用。

父组件：

```vue
<ChildComponent>
  <template v-slot:mySlotName="slotProps">
    <h1>{{ slotProps.title }}</h1> <!--向具名插槽传递一个title数据-->
  </template>
</ChildComponent>
```

子组件：

```vue
<template>
  <div>
    <slot name="mySlotName" :title="headerData"></slot>
  </div>
</template>

<script>
export default {
  data() {
    return {
      headerData: ''这是标题''
    };
  }
}
</script>
```

##### 3.2.默认作用域插槽（Default Scoped Slot）

没有指定名称的作用域插槽，当父组件中没有使用具名插槽时，默认将内容传递给子组件的默认插槽。在父组件中，可以使用`<template v-slot:default="slotProps">`或简写为`<template #default="slotProps">`来定义默认作用域插槽，并通过`slotProps`传递数据给子组件。在子组件中，使用`<slot :propName="data"></slot>`来接收并使用传递的数据。

父组件：

```html
<ChildComponent>
  <template v-slot:default="slotProps">
    <p>{{ slotProps.content }}</p>
  </template>
</ChildComponent>
```

子组件：

```html
<template>
  <div>
    <slot :content="defaultData"></slot>
  </div>
</template>

<script>
export default {
  data() {
    return {
      defaultData: ''这是默认内容''
    };
  }
}
</script>
```

### Router

#### 两种路由模式

```JavaScript
const router = createRouter({
	//路由的模式设置
    history: createWebHashHistory(), 
    routes
})
//指定了路由的模式为 hash 模式。在 hash 模式下，URL 中的路径会以 # 号开头，例如："http://192.168.187.167:9990/#/Water"。路由器将监听 URL 中 hash 的变化，并据此来匹配路由配置，并显示对应的组件;

const router = createRouter({
    //路由的模式设置
    history: createWebHistory(),
    routes
});
指定了路由的模式为 history 模式，即使用 HTML5 History API 来管理路由,在 history 模式下，URL 中的路径看起来更加直观，例如："http://localhost:856/hospital/register_setp";

hash 模式和 history 模式都有各自的优势和劣势，下面是它们的比较：

Hash 模式的优势：

兼容性好：Hash 模式可以在所有浏览器中使用，包括老版本的浏览器。
简单配置：使用 Hash 模式不需要额外的服务器配置，只需配置前端路由即可。
部署简单：Hash 模式在部署时只需将静态文件放置在任意服务器上即可，不需要额外的配置。
Hash 模式的劣势：

URL 不美观：Hash 模式会在 URL 中添加一个 # 号，对于一些用户来说，这样的 URL 可能不够美观。
SEO 不友好：搜索引擎对于带有 # 号的 URL 的处理可能不够友好，可能会影响 SEO 效果。
无法精确匹配：Hash 模式只能匹配到 # 后面的部分，无法精确匹配到更深层级的路径。
History 模式的优势：

URL 美观：History 模式可以使用普通的 URL，没有额外的特殊字符。
SEO 友好：使用 History 模式的应用可以更好地被搜索引擎索引，有利于提高网站的可搜索性。
适合正式环境：History 模式更适合在正式环境中使用，可以提供更好的用户体验。
History 模式的劣势：

兼容性局限：History 模式需要浏览器支持 HTML5 History API，一些老版本的浏览器可能不支持。
需要服务器配置：使用 History 模式需要服务器配置支持，以确保在刷新页面或直接访问 URL 时能够正确返回对应的页面。
部署复杂：History 模式在部署时需要配置服务器，以确保在前端路由无法匹配到对应路径时，能够正确返回 index.html 页面。
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060915672459907072, 2060915672455712768, '# Vite 5

### 配置资源路径别名

#### vite.config.ts

```typescript
import { defineConfig } from ''vite''
import vue from ''@vitejs/plugin-vue''
//引入node提供的内置模块path:可以获取绝对路径,需要安装 "@types/node": "^20.11.10",
import path from ''path'';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  resolve: {
    //src文件夹配置别名
    alias: {
      // 将 @ key 设置为用nodejs相关路径拼接方法得到src的绝对路径字符串
      // 主要影响 Vite 打包过程
      "@": path.resolve(__dirname, ''src''),
    },
      //或
      // 定义一个别名 ''@''，该别名对应于当前 JavaScript 模块文件所在目录下的 ''src'' 目录的绝对文件路径。
      //''@'': fileURLToPath(new URL(''./src'', import.meta.url))
  },
  server: {
    port: 1856,//自定义本地启动端口
    proxy: {//配置代理跨域
      // 带选项写法：http://localhost:5173/api/bar -> http://jsonplaceholder.typicode.com/bar
      ''/api'': {
        target: ''https://www.yangmufa.cn'',
        changeOrigin: true,
      },
    }
  }
});

```

#### vite-env.d.ts

```typescript
/// <reference types="vite/client" />

//vite使用的是ts，ts不识别.vue 后缀的文件 的解决办法
declare module "*.vue" {
    import { DefineComponent } from "vue"
    const component: DefineComponent<{}, {}, any>;
    export default component
}

```

#### tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "useDefineForClassFields": true,
    "module": "ESNext",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "preserve",
    //"jsx": "script-setup",

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,

    // 设置类型声明文件的根目录
    "typeRoots": ["./node_modules/@types", "./src/types"],
    // 指定要包含的类型声明文件
    "types": ["webpack-env", "jest", "@vue/runtime-core","node"],
      
      
    //让IDE可以进行路径智能提示,不配置此项 配置vite.config.ts的src文件夹配置别名不会生效
    "baseUrl": "../mini",
    "paths": {
      "@/*": [
        "src/*"
      ]
    },
      
      
    "allowSyntheticDefaultImports": true
  },
  "include": ["src/**/*.ts", "src/**/*.d.ts", "src/**/*.tsx", "src/**/*.vue"],
  "references": [{ "path": "./tsconfig.node.json" }]
}

```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060917370976866304, 2060917370972672000, '# Node.js



### Download

https://nodejs.org/zh-cn/download/releases

### Install



## NVM

nvm即node version manager可以管理node不同版本之间的丝滑切换

#### Download

https://github.com/coreybutler/nvm-windows/releases

#### EnvironmentVariables

```shell
VariableUsername: NVM_HOME
VariableValue: D:\DevelopmentKit\Nvm
VariableUsername: NVM_SYMLINK
VariableValue: D:\DevelopmentKit\Nvm\nodejs
```

#### CMD

```shell
nvm root # 查看nvm安装路径 
nvm -v # 查看nvm版本
nvm version # 查看nvm版本
nvm list available # 查询可以下载的node版本
nvm install latest  # 下载最新的node版本和与之对应的npm版本
nvm install 20.10.0 #安装指定版本的node
nvm uninstall 20.10.0 # 卸载node 20.10.0 版本
nvm list # 查看已经安装的版本
nvm list installed #查看已经安装的版本
nvm use 20.10.0 # 选择当前系统使用的node版本
nvm alias <alias> <version> # 为指定的 Node.js 版本设置别名
nvm use <alias> # 通过别名切换到对应的 Node.js 版本。
nvm install 安装最新版本nvm
nvm current显示当前版本
nvm alias <name> <version> # 给不同的版本号添加别名
nvm unalias <name> # 删除已定义的别名
nvm reinstall-packages <version> # 在当前版本node环境下，重新全局安装指定版本号的npm包
nvm on # 打开nodejs控制
nvm off # 关闭nodejs控制
nvm proxy # 查看设置与代理
nvm node_mirror [url] # 设置或者查看setting.txt中的node_mirror，如果不设置的默认是 https://nodejs.org/dist/
nvm npm_mirror [url] # 设置或者查看setting.txt中的npm_mirror,如果不设置的话默认的是： https://github.com/npm/npm/archive/.
nvm uninstall <version> # 卸载制定的版本
nvm use [version] [arch] # 切换制定的node版本和位数
nvm root [path] # 设置和查看root路径
nvm version # 查看当前的版本
```

## NPM
NPM（Node Package Manager）是 Node.js 的默认包管理工具，用于安装、管理和共享 JavaScript 代码模块。它拥有全球最大的开源库生态系统（npm registry），是前端开发和 Node.js 后端开发的核心工具之一。

### 一、安装 NPM
NPM 随 Node.js 自动安装，无需单独安装。
1. 安装 Node.js（包含 NPM）
   Windows/macOS/Linux
   从 Node.js 官网 下载并安装 LTS 版本。
验证安装
```shell
node -v  # 检查 Node.js 版本
npm -v   # 检查 npm 版本
```
2. 更新 NPM
```shell
npm install -g npm@latest
```
### 二、配置 NPM
1. 设置镜像源（国内加速）
   默认源可能较慢，可切换至国内镜像：
```shell
# 查看所有配置情况
npm config list
# 查看当前源
npm config get registry
# 切换为淘宝源
npm config set registry https://registry.npmmirror.com
# 恢复默认源
npm config set registry https://registry.npmjs.org
```
常用镜像源：  
淘宝 NPM 镜像：https://registry.npmmirror.com   
(http://registry.npm.taobao.org 已废弃,会被301重定向到 https://registry.npmmirror.com)  
腾讯云：https://mirrors.cloud.tencent.com/npm/  
华为云：https://mirrors.huaweicloud.com/repository/npm/  
2. 全局安装路径配置
```shell
# 查看全局安装路径
npm root -g
# 修改全局安装路径（需提前创建目录）
npm config set prefix "D:\npm-global"
```
配置后需将新路径加入系统 PATH 环境变量。
3. 缓存管理
```shell
# 查看缓存目录
npm config get cache
# 清理缓存
npm cache clean --force
# 修改缓存目录
npm config set cache "D:\npm-cache"
```
### 三、NPM 常用命令
```shell
功能	命令	说明  
npm init	# 初始化项目-	生成 package.json  
npm init -y	# 快速初始化-	跳过问答，使用默认配置  
npm install <package>	# 安装依赖-	安装到 node_modules  
npm install -g <package>	# 全局安装-	安装到全局  
npm install --save <package>	# 安装生产依赖-	写入 dependencies  
npm install --save-dev <package>	# 安装开发依赖-	写入 devDependencies  
npm uninstall <package>	# 卸载依赖-	移除依赖  
npm update <package>	# 更新依赖-	更新至最新版本  
npm run <script>	# 运行脚本-	执行 package.json 中的脚本  
npm list	# 查看已安装包-	查看项目依赖  
npm list -g --depth=0	# 查看全局包-	查看全局安装的包 
```
### 四、NPM 高级用法
1. 使用 npx 执行临时命令
```shell
npx create-react-app my-app  # 临时安装并运行 create-react-app
```
2. 版本控制
^1.2.3：允许次版本号和修订号更新（如 1.x.x）。
~1.2.3：只允许修订号更新（如 1.2.x）。
1.2.3：锁定精确版本。
3. 发布自己的包
```shell
npm login                  # 登录 npm 账号
npm publish                # 发布当前包
npm version patch          # 更新版本号（patch/minor/major）
```
### 五、常见问题
1. 权限问题（Linux/macOS）
```shell
# 避免 sudo 执行 npm install -g
sudo chown -R $USER /usr/local/lib/node_modules
```
2. 依赖冲突
   使用 npm ls 检查依赖树：
```shell
npm ls <package>  # 查看某个包的依赖关系
```
3. 删除 node_modules 重新安装
```shell
rm -rf node_modules package-lock.json
npm install
```


## PNPM
PNPM是npm的替代品，pnpm安装速度更快.
安装速度更快，安装速度
### 一、安装pnpm
环境准备：
确保已经安装了Node.js和npm。pnpm依赖于npm进行安装和管理。
通过npm安装pnpm：
打开命令行工具（在Windows上可以是cmd或PowerShell，Mac或Linux上可以是终端）。
执行以下命令全局安装pnpm：
```shell
pnpm install pnpm -g
```
执行以下命令全局更新pnpm：
```shell
pnpm update pnpm -g
```
### 二、配置pnpm
查看当前npm源（可选，但推荐）：
查看当前的pnpm源设置，使用命令：
```shell
pnpm config get registry
```
对于pnpm，虽然它的源设置通常与npm同步，也可以单独为pnpm设置源  
淘宝 NPM 镜像： https://registry.npmmirror.com  
阿里云 NPM 镜像：https://npm.aliyun.com  
腾讯云 NPM 镜像：https://mirrors.cloud.tencent.com/npm/  
华为云 NPM 镜像：https://mirrors.huaweicloud.com/repository/npm/  
网易 NPM 镜像：https://mirrors.163.com/npm/  
```shell
pnpm config set registry https://registry.npmmirror.com
```
查看缓存路径
```shell
pnpm store path
```
配置pnpm的全局安装路径和缓存路径（可选）：  
如果你希望自定义pnpm的全局安装路径和缓存路径，可以使用以下命令：  
```shell
pnpm config set global-dir <自定义全局安装路径>  
pnpm config set store-dir <自定义存储路径>
```


## 开启Yarn

nodejs16.10以上版本安装时自带了yarn，通过corepack 即可开启，执行命令如下：

Win键+X键 打开 WindowsPowerShell(管理员) 命令行窗口执行 不然报错

```shell
corepack enable # 16以上版本

```


## Yarn
Yarn 是一个快速、可靠、安全的 JavaScript 依赖管理工具。以下是关于 Yarn 的配置查看与修改、安装路径管理、缓存管理以及常用命令的完整指南。
### 一、Yarn 配置查看与修改
1. 查看当前配置  
```shell
# 查看所有配置
yarn config list
# 查看特定配置（如 registry）
yarn config get registry
```
2. 修改配置
```shell
# 修改配置（如设置淘宝镜像源）
yarn config set registry https://registry.npmmirror.com
```
3. 配置文件位置  
   全局配置：~/.yarnrc (Linux/macOS) 或 %USERPROFILE%\.yarnrc (Windows)  
项目配置：项目根目录下的 .yarnrc
### 二、Yarn 安装路径管理
1. 全局安装路径
```shell
# 查看全局安装路径
yarn global dir
# 修改全局安装路径（需同时修改bin链接,需提前创建目录）
yarn config set global-folder "D:\yarn-global"
yarn config set prefix "D:\yarn-global\bin"
```
2. 项目安装路径  
   默认安装在项目目录的 node_modules 中，不可修改路径。
### 三、Yarn 缓存路径管理  
1. 查看缓存路径
```shell
yarn cache dir
```
2. 修改缓存路径  
```shell
# 永久修改缓存路径
yarn config set cache-folder "D:\yarn-cache"
# 临时修改（单次有效）
yarn install --cache-folder "D:\temp-yarn-cache"
```
3. 缓存目录结构  
   text  
   .yarn/cache/  
   ├── v6/  
   │   ├── npm-package-1.0.0.tgz  
   │   └── ...  
   └── ...  
### 四、Yarn 基本命令
1. 安装依赖
```shell
# 安装所有依赖（根据 package.json）
yarn install
# 安装生产依赖
yarn add <package>
# 安装开发依赖
yarn add <package> --dev
# 全局安装
yarn global add <package>
```
2. 卸载依赖  
```shell
# 卸载项目依赖
yarn remove <package>
# 卸载全局包
yarn global remove <package>
```
3. 更新依赖
```shell
# 更新所有依赖
yarn upgrade
# 更新特定包
yarn upgrade <package>
```
### 五、Yarn 缓存管理
1. 清理缓存
```shell
# 清理所有缓存
yarn cache clean
# 清理指定包的缓存
yarn cache clean <package-name>
```
2. 查看缓存内容
```shell
# 列出所有缓存包
yarn cache list
```
3. 缓存策略优化
```shell
# 设置缓存过期时间（单位：秒）
yarn config set cache-lifetime 86400  # 24小时
```
### 六、Yarn 常用配置示例
1. 配置淘宝镜像
```shell
yarn config set registry https://registry.npmmirror.com
```
2. 禁用进度条（提升CI速度）
```shell
yarn config set no-progress true
```
3. 设置网络超时
```shell
yarn config set network-timeout 600000  # 10分钟
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060918288304705536, 2060918288300511232, '# SCSS

### 全局引入

```scss
// 1. 
import "./StationScreen.scss"
import "@/components/StationScreen.scss"

```

### CSS Modules

CSS Modules 是一种在 React 项目中管理样式的技术，它可以帮助实现样式的模块化和作用域隔离。使用 CSS Modules 可以让每个组件的样式都处于独立的命名空间中，避免全局样式污染和命名冲突。在使用 CSS Modules 时，通常会将 CSS 文件以 `.module.css` 的格式命名，例如 `styles.module.css`。这样的文件将被视为 CSS Modules 文件，其中定义的类名会自动进行局部作用域处理.

模块化引入的命名会加上.module,只有在文件名以 .module.css 结尾时，才会被视为 CSS Modules 文件，并且才能发挥 CSS Modules 的作用.

```tsx
// 模块化引入
import SSStyle2 from "@/components/StationScreen.module.scss"; 

// 注: webpack项目中根目录react-app-env.d.ts文件需要有如下配置
declare module ''*.module.scss'' {
  const classes: { readonly [key: string]: string };
  export default classes;
}
```

### CSS-in-JS

CSS-in-JS 是一种在 React 应用中管理样式的方法，它将 CSS 样式直接写入 JavaScript 文件中，实现了组件级别的样式化和作用域隔离。通过 CSS-in-JS 库，开发者可以利用 JavaScript 的能力来动态生成样式，实现更灵活和强大的样式管理方式.

这些 CSS-in-JS 库都提供了不同的特性和语法，开发者可以根据项目需求选择最适合的库来管理样式，它们通常能够帮助提高代码的可维护性、可读性和灵活性，同时实现样式的作用域隔禽和重用.

1.**Styled Components**：Styled Components 是一个功能强大且易于使用的 CSS-in-JS 库，它允许你在 React 组件中编写 CSS 样式，并且支持嵌套、动态样式和全局样式等特性.

```tsx
import styled from ''styled-components'';

const Button = styled.button`
  background-color: ${props => props.primary ? ''blue'' : ''green''};
  color: white;
`;

// 在组件中使用
<Button primary>Primary Button</Button>
```

2.**Emotion**：Emotion 是另一个流行的 CSS-in-JS 库，它提供了类似于 Styled Components 的 API，并且支持提取样式、媒体查询、组合样式等功能.

```tsx
/** @jsxImportSource @emotion/react */
import { css } from ''@emotion/react'';

const buttonStyles = css`
  background-color: blue;
  color: white;
`;

// 在组件中使用
<button css={buttonStyles}>Click me</button>
```

3.**Radium**：Radium 是一个支持内联样式、伪类处理和媒体查询的 CSS-in-JS 库，适用于需要更细粒度控制的场景.

```tsx
import Radium from ''radium'';

const styles = {
  base: {
    background: ''blue'',
    color: ''white''
  }
};

// 在组件中使用
const MyComponent = () => (
  <div style={[styles.base, { fontSize: ''16px'' }]}>Hello, Radium!</div>
);

export default Radium(MyComponent);
```







#### **深度选择器**

Vue3项目中 style scope lang="ts"时,由于使用了scope 声明局部作用域,
当temple标签内部再有组件时,其组件内部的样式无法直接被作用到,需得使用深度选择器进行穿透.

```vue
/* 在 SCSS 中使用 深度选择器 时，需要注意一些语法上的变化。*/

/* Vue3 用 :deep 来表示 Vue3也是最常用和最好理解的
 .child 选择器将样式应用于 child-component 中类名为 .child 的元素。*/
<template>
  <div class="parent">
    <child-component class="child"></child-component>
  </div>
</template>
<style lang="scss" scoped>
  .parent {
    :deep(.child){
      color: red;
    }
  }
</style>

/* Vue2 在 SCSS 中 ::v-deep 表示 
 .child 选择器将样式应用于 child-component 中类名为 .child 的元素。 */
<style scoped lang="scss">
.login_container {
  ::v-deep(.el-dialog_body) {
    border-top: 1px solid red;
  }
}
</style>

/* Vue2 在 SCSS 中 /deep/ 同样可以表示 
 .child 选择器将样式应用于 child-component 中类名为 .child 的元素。 */
<template>
  <div class="parent">
    <child-component class="child"></child-component>
  </div>
</template>
<style lang="scss" scoped>
  .parent {
    /deep/ .child {
      color: red;
    }
  }
</style>

/* Vue2 在 SCSS 中 >>> 也可以用来表示深度选择器   */
<template>
  <div class="parent">
    <child-component class="child"></child-component>
  </div>
</template>
<style lang="scss" scoped>
  .parent {
    >>> .child {
      color: red;
    }
  }
</style>



/*
无论是使用 :deep 还是 >>> 或 ::v-deep 或 /deep/ ，它们的作用是相同的，都可以让你在 SCSS 中修改子组件中的样式。
记得在 Vue 组件的 style 标签中声明 scoped 属性，以限制样式的作用域。

需要注意的是 在Vue3中推荐使用 :deep , Vue2中推荐使用 >>> 或 ::v-deep 或 /deep/, Vue2中的选择器在Vue3中是已经被弃用了的，在开发中应该尽可能的避免使用深度作用选择器，而尽可能通过 props 或全局样式来实现组件样式的定制化。
*/
```
#### 常见问题

```text
1.子元素上下margin不以父元素为参照 父元素设置了margin: 0px;

1.1.原因是:当一个元素具有 margin 属性时，它的 margin 可以与其相邻元素的 margin 合并（也称为折叠）。合并后的 margin 会应用于父元素或者相邻元素，从而影响到它们的间距。

1.2合并 margin 的条件是：
父元素和子元素之间没有 padding、border 或清除浮动等间隔性的干扰。
父元素和子元素都具有垂直方向上的 margin（例如上下 margin）。

1.3.常见的合并场景：
相邻兄弟元素的上下 margin 会合并。合并后的 margin 取两个 margin 中的较大值。
父元素的上下 margin 和第一个/最后一个子元素的上下 margin 会合并。合并后的 margin 取两个 margin 中的较大值。

1.4.例如，考虑以下结构：
html
<div class="parent">
  <div class="child">Child 1</div>
  <div class="child">Child 2</div>
</div>
css
.child {
  margin-top: 20px;
  margin-bottom: 30px;
}
.parent {
  background-color: lightgray;
  padding: 10px;
}
在上述示例中，两个子元素 .child 的 margin-top 和 margin-bottom 分别为 20px 和 30px。由于父元素 .parent 具有 padding，它不会发生与子元素之间的 margin 合并。
如果去掉父元素的 padding：
css
.parent {
  background-color: lightgray;
}
这时父元素 .parent 的上下 margin 会与第一个子元素 .child 的上下 margin 合并，合并后的 margin 取较大值（30px）：
.child {
  margin-top: 30px;
  margin-bottom: 30px;
}
这就是为什么当你会观察到 margin 看起来影响了父元素的原因。
注意，合并 margin 的行为是 CSS 相关规范中定义的，并不是事件冒泡。

1.5.要防止 margin 的合并，您可以使用以下方法之一：
使用 border 或 padding：在父元素中添加 border 或 padding 可以防止父元素的 margin 与子元素的 margin 合并。
css
.parent {
  padding: 1px; /* 添加一个小的 padding */
}
或者
css
.parent {
  border: 1px solid transparent; /* 添加一个透明的边框 */
}
使用 overflow 属性：将父元素的 overflow 属性设置为非 visible 值也可以防止 margin 合并。
css
.parent {
  overflow: auto; /* 或者使用 hidden、scroll 等值 */
}
这些方法会干扰 margin 的合并行为，从而使父元素的 margin 不会受到子元素 margin 的影响。选择其中一个方法就可以有效地防止 margin 合并。
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060920055960571904, 2060920055952183296, '# ECharts
### 基本概念

#### 容器

容器（container）是图表展示的区域，可以是 div 元素或者画布（canvas）元素;

在使用 ECharts 时，容器是指用于承载图表的 HTML 元素。ECharts 会将图表渲染到指定的容器中，使其展示在网页上。

要创建一个容器供 ECharts 使用，可以在 HTML 中添加一个 `<div>` 元素，并为其设置一个唯一的 ID，作为容器的标识。例如：

```html
在 HTML 中，给容器元素添加一个样式类或内联样式，并通过 width 和 height 属性来指定容器的宽度和高度。

使用 html 创建容器并设置宽高
<div id="chart-container" style="width: 500px; height: 300px;"></div>
这样就将容器的宽度设置为 500 像素，高度设置为 300 像素。

使用 JavaScript 设置宽高
在 JavaScript 中，可以通过获取容器元素的引用，然后使用其 DOM 属性来设置宽度和高度。例如：
var container = document.getElementById(''chart-container'');
container.style.width = ''500px'';
container.style.height = ''300px'';
```

#### 初始化和重载

在使用 ECharts 的 JavaScript 代码中，需要获取这个容器元素的引用，并将其传递给 ECharts 的初始化函数。例如：

```javascript
var chartContainer = document.getElementById(''chart-container''); // 获取DOM对象(容器)

var myChart = echarts.init(chartContainer); // 初始化

myChart.setOption(option,true); // 渲染图表,参数1_图表配置项,参数2_每次调用时新的配置项是否覆盖原有配置项中存在的同名属性，其他属性则会保留原有的配置.

myChart.clear(); // 清除图表实例中已有的内容,包括所有的系列和数据,释放内存空间,并将实例重置为未初始化状态,在清除完成后，可以使用 setOption(option,true) 方法重新加载新的配置项并绘制图表.

myChart.resize(); //方重新调整图表的尺寸以适应容器的变化,当小改变时,特别是在响应式布局或动态调整容器大小的情况下,使用该方法可以确保图表的尺寸与容器相匹配.

```

#### 图表

图表（chart）是由多个元素组成的可视化图形，例如柱状图、散点图、饼图等;

在 ECharts 中，图表是指通过数据和配置项进行描述的可视化图形。ECharts 支持多种类型的图表，包括但不限于折线图、柱状图、饼图、散点图、雷达图等。

要创建一个图表，需要使用 ECharts 的 JavaScript API，并将图表的数据和配置项传递给相应的函数。下面以柱状图为例，介绍创建图表的一般步骤：

```javascript
// 引入 ECharts 库：
// 在 HTML 文件中引入 ECharts 的 JavaScript 库文件：
<script src="https://cdn.jsdelivr.net/npm/echarts@5.2.1/dist/echarts.min.js"></script>
// vue3项目中JavaScript引入ECharts:
import * as echarts from ''docs/FrontFnd/VueEcology/ECharts/ECharts'';

// 准备容器：在 HTML 中创建一个容器元素，用于承载图表的展示：
<div id="chart-container" style="width: 500px; height: 300px;"></div>

// 获取容器引用：使用 JavaScript 获取容器元素的引用：
var chartContainer = document.getElementById(''chart-container'');

// 初始化图表实例：通过 echarts.init 方法初始化一个图表实例，并将容器引用传递给它：
var chart = echarts.init(chartContainer);

// 配置图表：创建一个配置项对象，其中包含图表的类型（如 ''bar'' 表示柱状图）、数据、样式等信息：
var option = {
    // 图表类型
    type: ''bar'',
    // 数据
    data: [10, 20, 30, 40, 50],
    // 其他配置项...
};

// 渲染图表：通过调用图表实例的 setOption 方法，将配置项应用到图表中，并渲染图表：
chart.setOption(option, true);
```

#### 元素

元素（element）是图表中的一个基本单元，例如坐标轴、系列、标签、数据等；

##### 坐标轴（Axis）

用于定义图表的坐标系和刻度

使用 `xAxis` 和 `yAxis` 配置项来定义一个分类（category）类型的 x 轴和一个数值（value）类型的 y 轴

```javascript
javascript复制代码option = {
  xAxis: {
    type: ''category'',
    data: [''A'', ''B'', ''C'', ''D''],
    axisLine: {
      lineStyle: {
        color: ''red'', // X轴线颜色
        width: 2, // X轴线宽度
        type: ''dashed'' // X轴线类型（实线/虚线）
      }
    },
    axisTick: {
      show: false, // 显示刻度线
      alignWithLabel: true, // 刻度线与标签对齐
      lineStyle: {
      color: ''red'', // 刻度线颜色
      width: 2 // 刻度线宽度
      }
    },
  },
  yAxis: {
    type: ''value'',
    splitLine: {
      show: true, // 是否显示分隔线
      lineStyle: {
        color: ''#ddd'', // 分隔线颜色
        width: 1, // 分隔线宽度
        type: ''dashed'', // 分隔线类型
        opacity: 0.5, // 分隔线不透明度
      },
    },
  }
};
```

##### 系列（Series）

定义和配置图表中具体的数据系列（例如折线、柱状、饼图等）

使用 `series` 配置项定义了一个柱状图（bar）系列，该系列的数据为 [10, 20, 30, 40]

```javascript
javascript复制代码option = {
  series: [{
    padding: [10, 10, 10, 10], //饼图无效
    type: ''bar'',
    data: [10, 20, 30, 40]
  }]
};
```

##### 标签（Label）

在图表上显示数据标签，辅助数据展示

使用 `label` 配置项将饼图（pie）系列的标签显示在图形内部，并设置其他相关样式

```javascript
javascript复制代码option = {
  series: [{
    type: ''pie'',
    left: "-50%" , // 设置标签与扇区外边的距离
    data: [
      { value: 335, name: ''A'' },
      { value: 310, name: ''B'' },
      { value: 234, name: ''C'' },
      { value: 135, name: ''D'' }
    ],
    label: {
      show: true,
      position: ''inside''
    }
  }]
};
```

##### 数据（Data）

使用 `data` 配置项定义了折线图（line）系列的数据为 `[10, 20, 30, 40]`，并通过 `symbolSize` 函数来控制数据点的大小

```javascript
javascript复制代码option = {
  series: [{
    type: ''line'',
    data: [10, 20, 30, 40],
    symbolSize: function (data) {
      return Math.sqrt(data);
    }
  }]
};
```

##### 网格(grid)

```text
show: 是否显示网格，默认为 true。
borderColor: 网格边框颜色，默认为 ''#ccc''。
borderWidth: 网格边框宽度，默认为 0。
backgroundColor: 网格背景色，默认为 ''transparent''。
containLabel: 网格是否包含坐标轴标签（即是否将坐标轴标签计算在内），默认为 false。
left: 网格左侧的距离，默认为 ''10%''。
right: 网格右侧的距离，默认为 ''10%''。
top: 网格顶部的距离，默认为 ''60''。
bottom: 网格底部的距离，默认为 ''40''。
z: 网格所在的 z 轴层级，默认为 0。
zlevel: 网格所在的 Canvas 分层，默认为 0。
shadowBlur: 网格阴影的大小，默认为 0。
shadowColor: 网格阴影的颜色，默认为 ''transparent''。
shadowOffsetX: 网格阴影的水平偏移量，默认为 0。
shadowOffsetY: 网格阴影的垂直偏移量，默认为 0。
tooltip: 鼠标悬浮时的提示框。
```



##### 标题和副标题（Title and Subtitle）

用于给图表添加标题和副标题

```javascript
javascript复制代码option = {
  title: {
    text: ''图表标题'',
    subtext: ''图表副标题''
  }
};
```

##### 图例（Legend）：

用于展示不同系列数据的标记和名称，帮助区分数据

```javascript
javascript复制代码option = {
  legend: {
    data: [''系列A'', ''系列B'']
  },
  series: [
    {
      name: ''系列A'',
      // ...
    },
    {
      name: ''系列B'',
      // ...
    }
  ]
};
```

##### 工具箱（Toolbox）：

提供一些常用的操作工具，例如导出图表、数据视图等

```javascript
javascript复制代码option = {
  toolbox: {
    feature: {
      saveAsImage: {},
      dataView: {}
    }
  }
};
```

##### 提示框（Tooltip）

在鼠标悬停时显示数据信息的弹出框

```javascript
javascript复制代码option = {
  tooltip: {
    trigger: ''axis''
  },
  // ...
};
```

##### 视觉映射组件（VisualMap）

将数据映射到视觉元素上，例如颜色或大小等

```javascript
javascript复制代码option = {
  visualMap: {
    type: ''continuous'',
    min: 0,
    max: 100,
    color: [''green'', ''red'']
  },
  series: [
    {
      type: ''heatmap'',
      data: // ...
    }
  ]
};
```
### 刻度图
![](https://img.yangmufa.cn/blog-article/ECharts%E8%BD%B4%E5%88%BB%E5%BA%A6%E7%A4%BA%E4%BE%8B.png)


### 柱状图
![](https://img.yangmufa.cn/blog-article/ECharts%E7%BB%84%E6%88%90%E9%83%A8%E5%88%86_%E6%9F%B1%E7%8A%B6%E5%9B%BE%E7%A4%BA%E4%BE%8B.png)

### 堆叠图
![](https://img.yangmufa.cn/blog-article/ECharts%E7%BB%84%E6%88%90%E9%83%A8%E5%88%86_%E5%A0%86%E5%8F%A0%E5%9B%BE%E7%A4%BA%E4%BE%8B.png)


### 桑基图
![](https://img.yangmufa.cn/blog-article/ECharts%E7%BB%84%E6%88%90%E9%83%A8%E5%88%86_%E6%A1%91%E5%9F%BA%E5%9B%BE%E7%A4%BA%E4%BE%8B.jpg)


### 在顶部标题标签上添加特殊字符

```typescript
series: [
  {
    type: ''bar'',
    label: {//图标顶部显示数据标签
      show: true,
      // 在数据值后添加%
      formatter: function (params) {
        return params.data[params.seriesName].toFixed(2) + ''%'';
        //params.data代表当前柱形图数据项的对象，params.seriesName代表当前系列的名称。
        // 通过params.data[params.seriesName]获取到对应的数值，然后使用toFixed(2)方法将数值保留两位小数。
        // 最后，通过字符串拼接的方式将百分号符号添加到数值的末尾，得到形如"xx.xx%"的百分比格式字符串。
      },
      position: "top"
    }
  }
]
```

### 在刻度标签上添加特殊符号

```typescript
xAxis: { 
  name: ''amount'',
  position:"left",
  axisLabel:{
    formatter:"{value} m³",
   // formatter:"{c} m³", 
  }
},
```



### 饼图

```javascript
// 上、右、下、左的内边距,由于饼图的布局方式不是基于盒子模型的，因此设置 padding 并不会影响饼图与容器之间的距离。
padding: [10, 10, 10, 10], 
```



### 常见问题

```javascript
series.data.itemStyle.color:rgb(666 666 66)  // 此处使用rgb会导致饼图鼠标悬停时图表变成透明色(消失不见)并且选中产生抖动

// 通过监听窗口大小改变事件来实现图表的大小自适应
window.onresize = function () {
    chart.resize();//重置容器宽高
};
window.addEventListener(''resize'', function(){ //兼容性更佳
  // 调整图表大小
  chart.resize();
});
#chart {
  overflow-x: hidden; /* 禁止横向滚动条 */
  width: 100%; /* 宽度占满容器 */
}
      
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060384515691515904, 2060384515678932992, '# MinIO 迁移到 RustFS

## 1. 迁移目标

最小改动原则：

```text
桶名不变
对象路径不变
AccessKey / SecretKey 不变
图片公网域名不变
后端配置尽量不变
前端不改
数据库不改
```

本项目后端现在使用 `RustFS` 配置节，并通过 S3 兼容客户端访问 RustFS。

示例：

```json
"RustFS": {
  "Endpoint": "http://127.0.0.1:9000",
  "UseSsl": false,
  "PublicEndpoint": "https://img.example.com",
  "AccessKey": "账号",
  "SecretKey": "密码",
  "BucketName": "blog-article"
}
```

只要 RustFS 最终接管 `9000` 端口，并且 `img.example.com` 仍然反向代理到 `9000`，项目代码和数据库图片地址都不需要修改。

## 2. 为什么不能直接挂载 MinIO 数据目录

RustFS 与 MinIO 都支持 S3 协议，但这只代表客户端访问协议兼容，不代表底层磁盘格式兼容。

不建议这样做：

```text
RustFS 直接挂载 /opt/docker/datas/minio/data
```

原因：

- MinIO 数据目录包含 `.minio.sys`、元数据、策略、分片、版本等内部结构；
- RustFS 有自己的存储布局和元数据格式；
- 直接挂载可能导致 RustFS 看不到对象，或者破坏 MinIO 原数据；
- 一旦写入后再回滚到 MinIO，风险更高。

推荐方式是通过 S3 API 做逻辑迁移：

```text
MinIO S3 API -> RustFS S3 API
```

工具可以使用 `mc` 或其他 S3 兼容同步工具。

## 3. 服务器目录规划

沿用项目 Docker 数据目录风格：

```text
MinIO 旧目录：/opt/docker/datas/minio
RustFS 新目录：/opt/docker/datas/RustFS
mc 配置目录：/opt/docker/datas/mc
```

RustFS 目录结构：

```text
/opt/docker/datas/RustFS/data
/opt/docker/datas/RustFS/logs
```

创建目录：

```bash
sudo mkdir -p /opt/docker/datas/RustFS/{data,logs}
sudo chmod -R 777 /opt/docker/datas/RustFS
```

> `chmod 777` 适合迁移验证阶段快速排除权限问题。生产环境可根据 RustFS 容器实际运行用户收紧权限。

## 4. 临时启动 RustFS

迁移阶段不要直接占用 MinIO 正在使用的 `9000` 端口，先让 RustFS 使用宿主机 `9002`：

```bash
docker run -d \
  --name RustFS \
  --restart unless-stopped \
  -p 9002:9000 \
  -v /opt/docker/datas/RustFS/data:/data \
  -v /opt/docker/datas/RustFS/logs:/logs \
  -e RUSTFS_ACCESS_KEY=账号 \
  -e RUSTFS_SECRET_KEY=密码 \
  rustfs/rustfs:latest
```

查看日志：

```bash
docker logs -f RustFS
```

如果出现：

```text
Permission denied (os error 13)
```

Rocky Linux / CentOS / RHEL 服务器可能是目录权限或 SELinux 导致。可以改用 `:Z` 挂载：

```bash
docker rm -f RustFS

docker run -d \
  --name RustFS \
  --restart unless-stopped \
  -p 9002:9000 \
  -v /opt/docker/datas/RustFS/data:/data:Z \
  -v /opt/docker/datas/RustFS/logs:/logs:Z \
  -e RUSTFS_ACCESS_KEY=账号 \
  -e RUSTFS_SECRET_KEY=密码 \
  rustfs/rustfs:latest
```

## 5. 使用 Docker 版 mc

如果服务器不能直接下载 `mc`，可以使用 Docker 版 `minio/mc`。

创建配置目录：

```bash
sudo mkdir -p /opt/docker/datas/mc
```

设置临时命令别名：

```bash
alias dmc=''docker run --rm -it --add-host=host.docker.internal:host-gateway -v /opt/docker/datas/mc:/root/.mc minio/mc''
```

配置旧 MinIO 和新 RustFS：

```bash
dmc alias set old-minio http://host.docker.internal:9000 账号 密码
dmc alias set new-rustfs http://host.docker.internal:9002 账号 密码
```

查看 MinIO 里的桶：

```bash
dmc ls old-minio
```

示例输出：

```text
blog-article/
blog-system/
example-blog/
test/
```

查看 RustFS：

```bash
dmc ls new-rustfs
```

## 6. 创建同名桶

RustFS 中需要创建和 MinIO 一样的桶名。桶名保持不变，数据库里的旧图片 URL 才能继续访问。

示例：

```bash
for bucket in blog-article blog-system example-blog test; do
  dmc mb --ignore-existing new-rustfs/$bucket
done
```

查看：

```bash
dmc ls new-rustfs
```

## 7. 同步对象

可以使用 `mc mirror`：

```bash
for bucket in blog-article blog-system example-blog test; do
  dmc mirror old-minio/$bucket new-rustfs/$bucket
done
```

如果 `mirror` 显示 `0 B / ?` 或目标桶没有对象，可以改用 `cp --recursive` 强制复制：

```bash
for bucket in blog-article blog-system example-blog test; do
  echo "==== copy $bucket ===="
  dmc cp --recursive old-minio/$bucket/ new-rustfs/$bucket/
done
```

注意源和目标路径后面的 `/`：

```text
old-minio/$bucket/
new-rustfs/$bucket/
```

## 8. 设置公开读取

图片桶需要浏览器可以访问，因此要设置匿名下载权限：

```bash
for bucket in blog-article blog-system example-blog test; do
  dmc anonymous set download new-rustfs/$bucket
done
```

如果某些桶是私有文件桶，不要设置公开读。博客图片、头像、封面等公开图片桶需要设置。

## 9. 校验对象数量

迁移后对比每个桶的对象数量：

```bash
for bucket in blog-article blog-system example-blog test; do
  echo "==== $bucket ===="
  echo -n "old-minio: "
  dmc ls --recursive old-minio/$bucket | wc -l
  echo -n "new-rustfs: "
  dmc ls --recursive new-rustfs/$bucket | wc -l
done
```

期望新旧数量一致：

```text
blog-article old 3 / new 3
blog-system  old 19 / new 19
example-blog     old 200 / new 200
test         old 1 / new 1
```

## 10. 验证公开访问

先列出真实对象路径，不要凭文件名猜：

```bash
dmc ls --recursive new-rustfs/blog-system
```

测试一张确定存在的图片：

```bash
curl -I http://127.0.0.1:9002/blog-system/author-avatar.jpg
```

成功时返回类似：

```text
HTTP/1.1 200 OK
content-type: image/jpeg
```

如果返回 `404`，优先检查对象是否真的在该桶和该路径下。

如果返回 `403`，检查匿名下载权限是否设置成功。

## 11. 正式切换

确认 RustFS `9002` 访问正常后，开始正式切换。

### 11.1 停后端

先停止后端，避免切换期间继续有新图片写入 MinIO：

```bash
sudo systemctl stop mint-blog-api
```

### 11.2 最终增量同步

```bash
for bucket in blog-article blog-system example-blog test; do
  echo "==== final copy $bucket ===="
  dmc cp --recursive old-minio/$bucket/ new-rustfs/$bucket/
done
```

再次核对数量：

```bash
for bucket in blog-article blog-system example-blog test; do
  echo "==== $bucket ===="
  echo -n "old-minio: "
  dmc ls --recursive old-minio/$bucket | wc -l
  echo -n "new-rustfs: "
  dmc ls --recursive new-rustfs/$bucket | wc -l
done
```

### 11.3 停 MinIO

先只停止，不要删除 MinIO 容器和数据目录：

```bash
docker stop MinioExample
```

如果容器名不同，先查看：

```bash
docker ps -a
```

### 11.4 重建 RustFS 接管 9000

删除临时 `9002` RustFS 容器：

```bash
docker rm -f RustFS
```

用 `9000` 重新启动：

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

验证本机访问：

```bash
curl -I http://127.0.0.1:9000/blog-system/author-avatar.jpg
```

配置 `mc` 新别名验证：

```bash
dmc alias set rustfs-9000 http://host.docker.internal:9000 账号 密码
dmc ls rustfs-9000
```

### 11.5 验证公网图片域名

如果原来 `img.example.com` 已经反向代理到宿主机 `9000`，切换后不需要改 Nginx。

验证：

```bash
curl -I https://img.example.com/blog-system/author-avatar.jpg
```

成功时返回：

```text
HTTP/2 200
content-type: image/jpeg
```

### 11.6 启动后端

```bash
sudo systemctl start mint-blog-api
sudo systemctl status mint-blog-api
```

## 12. 切换后验证

建议在后台管理页面测试：

1. 上传一张图片；
2. 打开返回的图片 URL；
3. 删除这张测试图片；
4. 刷新后台图片列表；
5. 前台文章、头像、封面正常显示；
6. Nginx 图片域名 `https://img.example.com` 正常访问。

也可以命令行验证：

```bash
dmc ls --recursive rustfs-9000/blog-article
curl -I https://img.example.com/blog-system/author-avatar.jpg
```

## 13. 防止 MinIO 和 RustFS 重启抢端口

RustFS 已接管 `9000` 后，应关闭 MinIO 自动重启，避免服务器重启后 MinIO 和 RustFS 抢占 `9000`：

```bash
docker update --restart=no MinioExample
```

检查重启策略：

```bash
docker inspect MinioExample --format ''{{.HostConfig.RestartPolicy.Name}}''
docker inspect RustFS --format ''{{.HostConfig.RestartPolicy.Name}}''
```

期望：

```text
no
unless-stopped
```

## 14. 回滚方案

如果切换后发现问题，可以快速回滚到 MinIO：

```bash
docker rm -f RustFS
docker start MinioExample
sudo systemctl restart mint-blog-api
```

因为后端仍然访问 `127.0.0.1:9000`，MinIO 重新占用 `9000` 后即可恢复旧对象存储。

## 15. 清理建议

确认 RustFS 稳定运行数天后再清理旧 MinIO。

建议顺序：

1. 先保留 `MinioExample` 容器和 `/opt/docker/datas/minio` 数据目录；
2. 稳定后删除 MinIO 容器；
3. 再额外保留 MinIO 数据目录一段时间；
4. 最后确认无回滚需求时再删除旧数据。

删除 MinIO 容器：

```bash
docker rm MinioExample
```

不要急着删除：

```text
/opt/docker/datas/minio
```

## 16. 最终状态

迁移完成后的目标状态：

```text
MinIO：停止，不再自启
RustFS：运行中，占用 9000
RustFS 数据目录：/opt/docker/datas/RustFS
图片公网域名：https://img.example.com
后端配置：使用 RustFS 配置节，Endpoint 为 http://127.0.0.1:9000
前端：不改
数据库：不改
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060981521686335488, 2060981521682141184, '```c++
//编写一个程序实现输入一随机小写字母，而后将其转换为相对应的大写字母
//（分别用三元运算符和位运算符实现）（分别用代码块一和二实现）
#include <stdio.h>
void main(){

	char cat;
	char catr;


	//代码块一（不能与代码块二同时执行）
	{
	printf("输入一个小写字母用三目元运算符转换为大写字母:");
	cat=getchar();
	cat=(cat>=97&&cat<=122)?(cat-32):(cat);
	putchar(cat);

	cat=(cat>=65&&cat<=90)?(cat+=32):cat;
	printf("\n用三目运算符把大写转换为小写字母:%c\n",cat);
	}



	//代码块二（不能与代码块一同时执行）
	{
	printf("\n输入一个小写字母用位运算转换为大写字母:");
	catr=getchar();
	if(catr>=97&&catr<=122){
		catr=catr & -33;
	}
	putchar(catr);

	printf("\n用位运算把大写字母转换为小写字母:");
	if(catr<=90&&catr>=65){
		catr |= 32;
		putchar(catr);
	}
	}


	printf("\n");
}


```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060981980375420928, 2060981980371226624, '```c++
//编写程序将China译成密码，
//规律是用原来的字母后面第四位字母代替原有的字母。
#include <stdio.h>
void main(){
	char password[6]="China";
	char password1[6];
	int i=0;
	for(i=0;i<6;i++){
		if(i<5){password1[i]=password[i]+4;
		}
		if(i==5){
			password1[i]=password[i];
			break;
		}
	}
	puts(password);
	puts(password1);

}

```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060982890455502848, 2060982890451308544, '```c++
//有四个水渠要向水池灌水，单开a渠需要3天，单开b渠需要1天，
//单开c渠需要4天，单开d渠需要5天，同时放水则需要多少天。
#include <stdio.h>
void main(){
	float a=3,b=1,c=4,d=5;
	float day=1/((1/b)+(1/a)+(1/c)+(1/d));
	printf("需要 %f 天\n",day);

}');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060983092788727808, 2060983092784533504, '```c++
 int i, j, k,g,s,b,sum;
        int m=0;g=s=b=1;sum=0;
        for(i=1;i<5;i++)
        for(j=1;j<5;j++)
        for(k=1;k<5;k++){
            if(i!=j&&k!=j&&i!=k){//如果遇到相同的就跳过
                g=k*1;s=j*10;b=i*100;
                sum=g+s+b;
                //输出结果和每个数的数值
                printf("结果：%d-%d-%d ｜ 数值：%d\n",i,j,k,sum);
                m++;
            }
        }
        printf("\n      共 %d 种\n",m);
        getch();
    }
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060392182275248128, 2060392182262665216, '# Mint.Blog 系统介绍

## 1. 项目概述

Mint.Blog V3，是一个面向个人博客、技术知识沉淀、专题专栏和技术资源导航的前后端分离系统。系统由三个独立应用组成：

- **后端 API**：基于 .NET 10 / ASP.NET Core，负责业务、认证鉴权、数据访问和后台任务。
- **管理后台**：基于 Vue 3、TypeScript 和 Vite，负责内容维护及系统管理。
- **博客前台**：基于 Nuxt 4 和 Vue 3，负责公开内容展示、资源检索和读者互动。

业务数据使用 PostgreSQL 持久化，文件通过 RustFS / S3 兼容对象存储管理，邮件通知通过 SMTP 发送。

本文描述当前仓库中的实现和配置，不代表所有功能已经完成真实环境验收。首次部署需要准备数据库、账号权限数据和外部服务配置，不能仅克隆代码就直接登录使用。

## 2. 系统定位与功能

### 2.1 内容发布与知识组织

- 文章创建、编辑、发布、置顶和删除。
- Markdown 编辑与内容渲染，文章封面、正文和草稿管理。
- 分类、技术标签及标签版本管理。
- 专栏、层级目录及专栏文章组织。
- 按技术标签、版本和资源类型整理外链资源。

当前数据关系中，标签归属于分类，文章关联技术标签和标签版本；不要将其理解为文章直接绑定分类或任意多个标签的模型。

### 2.2 公开展示与互动

- 首页文章列表、文章详情、分类、标签、归档和搜索。
- 专栏列表及专栏阅读。
- 技术资源导航、版本选择、类型筛选和关键词搜索。
- 评论、留言、友情链接和画廊。
- 看板、装备、项目介绍和作者介绍页面。
- 日间／夜间主题及响应式布局。

### 2.3 后台管理

- 文章、分类、标签、标签版本、资源导航和专栏管理。
- 评论审核、逻辑删除、恢复及物理删除。
- 友情链接、图片与画廊管理，其中图片管理和画廊管理是独立模块。
- 博客基础配置、Logo、作者头像等站点信息维护。
- 用户、角色、权限、个人中心及管理操作审计。

前台存在留言页面和对应后端能力，但当前后台未提供独立的留言管理页面。

## 3. 项目结构与职责

### 3.1 后端五项目分层

解决方案为 `Mint.Blog.slnx`，包含以下五个 .NET 项目：

| 项目 | 职责 |
| --- | --- |
| `Mint.Blog.Model` | 数据实体、请求 DTO、响应 VO、配置 Options |
| `Mint.Blog.Common` | 通用响应、错误码与异常、JWT、密码哈希、邮件和对象存储适配 |
| `Mint.Blog.Repository` | 仓储接口及实现、SqlSugar 数据访问、工作单元与事务 |
| `Mint.Blog.Service` | 业务接口及实现、业务编排、后台任务和队列消费 |
| `Mint.Blog.WebApi` | 应用入口、控制器、中间件、认证授权、依赖注入和 API 文档 |

当前不再使用 `Mint.Blog.Domain`、`Mint.Blog.Application`、`Mint.Blog.Infrastructure` 三项目结构。

主要项目引用关系：

```text
Common     → Model
Repository → Common、Model
Service    → Repository、Common、Model
WebApi     → Service、Repository、Common
```

这是按职责划分的分层结构，不是严格禁止跨层引用的单向依赖链。控制器接收 HTTP 请求，Service 编排业务，Repository 承担数据库访问；WebApi 负责统一装配。

### 3.2 管理后台

目录为 `Mint.Blog.Admin.Vue`，主要代码分布：

```text
src/views/blog       博客内容、资源和站点管理页面
src/views/system     登录、用户、角色、个人中心等系统页面
src/router           路由配置
src/menu             菜单配置
src/service          API 请求封装
src/store            状态管理
src/components       通用组件
```

主要技术为 Vue 3.5、Vite 8、TypeScript 6、Ant Design Vue 4、Pinia、Vue Router 和 Tailwind CSS 4，文章编辑和统计展示使用 md-editor-v3、ECharts 等组件。

### 3.3 博客前台

目录为 `Mint.Blog.Web.Nuxt`，与管理后台独立开发、构建和部署，不再是旧单前端工程中的 `views/blog/surfer` 页面集合。

```text
app/pages            基于文件的页面路由
app/components       页面及通用组件
server/api/surfer     公开 API 的服务端转发
nuxt.config.ts       开发端口、运行时配置等
```

主要技术为 Nuxt 4、Vue 3.5、TypeScript 6、markdown-it 和 sanitize-html。生产构建生成 `.output`，通过 Node.js 服务运行，不能将其简单等同于管理后台的静态 `dist` 产物。

### 3.4 后端基础技术

- .NET / ASP.NET Core 10：Web API 与托管服务。
- SqlSugar 5、PostgreSQL：关系数据访问与持久化。
- JWT、Refresh Token、BCrypt：认证、登录续期及密码哈希。
- AWS S3 SDK：访问 RustFS / S3 兼容对象存储。
- SMTP：邮件通知。
- Serilog：日志记录。
- Scalar / OpenAPI：开发环境接口文档。

具体依赖版本以项目文件及锁文件为准。数据库结构脚本导出自 PostgreSQL 17.2，其他版本需自行验证兼容性。

## 4. 前台路由

| 路由 | 用途 |
| --- | --- |
| `/` | 首页文章列表，支持 `?page=` 分页 |
| `/articles/:id` | 文章详情 |
| `/columns` | 专栏列表 |
| `/columns/:columnId?articleId=文章ID` | 专栏阅读，查询参数指定专栏内文章 |
| `/categories?id=分类ID` | 分类文章浏览 |
| `/tags?id=标签ID` | 标签文章浏览 |
| `/resources?tagId=标签ID&tagVersionId=版本ID` | 技术资源导航 |
| `/archives`、`/search` | 归档与搜索 |
| `/friends`、`/gallery`、`/messages` | 友链、画廊与留言 |
| `/dashboard`、`/equipment` | 看板与装备 |
| `/about`、`/author` | 项目与作者介绍 |

当前文章路径为复数 `/articles/:id`，不再沿用旧文档中的 `/blog/surfer/article/{articleId}`。分类和标签通过查询参数选择，不是 `/categories/:id` 或 `/tags/:id`。

资源导航使用 `tagVersionId` 表示选中版本。页面包含分类选择、标签搜索、技术标签列表、版本选择、资源类型筛选及资源搜索；当前页面未展示独立的“站内文章”区块。

## 5. 图片与对象存储

对象存储通过 RustFS / S3 兼容接口访问，数据库保存业务信息及资源引用。桶名、服务端 Endpoint 和公开访问地址应按部署环境配置，不应将示例桶名视为固定要求。

图片管理的主要能力：

- 按桶查看图片，支持名称搜索、引用筛选、排序和分页。
- 上传、重命名、单张及批量删除。
- 单张及批量跨桶移动，批量移动支持目标同名冲突检查及覆盖选项。
- 桶列表、创建桶、公开／私有策略切换和删除桶。
- 默认桶和非空桶具有删除保护。

重命名和跨桶移动通过复制对象后删除旧对象完成。

### 5.1 引用检测与删除保护

引用检测覆盖文章封面和正文、草稿封面和正文、专栏封面、博客 Logo、作者头像、画廊图片及友链头像。单张删除遇到引用时拒绝删除，批量删除跳过已引用图片。

引用展示与删除保护的范围并非完全一致：独立草稿参与删除保护，但未关联正式文章的草稿不一定出现在引用列表中，因此列表显示“未引用”不等于一定可以删除。

### 5.2 URL 更新边界

移动或重命名后的 URL 自动替换目前覆盖文章封面和正文、草稿封面和正文、博客 Logo 及作者头像；不应宣称会自动更新所有业务引用。专栏封面、画廊图片和友链头像等引用需要额外核对。

## 6. 认证、权限与审计

后台使用 JWT Access Token 与 Refresh Token：

- 登录验证数据库中的用户及 BCrypt 密码哈希。
- Access Token 用于请求鉴权，Refresh Token 用于登录续期，数据库保存刷新令牌哈希。
- 登录会撤销该用户原有未撤销的刷新令牌；刷新采用旧令牌撤销、新令牌签发的轮换方式。
- 注销撤销对应刷新令牌，修改密码撤销该用户全部刷新令牌。
- 用户、角色及权限关联用于后台访问控制。
- 管理审计由中间件和业务服务写入数据库，相关故障记录到日志。

刷新令牌存在两条清理路径：

| 触发方式 | 当前策略 |
| --- | --- |
| 登录、刷新 | 清理已撤销或已过期，且创建时间早于 30 天前的记录 |
| 后台清理服务 | 启动时清理一次，此后每天执行，清理已撤销或已过期，且创建时间早于 7 天前的记录 |

清理判断基于创建时间，不代表失效后再完整保留 7 天或 30 天。

## 7. 数据与后台任务

### 7.1 数据范围

PostgreSQL 保存的主要数据包括：

- 文章、正文、草稿及草稿正文。
- 分类、技术标签、标签版本和导航资源。
- 专栏及层级目录。
- 评论、留言、友情链接、画廊分类和图片。
- 博客设置、阅读与访问统计。
- 用户、角色、权限及关联关系。
- Refresh Token、管理审计记录。

### 7.2 后台任务

当前 WebApi 注册四个业务后台服务：

| 服务 | 职责 |
| --- | --- |
| `CommentNotificationBackgroundService` | 消费评论通知队列，发送评论发布和审核相关通知 |
| `ArticleReadTrackingBackgroundService` | 消费文章阅读队列，异步记录阅读统计 |
| `PvRecordInitializationBackgroundService` | 启动时及之后每小时检查并准备次日 PV 统计记录 |
| `UserRefreshTokenCleanupBackgroundService` | 启动时及之后每天清理失效刷新令牌 |

实现位于 `Mint.Blog.Service/BackgroundJobs`，由 WebApi 统一注册。

## 8. 本地开发与配置

### 8.1 环境及端口

- .NET 10 SDK。
- 推荐 Node.js 24 LTS，至少 `24.15.0`。
- 管理后台使用 pnpm，至少 `10.30.3`；前台可按 README 使用 npm，与其 Docker 构建保持一致。
- PostgreSQL，以及业务所需的对象存储和 SMTP 服务。

| 服务 | 本地开发地址 |
| --- | --- |
| 后端（`http` launch profile） | `http://localhost:7000` |
| 管理后台 | `http://localhost:7100` |
| Nuxt 博客前台 | `http://localhost:8080` |

详细安装、启动、构建及类型检查命令见 [README](../README.md)。两个前端需分别安装依赖，不能在仓库根目录统一执行前端启动命令。

### 8.2 主要配置

| 应用 | 配置 |
| --- | --- |
| 后端 | `PostgreSql`、`Jwt`、`RustFS`、`Smtp`、`Site`、`CommentNotification` 等配置节 |
| 管理后台 | `VITE_SERVICE_BASE_URL`、`VITE_BLOG_WEB_URL` 等环境变量 |
| Nuxt | `NUXT_API_BASE`、`NUXT_PUBLIC_SITE_URL`、`NUXT_PUBLIC_ADMIN_SITE_URL`、`NUXT_PUBLIC_ASSET_BASE_URL`、`NUXT_PUBLIC_LEGACY_SITE_URL` |

.NET 环境变量通过双下划线分隔层级，例如 `PostgreSql__ConnectionString`。生产环境应单独提供配置，发布产物不包含开发环境配置文件。

站点地址、前后台跳转地址、API 服务端地址和对象存储公开地址需要分别配置并保持一致。不要将真实数据库凭据、JWT 签名密钥、存储密钥或 SMTP 密码提交到仓库。

### 8.3 数据库初始化

当前仓库的结构脚本见 [数据库-仅结构.sql](./数据库-仅结构.sql)。导入前必须核对脚本内容、目标库及对象所有者；其中包含删除表和序列的语句，不应直接导入已有业务库。

当前没有完整的全库自动迁移及用户权限种子初始化流程。登录页和 README 中的开发演示账号不代表新建数据库后自动存在，首次使用需要准备相应用户、角色与权限数据。`DevPasswordTools` 仅生成 BCrypt 哈希，不会创建用户。

导入含显式 ID 的历史数据后，还应核对实际绑定的自增序列是否与表内最大 ID 同步，避免新增数据出现主键冲突。

## 9. 部署形态

推荐按独立应用部署：

```text
反向代理（HTTPS、域名和 API 转发）
├─ Nuxt 博客前台（Node.js 服务）
├─ Vue 管理后台（dist 静态产物）
└─ ASP.NET Core Web API
   ├─ PostgreSQL
   ├─ RustFS / S3 兼容对象存储
   └─ SMTP 邮件服务
```

仓库提供 `Mint.Blog.WebApi/compose.yaml` 和 `Mint.Blog.Web.Nuxt/compose.yaml`：

- 两者依赖预先存在的外部网络 `mint-network`。
- 后端 Compose 支持构建，前台 Compose 需要先准备镜像。
- 后端容器监听 `7000`，Nuxt 容器监听 `3000`。
- 当前 Compose 未启用宿主机端口发布；直接访问宿主机端口前，需要添加映射，或通过同网络反向代理访问。
- Nuxt 容器通过 `http://mint-blog-server:7000/api` 访问后端。
- 管理后台需单独部署静态产物，并设置 API 反向代理。
- PostgreSQL、对象存储及反向代理不包含在这两个 Compose 所组成的完整一键部署栈中，需要另行准备。

部署细节见 [Docker 部署流程](./Docker部署流程.md)，实际参数以当前 Compose 和 Dockerfile 为准。

## 10. API 文档与验证边界

- `/api/docs`：Scalar 接口文档，仅 `Development` 环境开放。
- `/api/openapi/v1.json`：OpenAPI 描述，仅 `Development` 环境开放。
- `/api/health`：健康检查，不限制为开发环境；当前不代表数据库和对象存储专项检查已通过。

编译、类型检查及服务解析只能验证部分工程条件，不能替代真实 HTTP、数据库事务、权限、对象存储和邮件发送的运行回归。部署后应按实际启用的业务逐项验收。');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060983253065666561, 2060983253065666560, '```c
//编写程序将China译成密码，
//规律是用原来的字母后面第四位字母代替原有的字母。
#include <stdio.h>
void main(){
	char password[6]="China";
	char password1[6];
	int i=0;
	for(i=0;i<6;i++){
		if(i<5){password1[i]=password[i]+4;
		}
		if(i==5){
			password1[i]=password[i];
			break;
		}
	}
	puts(password);
	puts(password1);

}
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060983469185568768, 2060983469181374464, '```c++
long int i,x,y;
for(i=0;i<100000;i++){
  x=sqrt(i+100);//求平方根
  y=sqrt(i+168);
  if(x*x==i+100&&y*y==i+168){
    printf("- %d - \n",i);
  }
}
printf("- %d - \n",i);//检查循环有没有走到最后
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060983679907401729, 2060983679907401728, '```c++
    int i, n; 
    unsigned int month_1=2;//出生第一个月的兔子数量 
    unsigned int month_2=0;//出生第二个月的兔子数量 
    unsigned int month_3=0;//可以生娃的兔子的数量 
 
    //一个月后的兔子数量 
    unsigned int month_1_tmp=0;// 
    unsigned int month_2_tmp=0; 
    unsigned int month_3_tmp=0;  
 
    //一个月后兔子情况更新 
    for(i=0;i<10;i++) 
    {
        month_1_tmp = month_3;//生娃 
        month_2_tmp = month_1;// 
        month_3_tmp = month_2+month_3; 
 
        month_1 = month_1_tmp; 
        month_2 = month_2_tmp; 
        month_3 = month_3_tmp; 
        printf("\n第 %d 个月：%4d（一） +  %d（二） +  %d（三） =   %d（兔子总数）\r\n",
            i+1,month_1,month_2,month_3,(month_1+month_2+month_3)); 
    }
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060982637014683648, 2060982637010489344, '```c++
//本文的各案例是以多个代码块形式集合在一个主函数中，
//统一共享头文件和宏定义常量。

#include <stdio.h>
#include <stdlib.h>
#include <string.h>	
#include <ctype.h>
#include <math.h>
#define IO 996
#define N 10

void main(){

	{
		//一、数值型：主要用于解决数学问题进行一些数值运算以及科学和工程计算等。
		//交换法
		// 1、 采用一个中间变量把one和ten的值交换（不考虑直接赋值）

		int one=1;
		int ten =10;
		int c;
		printf("交换前：one=%d ten=%d",one,ten);
		c=one;
		one=ten;
		ten=c;
		printf("\n交换后：one=%d ten=%d\n",one,ten);
	}


	{
		// 2、 任意读入三个数然后对其进行逆序和顺序排列。

		int one,two,three,temporary;
		scanf("%d%d%d",&one,&two,&three);
		printf("交换前：one=%d two=%d three=%d\n",one,two,three);
		if(one>two){temporary=one;one=two;two=temporary;}
		if(one>three){temporary=one;one=three;three=temporary;}
		if(two>three){temporary=two;two=three;three=temporary;}
		printf("交换后：one=%d two=%d three=%d \n",one,two,three);
		
	}


	{
		// 3、 累加法:
		//计算1~任意大小整数步长为一的累加
		//(如：1+2+3~+99+100+N)

		int i=1;
		int temporary;
		int sum = 0;
		scanf("%d",&temporary);
		while(i<temporary+1){
			sum+=i;
			i+=1;
		}
		printf("1~%d步长为一的累加 和为：%d\n",temporary,sum);
	}


	{
		// 4、 累乘法
		//计算1~15以内整数步长为一的累乘（超出long可能数据溢出越界为0）
		//(如：1x2x3~x14x15)

		int i=1;
		int temporary=1;
		long sum=1;
		scanf("%d",&temporary);
		while(i<=temporary){
			sum*=i;
			i+=1;
		}
		printf("1~%d步长为一的累乘 为：%d\n",temporary,sum);
	}


	{
		//二、非数值型：主要用于比较和逻辑运算以及模式识别、人工智能、数学定律、语言翻译等。
		//穷举法（枚举法）:
		// 5、 用枚举法输出输入的随机三位正整数内所有的水仙花数。

		int i=0;
		int temporary;
		int aindividual,ten,hundred;
		scanf("%d",&temporary);
		for(i=100;i<=temporary;i++){
			aindividual=i%10;//求个位数
			ten=(i/10)%10;//求十位数
			hundred=i/100;//求百位数
			if(aindividual*aindividual*aindividual\
				+ten*ten*ten+hundred*hundred*hundred==i){
				printf("%d的水仙花数有：%d\n",temporary,i);
				
			}
		}

		//总结出取某个数的某个位的方法：
		//(取多少位就除多少，最后固定模10，取最高位时直接除于最高位的1）
		//printf("%d\n",56789/1%10);
		//printf("%d\n",56789/10%10);
		//printf("%d\n",56789/100%10);
		//printf("%d\n",56789/1000%10);
		//printf("%d\n",56789/10000);

	}


	{
		// 6、 用枚举法输出输入的随机三位正整数内所有的水仙花数方法二（只考虑三位数）。
		//对分别输入的个十百为数，依次以步长为一循环到最高值，将组成的三位正整数与
		//每一组的三个数的立方和进行比较，一旦相等就说明为水仙花数即后输出。
		int tmpG,tmpS,tmpB;//输入每个位的最高值
		int g,s,b;//循环变量
		scanf("%d%d%d",&tmpG,&tmpS,&tmpB);
		for(b=1;b<=tmpB;b++){//循环每个最高位数
			for(s=0;s<=tmpS;s++){
				for(g=0;g<=tmpG;g++){
					if(g*g*g+s*s*s+b*b*b==g+s*10+b*100){//得到各位的立方和后与各数进行判断取True和False
						printf("鲜花数有：%d\n",g+s*10+b*100);
					}else{
						printf("没有水仙花数！\n");
					}
				}
			}
		}
	}

	
	{
		//排序算法
		// 7、 冒泡排序

		int i,j,temporary,arry[N];
		for(i=0;i<N;i++){//从键盘输入N个数依次从零赋值给N-1个位置。
			scanf("%d",&arry[i]);
		}
		for(j=1;j<=N-1;j++){//外循环控制趟数
			for(i=0;i<=N-1-j;i++){//内循环控制每趟的次数
				if(arry[i]>arry[i+1]){//判断大小并按要求交换
					temporary=arry[i];
					arry[i]=arry[i+1];
					arry[i+1]=temporary;
				}
			}
		}
		for(i=0;i<N;i++){printf("%d \n",arry[i]);}//验证结果
    }


	{
		// 8、 选择法排序
		//选择法排序是对冒泡法的一种改进

		int arry[N],i,j,k,temp;
		for(i=0;i<N;i++){scanf("%d",&arry[i]);}
		for(i=0;i<N-1;i++){//处理N-1趟
			k=i;//存储每次最小值（假定未排序序列的第一个元素就是最小元素）
			for(j=i+1;j<N;j++){//每一趟从未排序后的位置开始查找最小的数
				if(arry[j]<arry[k]){k=j;}//与前面一个相比较，记录最小值的位置
			}
			if(k!=i){//交换（如果他们俩相等就没必要交换）
				temp=arry[i];
				arry[i]=arry[k];
				arry[k]=temp;
			}
		}
		for(i=0;i<N;i++){printf("%d	 ",arry[i]);}
	}


	{
		// 9、 插入法排序
		//插入法排序是将一个数目插入某占据的位置（只考虑已排序的序列）。

		int arry[N]={11,22,33,44,55,66,77,88,99},x,j,k;
		scanf("%d",&x);
		if(x>arry[N-2]){
			arry[N-1]=x;//x如果大于插入前序列最后一个数，则这插入在最最后面
		}else{
			j=0;
			while(j<=N-2&&x>arry[j]){
				j++;//查找待插入的位置
			}
			for(k=N-2;k>=j;k--){
				arry[k+1]=arry[k];//从j处把所有位置往后移
			}
			arry[j]=x;//从j位置插入X
		}
		for(j=0;j<N;j++){printf("%d	",arry[j]);}

	}


	{
		// 10、 插入法排序
		//随机输入10个数，实现在输入每一个数时将其用插入法按降序动态排列。

		int arry[N],i,j,k,x;
		scanf("%d",&arry[0]);//把读入的第一个数直接放在arry[0]中。
		for(j=1;j<N;j++){
			scanf("%d",&x);//陆续将第2~10个一一插入并实时排序
			if(x<arry[j-1]){
				arry[j]=x;//比原数列最后一个数小则直接插入最后位。
			}else{//寻找待插入的位置
				i=0;
				while(x<arry[i]&&i<=j-1){i++;}
				//以下循环从最后一个数开始直到待插入的位置上的数依次后移一位。
				for(k=j-1;k>=i;k--){
					arry[k+1]=arry[k];//后移
				}
				arry[i]=x;//插入
			}
		}
		for(j=0;j<N;j++){printf("%d	",arry[j]);}
	}


	{
		// 11、 归并排序
		//有一个还有六个数字的顺序序列和一个含有4个数的升序序列，
		//将二者合并成一个十个数字的新序列。
		//[缺点]：两序列必须是相同顺序方式且后存完的剩下的一截无法参与整个新序列前段的排序。
#define SIX 6
#define FOUR 4
		int arry[SIX+FOUR],i,j,k;
		int tempArrySIX[SIX]={-3,6,19,26,168,100};
		int tempArryFOUR[FOUR]={8,10,12,22};
		i=j=k=0;
		while(i<SIX&&j<FOUR){
			//将tempArrySIX和tempArryFOUR数组中最小的依次存在arry[]中。
			if(tempArrySIX[i]<tempArryFOUR[j]){
				arry[k]=tempArrySIX[i];
				i++;
			}else{
				arry[k]=tempArryFOUR[j];
				j++;
			}
			k++;
		}
		while(i>=SIX&&j<FOUR){
			//若tempArrySIX全部存放完毕则把tempArryFOUR许下的全部放在arry中
			arry[k]=tempArryFOUR[j];
			k++;
			j++;
		}
		while(j>=FOUR&&i<SIX){
			//若tempArryFOUR全部存放完毕则把tempArrySIX许下的全部放在arry中
			arry[k]=tempArrySIX[i];
			k++;
			i++;
		}
		for(i=0;i<SIX+FOUR;i++){printf("%d  ",arry[i]);}

	}

	
	{
		//查找算法
		// 12、 顺序查找（线性查找）

		int arry[N],i,x;
		printf("请输入源数组序列：\n");
		for(i=0;i<N;i++){scanf("%d",&arry[i]);}
		printf("接下来输入需要查找的数看看是否存在于上列这些数中：");
		scanf("%d",&x);//输入需要查找的数
		for(i=0;i<N;i++){
			if(x==arry[i]){//循环查找输入的数看是否存在于arry数组中
				printf("\n%d 存在于上列数组中！\n",x);
				break;
			}else if(i==N-1&&x!=arry[i]){
				printf("\n%d 不存在于上列数组中！\n",x);
				break;
			}
		}
	}


	{
		// 13、 折半查找（二分查找）
		//使用二分查找的前提是数列必须是顺序的。
		int arry[N]={2,34,57,88,99,135,255,666,2455,5636},high,low,mid,x;
		printf("输入需要查找的数：");
		scanf("%d",&x);
		high=N-1;
		low=0;
		mid=(high+low)/2;
		while(arry[mid]!=x&&low<high){//判断查找范围不为0时，循环！
			if(x<arry[mid]){//确定左子表范围
				high=mid-1;
			}else{
				low=mid+1;//确定右子表范围
			}
			mid=(high+low)/2;//从新计算之间值
		}
		if(x==arry[mid]){//如果查找的数等于之间数则查找成功
			printf("\nfound!\n\n");
		}else{printf("\nNot found!\n\n");}

	}


	{
		//进制转换算法
		// 14、 十进制转换为其他进制数(当下只考虑16进制及以下)
		//任意输入一个十进制数将其转换为二、八、十六任意进制的字符串数。

		int i=0,j=0,yu=0,ji,yuan;
		char jieguo[1000],slArry[]="0123456789ABCDEF";
		printf("输入进制基数(...三十二进制32...二进制2):_");
		scanf("%d",&ji);
		printf("输入待转数（任意十进制正整数）：");
		scanf("%d",&yuan);
		do{
			yu=yuan%ji;//求余
			jieguo[i]=slArry[yu];//将十进制以上的结果超出9的数字以大写字母代替
			yuan/=ji;//取自身求商
			i++;
		}while(ji>=2&&ji<=16&&yuan>0);
		for(j=i-1;j>=0;j--){printf(" %c ",jieguo[j]);}
		printf(" \n ");
	}


	{	
//#include <math.h> (代码块中不能有math.h头文件)
		// 15、 其他进制数转十进制(当下只考虑16进制及以下)
		//任意输入一个任意进制数（二、八、十六）将其转换为十进制的字符串数。

		int ji,i,yu,len,temp;long long shi;char yuan[N*10];
		shi=yu=ji=i=len=temp=0;
		printf("输入一个将被用来转换为十进制数的N进制数\n \
			   （例如二进制110011,十六进制12E8F4）：");
		gets(yuan);		//输入被转的字符型数列
		strupr(yuan);   //将yuan中的小写字母转换成大写字母
		printf("\n上面输入的是几进制数(例如二进制输入2,八进制8)：");
		scanf_s("%d",&ji);
		 len=strlen(yuan);
		 for(i=0;i<len;i++){//按权位展开数组长度等于权位数
			 //判断输入的数据和进制数是否相符
			 if ( (yuan[i]-''0''>=ji&&yuan[i]<''A'')||(yuan[i]-''A''+10>=ji) ){
			//(yuan[i]-''0''求的是yuan[i]字符数字对应的十进制数)
			//(yuan[i]-''A''+10求的是yuan[i]字母相对应的十进制数)
				 printf("输入的数据和进制数不相符!!");
				 exit(0);		 //退出程序
			 }
			 if (yuan[i]>=''0''&& yuan[i]<=''9''){  //判断是否为数字
				 temp=yuan[i]-''0'';   //求出字符数字所代表的十进制数
			 }
			 else if (ji>=11&&(yuan[i]>=''A''&&yuan[i]<=''A''+ji-10)){//判断是否为字母
				temp=yuan[i]-''A''+10; //求出字母所代表的十进制数
			 }
			 shi=shi*ji+temp; //求出最终转换成的十进制数(其中shi=shi*ji是进位)
		 }
		 printf("\n原 %d 进制数:",ji);
		 for(i=0;i<len;i++){printf(" %c ",yuan[i]);}
		 printf("转换为十进制数为: %lld \n\n",shi);

		//二进制转十进制基础算法
		//while(yuan!=0){
		//	yu=yuan%10;//求余
		//	yuan/=10;//取本身的商
		//	pow函数的功能是计算ji的i次方默认返回值为double型，在#include <math.h> 中
		//	shi+=(int)yu*pow(ji,i);
		//	++i;
		//}
		//printf("原 %d 进制数 %s 转换为十进制数为: %ld \n\n",ji,puts(yuan),shi);

		}
		
		
	{
		//字符串处理
		// 16、 字符统计
		//对字符串中各个字符出现的次数进行统计（此处暂且只论小写字母）
		char arry[N*10];
		int i,statistical[26]={i=0};
		printf("输入原字符串（小写）：");
		gets(arry);
		for(;arry[i]!=''\0'';i++){
			//statistical[0]中存放''a''的个数，statistical[1]中存放''b''的，类推
			statistical[arry[i]-''a'']+=1;
			//arry[i]-''a''中各字符的ascii码值减去''a''的ascii码值，
			//刚好得到对应的计数器下标(i)
		}
		for(i=0;i<26;i++){
			if(statistical[i]!=0){
				printf(" %c 出现了 %d 次 ！\n",i+''a'',statistical[i]);
			}
		}
	}
	

	{
		// 17、 字符加密
		//对任意一个含有英文字母的字符串，将每一个字母用其后的
		//第三个字母代替（xyz对应abc）,ascii码的规律是（arry[i]-26 +3）
		int i;
		char arry[N*10];
		gets(arry);
		for(i=0;i<strlen(arry);i++){
			if(arry[i]>=''x''&&arry[i]<=''z''||arry[i]>=''X''&&arry[i]<=''Z''){
				arry[i]=arry[i]-26+3;//
			}else{
				arry[i]=arry[i]+3;
			}
		}
		puts(arry);
	}


	{
		// 18、 获取整数各个位上的数
		//
		long number;
		scanf("%ld",&number);
		if(number<0){
			printf("— ");
			number=-number;//如果是负数及转为正数
		}
		do{
			printf("%ld_",number%10);//取个位
			number/=10;//递减十倍
		}while(number!=0);
		printf("\n\n");
	}

 
	{
		// 19、 辗转相除法（欧几里德算法）方法一
		//其是一种用来求最大公约数的有效算法
		//(1)最大公约数：能同时被两个整数整除的最大公约数。
		//(2)最大公约数 = 小数 与 （大数%小数） 的最大公约数。
		int a,b,remainder,d;

		printf("输入俩正整数：");
			scanf(" %d%d",&a,&b);
			//if(a<b){t=a;a=b;b=t;}
		remainder=a%b;
		d=a*b;
		while(remainder!=0){//辗转相除法循环
			a=b;
			b=remainder;
			remainder=a%b;
			//上面的算法remainder=0时b这时的值就是最大公约数
		}
		printf("\n最大公约数：%d\n",b);
		printf("最小公倍数：%d\n\n",d/b);
		//两数的积除以最大公约数就是最小公倍数了

	}


	{
		// 20、求最大公约数和最小公倍数 方法二
		int x,y,z,m,t;

		printf("输入两个正整数：");
		scanf("%d%d",&x,&y);
		if(x<y){
			t=x;
			x=y;
			y=t;
		}
		m=x*y;
		z=x%y;
		while(z != 0){
			x=y;
			y=z;
			z=x%y;
		}
		printf("最大公约数是：%d \n",y);
		printf("最小公倍数是：%d \n",m/y);

	}
	

	{
		//21、 有四个水渠要向水池灌水，单开a渠需要3天，单开b渠需要1天，
		//单开c渠需要4天，单开d渠需要5天，同时放水则需要多少天。
		float a=3,b=1,c=4,d=5;
		float day=1/((1/b)+(1/a)+(1/c)+(1/d));
		printf("需要 %f 天\n",day);
	}


	{
		//22、 输入年数判断是平年还是润年。
		int year=0;
		printf("输入年份吧：");
		scanf("%d",&year);
		//（能被4整除并且不能被一百整除的）或者（能被400整除的）是为闰年。
		if((year%4==0&&year%100!=0)||(year%400==0)){
			printf("%d 为润年！\n",year);
		}else{
			printf("%d 为平年\n",year);
		}
	}


	{
		//23、 倒三角九九乘法表
//#define IO 996 代码块中不能宏定义,故已定义在文头
		const int ii =0;
		int yy=99;
		char m=''y'';
		char mm=''f'';
		int x=1;
		int y=1;
		unsigned u = 9810;
		yy=4*IO;
		for(x=9;x>0;x--){
			for(y=1;y<=x;y++){
				printf("%d * %d = %d    ",y,x,x*y);
			}
			printf("\n");
		}
		printf("%d \a",yy);
		printf("%d %d %d %d %d %d",sizeof(short),sizeof(int),\
			sizeof(long),sizeof(char),sizeof(float),sizeof(double));
	}
	

	{
		
		//24、 有4个字符串，首先将他们按照字符串中的字符个数由小到大排列，
		  //再分别取出每个字符串的第三个字母并合成一个新的字符串输出，
		  //（若少于3个字符的则输出空格）。要求：利用字符串指针和数组指针实现。

		int i,j,k;char str[5],*p;
		char *strarr[4]={"yang","mu","fa","haoshuai"};
		//按照从小到大排序
		for(i=0;i<4;i++){
			for(k=i,j=k+1;j<4;j++)
				if(strlen(strarr[k]) > strlen(strarr[j]) ){
					k=j;
				}
				if(k!=i){//交换位置
					p=strarr[k];
					strarr[k]=strarr[i];
					strarr[i]=p;
				}
		}
		//分别取出每个字符串的第三个字母并合成一个新的字符串输出
		for(j=i=0;i<4;i++) 
			str[j++]=strlen(strarr[i])>2 ? *(strarr[i]+2) :'' '';
			str[j]=''\0'';
			printf("The result is : %s\n",str);
	}

	
	{
		//25、 已知一个整形数组x[4],他的4个元素值分别为 3、10、4和20.
			//使用指针表示法编程，求出该数组各个元素的乘积。
	
		int i=0;
		int x[]={3,10,4,20};
		int *p=x;
		for(i=0;i<3;i++){
		printf("%d和%d的乘积=%d\n\n",*(p+i),*(p+i+1),*(p+i)* *(p+i+1));
		}
	}

}  // main函数结尾


/*

//26、函数subString()

	int substring(char *str,char *str1){
		int i=0;int j=0;int number=0;
		for(i=0;str[i]!=''\0'';i++){
			for(j=0;str[i+j]!=''\0''&&str1[j]!=''\0'';j++){
				if(str[i+j]!=str1[j])
					break;
			}
			if(str1[j]==''\0'')
				number++;
		}
		return number;
	}

*/



/*
//
	//27、输入八个整数，并将其中最小的与最第一个交换，把最大的数与最后一个对换。
//
#include <stdio.h>
#include <stdlib.h>
void Exchange(int l,int *min,int *max,int *Array);
void forinput(int l,int *Array);
void traverse_size(int l,int *min,int *max,int *Array);

void main(){
	int l=3,i;
	int *min=(int *)malloc(sizeof(int));
	int *max=(int *)malloc(sizeof(int));
	int *Array=(int *)malloc(sizeof(int)*8);
	printf("请输入词组个数：");
	scanf_s("%d",&l);
	printf("接下来请输入%d个任意大小的数：\n",l);
	for(i=0;i<l;i++){
		printf("第-%d-个随机数字：",i+1);
		scanf_s("%d",&Array[i]);
	    }
	    printf("交换前的顺序为：");
        forinput(l,Array);
        traverse_size(l,min,max,Array);
		printf("Max，Min 分别为；%d %d\n",*max,*min);
	    Exchange(l,min,max,Array);        
        printf("交换后的顺序为：");
        forinput(l,Array);
	    printf("\n");
}
//
//调用exchange函数对数字指定数字按要求将
//最小的与最第一个交换，把最大的数与最后一个对换，
void Exchange(int l,int *min,int *max,int *Array){
    int i;
	//printf("交换前顺序为：");
	//forinput(l,Array);
	printf("开始把最小的与原最第一个交换，把最大的数与最后一个对换，moment.....\n");
	for(i=0;i<l;i++){
		if(i==0){
			Array[i]=*min;
		}
		if(i==l-1){
			Array[i]=*max;
		}
	}
}
//
//遍历_打印输出
void forinput(int l,int *Array){
	int i;
  for(i=0;i<l;i++){
    printf("%d ",Array[i]);
  }
  printf("\n");
}
//
//遍历_求大小
 void traverse_size(int l,int *min,int *max,int *Array){
     int i;
	 *max=Array[0];*min=Array[0];
     *max=Array[0],*min=Array[0];
     for(i=0;i<l;i++){
     if(*min>Array[i]){
			 *min=Array[i];
		 }
     if(*max<Array[i]){
			 *max=Array[i];
		 }
        }
    //    printf("Max，Min 分别为；%d %d\n",*max,*min);
 }

 */



/*
//
	//28、定义一个动态数组，长度为变量n，用随机数给数组各元素赋值，
	//然后给数组个单元排序，定义swap()函数交换数据单元，要求参数使用指针传递。
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
void CreateArray(int,int *);
void Swap(int,int *);
void pint(int,int *);
//
void main(){
	int n=0;
	int *arr=NULL;
	//srand((unsigned int)time(NULL));//设置当前时间为种子 
	//n=(n = (rand()%100+1)/10)+5;//产生1~100的随机数 
	CreateArray(n,arr);
	Swap(n,arr);
	pint(n,arr);
}
//
//创建动态数组
void CreateArray(int n,int *arr){
	printf("确认过眼神：CreateArray\n");
	//srand((unsigned int)time(NULL));//设置当前时间为种子 
	printf("请输入数组的长度:");
	scanf_s("%d",&n);
	arr=(int *)malloc(sizeof(int)*n);
	//用随机数给数组各元素赋值
	int p= 0;
	while( p< n ){
		printf("请输入随机数为数组元素赋值:");
		//arr[I]=(rand()%100+1);//产生1~100的随机数 

		scanf_s("%d",&arr[p]);
		p++;
	}
}
//
//定义swap()函数交换数据单元（从小到大）
	void Swap(int n,int *Parr){
		printf("确认过眼神： Swap\n");
		int I=0,J=0,K=0,temporary;
			for(I=0;I<n;I++){
				for(K=I,J=K+1;J<n;J++){
					if(Parr[I]<Parr[J])
						K=J;
					if(K!=I){
						temporary=Parr[K];
						Parr[K]=Parr[I];
						Parr[I]=temporary;
					}
				}
			}
	}
	//
	//打印	
	void pint(int n,int *parameter){
		printf("确认过眼神：pint\n");
		int I=0;
		for(I=0;I<n;I++){
			printf("%d ",parameter[I]);
		}
		printf("\n");	
	}

	*/

```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060985362599251969, 2060985362599251968, '```c++
	int i, j, k, n=0, a[20][20]; 
    while(n<=0||n>=13){  //控制打印的行数不要太大，过大会造成显示不规范
        printf("请输入要打印的行数：");
        scanf("%d",&n);
    }
    printf(" %d 行杨辉三角如下：\n",n);
    for(i=1;i<=n;i++)
        a[i][1] = a[i][i] = 1;  //两边的数令它为1，因为现在循环从1开始，就认为a[i][1]为第一个数
    for(i=3;i<=n;i++)
        for(j=2;j<=i-1;j++)
            a[i][j]=a[i-1][j-1]+a[i-1][j];  //除两边的数外都等于上两顶数之和 
    for(i=1;i<=n;i++){
        for(k=1;k<=n-i;k++)
            printf("   ");  //这一行主要是在输出数之前打上空格占位，让输出的数更美观
        for(j=1;j<=i;j++)  //j<=i的原因是不输出其它的数，只输出我们想要的数
            printf("%6d",a[i][j]);
        printf("\n");  //当一行输出完以后换行继续下一行的输出
    }
    printf("\n");

```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060985596477837313, 2060985596477837312, '某公司采用公用电话传递数据，数据是四位的正数，在传递过程中是加密的，
每位数字都加上5，然后用和除于10的余数代替该数字，再将第一位和第四位交换，第二位和第三位交换。

```c++
		int i,password[5];
		printf("输入4位 0~9 之间的数字：");
		for(i=0;i<4;i++){
			scanf_s("%d",&password[i]);
			if(password[i]<0&&password[i]>9){
				printf("输入的不是0~9之间的数字！！！");
			}
		}
		printf("\n");

		//每位数字都加上5，然后用和除于10的余数代替该数字
		for(i=0;i<4;i++){
			printf("数字 %d ",password[i]);
			//每位数字都加上5，然后用和除于10的余数代替该数字，
			password[i]=(password[i]+5)%10;
			printf("加5除10余后 = %d \n",password[i]);
		}
		printf("\n");
		//再将第一位和第四位交换，第二位和第三位交换。
		password[4]=password[0];
		password[0]=password[3];
		password[3]=password[4];
		password[4]=password[1];
		password[1]=password[2];
		password[2]=password[4];
		printf("再经调换最后得到加密处理过后得到的数据为： ");
		for(i=0;i<4;i++){
			printf(" %d",password[i]);
		}
		printf("\n\n");
```
输入4位 0~9 之间的数字：4 5 7 9

数字 4 加5除10余后 = 9
数字 5 加5除10余后 = 0
数字 7 加5除10余后 = 2
数字 9 加5除10余后 = 4

再经调换最后得到加密处理过后得到的数据为：  4 2 0 9');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060985846760345600, 2060985846756151296, '```c
		int top=1,bottom,i,sum;
		
		while(1){
			bottom=top;
		//把最上层的数赋给其下一层，作为下一层是上一层的两倍数的计算基数
			sum=0;
			for(i=1;i<8;i++){
				bottom*=2;//使得bottom从第七层开始等于它的上一层*2
				sum+=bottom;//计算除第八层外的其他层的总灯数
			}
			sum+=top;//计算1~8层的总灯数
			if(sum==765){//判断1~8层的总灯数是不是765
				printf(" top=%d",top);
				printf("\nbottom=%d\n\n",bottom);
				break;
			}
			top++;//如果不满足条件则第八层加一，继续穷举
		}
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2077756000764563456, 2077756000756174848, '> # **横屏或电脑观看效果更佳**

# English

**不可盲目追求大词汇量，忽视深度掌握和使用,需先了解音标/单词/句子(语法)/时态与语态/文章/语气与功能 包含哪些知识点,每个知识点大概什么含义,如何根据学习方法合理的由浅入深的学习.**

## 音标

### **一、音标的基本概念**

#### **1. 国际音标（IPA）**

- **定义**：国际通用的语音符号系统，标记单词的标准发音。
- **英语音标分类**：
  - **英式音标**：DJ音标（Daniel Jones），如 /kæt/（cat）。
  - **美式音标**：KK音标（Kenyon & Knott），如 /kæt/（cat）。

#### **2. 音素（Phoneme）**

音素是从语音的自然属性角度划分出来的**最小、不能再分解的声音单位**。

- 英语共有 **44个音素**（英式）或 **40个音素**（美式）。
- 分为 **元音（Vowels）** 和 **辅音（Consonants）**。
- **本质**：就像化学里的**原子**。你可以把一句话拆成一个一个单独的、不可再切分的声音。
- **分类**：正好对应上一个问题——**元音音素** 和 **辅音音素**。
- **数量**：英语里有大约 44 个音素（不同口音有微小差异，一般公认44个左右），比如 /p/、/b/、/iː/、/æ/、/t/ 等。
- **作用**：用来**区别词义**。比如 “pat” 里的 /p/ 换成 /b/，单词就从“拍”变成了“蝙蝠”。
- **书写**：为了不与字母混淆，音素通常写在**两条斜线** // 或方括号 [] 里。

#### **3. 音节（Syllable）**

音节是从语音的自然属性角度，听觉上自然感受到的**最小的语音结构单位**。

- **本质**：像一个**单词**，但比单词小。一个音节通常由一个**音节核（通常是元音）** 和前后若干个**音节边界（辅音）** 组成。你每发一次“音峰”（声音由低到高再到低），就是一个音节。
- **核心**：**必须有元音音素**（除了极个别如 /m/ 可以自成音节，如 “button” 的第二个音节）。
- **结构**：一个音节可以有三种形式：
  - 只有元音：**a** /ə/， I /aɪ/
  - 辅音 + 元音：**bee** /biː/
  - 辅音 + 元音 + 辅音：**cat** /kæt/， **and** /ænd/

#### 4. 音素 vs. 音节

| 维度               | 音素                              | 音节                                        |
| :----------------- | :-------------------------------- | :------------------------------------------ |
| **定义**           | 最小的、不能再分解的声音单位      | 由音素组合成的、自然的语音片段              |
| **核心成分**       | 元音、辅音                        | **必须有元音**（元音是核心）                |
| **数量关系**       | 多个音素组成一个音节              | 一个音节可以由1个或多个音素组成             |
| **听觉感受**       | 感觉不到“节拍”，只感觉一个单音    | 能明显感到一次“轻重、长短”的节奏单元        |
| **举例（单词）**   | cat → /k/ + /æ/ + /t/ （3个音素） | cat → [kæt] （1个音节）                     |
| **举例（单音素）** | 元音 /aɪ/ 本身就是一个音素        | 这个音素 /aɪ/ 也单独构成一个音节（单词“I”） |

1. **单词**：please
2. **音素**：把 please 拆成最小的声音 → **/p/ + /l/ + /iː/ + /z/**（4个音素）。每个都不能再拆了。
3. **音节**：按听感节拍来分 → 它读起来是 **/pliːz/**，一拍 （一个音节）。因为只有一个元音音素 /iː/，所以只能构成一个音节。

### **二、元音（Vowels）**

**定义**：元音是发音时**气流从肺部呼出，经过口腔和咽头时不受任何阻碍**，同时**声带必然振动**的一类音素。

**关键特征**：

- **无阻碍**：舌头、嘴唇、软腭等发音器官没有形成任何封闭或狭窄（如完全闭合、接触或靠得很近），口腔通道完全打开。
- **声带振动**：所有元音都是**浊音**（voiced）。可以用手轻摸喉结，发“啊——”时能感到持续振动。
- **气流弱**：因为没有阻碍需要冲破，呼出的气流相对平稳、较弱。
- **可自成音节**：一个元音本身就可以构成一个完整的音节，例如英语单词 "a" /ə/ 或 "I" /aɪ/。

**简单记忆**：元音 = **通畅** + **声带响**。

**举例**：汉语普通话的 **a, o, e, i, u, ü**；英语的 **/iː/ (see), /æ/ (cat), /uː/ (too), /ɜː/ (bird)**。

#### **1. 单元音（Monophthongs）**

- **短元音**：发音短促，如 /ɪ/（sit）、/e/（bed）、/æ/（cat）。
- **长元音**：发音拉长，符号后带冒号，如 /iː/（see）、/ɑː/（car）、/ɔː/（law）。

#### **2. 双元音（Diphthongs）**

- 由两个元音滑动构成，如：
  - /eɪ/（face）、/aɪ/（like）、/ɔɪ/（boy）。
  - /əʊ/（go）、/aʊ/（now）、/ɪə/（here）、/eə/（hair）。

#### **3. 弱读元音（Schwa /ə/）**

- 英语中最常见的元音，出现在非重读音节，如 "about" /əˈbaʊt/。

------

### **三、辅音（Consonants）**

**定义**：辅音是发音时**气流从肺部呼出，在口腔或咽头受到某种阻碍**（如完全阻塞、形成窄缝、使部分器官接触等）的一类音素。

**关键特征**：

- **有阻碍**：这是与元音最根本的区别。阻碍的方式多种多样：
  - **完全阻塞后突然放开**：如 /p, b, t, d, k, g/（爆破音）
  - **口腔某处形成窄缝，气流摩擦通过**：如 /f, v, s, z, ʃ, ʒ/（摩擦音）
  - **先完全阻塞再缓慢打开形成摩擦**：如 /tʃ, dʒ/（破擦音）
  - **其他**：气流从鼻腔通过（鼻音 /m, n, ŋ/），或舌头两侧通过（边音 /l/）等。
- **声带可振可不振**：辅音分为**清辅音**（声带不振，如 /p, t, k, f, s/）和**浊辅音**（声带振动，如 /b, d, g, v, z, m, n, l, r/）。
- **气流强**：为了冲破或通过阻碍，呼出的气流通常比元音强。
- **通常不能自成音节**：辅音一般不能单独构成音节的核心（除了少数特殊情况，如 "hmm" /m̩/ 中的 /m/ 自成音节，或 "table" /ˈteɪ.bl̩/ 中的 /l/ 形成成音节辅音，但这些属于边缘现象，不影响核心定义）。

**简单记忆**：辅音 = **受阻** + （气流强） + （声带或振或不振）。

**举例**：汉语普通话的 **b, p, m, f, d, t, n, l, g, k, h, j, q, x, zh, ch, sh, r, z, c, s**；英语的 **/p, b, t, d, k, g, f, v, θ, ð, s, z, ʃ, ʒ, h, tʃ, dʒ, m, n, ŋ, l, r, j, w/**。

#### **1. 按发音方式分类**

- **爆破音**：/p/（pen）、/b/（bag）、/t/（tea）、/d/（dog）、/k/（cat）、/g/（go）。
- **摩擦音**：/f/（fish）、/v/（voice）、/s/（sun）、/z/（zoo）、/ʃ/（she）、/ʒ/（vision）。
- **破擦音**：/tʃ/（chat）、/dʒ/（judge）。
- **鼻音**：/m/（me）、/n/（no）、/ŋ/（sing）。
- **舌侧音**：/l/（like）。
- **半元音**：/j/（yes）、/w/（we）。

#### **2. 按声带振动分类**

- **清辅音**（不振动声带）：/p/, /t/, /k/, /f/, /s/。
- **浊辅音**（振动声带）：/b/, /d/, /g/, /v/, /z/。

#### **3. 易混淆辅音对比**

- /θ/（thin） vs. /ð/（this）
  （舌尖置于上下齿间，前者清音，后者浊音）。
- /ʃ/（ship） vs. /s/（sip）
  （舌身抬起，双唇撅起发/ʃ/，平唇发/s/）。

------

### **四、音标学习步骤**

#### **1. 掌握发音器官**

- **唇、齿、舌、喉**的位置控制（如发/θ/时舌尖轻触上齿）。

#### **2. 对照模仿**

- 使用工具：
  - 剑桥词典（带真人发音）：[dictionary.cambridge.org](https://dictionary.cambridge.org/)
  - YouTube频道：BBC Learning English、Rachel’s English。

#### **3. 最小对立体（Minimal Pairs）练习**

- 对比相似发音的单词，强化辨音能力：
  - /ɪ/ vs. /iː/：sit vs. seat
  - /v/ vs. /w/：vet vs. wet

#### **4. 拼读规则（自然拼读 Phonics）**

- **字母组合发音规律**：
  - "sh" → /ʃ/（ship）
  - "th" → /θ/（think）或 /ð/（this）
  - "ee" → /iː/（see）

------

### **五、常见问题与纠正**

1. **问题**：用中文近似音代替（如将/æ/读成“艾”）。
   **纠正**：/æ/发音时口型更大（如“张大嘴惊讶”）。
2. **问题**：忽略长短元音区别（如混淆/ɪ/和/iː/）。
   **纠正**：对比练习：ship vs. sheep。
3. **问题**：辅音尾音过重（如将“cat”/kæt/读成“kate”）。
   **纠正**：轻触即停，避免添加额外元音。

------

### **六、实用资源**

1. **工具书**：
   - 《剑桥国际英语语音教程》（Tree or Three?）
   - 《英语发音全解》（Pronunciation Pairs）。
2. **APP/网站**：
   - **Sounds: The Pronunciation App**（互动音标表）。
   - **Forvo**（母语者发音库）。
   - **YouGlish**（通过YouTube视频查单词真实发音）。
3. **练习素材**：
   - 绕口令（Tongue Twisters）：
     "She sells seashells by the seashore."
   - 歌词跟读：选择发音清晰的歌手（如Ed Sheeran）。

------

### **七、总结**

音标学习的关键是：

1. **精准模仿**（口型、舌位、气流）；
2. **对比强化**（相似音标的最小对立体）；
3. **融入单词**（结合拼读规则记忆）。
   初期可侧重 **20%高频音标**（如/ə/, /æ/, /θ/），覆盖80%常见单词发音。坚持每日跟读10分钟，2-3个月即可显著提升！



## 26个字母

### 英语字母表（A-Z）

| **大写** | **小写** | **字母名称（发音）**       | **例词**         |
| :------: | :------- | :------------------------- | :--------------- |
|  **A**   | a        | /eɪ/                       | Apple（苹果）    |
|  **B**   | b        | /biː/                      | Book（书）       |
|  **C**   | c        | /siː/                      | Cat（猫）        |
|  **D**   | d        | /diː/                      | Dog（狗）        |
|  **E**   | e        | /iː/                       | Egg（鸡蛋）      |
|  **F**   | f        | /ɛf/                       | Fish（鱼）       |
|  **G**   | g        | /dʒiː/                     | Girl（女孩）     |
|  **H**   | h        | /eɪtʃ/                     | House（房子）    |
|  **I**   | i        | /aɪ/                       | Ice（冰）        |
|  **J**   | j        | /dʒeɪ/                     | Juice（果汁）    |
|  **K**   | k        | /keɪ/                      | Kite（风筝）     |
|  **L**   | l        | /ɛl/                       | Lion（狮子）     |
|  **M**   | m        | /ɛm/                       | Moon（月亮）     |
|  **N**   | n        | /ɛn/                       | Night（夜晚）    |
|  **O**   | o        | /oʊ/                       | Orange（橙子）   |
|  **P**   | p        | /piː/                      | Pen（钢笔）      |
|  **Q**   | q        | /kjuː/                     | Queen（女王）    |
|  **R**   | r        | /ɑːr/                      | Rain（雨）       |
|  **S**   | s        | /ɛs/                       | Sun（太阳）      |
|  **T**   | t        | /tiː/                      | Tree（树）       |
|  **U**   | u        | /juː/                      | Umbrella（雨伞） |
|  **V**   | v        | /viː/                      | Van（货车）      |
|  **W**   | w        | /ˈdʌbljuː/                 | Water（水）      |
|  **X**   | x        | /ɛks/                      | Box（盒子）      |
|  **Y**   | y        | /waɪ/                      | Yellow（黄色）   |
|  **Z**   | z        | /zɛd/（英式）/ziː/（美式） | Zoo（动物园）    |

### **总结**

1. **发音重点**：
   - **G** 和 **J**：注意区分 `/dʒiː/`（G）和 `/dʒeɪ/`（J）。
   - **W**：发音为 `/ˈdʌbljuː/`（类似“double U”）。
   - **Z**：美式发音为 `/ziː/`，英式发音为 `/zɛd/`。
2. **记忆技巧**：
   - 通过《字母歌（ABC Song）》快速记忆顺序。
   - 将字母与日常物品关联（如 **A for Apple**）。
3. **书写练习**：
   - 注意大小写字母的笔顺和占格（如小写 **g** 的尾部延伸）。
4. **为什么字母顺序是 A-Z？**
   - 英语字母源自拉丁字母，其顺序在历史演变中固定下来，与古希腊和腓尼基字母表有关。
5. **字母在单词中的发音与单个字母名称发音不同？**
   - 是的！字母名称（如 `/eɪ/` 对应 A）和实际发音（如 A 在单词中可能发 `/æ/` 或 `/ɑː/`）可能不同，需结合自然拼读规则学习。



## 词法

### 发音-自然拼读

**看到它，要知道怎么读 ——  用「自然拼读法」**

这是解决发音问题的最科学方法，英语母语国家的孩子学发音就用它。

- **核心逻辑**：英语是拼音文字，字母和字母组合与发音之间有规律可循。掌握这些规律，就能做到**「见词能读」**。
- **怎么操作**：
  - 不需要查音标（除非是特殊情况），直接看单词的拼写。
  - **规则示例**：
    - 像 `cat`、`hat`、`bat` 中的 `a`，在闭音节里发 /æ/。
    - 像 `like`、`bike`、`make` 中的 `e` 不发音，它让前面的元音字母发字母本身的音（即“相对开音节”）。
    - 看到 `sh`，发 /ʃ/；看到 `tion`，发 /ʃən/。
- **效果**：掌握了自然拼读，你看到一个生词（比如 `insect`），就能下意识地拆解成 `in-sect` 并读出来，而不需要先查音标。

#### 学习方案和资源

##### 周育如自然拼读法-字母常见发音

***一、字母常见发音对照表***

| 字母        | 常见发音 (K.K.音标) | 周老师教学示范/联想词                     | 发音要点                                           |
| :---------- | :------------------ | :---------------------------------------- | :------------------------------------------------- |
| **a**(元音) | [æ]                 | **"哎"** (不把ī音读出)                    | 嘴巴张开，舌尖抵下齿，短促有力。                   |
| **b**       | [b]                 | **"啵"** 或 **"不"**                      | 浊辅音，发声时声带振动。                           |
| **c**       | [k]                 | **"克"** 或 **"磕"**                      | 清辅音，不振动声带，像中文"克"但不发出韵母。       |
| **d**       | [d]                 | **"得"**                                  | 浊辅音，舌尖抵上齿龈。                             |
| **e**(元音) | [ɛ]                 | **"哎"** (嘴巴张得比a小)                  | 注意与字母a的[æ]区分，口型较小。                   |
| **f**       | [f]                 | **"福"**                                  | 上齿轻咬下唇，送气。                               |
| **g**       | [g]                 | **"各"**                                  | 浊辅音，像中文"哥"但不送气。                       |
| **h**       | [h]                 | **"喝"**                                  | 清辅音，就像冬天哈气。                             |
| **i**(元音) | [ɪ]                 | **"哎"** (非常短促)                       | 介于"衣"与"也"之间，短而快。                       |
| **j**       | [dʒ]                | **"姬"** 或 **"遮"**                      | 浊辅音，像中文"知"但更短。                         |
| **k**       | [k]                 | **"克"**                                  | 同c的发音，清辅音。                                |
| **l**       | [l]                 | **"了"** (前缀) / **"欧"** (后缀)         | **难点**：在词首像"了"，在词尾舌尖翘起抵住上齿龈。 |
| **m**       | [m]                 | **"么"** (前缀) / **"嗯"** (后缀)(闭嘴发) | 闭嘴鼻音。                                         |
| **n**       | [n]                 | **"呢"** (前缀) / **"嗯"** (后缀)(闭嘴发) | 张嘴鼻音。                                         |
| **o**(元音) | [ɑ]                 | **"啊"**                                  | 嘴巴张到最大，圆唇。                               |
| **p**       | [p]                 | **"普"**                                  | 清辅音，爆破音。                                   |
| **q**       | [kw]                | **"阔"**                                  | 注意是/k/和/w/的结合，周老师用"宽阔"的"阔"帮记。   |
| **r**       | [r]                 | **"若"** (前缀) / **"二"** (后缀)         | **难点**：词首噘嘴，词尾卷舌。                     |
| **s**       | [s]                 | **"丝"**                                  | 清辅音，像蛇吐信子的声音。                         |
| **t**       | [t]                 | **"特"**                                  | 清辅音，舌尖弹上颚。                               |
| **u**(元音) | [ʌ]                 | **"阿"** (短促)                           | 嘴巴微张，短促有力。                               |
| **v**       | [v]                 | **"呜"** (咬唇)                           | **难点**：上齿咬下唇，振动摩擦。                   |
| **w**       | [w]                 | **"我"**                                  | 双唇收圆，短促，不咬唇。                           |
| **x**       | [ks]                | **"克斯"** (连读)                         | 爆破音/k/和/s/的组合。                             |
| **y**       | [j]                 | **"呀"** 或 **"爷"**                      | 浊辅音，像中文"也"的声母。                         |
| **z**       | [z]                 | **"滋"**                                  | 就是/s/的浊音版本，振动声带。                      |

> 💡 **小贴士**：周老师强调，记住上述发音只是第一步。当单词变长或音节变多时，元音（a,e,i,o,u）的发音会变化，这是自然拼读更关键的部分。

***二、核心发音规则（进阶）***

掌握了单个字母的发音后，周育如老师总结了几个核心的拼读规则，能解决很多长单词的发音问题：

- **规则一：元音+不发音的"e"结尾**
  如果单词结尾是"元音+辅音+e"，那么最后的"e"不发音，前面的元音发它**字母本身的音**。
  - *例如*：`make`里的''a''发/eɪ/（字母A的本音），''e''不发音。
- **规则二：字母''r''对元音的影响（R音节）**
  元音后面跟着''r''，发音会变。通常**重读音节**时发长音，在**词尾**时发短音/ə/。
  - *例如*：`car`里的''ar''发/ɑr/，`teacher`里的''er''发/ər/。
- **规则三：常见字母组合的固定发音**
  为了提高拼读速度，需要直接记住这些组合的发音：
  - **oo**：多数情况下发短音/ʊ/（如`book`），少数发长音/u/（如`food`）。
  - **au, ou, aw, ow**：通常都发/ɑʊ/，类似中文的"嗷~"。
  - **th**：有两种发音，清辅音/θ/（如`thank`，咬舌送气）和浊辅音/ð/（如`that`，咬舌振动）。

> **学习建议**：这套方法的核心在于"重复"和"肌肉记忆"。周老师建议把发音规则抄下来，每天看、每天读，遇到新单词时先尝试**用规则去猜发音**，而不是急着查字典。学好单个字母的发音大约能覆盖50%的拼读情况，再加上这些规则，就能解决80%以上的常见单词发音了。


### 拼写-构词法

**记住它的拼写—— 用「构词法」和「自然拼读」结合 **

拼写是很多人的痛点，但理解了单词的构成和发音规律，拼写就不是死记字母顺序。

- **方法 A：用「自然拼读」按音节拆分**（解决拼写准确度）
  - 单词太长记不住？那是因为错误试图一次性记一串随机字母（比如 10 个字母 `a-u-t-o-m-a-t-i-c`）。
  - 正确做法：按读音拆成音节。`automatic` → au / to / ma / tic。
  - 原理：只要你会读，根据发音规律，你就能把这几个音节对应的字母组合（au，to，ma，tic）写出来。这是**「以音记形」**。
- **方法 B：用「构词法」理解模块**（解决拼写逻辑）
  - 把单词看成积木，而不是砖块。
  - 比如 `unforgettable`，看起来很长的单词，其实是由三个有意义的模块组成的：`un`（不） + `forget`（忘记） + `able`（能...的）。
  - 你只需要记住这三块积木，拼写自然就下来了，而且还不容易漏字母。

词缀法

词根法

合成法

截短法

混合法

#### 1. **派生法（Derivation）**

通过添加**前缀（Prefix）**或**后缀（Suffix）**改变词性或词义。

- **词根**：代表或暗示单词的核心词义。

- **前缀**：通常改变词义，不改变词性。

  - **un-**（否定）：happy → **unhappy**（不开心的）
  - **re-**（再次）：write → **rewrite**（重写）
  - **mis-**（错误）：understand → **misunderstand**（误解）

- **后缀**：通常改变词性。

  - **-ness**（名词）：happy → **happiness**（幸福）
  - **-ful**（形容词）：care → **careful**（小心的）
  - **-ly**（副词）：quick → **quickly**（快速地）

  **总结：一般情况下的组合方式为：前缀+词根+后缀,也可随意顺序的组合。**

#### 2. **复合法（Compounding）**

将两个或多个独立单词组合成新词，新词的意义可能与原词相关或全新。

- **名词+名词**：
  - **tooth**（牙齿） + **brush**（刷子） → **toothbrush**（牙刷）
  - **sun**（太阳） + **flower**（花） → **sunflower**（向日葵）
- **形容词+名词**：
  - **black**（黑色） + **board**（板） → **blackboard**（黑板）
  - **green**（绿色） + **house**（房子） → **greenhouse**（温室）

#### 3. **转化法（Conversion）**

不改变单词形式，直接转换词性。

- **名词→动词**：
  - **water**（水） → **to water**（浇水）
  - **email**（电子邮件） → **to email**（发邮件）
- **动词→名词**：
  - **to run**（跑） → **a run**（跑步）
  - **to call**（打电话） → **a call**（电话）

#### 4. **缩略法（Abbreviation）**

通过缩短单词或短语形成新词。

- **首字母缩略（Acronym）**：
  - **NASA**（National Aeronautics and Space Administration）
  - **UNESCO**（United Nations Educational, Scientific and Cultural Organization）
- **截短（Clipping）**：
  - **advertisement** → **ad**（广告）
  - **examination** → **exam**（考试）

#### 5. **拼缀法（Blending）**

将两个单词的部分拼合成新词。

- **smoke**（烟） + **fog**（雾） → **smog**（烟雾）
- **breakfast**（早餐） + **lunch**（午餐） → **brunch**（早午餐）

#### 6. **逆构法（Back-Formation）**

通过去掉假想的词缀创造新词。

- **editor**（编辑） → **to edit**（编辑）
- **television**（电视） → **to televise**（电视播送）

#### 7. **借用法（Borrowing）**

从其他语言直接引入词汇。

- **法语**：**café**（咖啡馆），**ballet**（芭蕾）
- **汉语**：**kung fu**（功夫），**tofu**（豆腐）

#### 8. **拟声法（Onomatopoeia）**

模仿自然声音创造词汇。

- **buzz**（嗡嗡声），**meow**（猫叫），**bang**（砰的一声）

#### 9. **重复法（Reduplication）**

重复单词或音节形成新词。

- **bye-bye**（再见），**tick-tock**（钟表滴答声）

#### 10. **专有名词转化（Eponym）**

以人名、地名等专有名词命名事物。

- **sandwich**（三明治，源自伯爵名Sandwich）
- **volt**（伏特，源自物理学家Alessandro Volta）

##### **学习构词法的意义**

1. **推测词义**：通过前缀、后缀或词根推测陌生单词的含义。
2. **扩大词汇量**：系统性记忆单词，而非死记硬背。
3. **理解专业术语**：医学、科技等领域术语多由希腊/拉丁词根构成（如**bio-**（生物）、**tele-**（远程））。

##### **总结**

英语构词法主要包括：

- 派生（用希腊语/拉丁语词根/前缀/后缀构词）
- 复合（用源自日耳曼语的单词合并构词）
- 转化（使用同一单词的不同不同词性）
- 缩略（缩短单词）
- 拼缀（混合单词）
- 借用（外来词）

掌握这些方法，可以更高效地学习和应用英语词汇！

### 理解-词源/词根词缀

**要理解它的意思 —— 用「词源/词根词缀法」和「语境法」**

这是最核心的部分，决定了背单词是「死记硬背」还是「举一反三」。

- **方法 A（首选）：用「词根词缀」推断含义**
  - 这是理解单词内涵最科学的方法。英语单词的含义是有逻辑的，由词根承载。
  - **例子**：看到 `audience`
    - 如果你死记，它是一个独立的词。
    - 如果你懂词根，你知道 `audi` 表示“听”。那么 `audience` 就是“听的人”（听众），`auditorium` 就是“听的地方”（礼堂），`audible` 就是“能听见的”。
  - **操作**：遇到生词，先查它的词根含义。记住词根，比记住单词本身更重要。
- **方法 B（辅助）：用「语境」锁定具体含义**
  - 很多单词一词多义，词根只能告诉你它的核心方向，具体是什么意思要看上下文。
  - **例子**：`run`
    - 词根告诉你它是“跑”的方向。
    - 在 `run a company` 里，它是“经营”（跑公司）。
    - 在 `run a program` 里，它是“运行”。
  - **操作**：不要只背单词书上的第一个中文释义，一定要看**例句**，看它在句子中是怎么用的。这是在记住核心义的基础上，理解它的具体应用。

#### 学习方案和资源

//todo

**总结一个「三步走」实战流程**

假设今天遇到一个新词：**`predict`**

1. **读（自然拼读）**：看到 `pre` 发 /prɪ/，`dict` 发 /dɪkt/，直接拼出来。你会发现读得顺，拼写也就顺了。
2. **记（构词法）**：拆解模块。`pre`（在...前面） + `dict`（说）。拼写就是这两块的组合。
3. **懂（词源+语境）**：
   - 词源告诉你 `dict`=说，`pre`=前面。合起来就是**「在事情发生前说出来」→ 预言，预测**。
   - 再看个例句："It''s hard to **predict** the weather."（很难预测天气。）这样你就知道它通常和天气、未来事件搭配。

**简单来说：用自然拼读解决读，用构词法解决拼写和核心义，用语境解决具体用法。**

### **一、单词的构成与分类**

#### **1. 词性（Part of Speech）**

英语中的**词性**是指单词在句子中所起的语法作用和功能。根据意义、形式和语法功能，英语单词可分为不同词性。掌握词性对理解句子结构、正确用词和学好语法至关重要。词性大致分为**实词**和**虚词**两大类。

***实词（有实在意思,能独立充当句子成分）:***名词\动词\形容词\副词\数词\代词 等

***虚词（无完整词汇意义,起语法连接或辅助作用）:***冠词\介词\连词\感叹词\判断词 等

具体定义如下：

##### 1. **名词（Noun）**

- **定义**：表示人、事物、地点、概念等名称的词。
- **示例**：
  - 人：**teacher**（老师），**student**（学生）
  - 事物：**book**（书），**computer**（电脑）
  - 地点：**school**（学校），**park**（公园）
  - 概念：**happiness**（幸福），**freedom**（自由）

##### 2. **代词（Pronoun）**

- **定义**：用来代替名词的词，避免重复。
- **示例**：
  - **I**（我），**you**（你），**he**（他），**she**（她），**it**（它）
  - **this**（这个），**that**（那个），**these**（这些），**those**（那些）
  - **who**（谁），**which**（哪个），**what**（什么）

##### 3. **动词（Verb）**

- **定义**：表示动作、状态或存在的词。

- **示例**：

  - 动作：**run**（跑），**eat**（吃），**write**（写）
  - 状态：**be**（是），**seem**（似乎），**become**（变成）
  - 存在：**exist**（存在）

  > **按词义与作用又分为↓**

  ###### ①. 实义动词（行为动词）

  有具体动作或状态，能独立作谓语。

  - 及物动词 vt.：后面必须加宾语

    eat, love, make, buy, open

  - 不及物动词 vi.：后面不能直接加宾语

    run, swim, laugh, arrive, happen

  ###### ②. 系动词

  连接主语和表语，不表动作，表状态 / 特征

  - be 动词：am, is, are, was, were
    
  | 形式         | 词形        | 主要功能与用法                            | 经典例句                                                     |
  | :----------- | :---------- | :---------------------------------------- | :----------------------------------------------------------- |
  | **原形**     | **be**      | 用于情态动词后、不定式、祈使句等          | You must **be** careful. / I want to **be** a teacher.       |
  | **现在式**   | am, is, are | 构成一般现在时的“主系表”或进行时态        | He **is** tall. / They **are** studying.                     |
  | **过去式**   | was, were   | 构成一般过去时的“主系表”或过去进行时      | I **was** busy yesterday. / She **was** reading.             |
  | **现在分词** | **being**   | 构成进行时态的**被动语态**或作动名词/分词 | The room is **being** cleaned. / **Being** honest is important. |
  | **过去分词** | **been**    | 与have/has/had构成**完成时态**            | I have **been** to Paris. / She had **been** sick.           |

  - 感官：look, sound, smell, taste, feel
  - 变化：become, get, turn, grow
  - 保持：keep, stay, remain

  ###### ③. 助动词

  帮助构成时态、语态、否定、疑问，**无实义**

  - be: am, is, are, was, were, been, being
  - have: have, has, had
  - do: do, does, did
  - will, would, shall, should

  ###### ④. 情态动词

  表语气、态度（能力、许可、推测等）

  can, could, may, might, must, need, dare,

  will, would, shall, should, ought to

  > **按是否受主语限制又分为↓**

  ###### ⑤. 谓语动词

  有人称、时态变化，能单独作谓语

  - goes, ate, is playing, will go

  ###### ⑥. 非谓语动词

  不能单独作谓语，无人称变化

  - **to do** 不定式：to go, to eat
  - **doing** 动名词 / 现在分词：going, reading
  - **done** 过去分词：gone, eaten

##### 4. **形容词（Adjective）**

- **定义**：用来修饰名词或代词，描述其性质、特征或状态。
- **示例**：
  - **beautiful**（美丽的），**happy**（快乐的），**big**（大的）
  - **red**（红色的），**interesting**（有趣的）

##### 5. **副词（Adverb）**

- **定义**：用来修饰动词、形容词、其他副词或整个句子，表示时间、地点、程度、方式等。
- **示例**：
  - 时间：**now**（现在），**soon**（很快）
  - 地点：**here**（这里），**there**（那里）
  - 程度：**very**（非常），**quite**（相当）
  - 方式：**quickly**（快速地），**carefully**（小心地）

##### 6. **介词（Preposition）**

- **定义**：用来表示名词或代词与其他词之间的关系，通常表示时间、地点、方向等。
- **示例**：
  - 时间：**at**（在），**on**（在……上），**in**（在……里）
  - 地点：**under**（在……下），**above**（在……上）
  - 方向：**to**（向），**from**（从）

##### 7. **连词（Conjunction）**

- **定义**：用来连接单词、短语或句子的词。
- **注意**:连词连接的是两个词性相同的词
- **示例**：
  - 并列连词：**and**（和），**but**（但是），**or**（或者）
  - 从属连词：**because**（因为），**if**（如果），**although**（虽然）

##### 8. **冠词（Article）**

- **定义**：用来限定名词的词，分为定冠词和不定冠词。

  | 冠词类型     | 形式           | 核心功能与含义                                               | 使用规则与示例                                               |
  | :----------- | :------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
  | **不定冠词** | **a** / **an** | **泛指**：用于首次提及或不特定的单数可数名词，表示“一个”、“某一类”。 | **1. 基本规则**：根据**后续单词的首发音**决定。<br/>• **a** + 辅音音素：a book, a university, a one-way street<br/>• **an** + 元音音素：an apple, an hour, an MBA<br/>**2. 核心用法**：<br/>• **首次提及**：I saw **a dog** in the park. (我在公园看见一只狗。)<br/>• **泛指一类**：**A child** needs care. (孩子需要关爱。)<br/>• **表示“每一个”**：He earns $100 **a day**. (他每天赚100美元。) |
  | **定冠词**   | **the**        | **特指**：用于说话双方都明确知道的、或世界上独一无二的人或物。 | **1. 特指已知事物**：<br/>• 再次提到：I bought **a book**. **The book** is interesting. (我买了本书。**这书**很有趣。)<br/>• 语境明确：Please close **the door**. (请关门。) (双方都知道是哪扇门)<br/>**2. 独一无二的事物**：**the sun**, **the moon**, **the Internet**<br/>**3. 序数词/最高级前**：**the first**, **the best**<br/>**4. 修饰独一无二的事物**：**the only**, **the same**<br/>**5. 与形容词连用表一类人**：**the rich** (富人), **the old** (老人) |
  | **零冠词**   | **(无)**       | **泛称或抽象概念**：用于表示泛指、一般概念或某些固定语境。   | **1. 复数名词/不可数名词泛称**：<br/>• **Cats** are cute. (猫很可爱。)<br/>• **Love** is powerful. (爱是强大的。)<br/>**2. 专有名词前**（通常）：**China**, **Mary**, **Microsoft**<br/>**3. 抽象名词、学科、三餐前**：<br/>• study **physics** (学物理), have **breakfast** (吃早餐)<br/>**4. 固定搭配与习惯用法**：<br/>• go to **school** (上学), by **bus** (乘公交), in **bed** (卧床) |

- **示例**：

  - 定冠词：**the**（表示特指）

    

  - 不定冠词：**a**，**an**（表示泛指）

    `a` 和 `an` 是英语中的**不定冠词**，用于泛指单数可数名词，基本含义是“一个”。它们的核心区别只有一个：**取决于后面紧跟单词的发音（而非拼写）是否以元音音素开头**。

    | 冠词   | 使用规则                         | 示例                                 |
    | :----- | :------------------------------- | :----------------------------------- |
    | **a**  | 用于**辅音音素**开头的单词**前** | a book, a university, a one-way trip |
    | **an** | 用于**元音音素**开头的单词**前** | an apple, an hour, an MBA course     |

##### 9. **感叹词（Interjection）**

- **定义**：用来表达强烈情感或反应的词，通常独立于句子之外。
- **示例**：
  - **Oh!**（哦！），**Wow!**（哇！），**Oops!**（哎呀！）

##### 10. **数词（Numeral）**

- **定义**：表示数量或顺序的词。
- **示例**：
  - 基数词：**one**（一），**two**（二），**three**（三）
  - 序数词：**first**（第一），**second**（第二），**third**（第三）

##### 11. 词性的修饰关系

###### (一)、实词和虚词的修饰关系

> **实词**：名词、动词、形容词、副词（有独立词汇意义）
> **虚词**：冠词、介词、连词、感叹词（主要表示语法关系）

###### (1).修饰关系的本质

实词是**被修饰的核心**，虚词是**标记修饰关系的工具**（虚词本身不直接修饰，而是引导实词间的关系）。

###### (2).具体关系表

| 虚词类型   | 修饰作用                        | 示例                  | 说明                         |
| :--------- | :------------------------------ | :-------------------- | :--------------------------- |
| **冠词**   | 限定名词（实词）                | a book, the book      | 不改变词义，只改变指别       |
| **介词**   | 连接名词/代词（实词）与其它实词 | book **on** the table | on 标记“位置修饰”            |
| **连词**   | 连接实词或句子                  | big **and** small     | and 标记“并列修饰”           |
| **感叹词** | 独立修饰全句情绪                | **Oh!** It’s big.     | 不修饰单个实词，修饰语用意义 |

###### 结论：虚词不“直接修饰”实词，而是 **标记实词之间的语法关系**。

------

###### (二)、实词之间的修饰关系

这是修饰关系的**核心内容**，遵循 **“修饰语指向核心词”** 原则。

###### (1). 名词的修饰（形容词 / 名词 / 动词非谓语形式）

| 修饰方式      | 例子                  | 关系方向 |
| :------------ | :-------------------- | :------- |
| 形容词 → 名词 | a **red** apple       | 属性修饰 |
| 名词 → 名词   | a **history** teacher | 类别修饰 |
| 分词 → 名词   | a **broken** window   | 状态修饰 |
| 所有格 → 名词 | **John’s** car        | 所属修饰 |

###### (2). 动词的修饰（副词 / 介词短语 / 从句）

| 修饰方式        | 例子                | 关系方向  |
| :-------------- | :------------------ | :-------- |
| 副词 → 动词     | run **quickly**     | 方式      |
| 介词短语 → 动词 | arrive **at 5 pm**  | 时间/地点 |
| 状语从句 → 动词 | come **if you can** | 条件      |

###### (3). 形容词/副词的修饰（副词）

| 修饰方式      | 例子              |
| :------------ | :---------------- |
| 副词 → 形容词 | **very** happy    |
| 副词 → 副词   | run **very** fast |

###### (4).总结规律

> **实词之间的修饰，始终是“修饰语 + 核心词”，修饰语可省略，核心词决定短语类型。**

------

###### (三)、虚词组件的修饰关系

这里“虚词组件”指**由虚词构成的短语结构**（如介词短语、并列结构、从句引导词结构），它们整体作为修饰单元作用于实词。

###### (1). 介词短语（prep + NP）作为修饰组件

| 作用对象 | 例子                   | 修饰关系         |
| :------- | :--------------------- | :--------------- |
| 修饰名词 | the man **in the hat** | 相当于形容词短语 |
| 修饰动词 | sleep **after dinner** | 相当于副词短语   |

###### (2). 并列连词组件（A and/or B）

| 类型       | 例子                  | 修饰关系说明     |
| :--------- | :-------------------- | :--------------- |
| 并列名词   | bread **and** butter  | 两者共同修饰谓语 |
| 并列形容词 | tall **and** handsome | 共同修饰同一名词 |

###### (3). 从属连词组件（because / if / although + clause）

| 例子                  | 修饰关系             |
| :-------------------- | :------------------- |
| **because** it rained | 修饰主句动词（原因） |
| **if** you go         | 修饰主句动词（条件） |

###### 关键点

> **虚词组件作为整体，相当于一个“修饰块”，其内部结构由虚词决定，外部功能相当于形容词或副词。**

------

###### (三)总结

###### 表1：实词与虚词的修饰关系

| 虚词 | 作用     | 修饰对象     |
| :--- | :------- | :----------- |
| 冠词 | 限定     | 名词（实词） |
| 介词 | 标记关系 | 连接两个实词 |
| 连词 | 连接     | 实词或句子   |

###### 表2：实词之间的修饰关系

| 核心词 | 常见修饰语           | 例子                          |
| :----- | :------------------- | :---------------------------- |
| 名词   | 形容词、名词、分词   | big car, car door, broken car |
| 动词   | 副词、介词短语、从句 | run fast, run to school       |
| 形容词 | 副词                 | very good                     |

###### 表3：虚词组件的修饰关系

| 组件     | 内部结构      | 外部修饰功能     |
| :------- | :------------ | :--------------- |
| 介词短语 | prep + NP     | 形容词/副词      |
| 并列结构 | X + conj + Y  | 整体充当一个成分 |
| 状语从句 | conj + clause | 副词             |



##### 总结

英语中的词性是语法的基础，理解每个词性的作用有助于正确构建句子和分析语言结构。常见的词性包括：

- 名词、代词、动词、形容词、副词、介词、连词、冠词、感叹词和数词。

通过学习和练习，可以逐渐掌握这些词性的用法，从而提高英语的听、说、读、写能力。

- **名词（Noun）**：表人、物、概念（如 book, happiness）。
- **动词（Verb）**：表动作或状态（如 run, exist）。
- **形容词（Adjective）**：描述名词性质（如 happy, large）。
- **副词（Adverb）**：修饰动词、形容词或其他副词（如 quickly, very）。
- **介词（Preposition）**：表方位、时间等关系（如 in, at, by）。
- **连词（Conjunction）**：连接词、句（如 and, because）。
- **代词（Pronoun）**：替代名词（如 he, this）。
- **冠词（Article）**：限定名词（a, an, the）。

#### **2 词义（WordMeaning）**

在英语中，**词义**指的是一个单词所表达的具体意义或概念。词义是语言交流的核心，它帮助我们理解单词在特定上下文中的含义。词义可以分为以下几个方面：

##### 1. **字面意义（Denotation）**

- **定义**：单词的基本、字面意义，通常是词典中给出的定义。
- **示例**：
  - **"Apple"** 的字面意义是“苹果”（一种水果）。
  - **"Run"** 的字面意义是“跑”（一种动作）。

##### 2. **隐含意义（Connotation）**

- **定义**：单词所附带的情感色彩、文化联想或隐含意义，可能因语境或个人经验而不同。
- **示例**：
  - **"Home"** 的字面意义是“家”，但隐含意义可能包括温暖、安全、归属感等。
  - **"Snake"** 的字面意义是“蛇”，但隐含意义可能包括危险、狡猾等。

##### 3. **多义词（Polysemy）**

- **定义**：一个单词有多个相关意义。
- **示例**：
  - **"Bank"** 可以指“银行”（金融机构）或“河岸”（河流的边缘）。
  - **"Light"** 可以指“光”（名词）或“轻的”（形容词）。

##### 4. **同音异义词（Homonym）**

- **定义**：发音相同但意义不同的单词。
- **示例**：
  - **"Bear"** 可以指“熊”（动物）或“忍受”（动词）。
  - **"Right"** 可以指“正确的”（形容词）或“右边”（名词）。

##### 5. **同义词（Synonym）**

- **定义**：意义相同或相近的单词。
- **示例**：
  - **"Happy"** 和 **"Joyful"** 都表示“快乐的”。
  - **"Big"** 和 **"Large"** 都表示“大的”。

##### 6. **反义词（Antonym）**

- **定义**：意义相反的单词。
- **示例**：
  - **"Hot"** 和 **"Cold"** 表示“热的”和“冷的”。
  - **"Happy"** 和 **"Sad"** 表示“快乐的”和“悲伤的”。

##### 7. **上下义关系（Hyponymy）**

- **定义**：一个单词的意义包含在另一个单词的意义中。
- **示例**：
  - **"Rose"** 是 **"Flower"** 的下义词（玫瑰是一种花）。
  - **"Dog"** 是 **"Animal"** 的下义词（狗是一种动物）。

##### 8. **文化意义（Cultural Meaning）**

- **定义**：单词在特定文化背景中的特殊意义。
- **示例**：
  - **"Dragon"** 在西方文化中通常象征邪恶，而在中国文化中象征权力和好运。
  - **"Thanksgiving"** 在美国文化中代表家庭团聚和感恩。

##### 9. **语境意义（Contextual Meaning）**

- **定义**：单词在特定上下文中的具体意义。
- **示例**：
  - **"Bank"** 在句子 **"I went to the bank to deposit money."** 中指“银行”。
  - **"Bank"** 在句子 **"We sat by the bank of the river."** 中指“河岸”。

##### 10. **比喻意义（Figurative Meaning）**

- **定义**：单词通过比喻、象征等方式表达的非字面意义。
- **示例**：
  - **"Time is money."** 中，“time”和“money”被比喻为可以“花费”的资源。
  - **"She has a heart of stone."** 中，“heart of stone”比喻冷酷无情。

##### **总结**

英语中的词义是多层次的，包括：

- **字面意义**（基本定义）
- **隐含意义**（情感色彩）
- **多义词**（一词多义）
- **同音异义词**（发音相同，意义不同）
- **同义词**（意义相近）
- **反义词**（意义相反）
- **上下义关系**（包含关系）
- **文化意义**（文化背景）
- **语境意义**（上下文）
- **比喻意义**（非字面意义）

理解词义有助于更准确地使用单词，避免误解，并提高语言表达能力。

### **二、单词学习的核心概念**

#### **1. 词汇量分层**

- **基础词汇（1000-2000词）**：覆盖日常交流的80%（如牛津3000核心词）。
- **中级词汇（3000-5000词）**：理解新闻、影视的90%（如雅思6.5要求）。
- **高级词汇（8000+词）**：学术、专业领域（如GRE、SAT词汇）。

#### **2. 词汇的深度与广度**

- **广度**：单词数量（量的积累）。
- **深度**：掌握单词的多个含义、搭配、用法（如 "run" 有60+含义）。

#### **3. 主动词汇 vs. 被动词汇**

- **主动词汇（Active Vocabulary）**：能主动使用的词（需造句练习）。
- **被动词汇（Passive Vocabulary）**：仅能识别的词（通过阅读扩展）。

#### **4. 高频词与低频词**

- **高频词**：优先掌握（如 the, of, and）。
- **低频词**：按需学习（如专业术语：photosynthesis 光合作用）。

------

### **三、单词记忆的科学方法**

#### **1. 语境记忆法**

- **通过句子/文章记单词**：
  例：从句子 "The *ambitious* scientist *devoted* himself to research." 学习 ambitious（有野心的）、devoted（奉献的）。
- **影视/音乐学习**：
  通过歌词或台词记单词（如《老友记》学 "sarcasm" 讽刺）。

#### **2. 词群记忆法**

- **主题归类**：
  如医疗词汇：surgery, symptom, prescription。
- **同义词/反义词**：
  例：big ↔ small, happy ↔ sad。
- **词族扩展**：
  如 act → actor → action → active → activity。

#### **3. 词根词缀法**

- **常见词根**：
  - bio（生命）→ biology（生物学）, biography（传记）。
  - port（携带）→ transport（运输）, import（进口）。
- **高频前缀**：
  - re-（再次）→ rewrite, replay。
  - mis-（错误）→ misunderstand, mislead。

#### **4. 间隔重复法（Spaced Repetition）**

- 使用工具：Anki、Quizlet，根据遗忘曲线复习。
- 复习周期：1天→3天→7天→15天→30天。

#### **5. 多感官联动**

- **视觉**：单词卡片、思维导图。
- **听觉**：听单词发音（如剑桥词典在线发音）。
- **动觉**：手写单词+例句。

------

### **四、单词学习的阶段策略**

#### **1. 入门阶段（0-1000词）**

- **目标**：掌握高频基础词（数字、颜色、家庭成员、日常动词）。
- **方法**：
  - 看图识词（如《Word by Word》图解词典）。
  - 搭配简单句子练习（如 "I eat an apple."）。

#### **2. 进阶阶段（1000-5000词）**

- **目标**：扩展场景词汇（工作、旅行、科技）。
- **方法**：
  - 阅读分级读物（如《牛津书虫》）。
  - 学习短语动词（如 give up, look after）。

#### **3. 高级阶段（5000+词）**

- **目标**：学术词汇、同义词辨析、文化隐喻。
- **方法**：
  - 精读外刊（如《经济学人》）。
  - 学习词源（如希腊神话对英语词汇的影响）。

------

### **五、常见误区与解决方案**

1. **误区**：死记硬背单词表，脱离语境。
   **解决**：通过句子、文章或影视记单词。
2. **误区**：只记中文释义，忽略发音和用法。
   **解决**：查英英词典（如牛津高阶），关注例句和搭配。
3. **误区**：盲目追求词汇量，忽视深度掌握。
   **解决**：重点词汇造句、写作应用（如用新词写日记）。
4. **误区**：忽视发音规则，导致拼写错误。
   **解决**：学习自然拼读（Phonics），如 "tion" 发音为 /ʃən/。

------

### **六、实用工具**

- **查词工具**：
  - 欧路词典（支持跨软件取词）、剑桥词典（权威发音）。
- **记忆工具**：
  - Anki（自定义卡片）、Quizlet（词库共享）。
- **阅读资源**：
  - 简写版小说（如《哈利波特》英简版）、News in Levels（分级新闻）。
- **听力输入**：
  - 播客（如BBC Learning English）、YouTube频道（English Addict）。

------

### **七、总结**

单词学习需结合**科学方法**（词根词缀、语境记忆）和**分阶段目标**（高频词→场景词→学术词）。关键是通过**大量输入**（阅读、听力）和**主动输出**（写作、口语）巩固记忆，同时避免机械背诵，注重单词的“深度”掌握（发音、搭配、文化内涵）。



## 句法



句型

### **一、句子的核心成分**

1. **主语（Subject）**
   - 句子的执行者或描述对象，通常由名词、代词或名词性短语充当。
   - 例：*She* reads a book. / *The cat on the roof* is sleeping.
2. **谓语（Predicate）**
   - 描述主语的动作或状态，由动词或动词短语构成。
   - 例：He *runs fast*. / They *are students*.
3. **宾语（Object）**
   - 动作的承受者，分为直接宾语（动作直接作用对象）和间接宾语（动作间接影响对象）。
   - 例：She gave *me* (间接宾语) *a gift* (直接宾语).
4. **表语（Predicative）**
   - 与系动词（如 be, seem, become）连用，描述主语的性质或状态。
   - 例：He is *a teacher*. / The sky looks *blue*.
5. **补语（Complement）**
   - 补充说明主语或宾语的信息，分为主语补语和宾语补语。
   - 例：We elected him *president*. (宾语补语) / She seems *tired*. (主语补语)

------

### **二、句子的分类**

#### **1. 按结构分类**

- **简单句（Simple Sentence）**
  仅含一个主谓结构，表达完整意思。
  例：I study English.
- **并列句（Compound Sentence）**
  由并列连词（and, but, or）连接的两个或多个简单句。
  例：I like coffee, *but* she prefers tea.
- **复合句（Complex Sentence）**
  包含一个主句和一个或多个从句（如定语从句、状语从句）。
  例：*If it rains*, we will stay at home. (状语从句)
- **并列复合句（Compound-Complex Sentence）**
  并列句与复合句的结合。
  例：I went to the park, *and* she stayed home *because she was tired*.

#### **2. 按功能分类**

- **陈述句（Declarative Sentence）**
  陈述事实或观点，句末用句号。
  例：The sun rises in the east.
- **疑问句（Interrogative Sentence）**
  提出问题，分为一般疑问句、特殊疑问句、选择疑问句等。
  例：Do you like apples? / *Where* are you going?
- **祈使句（Imperative Sentence）**
  表达请求、命令或建议，通常省略主语。
  例：Close the door. / *Let’s* go for a walk.
- **感叹句（Exclamatory Sentence）**
  表达强烈情感，句末用感叹号。
  例：What a beautiful day!

------

### **三、句子的修饰成分**

1. **定语（Attribute）**
   - 修饰名词或代词，由形容词、介词短语、从句等充当。
   - 例：The *red* car / The book *on the desk*.
2. **状语（Adverbial）**
   - 修饰动词、形容词或整个句子，表示时间、地点、原因、方式等。
   - 例：He runs *quickly*. / *When I arrived*, they were eating.
3. **同位语（Appositive）**
   - 对名词进行解释或补充说明。
   - 例：My friend *Alice* is a doctor.

------

### **四、句子的核心结构**

1. **五种基本句型**
   - **S+V**（主+谓）：Birds fly.
   - **S+V+O**（主+谓+宾）：She eats an apple.
   - **S+V+C**（主+系+表）：He is happy.
   - **S+V+O+O**（主+谓+间宾+直宾）：I gave her a gift.
   - **S+V+O+C**（主+谓+宾+补）：We call him Tom.
2. **主谓一致（Subject-Verb Agreement）**
   - 谓语动词需与主语在“人称”和“数”上保持一致。
   - 例：*She* likes music. / *They* like music.

------

### **五、句子的常见错误**

1. **不完整句（Fragment）**
   - 缺少主谓结构，无法独立成句。
   - 错误：Because I was tired. → 修正：I left because I was tired.
2. **粘连句（Run-on Sentence）**
   - 多个独立分句未用正确连词或标点连接。
   - 错误：It’s raining take an umbrella. → 修正：It’s raining; take an umbrella.
3. **悬垂修饰（Dangling Modifier）**
   - 修饰语逻辑主语与句子主语不一致。
   - 错误：*Walking to school*, the rain started. → 修正：*Walking to school*, I got caught in the rain.

------

### **六、高级知识点**

1. **倒装句（Inversion）**
   - 谓语动词或助动词提前至主语前，常见于疑问句、否定词开头的句子。
   - 例：*Never have I* seen such a sight. / *Here comes* the bus.
2. **强调句（Emphatic Sentence）**
   - 通过结构（如 It is... that...）或词汇（如 do, really）强调某部分。
   - 例：*It was* John *who* broke the window. / I *do* love you.
3. **省略句（Ellipsis）**
   - 省略重复或语境明确的成分。
   - 例：—Can you swim? —Yes, I can. (省略 swim)

------

### **总结**

句子是语法的基础单元，需掌握其**成分、结构、分类、修饰**及**常见错误**。建议通过以下步骤学习：

1. 分析句子成分（主谓宾定状补）；
2. 练习基本句型；
3. 对比中英文差异（如英语重结构，汉语重语义）；
4. 多读多写，积累地道表达。



## 时态与语态

### **一、时态（Tense）**

时态表示动作发生的时间（过去、现在、将来）和状态（进行、完成）。英语共有 **16种时态**，但只需掌握 **8种高频时态** 即可覆盖90%日常使用场景：

#### **1. 高频时态详解**

| **时态名称**       | **结构公式**                  | **核心用法**                             | **时间标志词**           | **例句**                                       |
| :----------------- | :---------------------------- | :--------------------------------------- | :----------------------- | :--------------------------------------------- |
| **一般现在时**     | 动词原形（三单+s）            | 习惯、真理、客观事实                     | always, often, every day | She *works* from home.                         |
| **现在进行时**     | am/is/are + doing             | 正在进行的动作，或近期计划               | now, at the moment       | I *am reading* a book.                         |
| **现在完成时**     | have/has + done               | 过去动作对现在的影响，或持续到现在的状态 | already, since, for      | He *has finished* his homework.                |
| **一般过去时**     | 动词过去式                    | 过去发生的具体动作，与现在无关           | yesterday, last week     | They *watched* a movie last night.             |
| **过去进行时**     | was/were + doing              | 过去某一时刻正在进行的动作               | at 8 PM, while           | She *was cooking* when I called.               |
| **过去完成时**     | had + done                    | 过去的过去（两个动作先后发生）           | by the time, before      | I *had left* before he arrived.                |
| **一般将来时**     | will + do 或 be going to + do | 预测、计划或意图                         | tomorrow, next year      | It *will rain* soon. / I *am going to* travel. |
| **现在完成进行时** | have/has + been doing         | 从过去持续到现在的动作，强调动作仍在继续 | all day, for hours       | I *have been studying* English for 3 years.    |

#### **2. 易混淆时态对比**

- **一般过去时 vs 现在完成时**：
  - *He lived in Paris.*（曾住过，现已离开）
  - *He has lived in Paris.*（仍住在巴黎或强调经历）
- **现在完成时 vs 现在完成进行时**：
  - *I have read the book.*（已完成，强调结果）
  - *I have been reading the book.*（仍在读，强调过程）

#### **3. 时态学习技巧**

- **时间轴法**：画出过去-现在-未来时间轴，标出各时态对应的位置。
- **故事串联法**：用同一动词的不同时态编故事（如：Every day I *walk* to school. Yesterday I *walked* in the rain. By next year, I *will have walked* 1000 miles.）。

------

### **二、语态（Voice）**

语态分为 **主动语态（Active Voice）** 和 **被动语态（Passive Voice）**，用于切换动作的执行者与承受者。

#### **1. 被动语态的结构**

- **公式**：be动词 + 过去分词（+ by + 执行者）

- **时态体现**：通过be动词的时态变化反映时间：

  | **时态**   | **主动语态**                    | **被动语态**                     |
  | :--------- | :------------------------------ | :------------------------------- |
  | 一般现在时 | She writes the letter.          | The letter *is written* by her.  |
  | 现在进行时 | They are building a house.      | A house *is being built*.        |
  | 现在完成时 | He has cleaned the room.        | The room *has been cleaned*.     |
  | 一般过去时 | I fixed the car.                | The car *was fixed* by me.       |
  | 过去进行时 | She was painting the wall.      | The wall *was being painted*.    |
  | 一般将来时 | They will announce the results. | The results *will be announced*. |

#### **2. 使用场景**

- **强调承受者**：The Mona Lisa *was painted* by Da Vinci.（强调画作而非作者）
- **执行者未知或不重要**：My phone *was stolen* yesterday.（谁偷的不重要）
- **客观陈述（学术/新闻）**：The experiment *was conducted* under controlled conditions.

#### **3. 注意事项**

- **避免冗余**：
  错误：The book *was written by J.K. Rowling* in 1997. → 正确：The book *was written* in 1997.
  （若需强调作者则保留by短语）
- **及物动词才有被动语态**：
  错误：The accident *was happened* last night. → 正确：The accident *happened* last night.
  （happen为不及物动词）

------

### **三、中英文差异与常见错误**

#### **1. 时态差异**

- 中文无动词变形，依赖时间词（如“了”“过”）表达时态，易导致错误：
  - 错误：*I go to Beijing yesterday.* → 正确：I *went* to Beijing yesterday.

#### **2. 语态差异**

- 中文被动句常用“被”“由”，但英语被动语态更灵活：
  - 中文：这个问题被解决了。
  - 英文：The problem *has been solved*.（无需强调“被”）

#### **3. 典型错误与修正**

- **时态混淆**：
  错误：*When I arrive, she already leaves.*
  修正：When I *arrived*, she *had already left*.
- **被动语态结构错误**：
  错误：*The cake eaten by him.*
  修正：The cake *was eaten* by him.

------

### **四、学习策略与练习方法**

#### **1. 时态练习**

- **日记法**：每天用不同时态记录事件（如早晨计划用将来时，晚上总结用过去时）。
- **影视标记**：观看美剧时暂停，分析角色对话中的时态（如《老友记》中完成时的使用）。

#### **2. 语态练习**

- **转换训练**：将新闻标题从主动转为被动（如 "Police arrested the suspect." → "The suspect was arrested."）。
- **学术写作**：在论文中刻意使用被动语态（如 "The data were analyzed..."）。

#### **3. 工具推荐**

- **时态练习**：
  - 网站：EnglishPage.com（时态专项练习）
  - APP：Learn English Tenses（互动时间轴）
- **语态练习**：
  - 工具：Grammarly（自动检测语态错误）
  - 语料库：COCA（搜索被动语态真实用例）

------

### **五、总结**

- **时态**：关注动作的**时间**与**状态**，重点掌握8大高频时态，通过时间轴和对比练习强化理解。
- **语态**：根据表达需求切换**主动/被动**，注意结构准确性和使用场景。
- **关键**：避免孤立记忆规则，将时态语态融入听说读写，例如：
  - 听：辨别播客中的时态（如BBC新闻中的现在完成时）；
  - 说：描述过去经历时混合使用一般过去时和过去完成时；
  - 读：分析学术文章中的被动语态比例；
  - 写：在电子邮件中灵活运用不同时态。



## 语气与功能

英语中**语气（Mood）与句子功能（Function）**的系统解析，涵盖核心概念、用法对比及实际应用技巧，帮助我们精准表达态度与意图：

------

### **一、语气的定义与分类**

**语气（Mood）** 是动词形式的变化，反映说话者对所述内容的态度（如事实、假设、命令）。英语主要有以下五种语气：

| **语气类型** | **功能**                         | **例句**                                 |
| :----------- | :------------------------------- | :--------------------------------------- |
| **陈述语气** | 陈述事实或观点                   | She *is* a teacher. / It *rains* a lot.  |
| **祈使语气** | 表达请求、命令或建议             | *Close* the door. / *Let’s go*.          |
| **虚拟语气** | 描述假设、愿望或非现实情况       | If I *were* rich, I *would travel*.      |
| **疑问语气** | 提出问题                         | *Do* you like coffee? / Where *are* you? |
| **条件语气** | 表达可能性或假设（常与虚拟结合） | If it *rains*, we *will stay* home.      |

------

### **二、核心语气详解与功能**

#### **1. 陈述语气（Indicative Mood）**

- **功能**：描述事实、观点或客观信息（占日常使用90%以上）。
- **结构**：使用动词的常规时态形式。
  - *He **works** hard every day.*（一般现在时陈述事实）
  - *They **will visit** Paris next month.*（一般将来时陈述计划）

#### **2. 祈使语气（Imperative Mood）**

- **功能**：直接发出指令、请求或建议。
- **结构**：
  - **肯定**：动词原形开头（*Close* the window.）。
  - **否定**：Don’t + 动词原形（*Don’t touch* the fire.）。
  - **委婉**：添加 please 或 Let’s（*Please sit down*. / *Let’s start* now.）。

#### **3. 虚拟语气（Subjunctive Mood）**

- **功能**：表达非现实、假设、建议或愿望（常见于正式语境）。

- **核心结构**：

  | **场景**           | **结构规则**                         | **例句**                                        |
  | :----------------- | :----------------------------------- | :---------------------------------------------- |
  | **与现在事实相反** | If + 过去式，主句用would/could       | If I *had* time, I *would help* you.            |
  | **与过去事实相反** | If + had done，主句用would have done | If she *had studied*, she *would have passed*.  |
  | **建议/要求**      | that从句中用动词原形                 | It is vital that he *be* honest.                |
  | **愿望（wish）**   | wish后接过去式或过去完成式           | I wish I *were* taller. / I wish I *had known*. |

#### **4. 疑问语气（Interrogative Mood）**

- **功能**：提出问题，分为四类：
  - **一般疑问句**：Yes/No回答（*Do* you agree?）。
  - **特殊疑问句**：以疑问词开头（*What* is your name?）。
  - **选择疑问句**：提供选项（Is it *red or blue*?）。
  - **反义疑问句**：主句+附加疑问（You like coffee, *don’t you*?）。

#### **5. 条件语气（Conditional Mood）**

- **功能**：通过条件句（If从句）表达可能性或假设，与虚拟语气常结合使用。

- **分类**：

  | **条件类型**   | **结构**                           | **例句**                                                    |
  | :------------- | :--------------------------------- | :---------------------------------------------------------- |
  | **真实条件**   | If + 一般现在时，主句将来时        | If it *rains*, we *will cancel* the trip.                   |
  | **非真实条件** | If + 过去式，主句would do          | If I *won* the lottery, I *would travel*.                   |
  | **过去非真实** | If + had done，主句would have done | If he *had left* earlier, he *would have caught* the train. |

------

### **三、语气与功能的关联**

同一句子可通过语气转换实现不同交际功能：

| **功能**   | **语气选择**       | **例句对比**                                 |
| :--------- | :----------------- | :------------------------------------------- |
| **命令**   | 祈使语气           | *Turn off* the light.                        |
| **建议**   | 虚拟语气（委婉）   | I suggest that you *see* a doctor.           |
| **可能性** | 条件语气           | If you *practice* daily, you *will improve*. |
| **假设**   | 虚拟语气（非真实） | If I *were* you, I *would apologize*.        |
| **请求**   | 疑问语气（委婉）   | *Could* you open the window?                 |

------

### **四、常见错误与纠正**

1. **混淆虚拟与陈述语气**
   - 错误：If I *am* you, I *will* go.
   - 修正：If I *were* you, I *would* go.
   - **规则**：非真实条件句需用虚拟语气（be动词用were）。
2. **祈使句主语错误**
   - 错误：*You* close the door.
   - 修正：*Close* the door.
   - **规则**：祈使句默认主语为you，通常省略。
3. **虚拟语气中多余助动词**
   - 错误：It is important that he *should be* here.
   - 修正：It is important that he *be* here.
   - **规则**：美式英语中常省略should，直接用动词原形。

------

### **五、学习策略与工具**

#### **1. 情景模拟法**

- **角色扮演**：模拟餐厅点餐（祈使/疑问语气）、商务谈判（条件/虚拟语气）。
- **影视学习**：分析《纸牌屋》中的政治谈判（虚拟语气表达假设策略）。

#### **2. 对比练习**

- **改写句子**：将陈述句转为虚拟语气或祈使语气：
  - 原句：He should apologize.
  - 虚拟：It is necessary that he *apologize*.
  - 祈使：*Apologize* now!

#### **3. 工具推荐**

- **语法检查**：Grammarly（识别语气错误）。
- **例句库**：Ludwig.guru（搜索真实语境中的语气用法）。
- **练习平台**：British Council LearnEnglish（专项语气练习）。

------

### **六、总结**

- **语气是态度的载体**：同一内容通过不同语气可表达命令、请求、假设或客观陈述。
- **虚拟语气是难点**：需重点掌握其非现实性和建议性场景（如wish从句、建议性that从句）。
- **功能决定语气选择**：根据交际目的（命令、提问、假设）灵活切换语气形式。

**关键口诀**：

- 事实陈述用直陈，命令建议选祈使；
- 虚拟语气表非真，条件句中见可能；
- 疑问语气抓重点，功能明确句意清。





## 文章

### **一、文章的核心要素**

#### **1. 结构（Structure）**

- **三段式结构**（适用于议论文、说明文）：
  - **引言（Introduction）**：提出主题 + 论点（Thesis Statement）。
    *例：Online learning, despite its convenience, may weaken students’ social skills.*
  - **主体（Body Paragraphs）**：分论点 + 论据（数据、例子、引用）。
    *结构：Topic Sentence → Explanation → Example → Conclusion*
  - **结论（Conclusion）**：总结论点 + 升华意义。
    *常用句式：In conclusion, ... / Therefore, it is vital to...*
- **叙事结构**（适用于故事、记叙文）：
  开端（Exposition）→ 发展（Rising Action）→ 高潮（Climax）→ 结局（Resolution）。

#### **2. 连贯性（Cohesion）**

- **连接词（Linking Words）**：
  - 因果：because, therefore, as a result.
  - 对比：however, on the other hand.
  - 顺序：firstly, furthermore, finally.
- **指代（Reference）**：
  使用代词（it, they）或同义词避免重复。
  *例：Climate change is urgent. \*It\* requires global action.*

#### **3. 文体（Genre）**

- **议论文（Argumentative）**：说服读者（强调逻辑与证据）。
- **说明文（Expository）**：解释事实（如科普文章）。
- **记叙文（Narrative）**：讲述故事（含人物、情节）。
- **应用文（Practical Writing）**：邮件、报告、简历（注重格式）。

------

### **二、阅读文章的步骤与技巧**

#### **1. 三步阅读法**

- **略读（Skimming）**：快速抓主旨（读首尾段、段落首句）。
- **扫读（Scanning）**：定位细节（数字、人名、关键词）。
- **精读（Close Reading）**：分析逻辑、隐含意义。

#### **2. 高频考点与策略**

- **主旨题**：寻找 Thesis Statement 或重复出现的主题词。
- **推断题**：结合上下文，避免主观臆断。
- **词义猜测题**：通过前缀后缀、同位语或反义词推断。
  *例：The \*arid\* desert, where rain rarely falls, is harsh for life.*
  → arid = 干旱的（通过“rain rarely falls”推断）。

#### **3. 批判性阅读（Critical Reading）**

- 分析作者意图、语气（tone）和潜在偏见。
- *例：广告类文章可能夸大优点（biased），学术论文更中立（neutral）。*

------

### **三、写作文章的步骤与技巧**

#### **1. 四步写作法**

- **头脑风暴（Brainstorming）**：用思维导图列出观点。
- **大纲（Outline）**：按逻辑排序论点（如重要性顺序）。
- **初稿（Draft）**：快速写出内容，暂不纠结语法。
- **修改（Revising）**：检查逻辑、语法、词汇替换。

#### **2. 提升表达的高级技巧**

- **避免重复**：
  *原句：Many people think technology is good. Many people use it every day.*
  *修改：Many people advocate technology’s benefits, and its daily use proves this.*
- **多样化句式**：
  - 倒装句：Not only does technology help work, but it also enriches life.
  - 强调句：It is education that shapes our future.

#### **3. 常见写作错误**

- **中式英语（Chinglish）**：
  错误：*Although he is young, but he is wise.*
  修正：*Although he is young, he is wise.*
- **主谓不一致**：
  错误：*The list of items are on the table.*
  修正：*The list of items is on the table.*

------

### **四、分阶段学习策略**

#### **1. 初级阶段（能写100词短文）**

- **目标**：掌握基本结构和简单连接词。
- **练习**：
  - 模仿模板写段落（如描述一天活动）。
  - 阅读简化版文章（《新概念英语》第一册）。

#### **2. 中级阶段（能写300词议论文）**

- **目标**：逻辑清晰，论据充分。
- **练习**：
  - 学习范文结构（如雅思大作文）。
  - 积累高频论点库（环保、科技、教育）。

#### **3. 高级阶段（能写学术/专业文章）**

- **目标**：语言精准，学术规范。
- **练习**：
  - 精读期刊论文，学习引用格式（APA/MLA）。
  - 使用学术词汇（e.g., “demonstrate” 替代 “show”）。

------

### **五、实用资源推荐**

- **阅读素材**：
  - 入门：BBC News (Easy English)
  - 进阶：《经济学人》（The Economist）
  - 高级：科学美国人（Scientific American）
- **写作工具**：
  - Grammarly（语法修改）
  - Hemingway Editor（简化冗长句子）
- **范文网站**：
  - IELTS Liz（雅思范文）
  - ETS官方题库（托福写作）

------

### **六、总结**

英语文章的学习需兼顾**输入（阅读）\**与\**输出（写作）**：

- **阅读**时，注重结构分析和批判性思维；
- **写作**时，从模仿到创新，逐步提升逻辑与语言质量。
  **关键原则**：

1. 简洁胜于复杂（Simple is better than complex.）。
2. 修改比写作更重要（Good writing is rewriting.）。



## 学习方法

学习英语的知识体系构建需要兼顾**系统性**和**实用性**，避免割裂式学习。传统教学常按“音标→单词→语法→句子→文章”的线性顺序，但容易陷入“学完就忘”或“无法应用”的困境。更科学的方法应遵循 **“螺旋式上升”结构**，将知识点有机融合，分阶段循环强化。以下是一个经过验证的体系框架：

------

### **一、核心理念：四维联动模型**

将英语学习分为 **“语音、词汇、结构、应用”** 四个维度，**每个阶段都同步推进**，但侧重点不同：

1. **语音（音标+发音规则）**：建立发音基础，避免错误固化。
2. **词汇（词义+搭配+词族）**：通过场景和语块记忆，而非孤立背词。
3. **结构（语法+句型）**：以句子为核心，理解规则而非死记术语。
4. **应用（听说读写）**：从简单输出到复杂表达，强调真实语境。

------

### **二、分阶段学习路径**

#### **阶段1：基础搭建（0-3个月）**

- **目标**：能听懂/说出简单句子，掌握高频词和基础语法。
- **学习重点**：
  - **语音**：
    - 国际音标（重点：20个高频音标如/æ/, /θ/, /ʃ/）。
    - 自然拼读规则（CVC结构：cat, bed）。
  - **词汇**：
    - 500个高频词（名词：家庭/数字/颜色；动词：eat, go, have）。
    - 短语语块（如：How are you? / I want to...）。
  - **结构**：
    - 主谓宾句型（I eat apples.）。
    - 疑问句（Do you...? / What is...?）。
  - **应用**：
    - 听：慢速短对话（如ESL Pod）。
    - 说：替换练习（替换主语/宾语造句）。
    - 读：图解短文（如《Oxford Phonics World》）。
    - 写：抄写句子+填空练习。

#### **阶段2：系统扩展（4-12个月）**

- **目标**：流畅日常交流，理解中级文本。
- **学习重点**：
  - **语音**：
    - 连读、弱读、重音（如 "I want to" → /aɪ wənə/）。
    - 语调训练（疑问句升调、陈述句降调）。
  - **词汇**：
    - 扩展至3000词（按场景分类：旅行、职场、科技）。
    - 学习短语动词（get up, look after）和惯用语（break a leg）。
  - **结构**：
    - 复合句（定语从句：The book *that I read* is interesting.）。
    - 时态综合运用（过去完成时：I *had finished* work before she called.）。
  - **应用**：
    - 听：TED-Ed短篇演讲（带字幕）。
    - 说：角色扮演（餐厅点餐、问路）。
    - 读：分级读物（《牛津书虫》L3-L4）。
    - 写：日记（5-8句描述每日活动）。

#### **阶段3：高阶深化（1-2年）**

- **目标**：学术或专业场景应用，理解复杂逻辑。
- **学习重点**：
  - **语音**：
    - 区分近音（如 ship/sheep, think/sink）。
    - 演讲技巧（停顿、强调）。
  - **词汇**：
    - 学术词汇（analyze, hypothesis） + 同义词辨析（big/large/huge）。
    - 隐喻与文化词（white lie, spill the beans）。
  - **结构**：
    - 复杂句式（倒装句：*Not only* does he study, *but* he also works.）。
    - 逻辑衔接（因果：therefore / 让步：although）。
  - **应用**：
    - 听：学术讲座（Coursera课程）。
    - 说：辩论（AI利弊、环保政策）。
    - 读：外刊精读（《经济学人》科技板块）。
    - 写：议论文（500词，三段式结构）。

#### **阶段4：精通应用（长期）**

- **目标**：母语级表达，专业领域输出。
- **学习重点**：
  - **语音**：
    - 方言辨识（美式vs英式发音差异）。
    - 即兴演讲的节奏控制。
  - **词汇**：
    - 行业术语（如法律英语：plaintiff, tort）。
    - 文学修辞（明喻、反讽）。
  - **结构**：
    - 长难句拆解（学术论文、法律文件）。
    - 文体风格调整（正式邮件 vs 口语聊天）。
  - **应用**：
    - 听：无字幕影视（《纸牌屋》《神探夏洛克》）。
    - 说：即兴演讲（Toastmasters俱乐部）。
    - 读：原版小说（《1984》《傲慢与偏见》）。
    - 写：学术论文（APA格式）/ 创意写作。

------

### **三、关键策略与工具**

#### **1. 沉浸式学习法**

- **环境改造**：手机/电脑系统设为英文，每日听英文播客（如NPR）。
- **影子跟读（Shadowing）**：模仿音频的语音语调，延迟1-2秒复述。

#### **2. 模块化学习**

- **语法**：按功能而非术语学习（如“描述过去”→学习一般过去时、过去进行时）。
- **词汇**：按场景整合（如“医院场景”→doctor, pain, prescription, appointment）。

#### **3. 动态反馈机制**

- **录音对比**：用手机录下自己的发音，与原声对比。
- **AI工具**：Grammarly检查写作，ELSA纠正发音。

#### **4. 循环复习系统**

- **遗忘曲线复习**：用Anki设置单词/句子的复习间隔（1天→3天→7天→15天）。
- **主题循环**：每3个月重温一次核心语法（如时态、从句）。

------

### **四、常见误区与解决方案**

1. **误区**：先学完语法再练口语。
   **解决**：语法与输出同步，例如学完“现在进行时”后立即造句描述正在做的事情。
2. **误区**：只学“正确表达”，回避错误。
   **解决**：建立“错误日志”，定期分析常见错误（如he/she混淆）。
3. **误区**：孤立学习模块，忽视关联。
   **解决**：用思维导图整合知识点（如将“定语从句”与“描述人物”场景结合）。

------

### **五、工具推荐**

- **语音**：Sounds: The Pronunciation App（互动音标表）。
- **词汇**：Quizlet（自定义词卡）、欧路词典（跨软件取词）。
- **语法**：English Grammar in Use（剑桥语法红宝书）。
- **应用**：HelloTalk（语言交换）、Hemingway Editor（简化冗长句子）。

------

### **总结**

科学的英语知识体系应是 **“语音为锚点，句子为核心，场景为脉络”** 的动态结构：

1. **语音**：贯穿始终，从音标到语调逐步精进；
2. **句子**：作为最小应用单位，整合词汇与语法；
3. **场景**：提供学习动机（如旅游、考试、职场）。
   **关键原则**：先建立“能用”的框架（如用简单句交流），再逐步填充细节（精修发音、扩展词汇），最终实现从“语言知识”到“语言能力”的质变。');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060986106316460032, 2060986106312265728, '**猴子吃桃问题。猴子第一天摘下若干个桃子，
每天都吃了前一天剩下的一半零一个，到第10天早上想再吃的时候，
就剩下一个桃子. 求第一天共摘多少个桃子。
**

```c++
		int day,x,y;
		y=1;day=10;
		while(day>1){
			x=(y+1)*2;//前一天的桃子数量等于后一天的数量加1然后乘以2
			y=x;
			day--;
		}
		printf(" %d\n\n",x);
```
结果： 1534


**使用程序产生1~12（包括1和12）的一个数，然后输出对应得月份天数（2月按28天算）**

```c++
		int i,month;

		srand((unsigned int)time(NULL));//设置随机数种子。 
		month=rand()%12+1;//得到1~12区间的随机数
		switch(month){
			case 1:
				printf("%d 月有 31 天\n\n",month);break;
			case 2:
				printf("%d 月有 28 天\n\n",month);break;
			case 3:
				printf("%d 月有 31 天\n\n",month);break;
			case 4:
				printf("%d 月有 30 天\n\n",month);break;
			case 5:
				printf("%d 月有 31 天\n\n",month);break;
			case 6:
				printf("%d 月有 30 天\n\n",month);break;
			case 7:
				printf("%d 月有 31 天\n\n",month);break;
			case 8:
				printf("%d 月有 31 天\n\n",month);break;
			case 9:
				printf("%d 月有 30 天\n\n",month);break;
			case 10:
				printf("%d 月有 31 天\n\n",month);break;
			case 11:
				printf("%d 月有 30 天\n\n",month);break;
			case 12:
				printf("%d 月有 31 天\n\n",month);break;
			}
```
结果：7 月有 31 天');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060986902751875072, 2060986902747680768, '```c
#include <stdio.h>
#include <stdlib.h>
 
static int isprime(int);
 
void main(){
 
	int i,j=0;
 
	for(i=0;;){
 
		printf("输入一个数判断是否为质数（-0 退出）:");
		scanf_s("%d",&j);
 
		if(j==-0){
			printf("\nEXIT！\n  EXIT!\n   EXIT!!！\n\n",j);
			break;
		}
 
		if(isprime(j)){
			printf("\n	%d :Is a net prime number！\n\n",j);
		}else{
			printf("\n	%d :It is a prime number！\n\n",j);
		}
	}
}
static int isprime(int num){
	int i;
	for(i=2;i<num;i++){
		if(num%i==0){
			return 1;
		}else{
			return 0;
		}
	}
}
```
结果：![](https://img.yangmufa.cn/blog-article/0ee4cc3d58bd4995b71dc4fc7b31ea93.png)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060992619793747969, 2060992619793747968, 'WinFrom软件在正式环境运行,突然有一天早上就报错,

1.未能加载文件或程序集“netstandard, Version=2.0.0.0, Culture=neutral, PublicKeyToken=cc7b13ffcd2ddd51”的程序清单
![](https://img.yangmufa.cn/blog-article/ec97846041ba4b908b2468e7a3323ea1.png)

2.要启用程序集绑定失败日志记录，清将注册表值[0Softvara\miarosoft\Fusion''EnablsLoe](0WORD)设置为1注意:会有一些与程序集绑定头败日志记录关联的性能损失*要关闭此功能，请移除注册表值0MSoftwaremierosoft\rusion!EnableLoc]
![](https://img.yangmufa.cn/blog-article/ca5de399537d42b3a3c1d710b36f1714.png)

#### 解决办法
###### 1.安装.NetFramework运行时4.8.1
https://dotnet.microsoft.com/zh-cn/download/dotnet-framework/net481
(一开始安装4.7.1安装失败,提示系统已经具备此版本)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060991194133041153, 2060991194133041152, '主要介绍Windows Server 2019 搭建FTP站点踩过的坑

**大步骤分为以下：**  
  1.添加IIS及FTP服务角色  
  2.创建FTP账户（用户名和密码）和组  
  3.设置共享文件夹的权限  
  4.添加及设置FTP站点  
  5.配置FTP防火墙支持  
  6.配置安全组策略  
  7.客户端测试  
# 操作步骤
## 1. 添加IIS及FTP服务角色
　　a.选择【开始】→【服务器管理器】  
　　b.点击【添加角色和功能】  
  ![](https://img.yangmufa.cn/blog-article/855b8e9ee33242a09b187a98be1fde6b.png)　
　　c.在弹出的“开始之前”对话框中，单击“下一步”  
　　d.选择“基于角色或基于功能的安装”，单击“下一步”  
  ![](https://img.yangmufa.cn/blog-article/1fa870f4dbbb4a2f8b8634ddf28a497b.png)
　　e.从服务器池中选择服务器，单击“下一步”  
  ![](https://img.yangmufa.cn/blog-article/4db628c324f1433fabe590c06c9e41ba.png)
　　f.选择“ Web服务器（IIS）”，并在弹出的对话框中单击“添加功能”，然后单击“下一步”  
  ![](https://img.yangmufa.cn/blog-article/665b0c93d498413ab67e13122a203576.png)
  ![](https://img.yangmufa.cn/blog-article/fc0e9e1fac934c4dacf7e4a4711c6952.png)
　　g.连续单击“下一步”，到“角色服务”页面  
　　h.选择“FTP服务器” 以及 “IIS管理控制台”，单击“下一步”
![](https://img.yangmufa.cn/blog-article/3726759b1af04bcda05abd73eb9020a4.png)
　　i.单击“安装”，开始部署服务角色  
　　j.安装完成后，单击“关闭”  
## 2.创建FTP账户（用户名和密码）和组  
 　  **创建Windows账户（用户名和密码）和组，用于FTP使用。如果您希望匿名用户可以访问，可以不创建FTP用户和密码。**  
　　a.在“服务器管理器”中，选择“仪表板 > 工具 > 计算机管理”  
  ![](https://img.yangmufa.cn/blog-article/c1a0ecb62cf946ef8576e8522094fe8f.png)
    b.选择“系统工具 > 本地用户和组 > 组”，在右侧空白处右击，并选择“新建组”  
  ![](https://img.yangmufa.cn/blog-article/b29d8d94aea64565b7aac6e4f3463790.png)
　　c.选择“系统工具 > 本地用户和组 > 用户”，在右侧空白处右击，并选择“新用户”  
　　　　设置“用户名”和“密码”，此处用户名以“ftpadmin”为例
  ![](https://img.yangmufa.cn/blog-article/12d4d43a5b9746a984fd32d5d26d9ce7.png)
        为ftpadmin用户添加【隶属于】组，添加设置ftp组
  ![](https://img.yangmufa.cn/blog-article/316c3f03eac44cb3b18f8f04027d4a51.png)
## 3.设置共享文件夹的权限
  　　需要在FTP站点为共享给用户的文件夹设置访问及修改等权限  
    a.在服务器上创建一个供FTP使用的文件夹，选择文件夹，并单击右键选择“属性”。    
  　　此处以“work01”文件夹为例  
　　b.在“安全”页签，选择 “ftpadmin”用户和“ftp”组，单击“编辑”    
  ![](https://img.yangmufa.cn/blog-article/36375f7456af4384af65e5b37ccea830.png)
## 4.添加及设置FTP站点
　　a.在“服务器管理器”中，选择“仪表板 > 工具 > Internet Information Services (IIS)管理器 ”  
  ![](https://img.yangmufa.cn/blog-article/346391306bd142f9b4cfe231fb015f4d.png)
    b.选择“网站”并单击右键，然后选择“添加FTP站点”    
  ![](https://img.yangmufa.cn/article-cover-temp/90f0d707e5aa4b2da3a2c7715156122e.png)
    c.在弹出的窗口中，填写FTP站点名称及共享文件夹的物理路径，然后单击“下一步”  
　　   此处站点名称以“FtpServer”为例  
  ![](https://img.yangmufa.cn/blog-article/e73fc9fd438e43f394f2c47bab289f85.png)
    d.输入该弹性云服务器的公网IP地址以及端口号，并设置SSL，单击“下一步”  
      端口号 默认为21，也可自行设置。  
      SSL根据需求进行设置。　制作服务器证书  
  ![](https://img.yangmufa.cn/blog-article/3da83888b8ec4421992c8bce78f9cfbe.png)
  　　e.设置身份认证和授权信息，并单击“完成”      
　　　　**身份认证**  
　　　　　　**匿名：**允许任何仅提供用户名 “anonymous” 或 “ftp” 的用户访问内容  
　　　　　　**基本：**需要用户提供有效用户名和密码才能访问内容。但是基本身份验证通过网络传输密码时不加密，因此建议在确认客户端和FTP服务器之间的网络连接安全时使用此身份验证方法。  
　　　　**授权**  
　　　　　　**允许访问**  
　　　　　　　　**所有用户：** 所有用户均可访问相应内容。  
　　　　　　　　**匿名用户：** 匿名用户可访问相应内容。  
　　　　　　　　**指定角色或用户组：** 仅指定的角色或用户组的成员才能访问相应内容。如果选择此项，需要在下面输入框中输入指定的角色或用户组。  
　　　　　　　　**指定用户：** 仅指定的用户才能访问相应内容。如果选择此项，需要在下面输入框中输入指定的用户。  
  ![](https://img.yangmufa.cn/blog-article/7df03972e610404490c48dbc186ea9b9.png)
  ## 5.配置FTP防火墙支持
　　如果需要使用FTP服务器的被动模式，则需要配置FTP防火墙支持。  
　　a.双击“FTP防火墙支持”，打开FTP防火墙支持的配置界面  
  ![](https://img.yangmufa.cn/blog-article/2b8aaf1da007463a9b4fe10ea3a68f8b.png)
　　b.配置相关参数，并单击“应用”  
　　数据通道端口范围：指定用于被动连接的端口范围。可指定的有效端口范围为1025-65535。请根据实际需求进行设置  
　　防火墙的外部IP地址：输入该弹性云服务器的公网IP地址  
  ![](https://img.yangmufa.cn/blog-article/2c316f5ff5564a568252c95775ae8c40.png)
    c.重启云服务器使防火墙配置生效  
## 6.配置安全组策略
　　搭建好FTP站点后，需要在安全组的入方向添加两条放行FTP端口的规则，一条端口为21，一条端口为5000-6000区间。  
　　如果配置了“FTP防火墙支持”，需要在安全组中同时放行FTP站点使用的端口和FTP防火墙使用的数据通道端口。  
　　服务器防火墙默认放行TCP的21端口用于FTP服务。如果选用其他端口，需要在防火墙中添加一条放行此端口的入站规则。 ## 7.客户端测试  
 　   打开客户端的计算机，在路径栏输入 “ftp://FTP服务器IP地址:FTP端口”(如果不填端口则默认访问21端口) 。弹出输入用户名和密码的对话框表示配置成功，正确的输入用户名和密码后，即可对 FTP 文件进行相应权限的操作。  
  ![](https://img.yangmufa.cn/blog-article/66be8ab881b24337bb0f839c9f75687b.png)
## 8.踩过的坑说明：
　　1.因端口号没有在安全组入方向设置放行端口，导致无法访问    
　　2.因设置FTP授权规则中设置用户导致访问FTP文件夹失败，目前FTP授权规则用户设为所有用户可正常访问FTP文件夹。  
`原文链接: https://www.cnblogs.com/wencg/p/13450938.html`');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060991513785143296, 2060991513780948992, '## 问题:
1. .sqlite数据库文件损坏
`Error details: Error while executing SQL query on database  database disk image is malformed`  
![](https://img.yangmufa.cn/blog-article/c6f49c73c11f465586533800b622a744.png)
2.由于生产不能停,所以新.sqlite文件在不断的新增数据,  
3.修复的.sqlite文件的数据和新的.sqlite数据合并成了一个问题  
## 解决办法
### 一、准备
1. SQLite Expert Professional修复软件下载与安装
 参考文献：[](https://blog.csdn.net/fangye945a/article/details/96908513)  
### 二、修复损坏的.sqlite文件
1. 使用SQLite Expert Professional 打开数据库，点击Database选项页，点击Repair按键进行修复。   
![](https://img.yangmufa.cn/blog-article/a11d487b130c4e28818b0e613cd62765.png)
2. 选择new file，指定修复完成的数据库目标路径，点击start按钮开始修复，如果数据库比较大，耐心等待即可。  
![](https://img.yangmufa.cn/blog-article/c4cab23e0d174a92932b4b11f8d072be.png)
3.修复完成的数据库如下所示：
![](https://img.yangmufa.cn/blog-article/e18b851688494d44aaefbe50521740b0.png)
repaired.db3是修复后的文件，后缀如何你导入的是.sqlite那么导出的就是.sqlite，如过导入的是.db3那么导出的就是.db3  
### 二、编写C#代码对新的数据库文件和恢复出来的文件数据合并
1. 代码使用说明：
![](https://img.yangmufa.cn/article-cover-temp/20661b9791214473aa30d1d91e15a9b6.png)  
2. 完整代码如下：
```c#
using System;
using System.Linq;
using System.Collections.Generic;
using Microsoft.Data.Sqlite;

namespace DataRecovery;

class Program {
  static void Main(string[] args) {
    // 可使用命令行参数，或使用下面的硬编码路径
    // if (args.Length < 3) { Console.WriteLine("用法: DataRecovery <target.sqlite> <source.sqlite> <table_name>"); return; }

    // 根目录下的数据库文件（根据你当前的文件结构）
    var targetPath = @"e:\DevelopmentKitProject\Zhima\CSharp\DataRecovery\OP0060-MESDB-lao_repaired.sqlite";
    var sourcePath = @"e:\DevelopmentKitProject\Zhima\CSharp\DataRecovery\OP0060-MESDB-xin.sqlite";
    var tableName = "AlarmUpload";

    // 如果传了命令行参数，则优先使用参数
    if (args.Length >= 3) {
      targetPath = args[0];
      sourcePath = args[1];
      tableName = args[2];
    }

    // 是否自动迁移两个库中同名表
    bool autoMigrateAllTables = true;

    Console.WriteLine($"目标库: {targetPath}\n源库: {sourcePath}\n表名: {tableName}");

    if (autoMigrateAllTables) {
      Console.WriteLine("自动模式已开启：将扫描两个数据库的表并迁移所有同名表...");
      try {
        MigrateAllCommonTables(targetPath, sourcePath);
        Console.WriteLine("所有同名表迁移完成。");
      } catch (Exception ex) {
        Console.WriteLine($"自动迁移失败: {ex.Message}");
      }
      return;
    }

    try {
      // 优先 ATTACH，失败回退双连接
      MergeWithNewPrimaryKeys_Attach(targetPath, sourcePath, tableName);
      Console.WriteLine("合并完成: 源库记录已以新主键插入到目标库。(ATTACH)");
    } catch (SqliteException ex) {
      Console.WriteLine($"{tableName} ATTACH 失败: {ex.Message}，尝试使用双连接方式...");
      try {
        MergeWithNewPrimaryKeys_TwoConnections(targetPath, sourcePath, tableName);
        Console.WriteLine("合并完成: 源库记录已以新主键插入到目标库。(TwoConnections)");
      } catch (Exception ex2) {
        Console.WriteLine($"合并失败: {ex2.Message}");
      }
    } catch (Exception ex) {
      Console.WriteLine($"合并失败: {ex.Message}");
    }
  }

  // 扫描两个数据库的用户表，迁移所有同名表
  static void MigrateAllCommonTables(string targetPath, string sourcePath) {
    var targetTables = GetUserTables(targetPath);
    var sourceTables = GetUserTables(sourcePath);

    var commonTables = targetTables.Intersect(sourceTables, StringComparer.OrdinalIgnoreCase).ToArray();
    Console.WriteLine($"检测到两个库的同名表数量: {commonTables.Length}");
    if (commonTables.Length == 0) { Console.WriteLine("未发现同名表，自动迁移跳过。"); return; }

    foreach (var t in commonTables) {
      Console.WriteLine($"\n=== 迁移表: {t} ===");
      try {
        MergeTableSmart(targetPath, sourcePath, t);
        Console.WriteLine($"[OK] {t} 迁移完成");
      } catch (Exception ex) {
        Console.WriteLine($"[FAIL] {t} 迁移失败: {ex.Message}");
      }
    }
  }

  // 智能合并单表：优先 ATTACH，失败则回退双连接
  static void MergeTableSmart(string targetPath, string sourcePath, string tableName) {
    try {
      MergeWithNewPrimaryKeys_Attach(targetPath, sourcePath, tableName);
      Console.WriteLine($"合并完成 (ATTACH): {tableName}");
    } catch (SqliteException ex) {
      Console.WriteLine($"ATTACH 失败: {ex.Message} -> 回退双连接: {tableName}");
      MergeWithNewPrimaryKeys_TwoConnections(targetPath, sourcePath, tableName);
      Console.WriteLine($"合并完成 (TwoConnections): {tableName}");
    }
  }

  // 策略三：插入时为记录重新分配新的主键（ATTACH 方法）
  static void MergeWithNewPrimaryKeys_Attach(string targetPath, string sourcePath, string tableName) {
    using var conn = new SqliteConnection($"Data Source={targetPath};");
    conn.Open();

    using (var busyCmd = conn.CreateCommand()) { busyCmd.CommandText = "PRAGMA busy_timeout=5000;"; busyCmd.ExecuteNonQuery(); }

    using var tx = conn.BeginTransaction();

    // 只读附加源库（URI，使用标准 file:/// 格式）
    using (var attachCmd = conn.CreateCommand()) {
      attachCmd.Transaction = tx;
      attachCmd.CommandText = "ATTACH DATABASE $path AS src;";
      attachCmd.Parameters.AddWithValue("$path", BuildAttachUri(sourcePath, readOnly: true));
      try {
        attachCmd.ExecuteNonQuery();
      } catch (SqliteException ex) {
        Console.WriteLine($"ATTACH 使用 URI 失败: {ex.Message}，改用常规路径重试...");
        attachCmd.Parameters.Clear();
        attachCmd.CommandText = "ATTACH DATABASE $path AS src;";
        attachCmd.Parameters.AddWithValue("$path", sourcePath);
        attachCmd.ExecuteNonQuery();
      }
    }

    // 获取列信息与主键列集合
    var (columns, pkColumns, types) = GetColumnsAndPk(conn, tx, tableName);
    if (columns.Length == 0) throw new InvalidOperationException($"表不存在或无列: {tableName}");

    LogSchema("目标库", tableName, columns, pkColumns, types);

    // 构造列列表，将所有主键列替换为 NULL，其余列从 src 选择
    var colListForInsert = string.Join(", ", columns);
    var selectCols = new System.Text.StringBuilder();
    for (int i = 0; i < columns.Length; i++) {
      var col = columns[i];
      if (pkColumns.Contains(col)) selectCols.Append("NULL"); else selectCols.Append($"s.{col}");
      if (i < columns.Length - 1) selectCols.Append(", ");
    }

    var sql = $@"INSERT INTO {tableName} ({colListForInsert})
SELECT {selectCols} FROM src.{tableName} s;";

    using (var insertCmd = conn.CreateCommand()) { insertCmd.Transaction = tx; insertCmd.CommandText = sql; insertCmd.ExecuteNonQuery(); }

    // 同步 sqlite_sequence（如果存在）
    TrySyncSequence(conn, tx, tableName, pkColumns.FirstOrDefault() ?? "id");

    using (var detachCmd = conn.CreateCommand()) { detachCmd.Transaction = tx; detachCmd.CommandText = "DETACH DATABASE src;"; detachCmd.ExecuteNonQuery(); }

    tx.Commit();
    conn.Close();
  }

  // 双连接方法，避免 ATTACH 锁冲突；当只有主键列时也能处理（单列 INTEGER PRIMARY KEY 情况）
  static void MergeWithNewPrimaryKeys_TwoConnections(string targetPath, string sourcePath, string tableName) {
    using var targetConn = new SqliteConnection($"Data Source={targetPath};");
    targetConn.Open();
    using (var busyCmd = targetConn.CreateCommand()) { busyCmd.CommandText = "PRAGMA busy_timeout=5000;"; busyCmd.ExecuteNonQuery(); }

    using var tx = targetConn.BeginTransaction();

    // 目标库的列信息
    var (allColumns, pkColumns, types) = GetColumnsAndPk(targetConn, tx, tableName);
    LogSchema("目标库", tableName, allColumns, pkColumns, types);

    var nonPkColumns = allColumns.Where(c => !pkColumns.Contains(c)).ToArray();

    // 源库连接（只读）
    using var sourceConn = new SqliteConnection($"Data Source={sourcePath};Mode=ReadOnly;");
    sourceConn.Open();
    using (var busyCmd2 = sourceConn.CreateCommand()) { busyCmd2.CommandText = "PRAGMA busy_timeout=5000;"; busyCmd2.ExecuteNonQuery(); }

    // 打印源库表结构（帮助诊断）
    var (srcColumns, srcPkColumns, srcTypes) = GetColumnsAndPk(sourceConn, null, tableName);
    LogSchema("源库", tableName, srcColumns, srcPkColumns, srcTypes);

    if (nonPkColumns.Length == 0) {
      // 仅主键列：仅当单列 INTEGER PRIMARY KEY 时可以插入默认值
      if (pkColumns.Count == 1 && IsIntegerPrimaryKey(types[pkColumns[0]])) {
        Console.WriteLine("检测到表仅包含一个整数主键列，按源库行数插入空行以生成新主键...");
        using var cntCmd = sourceConn.CreateCommand();
        cntCmd.CommandText = $"SELECT COUNT(*) FROM {tableName};";
        var total = Convert.ToInt32(cntCmd.ExecuteScalar());

        using var insertCmd = targetConn.CreateCommand();
        insertCmd.Transaction = tx;
        insertCmd.CommandText = $"INSERT INTO {tableName} DEFAULT VALUES;";
        for (int i = 0; i < total; i++) insertCmd.ExecuteNonQuery();

        TrySyncSequence(targetConn, tx, tableName, pkColumns[0]);
        tx.Commit();
        Console.WriteLine($"插入记录数: {total}");
        return;
      }
      throw new InvalidOperationException("无法执行：表仅包含主键列或主键为复合/非整数类型，策略三不适用。");
    }

    // 正常情况：不包含主键列，让 SQLite 自行分配主键
    var insertSql = $"INSERT INTO {tableName} ({string.Join(", ", nonPkColumns)}) VALUES ({string.Join(", ", nonPkColumns.Select(c => "@" + c))});";
    using var insertCmd2 = targetConn.CreateCommand();
    insertCmd2.Transaction = tx;
    insertCmd2.CommandText = insertSql;
    var insertParams = nonPkColumns.Select(c => insertCmd2.Parameters.Add(new SqliteParameter("@" + c, null))).ToArray();

    var selectSql = $"SELECT {string.Join(", ", nonPkColumns)} FROM {tableName};";
    using var selectCmd = sourceConn.CreateCommand();
    selectCmd.CommandText = selectSql;

    int count = 0;
    using (var reader = selectCmd.ExecuteReader()) {
      while (reader.Read()) {
        for (int i = 0; i < nonPkColumns.Length; i++) insertParams[i].Value = reader.IsDBNull(i) ? DBNull.Value : reader.GetValue(i);
        insertCmd2.ExecuteNonQuery();
        count++;
      }
    }

    TrySyncSequence(targetConn, tx, tableName, pkColumns.FirstOrDefault() ?? "id");
    tx.Commit();
    targetConn.Close();
    Console.WriteLine($"插入记录数: {count}");
  }

  // 读取列信息与主键列集合
  static (string[] columns, List<string> pkColumns, Dictionary<string, string> types) GetColumnsAndPk(SqliteConnection conn, SqliteTransaction? tx, string tableName) {
    var columns = new List<string>();
    var pkColumns = new List<string>();
    var types = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);

    using var pragmaCmd = conn.CreateCommand();
    if (tx != null) pragmaCmd.Transaction = tx;
    pragmaCmd.CommandText = $"PRAGMA table_info({tableName});";
    using var reader = pragmaCmd.ExecuteReader();
    while (reader.Read()) {
      var name = reader.GetString(1);
      var type = reader.IsDBNull(2) ? string.Empty : reader.GetString(2);
      var pkOrder = reader.GetInt32(5); // >0 表示属于主键（复合主键时为序号 1..N）
      columns.Add(name);
      types[name] = type;
      if (pkOrder > 0) pkColumns.Add(name);
    }
    return (columns.ToArray(), pkColumns, types);
  }

  static bool IsIntegerPrimaryKey(string type) {
    // SQLite 对于 "INTEGER PRIMARY KEY"/"INTEGER NOT NULL PRIMARY KEY" 的类型字符串通常包含 INTEGER
    return type != null && type.Trim().Equals("INTEGER", StringComparison.OrdinalIgnoreCase);
  }

  static void TrySyncSequence(SqliteConnection conn, SqliteTransaction tx, string tableName, string pkColumn) {
    try {
      using var seqCmd = conn.CreateCommand();
      seqCmd.Transaction = tx;
      seqCmd.CommandText = $@"UPDATE sqlite_sequence SET seq = (SELECT MAX({pkColumn}) FROM {tableName}) WHERE name = ''{tableName.Replace("''", "''''")}'';";
      seqCmd.ExecuteNonQuery();
    } catch { /* sqlite_sequence 不存在时忽略 */ }
  }

  static void LogSchema(string dbLabel, string tableName, string[] columns, List<string> pkColumns, Dictionary<string, string> types) {
    Console.WriteLine($"[{dbLabel}] 表 {tableName} 列信息:");
    foreach (var c in columns) {
      var type = types.ContainsKey(c) ? types[c] : string.Empty;
      var isPk = pkColumns.Contains(c) ? "(PK)" : string.Empty;
      Console.WriteLine($" - {c} {type} {isPk}");
    }
  }

  // 工具方法：读取指定数据库的用户表（排除 sqlite_* 系统表）
  static string[] GetUserTables(string dbPath) {
    var list = new List<string>();
    using var conn = new SqliteConnection($"Data Source={dbPath};Mode=ReadOnly;");
    conn.Open();
    using (var busyCmd = conn.CreateCommand()) { busyCmd.CommandText = "PRAGMA busy_timeout=5000;"; busyCmd.ExecuteNonQuery(); }
    using var cmd = conn.CreateCommand();
    cmd.CommandText = "SELECT name FROM sqlite_master WHERE type=''table'' AND name NOT LIKE ''sqlite_%'';";
    using var reader = cmd.ExecuteReader();
    while (reader.Read()) list.Add(reader.GetString(0));
    return list.ToArray();
  }

  // 将 Windows 路径转换为 SQLite 支持的 file:/// URI，并可附加只读参数
  static string BuildAttachUri(string path, bool readOnly) {
    var uri = new Uri(path); // 例如 file:///E:/DevelopmentKitProject/.../db.sqlite
    var baseUri = uri.AbsoluteUri; // 标准 URI
    return readOnly ? baseUri + "?mode=ro" : baseUri;
  }
}
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060990722923958272, 2060990722919763968, '**1**、对int a[]={25,24,12,76,98,101,50,28}数组进行排序。  
```c
		int i=0,j=0,temp=0,a[]={25,24,12,76,98,101,50,28};
		while(i<sizeof(a)/4){
			for(j=0;j<sizeof(a)/4-i-1;){
				if(a[j]<a[j+1]||a[j]==a[j+1]){
					j++;
				}else if(a[j]>a[j+1]){
					temp=a[j];
					a[j]=a[j+1];
					a[j+1]=temp;
					j++;
				}
			}
			i++;
		}
		for(i=0;i<sizeof(a)/4;i++){
			printf("%d - ",a[i]);
		}
```
结果：![](https://img.yangmufa.cn/blog-article/4f84bb4a0f06479a95bbf6fabbed5a7e.png)
**2**、从键盘输入若干个整数，其值在0~4的范围内，用-1作结束标志，统计每个整数的个数。  
```c
		int number,i;
		number=i=0;
		while(number!=-1){
			scanf("%d",&number);
			i++;
		}
		printf("\n本次输入 %d 个数\n\n",i-1);
```
结果：![](https://img.yangmufa.cn/blog-article/b69b2e42854744cca7752354a21891e2.png)
**3**、定义一个含有30个整型元素的的数组，按顺序分别赋予从2开始打的偶数，
然后按顺序每5个数求出一个平均数，放在另一个数组中。  
```c
		int a[]={2,4,6,8,10,12,14,16,18,20,22,24,26,28,30};
		int b[(sizeof(a)/4)/5]={0},i=0,j=0,sum=0;
		for(i=0;i<sizeof(a)/4;i++){
			sum+=a[i];
			if((i+1)%5==0){
				b[j]=(sum/5);
				printf("%d\n",b[j]);
				j++;
				sum=0;
			}
		}
```
结果：![](https://img.yangmufa.cn/blog-article/289f7fa15b724433ae824d649e7c9523.png)
**4**、若定义有，int a[][]={1,2,3},{4,5,6};现要将a的行和列的元素互换
 后存到另一个二维数组b里，最后输出a、b的各个元素。  
```c
		int i,j,a[2][3]={{1,2,3},{4,5,6}},b[3][2];
		for(i=0;i<2;i++){
			for(j=0;j<3;j++){
				b[j][i]=a[i][j];
			}
		}
 
		for(i=0;i<2;i++){
			for(j=0;j<3;j++){
				printf("-%d-",a[i][j]);
			}
			printf("\n\n");
		}
		printf("\n\n");
 
		for(i=0;i<3;i++){
			for(j=0;j<2;j++){
				printf("/%d\\",b[i][j]);
			}
			printf("\n\n");
		}
		printf("\n\n");
```
结果：![](https://img.yangmufa.cn/blog-article/9dfa47d1b2ce483e8bf201bb44b398be.png)
**5**、通过循环按行顺序为一个5x5的二维数组a赋值1到25的自然数，然后输出该数组的左下半三角。  
```c
		int a[5][5],i,j,temporary;a[5][5]=i=j=0;temporary=1;
		for(i=0;i<5;i++){
			for(j=0;j<5;j++){
				a[i][j]=temporary++;
			}
		}
		temporary=0;
		for(i=0;i<5;i++){
			for(j=0;j<=temporary;j++){
				printf("-%d-",a[i][j]);
			}
			printf("\n\n");
			temporary++;
		}
```
结果：![](https://img.yangmufa.cn/blog-article/65585031b7224823bf04d0de3abfea26.png)

**6**、数组a包括10个整数，把a中所有的后项除以前项之商取整后存入数组b中，
并按每行3个元素的格式打印出数组b。(由于第一个数没有前项故从第二个开始)  
```c
		int a[10]={12,225,717,9419,29137,39465,79955,339656,922225,5341212};
		int b[9]={0},i=0,j=0;
 
		for(i=1;i<=9;i++){
			b[j]=a[i]/a[i-1];
			if(j%3==0){printf("\n");}
			printf("   %d",b[j]);
			j++;
		}
		printf("\n\n");
```
![](https://img.yangmufa.cn/blog-article/ccb4d94e6a16460daea9df5e2e949708.png)
**7**、从键盘输入一个字符串a，并在字符串中的最大元素后边插入另外输入的b字符串。  
```c
		char b[]={"CHAOJISHUAI"},a[10000]={''0''},max=a[0];
		int i=0,j=0,k=0;
		printf("输入字符串a:");
		gets(a);
		while(a[i]){
			if(max<a[i]){
				max=a[i];
				j=i;
			}
			i++;
		}
 
		if(a[j]==max){//验证最大元素与下标的匹配是否正确
			for(i=j+1;i<=(strlen(b)/1);i++){//从最大元素后一个开始需要后移元素的个数等于数组b的个数
				for(k=strlen(a);k>j;k--){//从数组a的最后一个元素开始往前移直到最大元素止每次后移需要挪动的元素总个数
					a[k+1]=a[k];//把前面一个赋值给后面一个
				}
				a[i]='' '';//腾出来的空间暂用空格代替
			}
		}
		puts(a);
 
		if(a[j]==max){
			k=0;
			for(i=j+1;i<(sizeof(b)/1);i++){//从a数组最大元素后开始插入b数组中从第一个元素开始的数
				a[i]=b[k];
				k++;
			}
		}
		puts(a);
		printf("\n\n");
```
结果：![](https://img.yangmufa.cn/blog-article/460da151442245d29b8729627cca0529.png)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2061627586693435392, 2061627586680852480, '## 错误信息

>Table ''xxx_mes.Sys_User'' doesn''t exist  

## 原因
- 数据库实际表名：`sys_user`（小写）
- 代码查询表名：`Sys_User`（驼峰）
- Docker MySQL（Linux）默认大小写敏感，导致表名不匹配

## 解决方案

### 第1步：创建配置文件
```bash
mkdir -p /Users/yangmufa/UserDocker/ConfigFile/MySQL
```

```bash

cat > /Users/yangmufa/UserDocker/ConfigFile/MySQL/my.cnf << ''EOF''

# ========== 大小写敏感性设置 ==========
# lower_case_table_names: 控制表名大小写敏感度
# 0 = 大小写敏感（Linux默认），1 = 大小写不敏感（Windows默认），2 = 保留大小写但比较时不敏感
# 设置为 1 可以解决 Mac/Linux Docker 环境下的表名找不到问题
# 注意：必须在初始化数据库前设置，已有数据后修改可能导致错误
[mysqld]
lower_case_table_names=1

# ========== 字符集设置 ==========
# character-set-server: 服务器默认字符集
# utf8mb4 是 utf8 的超集，支持完整的 Unicode 字符（包括 emoji 表情）
# 推荐使用 utf8mb4 而不是 utf8，因为 MySQL 的 utf8 实际只支持 3 字节
character-set-server=utf8mb4

# collation-server: 服务器默认排序规则
# utf8mb4_unicode_ci: 基于 Unicode 4.0 标准，不区分大小写(ci)和重音(ai)
# 另一个选择是 utf8mb4_0900_ai_ci（MySQL 8.0 默认，性能更好）
# ci = Case Insensitive（不区分大小写）
collation-server=utf8mb4_unicode_ci

# init-connect: 每个客户端连接时执行的初始化命令
# 设置连接的字符集为 utf8mb4，确保客户端和服务器字符集一致
# 注意：对 root 用户无效（root 的连接不会执行这个命令）
init-connect=''SET NAMES utf8mb4''

# ========== 性能优化配置 ==========
# max_connections: 最大连接数
# 控制同时连接到 MySQL 的最大客户端数量
# 默认 151，根据服务器内存和应用需求调整
# 每个连接大约消耗 256KB-4MB 内存
max_connections=500

# innodb_buffer_pool_size: InnoDB 缓冲池大小
# 这是最重要的性能参数，用于缓存数据和索引
# 通常设置为服务器物理内存的 70-80%
# 对于 Docker 环境，需要根据分配的内存调整
# 1G = 1024MB，适合中等负载场景
innodb_buffer_pool_size=2G

# ========== 客户端配置 ==========
# client 段的配置影响 mysql 命令行客户端
# default-character-set: 客户端默认字符集
# 确保与服务器字符集一致，避免乱码
[client]
default-character-set=utf8mb4

# ========== mysql 命令配置 ==========
# mysql 段的配置影响 mysql 命令行工具（不包含 mysqldump 等）
# default-character-set: mysql 命令行的默认字符集
# 保证命令行查询结果显示中文不乱码
[mysql]
default-character-set=utf8mb4


# ========== 可选：mysqldump 备份配置 ==========

# 连接超时时间（秒）
# wait_timeout=28800

# 交互式连接超时时间
# interactive_timeout=28800

# 日志文件大小
# innodb_log_file_size=256M

# 临时表大小
# tmp_table_size=64M

# [mysqldump]
# 快速导出模式
# quick

# 最大允许的包大小
# max_allowed_packet=256M
```

### 第2步：启动容器
```bash
docker run -d \
  --name MySQL \
  -p 3306:3306 \
  -v /Users/yangmufa/UserDocker/ConfigFile/MySQL/my.cnf:/etc/mysql/conf.d/my.cnf \
  -v /Users/yangmufa/UserDocker/MySQL/data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD="密码" \
  -e MYSQL_DATABASE=xxx_nmes \
  mysql:8.4
```

### 第3步：验证

```bash
docker exec -it MySQL mysql -uroot -p 密码 -e "SHOW VARIABLES LIKE ''lower_case_table_names'';"
# 输出应为：lower_case_table_names = 1
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060986473590689793, 2060986473590689792, '**1、
有5人坐在一起:问第5个人多少岁，他说逼第4个人大2岁。
问第4个人多少岁，他说比比第3个人大2岁。
问第3个人多少岁，他说比第2个人大2岁。
问第2个人多少岁。他说比第1一个人大两岁。
最后问问第1个人，他说10岁。(求第五个人多大)**

```c++
		int i,j=0,sum=10;
		for(i=1;i<=5;i++){
			sum+=2;
		}
		printf("第 5 个人 %d 岁！\n\n",sum);
```
结果：![](https://img.yangmufa.cn/blog-article/c5573cdf9dff44c7b664e9c1c2b1d1da.png)

**2、
给一个不多于5位数的整数：
1、分别求出每一位数字。
2、分别打印出每一位数字。
3、逆序打印出各位数字。**

```c++
		int i,j=1,number,array[5]={0};
		scanf("%d",&number);
		printf("第五位为个位!!!\n\n");
		for(i=4;i>=0;i--){
			array[i]=((number/j)%10);
			printf("第 %d 位数字为：%d \n\n",i+1,array[i]);
			j*=10;
		}
		printf("逆序打印出各位数字：");
		for(i=4;i>=0;i--){
			printf("%d ",array[i]);
		}
		printf("\n\n\n");
```
结果：![](https://img.yangmufa.cn/blog-article/85dc930a62ab40db82498b8d6e01bccf.png)

**3、
输出1000~5000之间的所有素数。**
```c++
		int i,j,temporary=0;
		for(i=1000;i<=5000;i++){
			for(j=2;j<i;j++){
				if(i%j==0){
					temporary=0;
					break;
				}else{
					temporary=1;
				}
			}
			if(temporary==1){
				printf(" %d ",i);
			}
		}
```
结果：![](https://img.yangmufa.cn/blog-article/1bec209c525a48ba9e09d28551c09938.png)

**4、计算1`10的二次方累加和。**

```c++
		int i,sum=0;
		for(i=1;i<=10;i++){
			sum+=i*i;
		}
		printf("1`10的二次方累加和为:%d\n\n",sum);
```
结果：![](https://img.yangmufa.cn/blog-article/df16f3b096704fc381da9b829076c03f.png)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060987191458402304, 2060987191454208000, 'A、B、C、D、E五个人在某天夜里合伙去捕鱼，到凌晨时疲惫不堪，于是各自找地方睡觉。
第二天A醒来，他将所有的鱼分成5份，把多余的一条鱼扔掉，拿走自己的一份。
B醒来，也将剩下的鱼分为5份，把多余的一条扔掉，拿走自己的一份。
C、D、E 也同样，分别醒来后，也将剩下的鱼分为5份，把多余的一条扔掉，拿走自己的一份。
问？他们合伙一共捕了多少条鱼。
```c
#include <stdio.h>
#include <stdlib.h>
 
int sub(int n);
 
void main(){
	printf("他们合伙一共捕鱼数为：%d\n\n",sub(5));
} 
 
int sub(int n){
	static int i=0;
	if(n==1){
		do{
			i++;
		}while(i%5!=0);
		//printf("%d-\n",i+1);
		return (i+1);
		
	}else{
		int t;
		do{
			t=sub(n-1);					//n=1,6 n=2,6 n=3,
		}while(t%4!=0);
		//printf("/%d\\\n",t/4*5+1);
		return (t/4*5+1);			  //n=1,
	}
	
}
```
结果:
![](https://img.yangmufa.cn/blog-article/653cd97ae25046a2a52ba09c82069dbd.png)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060987589388800000, 2060987589380411392, '```c++

#include <stdio.h>
#include <stdlib.h>
#include <string.h>	
#include <conio.h>
#include <ctype.h>
#include <math.h>
#include <time.h>
#define IO 996
#define N 10
#define input "%d,%d,%d,%d\n\n"

void product();
void sortReplication();
void sort();
void swap(int *,int);
void exchange();
void frequency();
int subString(char *,char *);

int main(int argc,char *argv[]){

//product();
//sortReplication();
//sort();
//exchange();
//frequency();

} 

void product(){
	//已知一个整形数组X[4]，其元素值分别为3/10/4/20，使用指针求个数字元素的积。
	int x[]={3,10,4,20},i,product=1,*xp=&x[0];
	for(i=0;i<4;i++){
		product*=*(xp+i);//*xp+i
		//printf("%d\n",i);
		//printf("%d\n",*xp);
		//printf("%d\n",*xp+i);
		//printf("%d\n\n",product);
	}
	printf("%d\n\n",product);
}


void sortReplication(){

	//有四个字符串，实现将他们按照字符串中的字符个数从小到大排序，
	//再分别取出每个字符串的第三个字母形成一个新的字符串输出（若少于三个字符的输出*），
	//要求：利用字符串指针和指针数组完成。

	char *array[5]={"yangmufa","shuai","de","chaojishuai",}\
	,(*tem)=NULL,t[5]={NULL};
	int i=0,j=0,k=0;

	for(i=0;i<4;i++){//i<4-1表示从第一个开始到倒数第二个结束(4个数组)
		k=i;//记录小串
		for(j=0;j<4;j++){//表示从第二个开始到倒数第一个结束，每一次比上一次比较次数减一	
			if(strlen(array[k])>strlen(array[j])){
				k=j;//记录小串
			}
			if(i!=k){//交换
				tem=array[i];
				array[i]=array[k];
				array[k]=tem;
			}
		}	
	}
	//分别取出每个字符串的第三个字母形成一个新的字符串
	for(i=0;i<4;i++){
		puts(*(array+i));
		if(strlen(*(array+i))>2){
			//*(*(array+4)+i)=*(*(array+1)+2);
			//此方法不可取因为"String"是存在静态存储区的，这个地址中的值不能被修改。
			t[i]=*(*(array+i)+2);
		}else if(strlen(*(array+i))<3){
			t[i]=''*'';
		}
	}
	printf("\n新字符串:%s\n\n",t);
}


void sort(){

	//定义一个动态数组长度为n，用随机数给各数组元素赋值，
	//然后对数组各单元排序，定义swap函数交换数据单元，要求参数使用指针传递。

	int n,i,*array;
	printf("输入长度：");
	scanf_s("%d",&n);
	array=(int*)malloc(n*sizeof(int));//以N为基数动态反配N个int类型大小的内存
	srand((unsigned)time(NULL));//设置以时间为随机种子
	printf("随机数排序前：");
	for(i=0;i<n;i++){
		array[i]=rand();//获取以时间为种子得来的随机数后赋值给array
		printf(" %d ",array[i]);
	}
	printf("\n");
	swap(array,n);	
}
void swap(int * array,int lenth){
	int i=0,j=0,k=0,temp;
	printf("\n随机数排序后：");
	for(i;i<lenth;i++){
		k=i;
		for(j=0;j<lenth;j++){
			if(array[k]<array[j]){k=j;}
			if(k!=i){
				temp=array[k];
				array[k]=array[i];
				array[i]=temp;
			}
		}
	}
	for(i=0;i<lenth;i++){
		printf(" %d ",array[i]);
	}
	printf("\n\n");
}


void exchange(){

	//输入N个整数，将其中最小的数与第一个数对换，将自重最大的数与与最大的数交换。

	int array[8],i,j,k,temp=0,max=0,min=0;
	srand((unsigned)time(NULL));//设置时间种子
	printf("随机数:");
	for(i=0;i<8;i++){
		array[i]=rand();//获取以时间为种子得来的随机数后赋值给array
		printf(" %d ",array[i]);	
	}

	printf("\n交换后:");
	max=array[0];
	min=array[0];
	for(i=0;i<8-1;i++){
		if(max<array[i]){
			max=array[i];
		}//求出最大元素
		if(min>array[i]){
			min=array[i];
		}//求出最小元素
	}
	array[0]=min;//将其中最小的数与第一个数对换，
	array[7]=max;//将其中最大的数与与最大的数交换。
	for(i=0;i<8;i++){
		printf(" %d ",array[i]);
	}
		for(i=0;i<8;i++){
		k=i;
		for(j=0;j<8;j++){
			if(array[k]<array[j]){k=j;}
			if(k!=i){
				temp=array[k];
				array[k]=array[i];
				array[i]=temp;
			}
		}
	}
	printf("\n排序后:");
	for(i=0;i<8;i++){
		printf(" %d ",array[i]);
	}
	printf("\nmax:%d\nmin:%d\n",max,min);
}



void frequency(){

	//计算字符串中子串出现的次数，要求用一个subString函数实现，
	//参数为指向字符串和子字符串的指针，返回次数。

	char array[]={"yangmufchaojiwudidashuaigeyangmufachaojishuai"},\
		SubString[]={"chaoji"};
	printf("字符串：");
	puts(SubString);
	printf("在字符串：");
	puts(array);
	printf("中出现了： ");
	printf(" %d 次\n",subString(array,SubString));

}
int subString(char *a,char *s){

	int i=0,j=0,count=0,alen=strlen(a),slen=strlen(s);
	while(i<alen){
		if(a[i]==s[j]){
			//如果子串第j个元素和母串的第i个元素相等则都继续指向下一个元素进行比较
			i++;
			j++;
		}else{
			//如果子串和母串出现不匹配则母串回到挡轮比较之前，子串归零
			i=i-j+1;
			j=0;
		}
		if(j==slen){
			//如果出现子串到最后一个元素均与母串相等的情况则出现次数加一，子串归零继续下一轮比较。
			count++;
			j=0;
		}
	}
	return count;
}
```
​
**Result：**

product();
​​![](https://img.yangmufa.cn/blog-article/78f84a64a2a746faa351ab64cd0e1d7f.png)
sortReplication();
![](https://img.yangmufa.cn/blog-article/f33cf9174a044558a5f3c9f1963e5b5c.png)
sort();
![](https://img.yangmufa.cn/blog-article/9f7fafd702274dfeb7098ec06efccc16.png)
exchange();
![](https://img.yangmufa.cn/blog-article/b29562e684644f4d9ff3f0cffaa3c273.png)
frequency();
![](https://img.yangmufa.cn/blog-article/8629f764ea04405fa51fa70d76292ef0.png)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060986685319155713, 2060986685319155712, '​
**1、** strlen(字符数组)；（strlen：String length）
      测量字符串程度，返回值是字符串的的实际长度，其中不包括，结束符号''\0''。
```c
		char array[]="yangmufa";
		char array1[]={''y'',''a'',''n'',''g'',''m'',''u'',''f'',''a'',''\0''};
		char array2[]={''y'',''a'',''n'',''g'',''m'',''u'',''f'',''a''};
		printf("%s hs %d chars\n\n",array,strlen(array));
		printf("%s hs %d chars\n\n",array1,strlen(array1));
		
		//printf("%s hs %d chars\n\n\n",array2,strlen(array2));
		//puts(array2);
		//：后缀没有''\0''的字符数组是不能用%s和puts()函数输出的，可用for等循环结构为佳。
```
结果：![](https://img.yangmufa.cn/blog-article/cf5c05561b264f13b11ae303a4f3c45c.png)


**2、** strcat(字符数组1,字符数组2)；（strcat：String catenate）
            字符串连接函数，连接两个数组中的字符串，把字符串2接到字符串1的后面（覆盖串1尾部的''\0''）。
```c
		char array1[30]="yangmufa";
		char array2[]={"haoshuaio"};
		strcat(array1,array2);
		printf("%s has %d chars\n\n\n",array1,strlen(array1));
		//：被接收复制的字符数组（字符串1）空间必须足够大。
```
结果：![](https://img.yangmufa.cn/blog-article/7126bd0b74b249caa60000d4e9b7cf37.png)


**3、** strcpy(字符数组1,字符串2)；（strcpy：String copy）
            字符串复制函数，将字符2的内容复制到字符数组2中去。
```c
		char array1[30]="yangmufa";
		char array2[]={"haoshuaio"};
		strcpy(array1,array2);
		printf("%s has %d chars\n\n\n",array1,strlen(array1));
```
结果：![](https://img.yangmufa.cn/blog-article/53e886d9c5d5458dac9ec82c3f7a500a.png)


**4、** strcmp(字符串1,字符串2)；（strcmp：String compare）
        字符串比较函数，按照ascii码值的大小，从左至右逐个比较，字符串1和2，
        如果字符串1=字符串2则返回值为0，如果字符串1大于字符串2则返回值为1(或正整数)，
        如果字符串1小于字符串2则返回值为负整数。
```c
		char array1[]="yangmufa";
		char array2[]={"yangmufahaoshuaio"};
		char array3[]={"yangmufA"};
		char array4[]={''y'',''a'',''n'',''g'',''m'',''u'',''f'',''a'',''\0''};
		int a1=strcmp(array1,array2);
		int a2=strcmp(array1,array3);
		int a3=strcmp(array1,array4);
		printf("chars：%s compare chars：%s = %d\n\n",array1,array2,a1);
		printf("chars：%s compare chars：%s = %d\n\n",array1,array3,a2);
		printf("chars：%s compare chars：%s = %d\n\n\n",array1,array4,a3);
```
结果：![](https://img.yangmufa.cn/blog-article/9126eb4276234e9a8710caf2983e3b87.png)


**5、** strlwr(字符串)；（strlwr：String lowercase）
       将字符串大写字母转换成小写。
```c
		char array1[]="YangMuFa";
		char array2[]={"yANGmUfA"};
		printf("chars：%s ",array1);
		strlwr(array1);
		printf("compare = %s\n\n",array1);
		printf("chars：%s compare = %s\n\n\n",array2,strlwr(array2));
```
结果：![](https://img.yangmufa.cn/blog-article/1c9056e06726488cb3e8269e9927c819.png)


**6、** strupr(字符串)；（strlwr：String uppercase）
       将字符串小写字母转换成大写字母。
```c
		char array1[]={"yANGmUfa"};
		char array2[]={''Y'',''a'',''n'',''g'',''M'',''u'',''F'',''a'',''\0''};
		printf("chars：%s compare = %s\n\n",array1,strupr(array1));
		printf("chars：%s compare = %s\n\n\n",array2,strupr(array2));
```
结果：![](https://img.yangmufa.cn/blog-article/c9a3968bfe6a4a6596690eb2b530623c.png)


**7、**memcpy(字符串1,字符串2,n)；
      从字符串2所指的内存地址的起始位置开始，
      复制n个字节到字符串1所指的内存地址的起始位置起中去。
```c
		char array1[30]="YangMuFa";
		char array2[]={"woshichaojidashuaige"};	
		printf("chars：%s replace = %s\n\n\n",array1,memcpy(array1,array2,20));

		//：源字符在复制给其他数组时长度可以考虑''\0''也可以不考虑''\0''。
		//：在接收复制来的字符时能装下的字符数长度必须考虑''\0''。
```
结果：![](https://img.yangmufa.cn/blog-article/0701715ca2f5425892bc118eee67a146.png)


**8、**memcmp(字符串1,字符串2,n)；
     将字符串1的前n个字符与字符串2的前n个字节进行比较返回值与strcmp()类似。
```c
		char array1[30]="Yangmufa";
		char array2[30]="yangmufa";
		char array3[30]="YAngmufa";
		char array4[30]="YAngmuFa";
		char array5[30]="yangmufa";
		char array6[30]="zangmufa";
		char array7[]={"woshichaojidashuaige"};	
		printf("chars：%s compare chars：%s = %d\n\n",array1,array2,memcmp(array1,array2,8));
		printf("chars：%s compare chars：%s = %d\n\n\n",array4,array6,memcmp(array4,array6,8));
		printf("chars：%s compare chars：%s = %d\n\n\n",array3,array4,memcmp(array3,array4,8));
		printf("chars：%s compare chars：%s = %d\n\n\n",array2,array5,memcmp(array2,array5,8));
		printf("chars：%s compare chars：%s = %d\n\n\n",array6,array7,memcmp(array6,array7,8));
		printf("chars：%s compare chars：%s = %d\n\n\n",array7,array1,memcmp(array7,array1,8));
```
结果：![](https://img.yangmufa.cn/blog-article/e34aeea869674c0ebb5dc824c7e45cb0.png)


**9、** memset(字符串1,字符串2,n)；（：）
       将字符串1的前n个字符替换为字符的值。
```c
		char array1[30]="yangmufa";
		char array2[]="YangMuFa";
		char array3[]={"woshichaojidashuaige"};	
		printf("chars：%s ",array1);
		memset(array1,''6'',8);
		printf(" replace = %s\n\n",array1);
		printf("chars：%s compare = %s\n\n\n",array2,memset(array2,''-*- '',8));
```
结果：![](https://img.yangmufa.cn/blog-article/f93f9d25f199410d8a62ddec0696267b.png)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060992010558509056, 2060992010554314752, '## 概述
将多块物理网卡捆绑成一块高性能、高可用的虚拟网卡;如果其中一个网口（物理网卡）出现故障或网络连接断开，操作系统会自动将所有的网络流量无缝切换到另一个正常的网口上，从而保证网络连接不中断。

在现代Windows系统（Windows 10 1809及以上 / Windows Server 2019及以上）中，**NetLbfoTeam** 已被弃用，取而代之的是更先进的 **NetSwitchTeam**（交换机嵌入式团队）。本文将指导您了解并实践如何使用PowerShell创建和管理网卡团队，以实现网络带宽聚合和故障转移。

## 什么是网卡组队？

网卡组队，又称链路聚合或端口聚合，是将多个物理网络适配器组合成一个单一、逻辑的“团队”适配器的过程。

**核心优势：**

1. **带宽聚合**：合并多个网卡的带宽，提升总吞吐量。
2. **故障转移/冗余**：当其中一个物理网卡或线路故障时，网络流量会自动切换到其他健康的网卡，保证业务不中断。

## 先决条件与注意事项

### 先决条件

- **操作系统**：Windows 10 1809 或更高版本，或 Windows Server 2019 及以上。
- **管理员权限**：需要使用管理员身份的PowerShell。
- **物理网卡**：至少两个物理网卡（有线）。
- **交换机支持**：对于某些高级模式（如LACP），需要交换机支持并相应配置。但默认的“开关”模式通常无需交换机配置。

### 重要警告

- **远程连接风险**：**切勿**在通过远程桌面（RDP）连接的服务器上操作，除非您有备用的管理方式（如iDRAC、iLO、IP KVM）。错误的配置会导致立即断线。
- **网卡兼容性**：最好使用相同品牌和型号的网卡，以获得最佳兼容性。
- **驱动**：确保网卡驱动程序为最新版本。

## 实战操作

### 步骤一：识别网络适配器

首先，我们需要获取物理网卡的准确名称。

1. 以**管理员身份**打开 **Windows PowerShell**。
2. 运行以下命令：


```powershell
Get-NetAdapter | Where-Object {$_.PhysicalMediaType -eq "802.3" -and $_.Status -eq "Up"}

```



**命令解释：**

- `Get-NetAdapter`： 列出所有网络适配器。
- `Where-Object {...}`： 过滤器，只显示物理有线网卡（`802.3`）且状态为“已连接”（`Up`）的适配器。这有助于排除无线网卡和虚拟适配器。

**输出示例：**


```text
Name                      InterfaceDescription                    ifIndex Status       MacAddress             LinkSpeed
----                      --------------------                    ------- ------       ----------             ---------
MES                       Intel(R) Ethernet Connection (7) I219-L       8 Up           A0-B1-C2-D3-E4-F5        1 Gbps
MES 2                     Intel(R) I211 Gigabit Network Connec...       9 Up           A0-B1-C2-D3-E4-F6        1 Gbps
```



记下你想要组队的网卡的 `Name`，例如 `"MES"` 和 `"MES 2"`。

### 步骤二：创建网卡团队

使用 `New-NetSwitchTeam` cmdlet 创建新的团队。


```powershell
New-NetSwitchTeam -Name "MySwitchTeam" -TeamMembers "MES", "MES 2"
```



**参数解释：**

- `-Name "MySwitchTeam"`： 为你新创建的虚拟团队适配器命名。
- `-TeamMembers "MES", "MES 2"`： 指定要加入团队的物理网卡名称，用逗号分隔。

**执行后结果：**

- 在“网络连接”控制面板中，会出现一个名为 `MySwitchTeam` 的新网络适配器。
- 原先的 `MES` 和 `MES 2` 适配器将从列表中“消失”，因为它们现在从属于团队适配器。
- **重要**：所有IP地址（静态或DHCP）现在都必须设置在 `MySwitchTeam` 上。

### 步骤三：验证团队状态

创建后，使用以下命令检查团队状态和配置。


```powershell
# 查看团队概要
Get-NetSwitchTeam

# 查看团队的详细信息和成员状态
Get-NetSwitchTeamMember -TeamName "MySwitchTeam"

# 查看新的团队适配器及其IP配置
Get-NetAdapter -Name "MySwitchTeam"
Get-NetIPAddress -InterfaceAlias "MySwitchTeam"
```



## 故障转移测试

这是检验组队是否成功的关键步骤。

1. **持续 Ping**： 在PowerShell中，开始持续ping一个可靠的IP地址（如你的网关或8.8.8.8）。


   ```   powershell
   ping -t 192.168.1.1
   ```

   

2. **模拟故障**： 在ping命令运行时，**手动拔掉** `MySwitchTeam` 团队中一个网卡的网线。

3. **观察结果**：

   - 你可能会看到 **1个或2个ping请求超时**（通常在毫秒级别）。
   - 随后，ping请求会**自动恢复**。
   - 这证明故障转移成功！流量已从故障网卡无缝切换到健康网卡。

4. **恢复测试**： 重新插入网线，观察流量是否会重新分布。

## 管理与删除

### 查看所有团队


```powershell
Get-NetSwitchTeam
```



### 删除团队

如果你需要解散团队，恢复物理网卡的独立状态，请使用以下命令：


```powershell
Remove-NetSwitchTeam -Name "MySwitchTeam"
```



**执行后**：虚拟团队适配器被删除，原有的物理网卡将重新出现在“网络连接”中。

## 故障排除

- **“找不到名为…的团队”**： 检查团队名称拼写，使用 `Get-NetSwitchTeam` 确认名称。
- **“访问被拒绝”**： 确保使用**管理员身份**运行PowerShell。
- **创建团队后无法上网**： 检查 `MySwitchTeam` 适配器的IP配置是否正确。它需要从DHCP获取新地址或手动设置静态IP。
- **性能不佳**： 默认的“动态”负载均衡模式适用于大多数场景。对于服务器，可考虑在支持的交换机上配置LACP模式。

## 总结

`NetSwitchTeam` 是现代Windows系统中实现网络高可用性和带宽提升的推荐工具。通过简单的PowerShell命令，您可以轻松构建一个可靠的网络连接，确保在单点故障时业务依然能够持续运行。');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060988454694686720, 2060988454677909504, '打算学Python的，于是兴致勃勃的下载了Python语言并配置了环境变量、安装了IDE PyCharm、找了个项目，当我通过在PyCharm里打开本地终端时提示  

**Cannot open Local Terminal**  
**Failed to start [powershell.exe] in F:\JetBrains\PyCharm\PycharmProjects\Reptiles house**  

**Error running process: CreateProcess failed. Code 2**  
**See IDE log (Help | Show Log in Explorer) for the details.**  

（如下图），一直卡了我两天才解决  
![](https://img.yangmufa.cn/blog-article/1789e71e614e406e96d3d89eed25dc44.png)
 翻译过来是

（
无法打开本地终端

无法在F:\JetBrains\PyCharm\PycharmProjects\Reptiles house中启动[powershell.exe]

运行进程时出错：创建进程失败。代码2

有关详细信息，请参阅IDE日志（帮助|在资源管理器中显示日志）。

）
<u>意思就是在当前项目的路径下找不到 powershell.exe，所以需要配置相应的文件路径。</u>

**解决办法：**
1、在 file→settings→Tools→Terminal→Shell path 中把值设置为 电脑系统 powershell.exe 文件 的全路径（如下图）。
![](https://img.yangmufa.cn/blog-article/935d287d586a476097f700e4347b9300.png)
![](https://img.yangmufa.cn/blog-article/9d0e4c10c1b04af5958f25b1e5a46a7b.png)
![](https://img.yangmufa.cn/blog-article/edba6d240c294d5fbeb7650f6cf603ce.png)
![](https://img.yangmufa.cn/blog-article/e6a109de42b24bd8acf1fb5064fbf928.png)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2079842831194787840, 2079842831182204928, '# 一、背景
我的博客站点 www.yanggongzi.dev 部署在阿里云 ECS 上，使用 Docker 运行 Nginx 1.27 作为反向代理和静态资源服务器。之前的 SSL 证书即将到期，这次决定申请 Let''s Encrypt 的泛域名证书（Wildcard Certificate），一张证书覆盖 *.yanggongzi.dev 和 yanggongzi.dev，省去为每个子域名单独申请的麻烦。  
# 二、申请泛域名证书

## 2.1 安装并启用 EPEL 仓库
```bash
# CentOS / RHEL
sudo yum install epel-release -y
```
## 2.2 安装 certbot
```bash
# CentOS / RHEL
sudo yum install certbot -y
```
## 2.3 验证安装
```bash
certbot --version
```
如果显示版本号（如 certbot 1.2.x），说明安装成功。
## 2.4 执行申请命令
泛域名证书不支持 HTTP 验证，必须使用 DNS 验证方式：
```bash
certbot certonly --manual --preferred-challenges dns \
  -d *.yanggongzi.dev \
  -d yanggongzi.dev
```
## 2.5 DNS 验证过程
执行命令后，Certbot 会提示你添加一条 TXT 记录：
```txt
Please deploy a DNS TXT record under the name:
_acme-challenge.yanggongzi.dev
with the following value:
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```
到域名 DNS 管理后台（我用的阿里云 DNS），添加：

| 记录类型 | 主机记录|记录值 |
| - | - | - |
| TXT|_acme-challenge |xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx |

```bash
dig TXT _acme-challenge.yanggongzi.dev
# 确认记录都能查到后，回到终端按 Enter 继续。
```
## 2.6 证书签发成功
```bash
Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/yanggongzi.dev/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/yanggongzi.dev/privkey.pem
This certificate expires on 2026-10-20.
证书有效期 90 天，到期前需要续期。
```

## 2.7 文件
/etc/letsencrypt/live/yanggongzi.dev中会有四个文件:
> cert.pem / chain.pem / fullchain.pem / privkey.pem
把  
fullchain.pem改名为fullchain.yangmufa.cn.pem  
privkey.pem改名为private.yanggongzi.dev.key
在Nginx配置中使用即可
```bash
# # 监听443端口（HTTPS）
server {

    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;  # 开启HTTP/2支持
    server_name yanggongzi.dev blog.yanggongzi.dev;
    # SSL配置
    ssl_certificate /etc/letsencrypt/live/fullchain.yanggongzi.dev.pem;
    ssl_certificate_key /etc/letsencrypt/live/private.yanggongzi.dev.key;

    # 将所有请求重定向到 https://www.yanggongzi.dev
    return 301 https://www.yanggongzi.dev$request_uri;
}
```

## 2.8 续期命令
```bash
certbot certonly --manual --preferred-challenges dns -d *.yanggongzi.dev -d yanggongzi.dev
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2113190262510587904, 2113190262502199296, '## 1. 更新系统包
确保系统包处于最新状态：
```shell
sudo dnf update -y
```

## 2. 卸载可能会与 Docker 相关冲突的包
Rocky Linux 默认可能自带了 Podman 或 buildah 等冲突组件，最好先清理`(卸载前自行确认它们有没有承载现有业务)`：
```shell
# 如果提示未安装，忽略即可
sudo dnf remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine podman podman-docker runc buildah
```

## 3. 添加 Docker 官方仓库
对于 Rocky Linux 10，应使用 Docker 为 RHEL 10 提供的仓库路径：
```shell
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
```

## 4. 确认仓库能找到 Docker：
```shell
sudo dnf list docker-ce --showduplicates
```
如果报错显示仓库 URL 使用了`10.2` ，并返回 404 ，可只对 Docker 仓库固定使用大版本`10` ，不要改整个系统的版本设置：
```shell
sudo sed -i ''s/\$releasever/10/g'' /etc/yum.repos.d/docker-ce.repo
sudo dnf makecache --refresh
```

## 5. 安装 Docker 和 Compose
如果提示已有 Podman、`podman-docker` 或`runc` 发生冲突，先确认它们没有承载现有业务，再根据具体冲突卸载； 不要直接使用`--allowerasing` 自动删除依赖 。
```shell
sudo dnf install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin
```

## 6. 启动并设置开机自启
```shell
sudo systemctl enable --now docker
```

## 7. 验证安装
```shell
sudo systemctl is-active docker
sudo docker version
sudo docker compose version
```

## 8. 设置镜像加速为华为云
### 8.1 新建或或修改`/etc/docker/daemon.json`文件:
```json
{
  "registry-mirrors": [
    "https://0e1d24ce7b384fc0bbc09421329b3ff7.mirror.swr.myhuaweicloud.com"
  ]
}
```
或者阿里云`https://8wyqam7d.mirror.aliyuncs.com`

### 8.2 验证镜像加速
```shell
sudo docker info
```

## 9. 重启 Docker 服务
```shell
sudo systemctl restart docker
```

## 10. 运行测试容器
```shell
sudo docker run --rm hello-world
```

## 11. 查看镜像和容器
```shell
sudo docker images
sudo docker ps
```');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2087467279947272192, 2087467279938883584, '# Mac Docker FTP 服务搭建指南

> 适用场景：在 Mac 上通过 Docker 运行 FTP 服务，供 Parallels Desktop 中的 Windows 虚拟机访问，实现文件共享。

------

## 一、准备工作

### 1.1 环境要求

| 项目     | 说明                                  |
| :------- | :------------------------------------ |
| 宿主机   | MacBook（Apple Silicon / Intel 均可） |
| 虚拟机   | Parallels Desktop + Windows 11 ARM64  |
| 容器平台 | Docker Desktop for Mac                |
| FTP 镜像 | `fauria/vsftpd`                       |

### 1.2 创建目录结构

```bash
# 创建脚本目录
mkdir -p ~/scripts/FauriaVsftpd

# 创建 FTP 数据目录
mkdir -p /Users/yanggongzi/Share/TempFile/FauriaVsftpdData
```



------

## 二、启动脚本

### 2.1 创建脚本文件

在 `~/scripts/FauriaVsftpd/start-ftp.sh` 中写入以下内容：

```bash
#!/bin/bash
# ============================================
#  Mac Docker Desktop FTP 一键启动脚本
#  使用 fauria/vsftpd 镜像
#  支持 WiFi 切换后自动更新 IP
# ============================================

# ---------- 1. 自动获取当前 WiFi IP ----------
CURRENT_IP=$(ipconfig getifaddr en0)

if [ -z "$CURRENT_IP" ]; then
    CURRENT_IP=$(ipconfig getifaddr en1)
fi

if [ -z "$CURRENT_IP" ]; then
    echo "❌ 无法获取任何网络接口 IP，请检查 WiFi 是否已连接"
    exit 1
fi

echo "📡 检测到当前 IP: $CURRENT_IP"

# ---------- 2. 清理旧容器 ----------
docker rm -f FauriaVsftpd 2>/dev/null

# ---------- 3. 启动 FTP 容器 ----------
docker run -d \
    --name FauriaVsftpd \
    --restart=no \
    -p 20:20 \
    -p 21:21 \
    -p 21100-21110:21100-21110 \
    -e FTP_USER=YangGongzi \
    -e FTP_PASS=YangGongzi666 \
    -e PASV_ADDRESS=$CURRENT_IP \
    -e PASV_MIN_PORT=21100 \
    -e PASV_MAX_PORT=21110 \
    -v /Users/yanggongzi/Share/TempFile/FauriaVsftpdData:/home/vsftpd/YangGongzi \
    fauria/vsftpd

# ---------- 4. 检查运行状态 ----------
if [ $? -eq 0 ]; then
    echo "✅ FTP 容器启动成功！"
    echo "📡 当前 IP: $CURRENT_IP"
    echo "🔗 客户端请使用主动模式连接"
else
    echo "❌ 容器启动失败，请检查 Docker 是否运行"
fi
```



### 2.2 赋予执行权限

```bash
chmod +x ~/scripts/FauriaVsftpd/start-ftp.sh
```



------

## 三、首次部署

### 3.1 拉取镜像

```bash
docker pull fauria/vsftpd
```



### 3.2 执行启动脚本

```bash
~/scripts/FauriaVsftpd/start-ftp.sh
```



### 3.3 验证容器状态

```bash
docker ps
```



预期输出应包含：

```text
CONTAINER ID   IMAGE           PORTS
xxxxxxxxxxxx   fauria/vsftpd   0.0.0.0:20-21->20-21/tcp, 0.0.0.0:21100-21110->21100-21110/tcp
```



------

## 四、客户端连接

### 4.1 推荐客户端

| 客户端             | 说明               |
| :----------------- | :----------------- |
| **FileZilla**      | ✅ 推荐，稳定可靠   |
| WinSCP             | ✅ 备选             |
| Windows 资源管理器 | ❌ 不推荐，兼容性差 |

### 4.2 FileZilla 配置

| 设置项       | 值                                |
| :----------- | :-------------------------------- |
| 协议         | `FTP - 文件传输协议`              |
| 加密         | `只使用纯文本的 FTP（不安全）`    |
| 主机         | `192.168.1.120`（按实际 IP 填写） |
| 端口         | `21`                              |
| 登录类型     | `普通`                            |
| 用户         | `YangGongzi`                        |
| 密码         | `YangGongzi666`                     |
| **传输模式** | **主动**（关键！）                |

### 4.3 保存站点

1. FileZilla 中按 `Ctrl+S` 打开站点管理器
2. 点击 **新站点**，命名为 `MacFTP`
3. 按上表填写配置
4. 切换到 **传输设置** → **主动**
5. 点击 **确定** 保存

下次直接双击站点名称即可连接。

------

## 五、日常维护

### 5.1 切换 WiFi 后

```bash
~/scripts/FauriaVsftpd/start-ftp.sh
```



脚本会自动获取新 IP 并重建容器。

### 5.2 常用命令

```bash
# 查看容器状态
docker ps

# 查看日志
docker logs FauriaVsftpd

# 停止容器
docker stop FauriaVsftpd

# 启动容器
docker start FauriaVsftpd

# 删除容器
docker rm -f FauriaVsftpd
```



### 5.3 文件存放位置

| 位置           | 路径                                              |
| :------------- | :------------------------------------------------ |
| Mac 本地目录   | `/Users/yanggongzi/Share/TempFile/FauriaVsftpdData` |
| 容器内目录     | `/home/vsftpd/YangGongzi`                           |
| FTP 访问根目录 | 登录后直接看到的就是上述目录内容                  |

------

## 六、故障排查

### 6.1 连接不上？

| 步骤 | 操作                                                         |
| :--- | :----------------------------------------------------------- |
| 1    | 确认容器运行：`docker ps`                                    |
| 2    | 查看日志：`docker logs FauriaVsftpd`                         |
| 3    | 确认 Mac IP：`ipconfig getifaddr en0`                        |
| 4    | 确认 Parallels 网络模式为"共享网络"或"桥接"                  |
| 5    | 临时关闭 Mac 防火墙测试：`sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off` |
| 6    | 客户端必须使用**主动模式**                                   |

### 6.2 防火墙放行 Docker（可选）

```bash
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /usr/local/bin/docker
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp /usr/local/bin/docker
```



### 6.3 获取当前 Mac IP

```bash
ipconfig getifaddr en0
```



------

## 七、常见问题

### Q1：为什么不用 `garethflowers/ftp-server`？

该镜像不完整支持 `PASV_ADDRESS` 环境变量，被动模式会返回 `0.0.0.0`，导致客户端无法连接。`fauria/vsftpd` 对该变量支持更好。

### Q2：为什么必须用主动模式？

Parallels 虚拟机的网络环境与 Mac 宿主机之间存在 NAT 转换，被动模式需要客户端能访问服务器返回的 IP 和端口，在虚拟化环境下容易出现路由问题。主动模式由服务器主动连接客户端，更稳定。

### Q3：切换 WiFi 后 IP 变了怎么办？

执行 `~/scripts/FauriaVsftpd/start-ftp.sh` 一键更新。脚本会自动获取新 IP 并重建容器。

### Q4：如何在 Windows 中查看当前 Mac IP？

在 Mac 终端执行 `ipconfig getifaddr en0`，或在 Windows 中 ping 主机名 `ping YangMacBook-Pro.local`（需 Bonjour 服务支持）。');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060987404533239808, 2060987404529045504, '```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>	
#include <conio.h>
#include <ctype.h>
#include <math.h>
#include <time.h>
#define IO 996
#define N 10
 
void Triangle();
void judgeTheLetterCase();
void fact();
double factorial(int);
void stringCopy();
char * longStr();
void main(){
	//Triangle();
	//judgeTheLetterCase();
	//fact();
	//stringCopy();
	//puts(longStr());
} 
 
void Triangle(){
	//用函数打印出等腰三角形，行数由键盘随机输入。
	int row=0,i=0,j=0,k=0;
	scanf_s("%d",&row);
	for(i=0;i<row;i++){
		for(j=0;j<row-i-1;j++){
			printf(" ");
		}
		for(k=0;k<=i;k++){
			printf("* ");
		}
		printf("\n");
	}
	printf("\n\n");
}
 
 
void judgeTheLetterCase(){
	//判断输入的字母大小写
	char arary[5]="\0";
	while(1){
		printf("输入 一个 字母：");
		gets(arary);
		if(strlen(arary)>1){
			printf("\n输入数量大于一！或是占据两个字节的符号！！\n \n 得从新输入!!!\n\n");
			continue;
		}if((arary[0]>=''a''&&arary[0]<=''z'')||(arary[0]>=''A''&&arary[0]<=''Z'')){
		}else{
			printf("\n输入的不是字母！！！\n\n得从新输入！ \n\n");
			continue;
		}
		if(arary[0]>=97&&arary[0]<=122){
			printf("\n小写字母：%c \n\n",arary[0]);
			break;
		} else if(arary[0]>=65&&arary[0]<=106){
			printf("\n大写字母：%c \n\n",arary[0]);
			break;
		}
	}
}
 
void fact(){
	//输入正整数n，求1+1/2!+1/3!+...+1/n!的值，定义并调用factorial(n)计算n的阶乘返回值为单精度浮点型。
	double value=1.0;int n=0,i=2;
	printf("输入一个大于1的数：");
	scanf_s("%d",&n);
	for(i=2;i<=n;i++){
		value+=(1/factorial(i));
	}
	printf("\n1+1/2!+1/3!+...+1/%d!的值为：%.20lf \n\n",n,value);
}
double factorial(int n){
						//求阶乘函数
	if(n==0||n==1) return n;
	else return n * factorial(n-1);
}
 
 
void stringCopy(){
	//编写一个函数实现将字符串s1中的数字字符复制到另一个字符串s2中。
	char s1[1000],s2[1000]="";
	int i=0,j=0;
	printf("\n\n输入一些字符串必须包含数字：");
	gets(s1);
	for(i=0;i<(int)strlen(s1);i++){
		if(s1[i]>=''0''&&s1[i]<=''9''){
			s2[j++]=s1[i];
		}
	}
	if(s2[0]<''0''||s2[0]>''9''){
		printf("\n\n输入的字符串-");
		puts(s1);
		printf("			-没有包含没有包含数字或存在两个字节得字符！！！得从新输入！\n");
		stringCopy();
	}
	printf("\n\nS2= ");
	puts(s2);
	printf("\n\n");
}
 
 
char* longStr(){
	//编写一个函数longStr实现从n个字符串中寻找最长串，
	//其中z是指向多个字符串得指针数组，n是字符串得个数，函数得返回值是最长串得首地址。
	char*z[3]={{"yangmufa"},{"haoshuaiya"},{"jianzhibuyaotaishuai"}};
	int n=3,i=0,max=0;
	for(i=0;i<n;i++){
		if(strlen(z[max])<=strlen(z[i])){
			max=i;
		}
	}
	return (z[max]);
}
```
结果Triangle:  
Triangle()：![](https://img.yangmufa.cn/blog-article/1be523adb34d49c381d95126ff6b8ac1.png)  
judgeTheLetterCase()：![](https://img.yangmufa.cn/blog-article/9bfa5f6ec0a64e20ba47961f528038f8.png)
fact()：![](https://img.yangmufa.cn/blog-article/49c77deef710444ab28f098a0bf9fce3.png)
stringCopy()：![](https://img.yangmufa.cn/blog-article/99ab63670d214313b2fabf120b4366f6.png)
puts(longStr())：![](https://img.yangmufa.cn/blog-article/538c14656f6e448997649a9a71e5833c.png)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2113281070739886080, 2113281070735691776, '> 面向熟悉 C#、.NET、Avalonia 或 WinForms，希望理解 Vue 状态管理的开发者。

## 1. Store 到底是什么

一句话理解：

**Store 是多个组件共同使用的、具有响应式能力的前端状态容器；Pinia 是管理这些 Store 的工具。**

例如，后台管理系统中很多地方都需要登录状态：

- 登录页写入 Token 和用户信息。
- 顶部栏显示用户名和头像。
- 路由守卫判断是否允许进入页面。
- 权限按钮判断是否显示。
- HTTP 请求读取 Token 并添加请求头。

如果每个组件都保存一份用户信息，很容易出现数据不一致。Store 将它们集中到一起：

```text
                 Auth Store
          Token、用户、角色、权限
                    │
        ┌───────────┼───────────┐
        ↓           ↓           ↓
      登录页      顶部栏      路由守卫
      修改状态    读取状态    读取状态
```

同一个 Pinia 容器中，组件通过相同的 Store 定义获取的是同一个 Store 实例，而不是每调用一次就创建一份独立状态。

## 2. 用 C# 建立心智模型

可以把认证 Store 近似理解成一个共享的状态服务：

```csharp
public class AuthState {

    public string? Token { get; private set; }
    public string? Username { get; private set; }

    public bool IsLoggedIn => !string.IsNullOrEmpty(Token);

    public void SetSession(string token, string username) {
        Token = token;
        Username = username;
    }

    public void Logout() {
        Token = null;
        Username = null;
    }
}
```

在 .NET 中，可以通过依赖注入获取共享服务：

```csharp
var authState = serviceProvider.GetRequiredService<AuthState>();
```

在 Vue 中，对应的使用方式是：

```ts
const authStore = useAuthStore();
```

但不要把它与 ASP.NET Core 的服务端 Singleton 完全等同：

| 对比 | ASP.NET Core Singleton | 浏览器中的 Pinia Store |
| --- | --- | --- |
| 运行位置 | 服务器进程 | 浏览器页面 |
| 共享范围 | 同一服务容器中的请求和服务 | 同一 Pinia 实例中的组件 |
| 不同用户 | 可能访问同一个服务实例 | 通常各自拥有独立 Store |
| 页面刷新 | 不影响服务器服务 | 页面内存状态重新创建 |

在常见单页应用中，每个浏览器标签页都有自己的 Pinia 实例。即使同源标签页共享 localStorage，它们的 Store 内存也不会自动同步。

## 3. Store 的三个核心概念

Pinia 最重要的三个概念是：

```text
State    保存数据
Getter   根据已有数据计算结果
Action   执行操作和业务流程
```

持久化不是第四种内置状态类型，而是可选能力，需要手动实现或使用插件。

下面用 Setup Store 写一个最小示例：

```ts
import { defineStore } from ''pinia'';
import { computed, ref } from ''vue'';

export const useAuthStore = defineStore(''auth'', () => {
  const token = ref<string | null>(null);
  const username = ref<string | null>(null);

  const isLoggedIn = computed(() => !!token.value);

  function setSession(newToken: string, newUsername: string) {
    token.value = newToken;
    username.value = newUsername;
  }

  function logout() {
    token.value = null;
    username.value = null;
  }

  return {
    token,
    username,
    isLoggedIn,
    setSession,
    logout,
  };
});
```

在这个示例中：

| 代码 | Pinia 概念 | C# 类比 |
| --- | --- | --- |
| `token`、`username` | State | 保存数据的属性 |
| `isLoggedIn` | Getter | 计算属性 |
| `setSession()`、`logout()` | Action | 实例方法 |
| `useAuthStore()` | 获取 Store | 从容器获取共享服务 |

## 4. State：保存当前状态

```ts
const token = ref<string | null>(null);
```

这行代码表示：

- 定义一个响应式变量。
- 数据类型是 `string` 或 `null`。
- 初始值是 `null`。

在 Store 内部访问和修改 ref，使用 `.value`：

```ts
token.value = ''some-token'';
console.log(token.value);
```

获取 Store 后，Pinia 会自动解包这些 ref：

```ts
const authStore = useAuthStore();

console.log(authStore.token);
```

因此要区分：

```text
Store 内部的 ref       token.value
Store 实例上的属性      authStore.token
```

Pinia 允许直接修改 State，例如 `authStore.token = ''some-token''`。不过涉及 Token、用户和过期时间一起更新时，通过 Action 统一处理更容易保持一致。

## 5. Getter：根据状态计算结果

```ts
const isLoggedIn = computed(() => !!token.value);
```

`!!` 的作用是转换为布尔值：

```ts
!!null;       // false
!!'''';         // false
!!''abc'';      // true
```

因此，当 Token 有值时，`isLoggedIn` 为 `true`。

它类似 C# 的计算属性：

```csharp
public bool IsLoggedIn => !string.IsNullOrEmpty(Token);
```

Getter 的价值是避免重复保存可推导的数据。

例如，保存了角色对象列表：

```ts
const roles = ref([
  { id: ''1'', code: ''admin'', name: ''管理员'' },
]);
```

如果需要角色代码，可以计算得到：

```ts
const roleCodes = computed(() => roles.value.map((role) => role.code));
```

结果是：

```ts
[''admin'']
```

不需要再手动维护一份角色代码数组。依赖变化时，计算结果会随之更新。

## 6. Action：执行操作

Action 是 Store 中执行操作的方法，可以同步，也可以异步。

同步操作：

```ts
function logout() {
  token.value = null;
  username.value = null;
}
```

异步操作通常用来请求接口，然后更新 State：

```ts
async function login(username: string, password: string) {
  const result = await loginApi({ username, password });
  token.value = result.data.token;
}
```

可以理解成 C# 中的异步服务方法：

```csharp
public async Task LoginAsync(string username, string password) {
    var result = await authApi.LoginAsync(username, password);
    Token = result.Data.Token;
}
```

这里的 `loginApi` 表示 API 层提供的请求方法，具体返回结构由项目接口约定决定。

## 7. defineStore 和 useAuthStore 分别是什么

```ts
export const useAuthStore = defineStore(''auth'', () => {
  // 定义状态、计算属性和方法
});
```

可以分成三部分：

- `defineStore()`：定义 Store。
- `''auth''`：Store 的唯一 ID，用于区分不同 Store。
- `useAuthStore`：获取这个 Store 实例的函数，名称是约定，不是固定语法。

使用时：

```ts
const authStore = useAuthStore();
```

要区分：

```text
useAuthStore    获取 Store 的函数
useAuthStore() 调用函数，取得 Store 实例
authStore      取得的 Store 实例
```

同一个 Pinia 实例中，多次调用 `useAuthStore()` 会获得同一个认证 Store。

## 8. return 的作用

Setup Store 最后需要返回 State、Getter 和 Action：

```ts
return {
  token,
  username,
  isLoggedIn,
  setSession,
  logout,
};
```

返回后，组件才能通过 Store 实例访问它们：

```ts
authStore.token;
authStore.isLoggedIn;
authStore.logout();
```

可以把 `return` 暂时类比为“对外公开接口”，但它不是 C# 访问修饰符的完整替代。

特别注意：**Setup Store 的响应式 State 应当全部返回**，不要用“不返回 State”来实现私有状态，否则可能影响开发者工具、插件和服务端渲染。普通内部辅助函数则不一定需要返回。

## 9. 在 Vue 中注册 Pinia

在应用入口注册一次：

```ts
import { createApp } from ''vue'';
import { createPinia } from ''pinia'';
import App from ''./App.vue'';

const app = createApp(App);
const pinia = createPinia();

app.use(pinia);
app.mount(''#app'');
```

流程是：

```text
创建 Vue 应用
      ↓
创建 Pinia 容器
      ↓
注册到 Vue 应用
      ↓
组件中使用 Store
```

通常在组件的 `<script setup>` 中调用 `useAuthStore()`。在路由守卫等组件外部使用时，也要保证 Pinia 已经安装，或显式传入对应 Pinia 实例。

## 10. 组件如何使用 Store

假设已经定义了前面的认证 Store，组件可以这样使用：

```vue
<script setup lang="ts">
import { useAuthStore } from ''@/stores/auth'';

const authStore = useAuthStore();

function simulateLogin() {
  authStore.setSession(''demo-token'', ''yangmufa'');
}
</script>

<template>
  <div>
    <p v-if="authStore.isLoggedIn">
      当前用户：{{ authStore.username }}
    </p>
    <p v-else>尚未登录</p>

    <button @click="simulateLogin">模拟登录</button>
    <button @click="authStore.logout()">退出登录</button>
  </div>
</template>
```

这里的 `demo-token` 只是演示响应式状态，不具备真实认证能力。

点击“模拟登录”后：

```text
setSession()
      ↓
修改 token 和 username
      ↓
isLoggedIn 自动重新计算
      ↓
模板自动显示用户名
```

点击“退出登录”后，所有依赖这个 Store 的组件都会看到更新后的状态。

## 11. 响应式可以类比属性变更通知

在 Avalonia 或其他 MVVM 框架中，通常通过 `INotifyPropertyChanged` 通知界面更新。

例如使用 CommunityToolkit.Mvvm：

```csharp
public partial class AuthViewModel : ObservableObject {
    [ObservableProperty]
    private string? username;
}
```

修改 `Username` 后，绑定它的界面更新。

Vue 和 Pinia 的效果类似：

```ts
username.value = ''yangmufa'';
```

依赖 `username` 的模板会自动更新。

区别在于，Vue 使用 ref 和响应式代理追踪依赖，不需要你手动实现 `INotifyPropertyChanged`。

## 12. 一个容易踩的坑：直接解构 Store

下面这种写法可能丢失 State 和 Getter 的响应式连接：

```ts
const authStore = useAuthStore();
const { username, isLoggedIn } = authStore;
```

对于字符串、布尔值等属性，这相当于取出了当前值，而不是保留与 Store 属性的响应式绑定。

推荐两种方式。

### 方式一：直接通过 Store 访问

```ts
const authStore = useAuthStore();
```

模板中使用：

```vue
<span>{{ authStore.username }}</span>
```

### 方式二：使用 storeToRefs

```ts
import { storeToRefs } from ''pinia'';

const authStore = useAuthStore();
const { username, isLoggedIn } = storeToRefs(authStore);
```

此时在脚本中：

```ts
console.log(username.value);
```

在模板中自动解包：

```vue
<span>{{ username }}</span>
```

Action 可以直接解构：

```ts
const { logout } = authStore;
logout();
```

记忆方式：

```text
State、Getter 解构：用 storeToRefs
Action 解构：可以直接取
```

## 13. Store、API、Mock 分别负责什么

这三者不在同一层。

| 层 | 职责 | .NET 类比 |
| --- | --- | --- |
| Vue 组件 | 展示界面、响应点击 | View |
| Pinia Store | 保存共享状态、编排操作 | 状态服务或共享 ViewModel |
| API 模块 | 封装 HTTP 请求 | HttpClient 客户端 |
| Mock | 模拟接口响应 | 假 Controller 和内存数据源 |
| 真实后端 | 认证、权限校验、业务和持久化 | ASP.NET Core API |

登录流程可以理解为：

```text
登录组件
    ↓ 调用方法
authStore.login()
    ↓ 调用 API
loginApi()
    ↓ HTTP 请求
Mock 或真实后端
    ↓ 返回 Token
authStore 保存 Token
    ↓ 请求当前用户
getUserInfo()
    ↓ 返回用户、角色、权限
authStore 保存用户信息
    ↓ 响应式更新
顶部栏、权限按钮等组件更新
```

换成真实后端时，只要请求和响应契约保持一致，Store 通常不需要知道对面是 Mock 还是 ASP.NET Core。

**Store 不是数据库，也不是后端身份验证服务。** 前端可以根据权限控制显示效果，但真正的安全校验必须由后端执行。

## 14. 结合本项目理解认证 Store

本项目认证 Store 位于 `Mint.Blog.Admin.Vue/src/stores/auth.ts`，可以按下面的顺序阅读。

### 第一步：找 State

主要包括：

- `token`：访问令牌。
- `refreshTokenValue`：刷新令牌。
- `tokenExpiresAt`：前端记录的过期时间。
- `user`：当前用户。
- `roles`：角色对象列表。
- `permissions`：权限对象列表。

### 第二步：找 Getter

主要包括：

- `isTokenExpired`：根据记录的时间判断令牌是否过期。
- `isLoggedIn`：综合 Token、用户和过期状态判断登录状态。
- `userRoles`：从角色对象中提取角色代码。
- `userPermissions`：从权限对象中提取权限代码。

注意，`computed(() => Date.now() >= expiresAt)` 不等于定时器：时间经过本身不会触发响应式更新。若需要到点立即退出，需要额外的定时或请求校验机制。

### 第三步：找 Action

主要包括：

- `setToken()`：更新令牌并保存到 localStorage。
- `setUserInfo()`：更新用户、角色和权限，并缓存用户信息。
- `login()`：编排登录和获取用户信息两个请求。
- `logout()`：清除前端认证状态。
- `refreshToken()`：请求新令牌。
- `hasRole()`、`hasPermission()`：提供角色和权限判断。
- `initAuth()`：恢复或清理本地缓存的认证信息。

### 第四步：读登录流程

```text
获取 API 函数
      ↓
清理旧认证状态
      ↓
提交用户名和密码
      ↓
获得 Token、Refresh Token、有效期
      ↓
setToken() 更新状态并缓存
      ↓
请求当前用户信息
      ↓
setUserInfo() 更新用户、角色、权限并缓存
```

动态导入这一句：

```ts
const { login: loginApi, getUserInfo } = await import(''@/api/auth'');
```

等价于先取出模块，再取出函数：

```ts
const authApi = await import(''@/api/auth'');
const loginApi = authApi.login;
const getUserInfo = authApi.getUserInfo;
```

后面的 `loginApi(...)` 和 `getUserInfo()` 就是在调用这两个函数。

其中 `login: loginApi` 是解构重命名，用于区分 API 的 `login` 和 Store 的 `login`。不重命名可能造成内层名称遮蔽；不同作用域中的同名声明并不一定是语法冲突。

## 15. Store 与 localStorage：内存和持久化

Pinia 默认不会自动把 State 保存到 localStorage。

```ts
token.value = newToken;
```

这只是修改内存状态。页面刷新后，内存会重建。

```ts
localStorage.setItem(''access_token'', newToken);
```

这才是持久化保存。

| 对比 | Pinia Store | localStorage |
| --- | --- | --- |
| 用途 | 页面运行时的共享状态 | 浏览器持久化存储 |
| Vue 响应式 | 有 | 默认没有 |
| 数据形式 | 对象、数组等 | 字符串 |
| 页面刷新后 | 内存重建 | 通常仍存在 |
| 自动更新界面 | 可以 | 不会直接触发 Vue 更新 |

常见做法是同时更新两者：

```ts
function setToken(newToken: string | null) {
  token.value = newToken;

  if (newToken) {
    localStorage.setItem(''access_token'', newToken);
  } else {
    localStorage.removeItem(''access_token'');
  }
}
```

初始化时再恢复：

```ts
const token = ref<string | null>(
  localStorage.getItem(''access_token''),
);
```

这些浏览器 API 示例适用于客户端应用。服务端渲染时不能直接假定存在 localStorage。

另外，localStorage 中的数据可以被用户修改，也可能在 XSS 攻击中被脚本读取。缓存的用户和权限不能作为后端授权依据，令牌存储方式需要结合安全方案选择。

## 16. 哪些数据适合放 Store

适合放 Store 的数据通常有这些特点：

- 多个组件都需要。
- 跨页面需要共享。
- 修改后多个区域需要同步更新。
- 属于清晰的应用业务状态。

例如：

| 数据 | 通常是否适合放 Store |
| --- | --- |
| 当前用户和权限 | 适合 |
| 全局主题 | 适合 |
| 多标签页状态 | 适合 |
| 购物车 | 适合 |
| 多页面共用的字典数据 | 适合 |
| 单个弹窗是否打开 | 通常放组件内 |
| 一个输入框的临时值 | 通常放组件内 |
| 只在当前页面使用的列表 | 不一定需要 Store |

不是所有接口数据都需要放 Store，也不是每个组件都需要自己的 Store。

最简单的判断是：

> 如果数据只有当前组件使用，先放组件里；出现明确共享需求，再考虑提取到 Store。

## 17. 多个 Store 如何配合

通常按业务领域拆分 Store，而不是创建一个包含所有数据的巨大 Store。

例如：

```text
Auth Store
保存用户、角色和权限
      ↓
Permission Store
过滤路由、生成菜单
      ↓
页面导航
      ↓
Tabs Store
记录打开的页面
```

一个 Store 可以使用另一个 Store，但需要避免互相初始化、互相调用造成循环依赖。

前端角色和权限状态用于界面体验；无论菜单是否隐藏，后端接口都必须独立校验访问权限。

## 18. Options Store 和 Setup Store

Pinia 有两种常见写法。

### Options Store

```ts
export const useCounterStore = defineStore(''counter'', {
  state: () => ({
    count: 0,
  }),

  getters: {
    doubleCount: (state) => state.count * 2,
  },

  actions: {
    increment() {
      this.count++;
    },
  },
});
```

它显式区分 `state`、`getters`、`actions`。

### Setup Store

```ts
export const useCounterStore = defineStore(''counter'', () => {
  const count = ref(0);
  const doubleCount = computed(() => count.value * 2);

  function increment() {
    count.value++;
  }

  return { count, doubleCount, increment };
});
```

对应关系是：

```text
ref()       → State
computed()  → Getter
function    → Action
```

本项目认证 Store 使用 Setup Store。两种写法的核心概念一致，不需要为了学习而重写现有代码。

## 19. 如何阅读一个陌生 Store

不要一开始逐行研究所有辅助函数，先回答五个问题：

1. 它保存什么数据？
2. 哪些数据是计算出来的？
3. 它提供哪些操作？
4. 哪些组件或模块使用它？
5. 刷新页面后，数据如何恢复？

对于认证 Store，可以快速整理成：

```text
保存：Token、用户、角色、权限
计算：登录状态、角色代码、权限代码
操作：登录、退出、刷新 Token、权限判断
使用者：登录页、顶部栏、路由守卫、请求封装
恢复：读取 localStorage，并执行初始化逻辑
```

能说明白这五项，就已经掌握了它的主要职责。

## 20. 常见问题

### 20.1 导入函数和获取实例有什么区别

```ts
import { useAuthStore } from ''@/stores/auth'';

const authStore = useAuthStore();
```

- 第一行是从模块中导入名为 `useAuthStore` 的函数，不是获取 Store 实例。
- 第二行才是调用函数，获取当前 Pinia 容器中的 auth Store 实例，并赋值给局部常量 `authStore`。
- `authStore` 不是 Pinia 容器本身，而是容器管理的一个业务 Store。

可以用 C# 的服务容器作近似类比：

```text
createPinia()   → 创建服务容器
useAuthStore   → 获取 AuthState 服务的函数
useAuthStore() → 从当前容器解析 AuthState 服务
authStore      → 获取到的 AuthState 实例
```

这里的“共享”范围是同一个 Pinia 容器，不是所有浏览器、所有用户共享一个实例。

### 20.2 authStore.user 和 authStore.isLoggedIn 要不要 .value

规则相同：**Store 内部的 ref/computed 使用 `.value`；通过 Store 实例访问时，Pinia 已自动解包，不需要 `.value`。**

| 使用位置 | 用户信息 State | 登录状态 Getter |
| --- | --- | --- |
| Store 内部 | `user.value` | `isLoggedIn.value` |
| 组件脚本，通过 Store 访问 | `authStore.user` | `authStore.isLoggedIn` |
| 组件模板，通过 Store 访问 | `authStore.user` | `authStore.isLoggedIn` |
| 组件脚本，经过 `storeToRefs` 解构 | `user.value` | `isLoggedIn.value` |
| 组件模板，经过 `storeToRefs` 解构 | `user` | `isLoggedIn` |

例如，组件直接通过 Store 使用：

```vue
<script setup lang="ts">
import { useAuthStore } from ''@/stores/auth'';

const authStore = useAuthStore();

function checkLogin() {
  console.log(authStore.isLoggedIn);
  console.log(authStore.user);
}
</script>

<template>
  <p v-if="authStore.isLoggedIn">已登录</p>
  <button @click="checkLogin">查看当前状态</button>
</template>
```

不要写 `authStore.isLoggedIn.value` 或 `authStore.user.value`，因为这些属性在 Store 实例上已经解包了。

也可以先转换为响应式引用：

```ts
import { storeToRefs } from ''pinia'';

const authStore = useAuthStore();
const { user, isLoggedIn } = storeToRefs(authStore);

console.log(user.value);
console.log(isLoggedIn.value);
```

这里的 `.value` 与是否启用持久化无关，只取决于你访问的是 Store 属性，还是单独的 ref/computed。

### 20.3 对象直接解构后，是不是完全没有响应式了

要区分“对象自身的响应式”和“与 Store 属性保持连接”：

```ts
const { user } = authStore;
```

- 如果解构时 `authStore.user` 为 `null`，局部变量 `user` 就是 `null`，之后登录也不会自动变成新用户。
- 如果解构时它是响应式对象，局部变量仍指向那个响应式对象，修改该对象的现有属性仍可被响应式追踪。
- 但执行 `authStore.user = newUser` 时，局部变量不会跟随切换到新对象；退出登录将 Store 中的用户设为 `null`，局部变量也不会自动变成 `null`。

这类似 C# 中 `var user = authState.User;`：取出对象引用后，重新给 `authState.User` 赋值，不会自动改变局部变量 `user`。

因此，想跟随登录、退出以及用户对象的整体替换，使用 `authStore.user` 或 `storeToRefs(authStore)`。

同理，`const loggedIn = authStore.isLoggedIn` 只是保存当前布尔值，不会自动重新执行这次赋值。应在模板、`computed`、`watch` 等响应式上下文中读取 Store 属性，例如：

```ts
watch(
  () => authStore.isLoggedIn,
  (loggedIn) => {
    console.log(''登录状态变化：'', loggedIn);
  },
);
```

上例的 `watch` 需要从 `vue` 导入。监听整个 `user` 对象的替换时可以使用 `watch(() => authStore.user, ...)`；如果还需要监听对象内部属性的修改，应监听具体属性，或按需使用深度监听。

本项目建议通过 `authStore.setUserInfo(newUser)` 更新用户，而不是只给 `authStore.user` 赋值，因为该 Action 还会同步角色、权限和本地缓存。

### 20.4 如何设置 persist

`persist` 不是 Pinia 自带的开关，需要先安装并注册插件。下面使用 `pinia-plugin-persistedstate` 的 `pick` 配置方式演示。

安装：

```bash
npm install pinia-plugin-persistedstate
```

在应用入口创建并注册 Pinia 时安装插件：

```ts
import { createApp } from ''vue'';
import { createPinia } from ''pinia'';
import piniaPluginPersistedstate from ''pinia-plugin-persistedstate'';
import App from ''./App.vue'';

const app = createApp(App);
const pinia = createPinia();

pinia.use(piniaPluginPersistedstate);
app.use(pinia);
app.mount(''#app'');
```

插件要注册到实际传给 `app.use(pinia)` 的同一个 Pinia 实例上。

Setup Store 的持久化配置放在 `defineStore()` 的第三个参数中。以下是独立教学示例，不是当前认证 Store 的完整实现：

```ts
import { defineStore } from ''pinia'';
import { computed, ref } from ''vue'';

type DemoUser = {
  id: string;
  username: string;
};

export const useDemoAuthStore = defineStore(
  ''demo-auth'',
  () => {
    const token = ref<string | null>(null);
    const user = ref<DemoUser | null>(null);
    const isLoggedIn = computed(() => !!token.value && !!user.value);

    function setSession(newToken: string, newUser: DemoUser) {
      token.value = newToken;
      user.value = newUser;
    }

    function logout() {
      token.value = null;
      user.value = null;
    }

    return { token, user, isLoggedIn, setSession, logout };
  },
  {
    persist: {
      key: ''demo-auth'',
      storage: localStorage,
      pick: [''token'', ''user''],
    },
  },
);
```

这只是演示持久化，真实认证还要处理令牌有效期和后端校验。此示例与第 15 章的手动 localStorage 方案是两种替代做法，不需要同时使用。

### 20.5 pick 是决定哪些数据需要持久化吗

是。`pick` 是持久化字段的选择列表：

```ts
persist: {
  key: ''auth'',
  storage: localStorage,
  pick: [''token'', ''user'', ''tokenExpiresAt''],
}
```

| 配置 | 含义 |
| --- | --- |
| `key` | localStorage 中使用的存储键名 |
| `storage` | 使用的存储对象，这里是 localStorage，也可以选择 sessionStorage |
| `pick` | 从 Store 的 State 中选择需要保存和恢复的字段 |

上例只持久化 `token`、`user` 和 `tokenExpiresAt`；没有选中的 State 仍然在内存中具有响应式，只是不由该配置保存和恢复。省略 `pick` 时，插件默认持久化整个 State；设置 `pick: []` 则不选择任何字段。

Getter 和 Action 不属于需要序列化的 State。`isLoggedIn`、`isTokenExpired`、`userRoles` 等计算结果不需要放入 `pick`，它们会根据恢复后的 State 重新计算。

### 20.6 持久化后 authStore.user 会不会丢失响应式

**不会。持久化的是状态的数据，不是把 Vue 的响应式代理直接存到 localStorage 中。**

流程可以理解为：

```text
运行时：
修改响应式 State → 插件序列化数据 → 保存到 localStorage

刷新后：
创建 Store → 插件读取并反序列化缓存 → 恢复到响应式 State
                                           ↓
                              Getter 计算、模板读取并更新
```

因此，恢复后的 `authStore.user` 仍然具有响应式，使用方式不变：

```ts
const authStore = useAuthStore();

// 通过 Store 访问，不需要 .value
console.log(authStore.user);
console.log(authStore.isLoggedIn);

// 需要解构时，使用 storeToRefs
const { user, isLoggedIn } = storeToRefs(authStore);
console.log(user.value);
console.log(isLoggedIn.value);
```

上例中的 `storeToRefs` 需要从 `pinia` 导入。可以用 C# 类比：将状态服务序列化为 JSON 文件，再读回服务属性，并不意味着属性变更通知机制被永久删除；持久化负责数据，响应式负责运行时的依赖追踪。

注意三个边界：

1. **手动修改 localStorage 不等于修改 Store。** 插件不会因为你直接调用 `localStorage.setItem()` 就自动同步当前页面的 Store，也不会自动同步其他标签页。
2. **默认 JSON 序列化存在类型限制。** 普通对象、数组、字符串可以保存；`Date`、`Map`、`Set`、类实例等不能直接保证原始类型和行为被保留。多个属性原本共享同一个对象引用的关系，也不会由 JSON 自动恢复。这些是序列化问题，不是响应式丢失。
3. **持久化不会让时间变成响应式。** `Date.now()` 不会主动触发 computed 更新，令牌到期判断仍需要合适的定时或请求校验机制。

### 20.7 当前项目采用哪种持久化方式

当前认证 Store 使用手动 localStorage 方案，还没有安装和注册上述插件：

- `setToken()` 写入或删除令牌及过期时间。
- `setUserInfo()` 写入或删除用户信息，同时同步角色和权限。
- 创建 Store 时恢复令牌，`initAuth()` 恢复用户并处理缓存版本等逻辑。

这些数据最终赋值给 `ref.value`，因此仍然是响应式状态。

如果以后改用插件，应统一调整手动读写和恢复逻辑，避免两套机制使用不同键名或相互覆盖。同时保留必要的用户数据迁移、过期校验和角色权限同步，不能只添加 `persist` 就删除全部初始化业务逻辑。

## 21. 最后用一句话串起来

**组件通过 Action 发起操作，Action 调用 API 并修改 State，Getter 根据 State 计算结果，依赖这些状态的组件自动更新；如需跨刷新保留数据，再额外实现持久化。**

```text
用户操作
   ↓
组件调用 Action
   ↓
请求 API 或执行本地逻辑
   ↓
更新 State
   ↓
Getter 重新计算
   ↓
相关组件自动更新
```

把 Pinia 理解为“带响应式能力的共享状态服务”，再用 C# 的属性、计算属性、方法和依赖注入来对照，会更容易建立完整的心智模型。');
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
  "create_time" timestamp(6) NOT NULL,
  "update_time" timestamp(6) NOT NULL,
  "visibility" int2 NOT NULL DEFAULT '1'::smallint,
  "tag_id" int8,
  "tag_version_id" int8
)
;
ALTER TABLE "public"."blog_article_draft" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_article_draft"."visibility" IS '1 ：公开可见
2 ：仅专栏可见';
COMMENT ON COLUMN "public"."blog_article_draft"."tag_version_id" IS '与tag_id同时为空表示尚未选择；通用必须引用真实版本ID';

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
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059446227048730624, 'C#.Net', '2026-05-27 01:26:57.844267', '2026-05-27 01:26:57.844267', 0, 2, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059447423109042176, 'Databases', '2026-05-27 01:31:43.009024', '2026-05-27 01:31:43.009024', 0, 4, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059447483628654592, 'Middleware', '2026-05-27 01:31:57.438571', '2026-05-27 01:31:57.438571', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059447573978157056, 'Algorithms', '2026-05-27 01:32:18.979536', '2026-05-27 01:32:18.979536', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059447876098068480, 'Architecture', '2026-05-27 01:33:31.010782', '2026-05-27 01:33:31.010782', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059448449551699968, 'DevOps', '2026-05-26 17:35:47.732039', '2026-05-27 01:39:43.93353', 0, 6, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059448978084335616, 'DevTools', '2026-05-26 09:37:53.744045', '2026-05-27 01:39:49.833062', 0, 1, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059448377816518656, 'OpenLibrary', '2026-05-26 09:35:30.62937', '2026-05-27 01:40:03.443138', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059454849011027968, 'Mint.Blog', '2026-05-27 02:01:13.482286', '2026-05-27 02:01:13.482286', 0, 1, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059460283725910016, 'ProblemRecord', '2026-05-27 02:22:49.219106', '2026-05-27 02:22:49.219106', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2060922257240363008, 'NetBeans', '2026-05-31 03:12:10.866454', '2026-05-31 03:12:10.866454', 0, 0, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2067993230846332928, 'Safety', '2026-06-19 15:29:42.344422', '2026-06-19 15:29:42.344422', 0, 2, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2077756560666398720, 'Learning', '2026-07-16 14:05:41.569453', '2026-07-16 14:05:41.569453', 0, 23, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059447031314911232, 'Frontend（Browser）', '2026-05-26 09:30:09.598603', '2026-10-22 14:51:07.860929', 0, 6, 0);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059446737717825536, 'Frontend（Client）', '2026-05-26 17:28:59.599736', '2026-10-22 14:53:45.28383', 0, 1, 0);
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
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (1, 'Mint.Blog开发部署文档', 'https://img.yanggongzi.dev/blog-system/mint-logo.svg', '开发文档', '2024-11-19 08:53:28', '2026-09-02 09:49:58.083063', 0, 7, 1, 11);
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
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (63, 2077753941604569088, NULL, '音标', 1, 0, 1, '2026-07-16 14:03:52.172492', '2026-07-16 14:03:52.172493', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (64, 2077753941604569088, NULL, '26个字母', 1, 0, 2, '2026-07-16 14:03:52.173071', '2026-07-16 14:03:52.173071', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (65, 2077753941604569088, NULL, '词法', 1, 0, 3, '2026-07-16 14:03:52.173493', '2026-07-16 14:03:52.173494', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (66, 2077753941604569088, NULL, '语法', 1, 0, 4, '2026-07-16 14:03:52.173902', '2026-07-16 14:03:52.173902', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (67, 2077753941604569088, NULL, '句法', 1, 0, 5, '2026-07-16 14:03:52.174305', '2026-07-16 14:03:52.174305', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (68, 2077753941604569088, NULL, '时态和语态', 1, 0, 6, '2026-07-16 14:03:52.174694', '2026-07-16 14:03:52.174695', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (69, 2077753941604569088, NULL, '语气和功能', 1, 0, 7, '2026-07-16 14:03:52.175077', '2026-07-16 14:03:52.175077', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (70, 2077753941604569088, NULL, '文章', 1, 0, 8, '2026-07-16 14:03:52.175459', '2026-07-16 14:03:52.175459', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (71, 2077753941604569088, NULL, '学习方法', 1, 0, 9, '2026-07-16 14:03:52.175831', '2026-07-16 14:03:52.175831', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (72, 2077753941604569088, 2077756000756174848, '英语语法体系', 2, 63, 1, '2026-07-16 14:03:52.176215', '2026-07-16 14:03:52.176215', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (73, 2095086327090515968, NULL, '项目介绍', 1, 0, 1, '2026-09-02 11:08:31.165486', '2026-09-02 11:08:31.165486', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (74, 2095086327090515968, NULL, '2222', 1, 0, 2, '2026-09-02 11:08:31.173992', '2026-09-02 11:08:31.173992', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (75, 2095086327090515968, 2068016047268696064, 'Docker部署AllinSSL自动化申请续签HTTPS安全证书', 2, 73, 1, '2026-09-02 11:08:31.176465', '2026-09-02 11:08:31.176465', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (76, 2095086327090515968, 2079842831182204928, '通过CertBot手动申请Let''sEncrypt泛域名证书', 2, 73, 2, '2026-09-02 11:08:31.176494', '2026-09-02 11:08:31.176494', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (77, 2095086327090515968, 2060384515678932992, 'MinIO 迁移到 RustFS', 2, 73, 3, '2026-09-02 11:08:31.176495', '2026-09-02 11:08:31.176495', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (78, 2095086327090515968, 2060980770335494144, 'MySQL 8.0.16-WINx64安装详细步骤-第二版', 2, 73, 4, '2026-09-02 11:08:31.176495', '2026-09-02 11:08:31.176495', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (79, 2095086327090515968, 2060983253065666560, 'C语言-有 1、2、3、4 几个数字，能组成多少个互不相同且不重复的三位数', 2, 74, 1, '2026-09-02 11:08:31.176495', '2026-09-02 11:08:31.176495', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (80, 1, NULL, '部署', 1, 0, 1, '2026-11-01 04:55:35.512573', '2026-11-01 04:55:35.512573', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (81, 1, 2060392182262665216, '系统介绍', 2, 80, 1, '2026-11-01 04:55:35.518261', '2026-11-01 04:55:35.518261', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (82, 1, NULL, '前端', 2, 80, 2, '2026-11-01 04:55:35.518281', '2026-11-01 04:55:35.518281', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (83, 1, NULL, '后端', 2, 80, 3, '2026-11-01 04:55:35.518281', '2026-11-01 04:55:35.518281', 0);
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
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2049542732141170688, '多少多少', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/10', '2026-04-29 17:34:00.661583', '2026-04-29 17:34:00.661583', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2049542786654539776, '顶顶顶顶', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/10', '2026-04-29 17:34:13.658662', '2026-04-29 17:34:13.658662', 0, NULL, NULL, '', 2);
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
  "rss_url" varchar(1000) COLLATE "pg_catalog"."default",
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
COMMENT ON COLUMN "public"."blog_friend"."rss_url" IS 'RSS/Atom 订阅链接（可选）';
COMMENT ON COLUMN "public"."blog_friend"."avatar" IS '友链头像URL';
COMMENT ON COLUMN "public"."blog_friend"."status" IS '友链状态：active-正常，inactive-停用，pending-待审核';
COMMENT ON COLUMN "public"."blog_friend"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."blog_friend"."category" IS 'tech技术类 tools工具类 avigation导航类 news新闻类 aggregate聚合类 life生活类 mintblog优秀站点';
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
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "rss_url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (3, 'One', '明心静性，爱自己', 'https://onedayxyy.cn', NULL, 'https://img.xxdevops.cn/blog/avatar/yuwen_avatar.avif', 'active', '2026-05-30 03:37:27', 'tech', 'f', '', 7, 0, '2026-06-02 08:14:11.526904');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "rss_url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (2, 'Hyde Blog', '人心中的成见是一座大山~', 'https://teek.seasir.top', NULL, 'https://teek.seasir.top/avatar/avatar.webp', 'active', '2026-05-30 03:34:54', 'tech', 'f', '', 5, 0, '2026-06-02 08:14:11.532665');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "rss_url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (4, '25196', '互联网上的小窝', 'https://www.yangworld.top', NULL, 'https://q1.qlogo.cn/g?b=qq&nk=2779643212&s=640', 'inactive', '2026-05-30 03:36:25', 'tech', 'f', '', 0, 0, '2026-08-05 15:29:18.858424');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "rss_url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (6, 'UTOPIA', 'UTOPIA 人类思想意识中最美好的国度。', 'https://yshujia.cn', NULL, 'https://yshujia.cn/cover.webp', 'inactive', '2026-05-30 03:44:32', 'tech', 'f', '', 0, 0, '2026-08-17 08:40:11.230254');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "rss_url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (17, '薄荷の小屋', '越是拼命往前伸手，渴望之物越是渐行渐远', 'https://www.hoshiroko.com', NULL, 'https://api.hoshiroko.com/img/avatar.jpg', 'inactive', '2026-08-05 15:32:27', 'tech', 'f', '', 0, 0, '2026-08-17 08:40:55.155268');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "rss_url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (18, '栖息地', '他强任他强，清风拂山岗。', 'https://qixidi.top', NULL, 'https://qixidi.top/img/logo.png', 'active', '2026-08-17 08:38:12', 'life', 'f', '', 1, 0, '2026-08-17 08:40:58.943824');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "rss_url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (5, '瀚星河', '缓慢向上也是一种勇气。', 'https://www.golangblog.com', NULL, 'https://cdn.codepzj.cn/image/20250529174726187.jpeg', 'inactive', '2026-05-30 03:43:36', 'tech', 'f', '', 0, 0, '2026-08-17 08:40:58.943823');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "rss_url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (1, '宇阳 - 春风得意马蹄疾，不信人间有别离', '记录所学知识，缩短和大神的差距！', 'https://liuyuyang.net/', 'https://liuyuyang.net/api/rss', 'https://q1.qlogo.cn/g?b=qq&nk=3311118881&s=640', 'active', '2026-05-30 03:44:04', 'tech', 'f', '', 8, 0, '2026-10-23 01:48:21.986669');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "rss_url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (19, '程序员杨工子', '我是程序员杨工子；练习编程两年半，C#.Net全栈工程师、Mint.Blog(薄荷博客)作者。', 'https://www.yanggongzi.dev', 'https://www.yanggongzi.dev/api/rss', 'https://img.yanggongzi.dev/blog-system/mint-logo.svg', 'active', '2026-10-23 01:18:49', 'tech', 'f', 'YangGongziDev@163.com', 0, 1, '2026-10-28 11:47:40.349755');
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
-- Table structure for blog_resource
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_resource";
CREATE TABLE "public"."blog_resource" (
  "id" int8 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1
),
  "tag_id" int8 NOT NULL,
  "tag_version_id" int8 NOT NULL,
  "title" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::text,
  "url" varchar(2048) COLLATE "pg_catalog"."default" NOT NULL,
  "kind" int2 NOT NULL,
  "is_featured" int2 NOT NULL DEFAULT 0,
  "sort" int8 NOT NULL DEFAULT 0,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0
)
;
ALTER TABLE "public"."blog_resource" OWNER TO "postgres";
COMMENT ON TABLE "public"."blog_resource" IS '单标签单版本资源，通用显式引用真实版本ID';

-- ----------------------------
-- Records of blog_resource
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_resource" ("id", "tag_id", "tag_version_id", "title", "description", "url", "kind", "is_featured", "sort", "create_time", "update_time", "is_deleted") VALUES (1, 2113187978510733313, 94, '系统介绍', '', 'http://www.yanggongzi.dev/articles/2060392182262665216', 1, 0, 0, '2026-10-31 02:02:28.20636', '2026-10-31 02:02:28.20636', 0);
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
INSERT INTO "public"."blog_settings" ("id", "name", "logo", "author", "avatar", "introduction", "copyright_declaration", "github_homepage", "csdn_homepage", "gitee_homepage", "zhihu_homepage", "douyin_homepage", "mail", "is_comment_sensi_word_open", "is_comment_examine_open", "is_auto_theme") VALUES (1, '程序员杨工子', 'https://img.yanggongzi.dev/blog-system/mint-logo.svg', '程序员杨工子', 'https://img.yangmufa.cn/blog-system/author-avatar.jpg', '我是程序员杨工子；练习编程两年半，C#.Net全栈工程师、Mint.Blog(薄荷博客)作者。', '本文为 程序员杨工子 原创文章，遵循 CC BY 4.0 版权协议，转载请附上原文出处和链接。
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
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (384, '2026-10-20', 5, '2026-10-19 00:57:37.549637', '2026-10-20 17:40:19.974999');
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
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (385, '2026-10-21', 1, '2026-10-20 00:57:37.530511', '2026-10-21 04:16:11.460404');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (374, '2026-10-10', 3, '2026-10-09 00:57:37.561913', '2026-10-10 12:57:25.807904');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (376, '2026-10-12', 0, '2026-10-11 00:57:37.567136', '2026-10-11 00:57:37.567136');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (351, '2026-09-17', 27, '2026-09-16 00:57:37.527556', '2026-09-17 17:10:59.184625');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (375, '2026-10-11', 3, '2026-10-10 00:57:37.546973', '2026-10-11 18:01:25.732861');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (352, '2026-09-18', 3, '2026-09-17 00:57:37.524673', '2026-09-18 16:21:23.323054');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (354, '2026-09-20', 0, '2026-09-19 00:57:37.523051', '2026-09-19 00:57:37.523051');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (353, '2026-09-19', 2, '2026-09-18 00:57:37.52167', '2026-09-19 01:25:55.761531');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (355, '2026-09-21', 1, '2026-09-20 00:57:37.51672', '2026-09-21 00:55:22.852883');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (378, '2026-10-14', 0, '2026-10-13 00:57:37.545885', '2026-10-13 00:57:37.545885');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (377, '2026-10-13', 1, '2026-10-12 00:57:37.524775', '2026-10-13 07:27:45.067958');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (380, '2026-10-16', 0, '2026-10-15 00:57:37.547673', '2026-10-15 00:57:37.547673');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (379, '2026-10-15', 3, '2026-10-14 00:57:37.552101', '2026-10-15 04:14:38.337097');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (381, '2026-10-17', 0, '2026-10-16 00:57:37.549305', '2026-10-16 00:57:37.549305');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (382, '2026-10-18', 0, '2026-10-17 00:57:37.546387', '2026-10-17 00:57:37.546387');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (383, '2026-10-19', 0, '2026-10-18 00:57:37.541853', '2026-10-18 00:57:37.541853');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (386, '2026-10-22', 73, '2026-10-21 00:57:37.516136', '2026-10-22 23:00:34.249835');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (393, '2026-10-29', 68, '2026-10-28 00:55:36.893124', '2026-10-29 23:53:59.076939');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (387, '2026-10-23', 5, '2026-10-22 00:57:37.522641', '2026-10-23 10:13:42.761172');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (394, '2026-10-30', 30, '2026-10-29 00:49:13.892771', '2026-10-30 16:17:02.021845');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (391, '2026-10-27', 15, '2026-10-26 00:36:41.668863', '2026-10-27 22:44:23.139013');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (388, '2026-10-24', 23, '2026-10-23 00:45:22.99422', '2026-10-24 14:53:36.178131');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (390, '2026-10-26', 0, '2026-10-25 00:36:41.701522', '2026-10-25 00:36:41.701522');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (389, '2026-10-25', 1, '2026-10-24 00:36:41.725183', '2026-10-25 03:58:54.688751');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (392, '2026-10-28', 65, '2026-10-27 00:36:41.671085', '2026-10-28 23:52:36.994766');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (395, '2026-10-31', 6, '2026-10-30 00:49:13.853226', '2026-10-31 16:28:50.620184');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (397, '2026-11-02', 0, '2026-11-01 04:41:17.335938', '2026-11-01 04:41:17.335987');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (396, '2026-11-01', 2, '2026-10-31 00:49:13.854416', '2026-11-01 06:16:49.856676');
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
  "sort" int8,
  "category_id" int8 NOT NULL,
  "show_in_navigation" int2 NOT NULL DEFAULT 0,
  "logo_url" varchar(2000) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "navigation_description" varchar(500) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying
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
COMMENT ON COLUMN "public"."blog_tag"."category_id" IS '统一分类归属；活跃标签不能属于软删除分类';
COMMENT ON TABLE "public"."blog_tag" IS '文章标签表';

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697656856578, 'Vite', '2026-05-31 02:50:05.359564', '2026-05-31 02:50:05.359564', 0, 0, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697656856577, 'Webpack', '2026-05-31 02:50:05.359564', '2026-05-31 02:50:05.359564', 0, 0, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2059455068285046785, 'TypeScript', '2026-05-27 02:02:05.76163', '2026-05-31 02:28:57.750351', 0, 0, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697661050883, 'ECharts', '2026-05-31 02:50:05.360742', '2026-05-31 02:50:05.360742', 0, 1, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697652662273, 'Node.js', '2026-05-31 02:50:05.358194', '2026-05-31 02:50:05.358194', 0, 1, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697661050882, 'Pinia', '2026-05-31 02:50:05.360595', '2026-05-31 02:50:05.360595', 0, 1, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060394685700116480, 'SCSS', '2026-05-29 16:15:48.010762', '2026-05-29 16:15:48.010762', 0, 1, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060394685679144960, 'Vue', '2026-05-29 16:15:48.000069', '2026-05-29 16:15:48.000069', 0, 2, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466700599296, 'HBase', '2026-05-31 02:37:15.038957', '2026-05-31 02:37:15.038957', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466692210688, 'InfluxDB', '2026-05-31 02:37:15.037825', '2026-05-31 02:37:15.037825', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466696404993, 'Memcached', '2026-05-31 02:37:15.038597', '2026-05-31 02:37:15.038597', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466700599297, 'MongoDB', '2026-05-31 02:37:15.039264', '2026-05-31 02:37:15.039264', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466704793600, 'MySQL', '2026-05-31 02:37:15.040217', '2026-05-31 02:37:15.040217', 0, 3, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060921645828280323, 'MySQL Proxy', '2026-05-31 03:09:45.095555', '2026-05-31 03:09:45.095555', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466700599298, 'Neo4j', '2026-05-31 02:37:15.03932', '2026-05-31 02:37:15.03932', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466700599299, 'NoSQL', '2026-05-31 02:37:15.039597', '2026-05-31 02:37:15.039597', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466885148672, 'Oracle', '2026-05-31 02:37:15.083688', '2026-05-31 02:37:15.083688', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060921645828280325, 'PostgreSQL Proxy', '2026-05-31 03:09:45.095831', '2026-05-31 03:09:45.095831', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466700599300, 'Redis', '2026-05-31 02:37:15.039597', '2026-05-31 02:37:15.039597', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466696404992, 'Spanner', '2026-05-31 02:37:15.038244', '2026-05-31 02:37:15.038244', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466700599301, 'SQL', '2026-05-31 02:37:15.039896', '2026-05-31 02:37:15.039896', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466818039808, 'SQLserver', '2026-05-31 02:37:15.067445', '2026-05-31 02:37:15.067445', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466700599302, 'SQLite', '2026-05-31 02:37:15.039896', '2026-05-31 02:37:15.039896', 0, 1, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466704793601, 'PostgreSQL', '2026-05-31 02:37:15.040217', '2026-05-31 02:37:15.040217', 0, 0, 0, 2059447423109042176, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060921645832474624, 'ActiveMQ', '2026-05-31 03:09:45.096092', '2026-05-31 03:09:45.096092', 0, 0, 0, 2059447483628654592, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060920950798553088, 'Apigee', '2026-05-31 03:06:59.387141', '2026-05-31 03:06:59.387141', 0, 0, 0, 2059447483628654592, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060921645828280320, 'Etcd', '2026-05-31 03:09:45.095174', '2026-05-31 03:09:45.095174', 0, 0, 0, 2059447483628654592, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060921645832474625, 'Kafka', '2026-05-31 03:09:45.096092', '2026-05-31 03:09:45.096092', 0, 0, 0, 2059447483628654592, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060908105616723970, 'Knife4j', '2026-05-31 02:15:56.857645', '2026-05-31 02:15:56.857645', 0, 0, 0, 2059447483628654592, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060920950798553089, 'Kong', '2026-05-31 03:06:59.387106', '2026-05-31 03:06:59.387106', 0, 0, 0, 2059447483628654592, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060921645828280322, 'Nacos', '2026-05-31 03:09:45.095521', '2026-05-31 03:09:45.095521', 0, 0, 0, 2059447483628654592, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060921645828280324, 'RabbitMQ', '2026-05-31 03:09:45.095831', '2026-05-31 03:09:45.095831', 0, 0, 0, 2059447483628654592, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060921645832474626, 'RocketMQ', '2026-05-31 03:09:45.096342', '2026-05-31 03:09:45.096342', 0, 0, 0, 2059447483628654592, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060921645828280321, 'Zookeeper', '2026-05-31 03:09:45.09531', '2026-05-31 03:09:45.09531', 0, 0, 0, 2059447483628654592, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060921645824086016, 'Apache HTTP Server', '2026-05-31 03:09:45.094839', '2026-05-31 03:09:45.094839', 0, 0, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875604172801, 'Docker', '2026-05-31 03:18:36.71514', '2026-05-31 03:18:36.71514', 0, 1, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875566424064, 'GitHub Actions', '2026-05-31 03:18:36.70665', '2026-05-31 03:18:36.70665', 0, 0, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875604172800, 'Jenkins', '2026-05-31 03:18:36.715179', '2026-05-31 03:18:36.715179', 0, 0, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060913466688016384, 'Minio', '2026-05-31 02:37:15.036802', '2026-05-31 02:37:15.036802', 0, 0, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060922150373691392, 'Rider', '2026-05-31 03:11:45.388313', '2026-05-31 03:11:45.388313', 0, 0, 0, 2059448978084335616, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060922150373691395, 'VisualStudio', '2026-05-31 03:11:45.388581', '2026-05-31 03:11:45.388581', 0, 0, 0, 2059448978084335616, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060922150373691396, 'WebStorm', '2026-05-31 03:11:45.38886', '2026-05-31 03:11:45.38886', 0, 1, 0, 2059448978084335616, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060981605832462336, 'C/C++', '2026-05-31 07:08:00.674547', '2026-05-31 07:08:00.674547', 0, 21, 0, 2077756560666398720, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060909793954107392, 'Java', '2026-05-31 02:22:39.388166', '2026-05-31 02:22:39.388166', 0, 0, 0, 2077756560666398720, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2079836577395249152, 'CertBot', '2026-07-22 07:50:56.200819', '2026-07-22 07:50:56.200819', 0, 1, 0, 2067993230846332928, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2079843242735702016, 'Let''sEncrypt', '2026-07-22 08:17:25.344694', '2026-07-22 08:17:25.344694', 0, 0, 0, 2067993230846332928, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060907705274601473, 'ASP.NET Web', '2026-05-31 02:14:21.405572', '2026-05-31 02:14:21.405572', 0, 0, 0, 2059446227048730624, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060907705274601472, 'ASP.NET Web API', '2026-05-30 18:14:21.408016', '2026-05-31 02:14:55.928917', 0, 0, 0, 2059446227048730624, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2052375606020149248, 'C#', '2026-05-06 21:10:50.420397', '2026-05-31 02:22:45.411134', 0, 1, 0, 2059446227048730624, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060908105616723971, 'EntryFramework', '2026-05-31 02:15:56.857668', '2026-05-31 02:15:56.857668', 0, 0, 0, 2059446227048730624, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060908105616723968, 'NSwag', '2026-05-31 02:15:56.857057', '2026-05-31 02:15:56.857057', 0, 0, 0, 2059446227048730624, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060908105616723969, 'Swashbuckle', '2026-05-31 02:15:56.857332', '2026-05-31 02:15:56.857332', 0, 0, 0, 2059446227048730624, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697656856579, 'Ant Design of React', '2026-05-31 02:50:05.359914', '2026-05-31 02:50:05.359914', 0, 0, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697661050881, 'Ant Design of Vue', '2026-05-31 02:50:05.360436', '2026-05-31 02:50:05.360436', 0, 0, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697656856580, 'ElementPlus', '2026-05-31 02:50:05.359931', '2026-05-31 02:50:05.359931', 0, 0, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697652662272, 'HTML', '2026-05-31 02:50:05.358194', '2026-05-31 02:50:05.358194', 0, 0, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697661050880, 'Ionicons', '2026-05-31 02:50:05.36024', '2026-05-31 02:50:05.36024', 0, 0, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697656856576, 'React', '2026-05-31 02:50:05.359061', '2026-05-31 02:50:05.359061', 0, 0, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697665245184, 'Tsparticles', '2026-05-31 02:50:05.361219', '2026-05-31 02:50:05.361219', 0, 0, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060916697661050884, 'Vant', '2026-05-31 02:50:05.360883', '2026-05-31 02:50:05.360883', 0, 0, 0, 2059447031314911232, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060907705270407168, '.Net', '2026-05-30 18:14:21.406541', '2026-06-02 01:53:06.624649', 0, 0, 0, 2059446227048730624, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2061627082869444608, 'SqlSugar', '2026-06-02 01:52:54.391594', '2026-06-02 01:52:54.391594', 0, 0, 0, 2059446227048730624, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2100496363606380544, 'NPOI', '2026-09-17 08:05:33.075317', '2026-09-17 08:05:33.075317', 0, 1, 0, 2059446227048730624, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060992736181489666, 'Avalonia', '2026-05-31 07:52:14.356943', '2026-05-31 07:52:14.356943', 0, 0, 0, 2059446737717825536, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060992736181489665, 'WPF', '2026-05-31 07:52:14.356509', '2026-05-31 07:52:14.356509', 0, 0, 0, 2059446737717825536, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060992736181489664, 'WinFrom', '2026-05-31 07:52:14.356509', '2026-05-31 07:52:14.356509', 0, 1, 0, 2059446737717825536, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875612561410, 'OpenHarmonyMS', '2026-05-31 03:18:36.717366', '2026-05-31 03:18:36.717366', 0, 0, 0, 2059446737717825536, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875612561413, 'OpenHarmonyPC', '2026-05-31 03:18:36.717658', '2026-05-31 03:18:36.717658', 0, 0, 0, 2059446737717825536, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875608367106, 'Tomcat', '2026-05-31 03:18:36.716592', '2026-05-31 03:18:36.716592', 0, 0, 0, 2059447483628654592, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875604172802, 'Git', '2026-05-31 03:18:36.715504', '2026-05-31 03:18:36.715504', 0, 0, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875604172803, 'Kubernetes', '2026-05-31 03:18:36.715834', '2026-05-31 03:18:36.715834', 0, 0, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875612561408, 'Nginx', '2026-05-31 03:18:36.717078', '2026-05-31 03:18:36.717078', 0, 0, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875608367105, 'SFTP', '2026-05-31 03:18:36.716454', '2026-05-31 03:18:36.716454', 0, 0, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875608367108, 'SVN', '2026-05-31 03:18:36.716862', '2026-05-31 03:18:36.716862', 0, 0, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875612561411, 'Unix', '2026-05-31 03:18:36.717366', '2026-05-31 03:18:36.717366', 0, 0, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875633532928, 'FTP', '2026-05-31 03:18:36.722598', '2026-05-31 03:18:36.722598', 0, 2, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875608367104, 'MacOS', '2026-05-31 03:18:36.716149', '2026-05-31 03:18:36.716149', 0, 0, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060992059724140544, 'Network', '2026-05-31 07:49:33.076561', '2026-05-31 07:49:33.076561', 0, 1, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875612561412, 'Windows', '2026-05-31 03:18:36.71762', '2026-05-31 03:18:36.71762', 0, 0, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2113187978510733312, 'RockyLinux', '2026-10-22 08:37:29.868477', '2026-10-22 08:37:29.868477', 0, 1, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2068309963293462528, 'RustFS', '2026-06-20 12:28:17.246347', '2026-06-20 12:28:17.246347', 0, 1, 0, 2059448449551699968, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060922150373691394, 'IntelliJ IDEA', '2026-05-31 03:11:45.388581', '2026-05-31 03:11:45.388581', 0, 0, 0, 2059448978084335616, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060922150369497088, 'Notepad', '2026-05-31 03:11:45.387899', '2026-05-31 03:11:45.387899', 0, 0, 0, 2059448978084335616, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875612561414, 'Parallels Desktop', '2026-05-31 03:18:36.717892', '2026-05-31 03:18:36.717892', 0, 0, 0, 2059448978084335616, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875612561415, 'VisualBox', '2026-05-31 03:18:36.717892', '2026-05-31 03:18:36.717892', 0, 0, 0, 2059448978084335616, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060923875608367107, 'VMWare', '2026-05-31 03:18:36.716745', '2026-05-31 03:18:36.716745', 0, 0, 0, 2059448978084335616, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060922150373691393, 'VSCoode', '2026-05-31 03:11:45.388309', '2026-05-31 03:11:45.388309', 0, 0, 0, 2059448978084335616, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2060922150369497089, 'Markdon', '2026-05-31 03:11:45.387899', '2026-05-31 03:11:45.387899', 0, 0, 0, 2059448978084335616, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2077756628832227328, 'English', '2026-07-16 14:05:57.821251', '2026-07-16 14:05:57.821251', 0, 1, 0, 2077756560666398720, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2113187978510733314, 'JASS', '2026-10-30 15:28:37.993624', '2026-10-30 15:28:37.993624', 0, 1, 0, 2077756560666398720, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2067992442828886016, 'AllinSSL', '2026-06-19 07:26:34.468014', '2026-06-19 15:36:32.108449', 0, 1, 0, 2067993230846332928, 0, '', '');
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort", "category_id", "show_in_navigation", "logo_url", "navigation_description") VALUES (2113187978510733313, 'Mint.Blog', '2026-10-30 15:28:37.993624', '2026-10-31 02:05:31.801873', 0, 1, 0, 2059454849011027968, 1, 'https://img.yanggongzi.dev/blog-system/mint-logo.svg', '');
COMMIT;

-- ----------------------------
-- Table structure for blog_tag_version
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_tag_version";
CREATE TABLE "public"."blog_tag_version" (
  "id" int8 NOT NULL GENERATED BY DEFAULT AS IDENTITY (
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1
),
  "tag_id" int8 NOT NULL,
  "name" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "is_general" int2 NOT NULL DEFAULT 0,
  "sort" int8 NOT NULL DEFAULT 0,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0
)
;
ALTER TABLE "public"."blog_tag_version" OWNER TO "postgres";
COMMENT ON TABLE "public"."blog_tag_version" IS '真实版本；每标签一条通用版本，应用同事务创建并禁止删除通用版本';

-- ----------------------------
-- Records of blog_tag_version
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (1, 2052375606020149248, '通用', 1, 0, '2026-05-06 21:10:50.420397', '2026-05-31 02:22:45.411134', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (2, 2059455068285046785, '通用', 1, 0, '2026-05-27 02:02:05.76163', '2026-05-31 02:28:57.750351', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (3, 2060394685679144960, '通用', 1, 0, '2026-05-29 16:15:48.000069', '2026-05-29 16:15:48.000069', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (4, 2060394685700116480, '通用', 1, 0, '2026-05-29 16:15:48.010762', '2026-05-29 16:15:48.010762', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (5, 2060907705270407168, '通用', 1, 0, '2026-05-30 18:14:21.406541', '2026-06-02 01:53:06.624649', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (6, 2060907705274601472, '通用', 1, 0, '2026-05-30 18:14:21.408016', '2026-05-31 02:14:55.928917', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (7, 2060907705274601473, '通用', 1, 0, '2026-05-31 02:14:21.405572', '2026-05-31 02:14:21.405572', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (8, 2060908105616723968, '通用', 1, 0, '2026-05-31 02:15:56.857057', '2026-05-31 02:15:56.857057', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (9, 2060908105616723969, '通用', 1, 0, '2026-05-31 02:15:56.857332', '2026-05-31 02:15:56.857332', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (10, 2060908105616723970, '通用', 1, 0, '2026-05-31 02:15:56.857645', '2026-05-31 02:15:56.857645', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (11, 2060908105616723971, '通用', 1, 0, '2026-05-31 02:15:56.857668', '2026-05-31 02:15:56.857668', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (12, 2060909793954107392, '通用', 1, 0, '2026-05-31 02:22:39.388166', '2026-05-31 02:22:39.388166', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (13, 2060913466688016384, '通用', 1, 0, '2026-05-31 02:37:15.036802', '2026-05-31 02:37:15.036802', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (14, 2060913466692210688, '通用', 1, 0, '2026-05-31 02:37:15.037825', '2026-05-31 02:37:15.037825', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (15, 2060913466696404992, '通用', 1, 0, '2026-05-31 02:37:15.038244', '2026-05-31 02:37:15.038244', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (16, 2060913466696404993, '通用', 1, 0, '2026-05-31 02:37:15.038597', '2026-05-31 02:37:15.038597', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (17, 2060913466700599296, '通用', 1, 0, '2026-05-31 02:37:15.038957', '2026-05-31 02:37:15.038957', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (18, 2060913466700599297, '通用', 1, 0, '2026-05-31 02:37:15.039264', '2026-05-31 02:37:15.039264', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (19, 2060913466700599298, '通用', 1, 0, '2026-05-31 02:37:15.03932', '2026-05-31 02:37:15.03932', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (20, 2060913466700599299, '通用', 1, 0, '2026-05-31 02:37:15.039597', '2026-05-31 02:37:15.039597', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (21, 2060913466700599300, '通用', 1, 0, '2026-05-31 02:37:15.039597', '2026-05-31 02:37:15.039597', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (22, 2060913466700599301, '通用', 1, 0, '2026-05-31 02:37:15.039896', '2026-05-31 02:37:15.039896', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (23, 2060913466700599302, '通用', 1, 0, '2026-05-31 02:37:15.039896', '2026-05-31 02:37:15.039896', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (24, 2060913466704793600, '通用', 1, 0, '2026-05-31 02:37:15.040217', '2026-05-31 02:37:15.040217', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (25, 2060913466704793601, '通用', 1, 0, '2026-05-31 02:37:15.040217', '2026-05-31 02:37:15.040217', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (26, 2060913466818039808, '通用', 1, 0, '2026-05-31 02:37:15.067445', '2026-05-31 02:37:15.067445', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (27, 2060913466885148672, '通用', 1, 0, '2026-05-31 02:37:15.083688', '2026-05-31 02:37:15.083688', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (28, 2060916697652662272, '通用', 1, 0, '2026-05-31 02:50:05.358194', '2026-05-31 02:50:05.358194', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (29, 2060916697652662273, '通用', 1, 0, '2026-05-31 02:50:05.358194', '2026-05-31 02:50:05.358194', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (30, 2060916697656856576, '通用', 1, 0, '2026-05-31 02:50:05.359061', '2026-05-31 02:50:05.359061', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (31, 2060916697656856577, '通用', 1, 0, '2026-05-31 02:50:05.359564', '2026-05-31 02:50:05.359564', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (32, 2060916697656856578, '通用', 1, 0, '2026-05-31 02:50:05.359564', '2026-05-31 02:50:05.359564', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (33, 2060916697656856579, '通用', 1, 0, '2026-05-31 02:50:05.359914', '2026-05-31 02:50:05.359914', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (34, 2060916697656856580, '通用', 1, 0, '2026-05-31 02:50:05.359931', '2026-05-31 02:50:05.359931', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (35, 2060916697661050880, '通用', 1, 0, '2026-05-31 02:50:05.36024', '2026-05-31 02:50:05.36024', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (36, 2060916697661050881, '通用', 1, 0, '2026-05-31 02:50:05.360436', '2026-05-31 02:50:05.360436', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (37, 2060916697661050882, '通用', 1, 0, '2026-05-31 02:50:05.360595', '2026-05-31 02:50:05.360595', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (38, 2060916697661050883, '通用', 1, 0, '2026-05-31 02:50:05.360742', '2026-05-31 02:50:05.360742', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (39, 2060916697661050884, '通用', 1, 0, '2026-05-31 02:50:05.360883', '2026-05-31 02:50:05.360883', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (40, 2060916697665245184, '通用', 1, 0, '2026-05-31 02:50:05.361219', '2026-05-31 02:50:05.361219', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (41, 2060920950798553088, '通用', 1, 0, '2026-05-31 03:06:59.387141', '2026-05-31 03:06:59.387141', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (42, 2060920950798553089, '通用', 1, 0, '2026-05-31 03:06:59.387106', '2026-05-31 03:06:59.387106', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (43, 2060921645824086016, '通用', 1, 0, '2026-05-31 03:09:45.094839', '2026-05-31 03:09:45.094839', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (44, 2060921645828280320, '通用', 1, 0, '2026-05-31 03:09:45.095174', '2026-05-31 03:09:45.095174', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (45, 2060921645828280321, '通用', 1, 0, '2026-05-31 03:09:45.09531', '2026-05-31 03:09:45.09531', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (46, 2060921645828280322, '通用', 1, 0, '2026-05-31 03:09:45.095521', '2026-05-31 03:09:45.095521', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (47, 2060921645828280323, '通用', 1, 0, '2026-05-31 03:09:45.095555', '2026-05-31 03:09:45.095555', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (48, 2060921645828280324, '通用', 1, 0, '2026-05-31 03:09:45.095831', '2026-05-31 03:09:45.095831', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (49, 2060921645828280325, '通用', 1, 0, '2026-05-31 03:09:45.095831', '2026-05-31 03:09:45.095831', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (50, 2060921645832474624, '通用', 1, 0, '2026-05-31 03:09:45.096092', '2026-05-31 03:09:45.096092', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (51, 2060921645832474625, '通用', 1, 0, '2026-05-31 03:09:45.096092', '2026-05-31 03:09:45.096092', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (52, 2060921645832474626, '通用', 1, 0, '2026-05-31 03:09:45.096342', '2026-05-31 03:09:45.096342', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (53, 2060922150369497088, '通用', 1, 0, '2026-05-31 03:11:45.387899', '2026-05-31 03:11:45.387899', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (54, 2060922150369497089, '通用', 1, 0, '2026-05-31 03:11:45.387899', '2026-05-31 03:11:45.387899', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (55, 2060922150373691392, '通用', 1, 0, '2026-05-31 03:11:45.388313', '2026-05-31 03:11:45.388313', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (56, 2060922150373691393, '通用', 1, 0, '2026-05-31 03:11:45.388309', '2026-05-31 03:11:45.388309', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (57, 2060922150373691394, '通用', 1, 0, '2026-05-31 03:11:45.388581', '2026-05-31 03:11:45.388581', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (58, 2060922150373691395, '通用', 1, 0, '2026-05-31 03:11:45.388581', '2026-05-31 03:11:45.388581', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (59, 2060922150373691396, '通用', 1, 0, '2026-05-31 03:11:45.38886', '2026-05-31 03:11:45.38886', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (60, 2060923875566424064, '通用', 1, 0, '2026-05-31 03:18:36.70665', '2026-05-31 03:18:36.70665', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (61, 2060923875604172800, '通用', 1, 0, '2026-05-31 03:18:36.715179', '2026-05-31 03:18:36.715179', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (62, 2060923875604172801, '通用', 1, 0, '2026-05-31 03:18:36.71514', '2026-05-31 03:18:36.71514', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (63, 2060923875604172802, '通用', 1, 0, '2026-05-31 03:18:36.715504', '2026-05-31 03:18:36.715504', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (64, 2060923875604172803, '通用', 1, 0, '2026-05-31 03:18:36.715834', '2026-05-31 03:18:36.715834', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (65, 2060923875608367104, '通用', 1, 0, '2026-05-31 03:18:36.716149', '2026-05-31 03:18:36.716149', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (66, 2060923875608367105, '通用', 1, 0, '2026-05-31 03:18:36.716454', '2026-05-31 03:18:36.716454', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (67, 2060923875608367106, '通用', 1, 0, '2026-05-31 03:18:36.716592', '2026-05-31 03:18:36.716592', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (68, 2060923875608367107, '通用', 1, 0, '2026-05-31 03:18:36.716745', '2026-05-31 03:18:36.716745', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (69, 2060923875608367108, '通用', 1, 0, '2026-05-31 03:18:36.716862', '2026-05-31 03:18:36.716862', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (70, 2060923875612561408, '通用', 1, 0, '2026-05-31 03:18:36.717078', '2026-05-31 03:18:36.717078', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (71, 2060923875612561410, '通用', 1, 0, '2026-05-31 03:18:36.717366', '2026-05-31 03:18:36.717366', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (72, 2060923875612561411, '通用', 1, 0, '2026-05-31 03:18:36.717366', '2026-05-31 03:18:36.717366', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (73, 2060923875612561412, '通用', 1, 0, '2026-05-31 03:18:36.71762', '2026-05-31 03:18:36.71762', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (74, 2060923875612561413, '通用', 1, 0, '2026-05-31 03:18:36.717658', '2026-05-31 03:18:36.717658', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (75, 2060923875612561414, '通用', 1, 0, '2026-05-31 03:18:36.717892', '2026-05-31 03:18:36.717892', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (76, 2060923875612561415, '通用', 1, 0, '2026-05-31 03:18:36.717892', '2026-05-31 03:18:36.717892', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (77, 2060923875633532928, '通用', 1, 0, '2026-05-31 03:18:36.722598', '2026-05-31 03:18:36.722598', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (78, 2060981605832462336, '通用', 1, 0, '2026-05-31 07:08:00.674547', '2026-05-31 07:08:00.674547', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (79, 2060992059724140544, '通用', 1, 0, '2026-05-31 07:49:33.076561', '2026-05-31 07:49:33.076561', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (80, 2060992736181489664, '通用', 1, 0, '2026-05-31 07:52:14.356509', '2026-05-31 07:52:14.356509', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (81, 2060992736181489665, '通用', 1, 0, '2026-05-31 07:52:14.356509', '2026-05-31 07:52:14.356509', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (82, 2060992736181489666, '通用', 1, 0, '2026-05-31 07:52:14.356943', '2026-05-31 07:52:14.356943', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (83, 2061627082869444608, '通用', 1, 0, '2026-06-02 01:52:54.391594', '2026-06-02 01:52:54.391594', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (84, 2067992442828886016, '通用', 1, 0, '2026-06-19 07:26:34.468014', '2026-06-19 15:36:32.108449', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (85, 2068309963293462528, '通用', 1, 0, '2026-06-20 12:28:17.246347', '2026-06-20 12:28:17.246347', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (86, 2077756628832227328, '通用', 1, 0, '2026-07-16 14:05:57.821251', '2026-07-16 14:05:57.821251', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (87, 2079836577395249152, '通用', 1, 0, '2026-07-22 07:50:56.200819', '2026-07-22 07:50:56.200819', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (88, 2079843242735702016, '通用', 1, 0, '2026-07-22 08:17:25.344694', '2026-07-22 08:17:25.344694', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (89, 2100496363606380544, '通用', 1, 0, '2026-09-17 08:05:33.075317', '2026-09-17 08:05:33.075317', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (90, 2113187978510733312, '通用', 1, 0, '2026-10-22 08:37:29.868477', '2026-10-22 08:37:29.868477', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (92, 2113187978510733314, '通用', 1, 0, '2026-10-30 15:28:37.993624', '2026-10-30 15:28:37.993624', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (93, 2113187978510733313, 'mint-blog-v1-java', 0, 1000, '2026-10-31 01:37:18.546665', '2026-10-31 02:36:51.880312', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (94, 2113187978510733313, 'mint-blog-v2-ddd', 0, 999, '2026-10-31 01:37:27.804189', '2026-10-31 02:36:59.913587', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (91, 2113187978510733313, '通用', 1, 0, '2026-10-30 15:28:37.993624', '2026-10-31 02:37:39.236574', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (95, 2113187978510733313, 'mint-blog-v3', 0, 998, '2026-10-31 01:38:42.490149', '2026-10-31 02:55:50.982934', 0);
INSERT INTO "public"."blog_tag_version" ("id", "tag_id", "name", "is_general", "sort", "create_time", "update_time", "is_deleted") VALUES (96, 2113187978510733313, 'mint-blog-v4', 0, 997, '2026-10-31 01:41:24.865624', '2026-10-31 02:56:00.842679', 1);
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
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (1, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/admin/setting", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 44, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/admin/setting"}', '2026-10-22 17:52:36.25945+00', '2026-10-22 17:52:36.25945+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (2, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 362, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/auth/login"}', '2026-10-22 17:52:46.24235+00', '2026-10-22 17:52:46.24235+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (3, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 306, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/auth/login"}', '2026-10-22 17:53:12.310521+00', '2026-10-22 17:53:12.310521+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (4, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 74, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-22 17:54:19.511019+00', '2026-10-22 17:54:19.511019+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (5, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 10, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-22 17:54:34.968432+00', '2026-10-22 17:54:34.968432+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (6, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 NetType/WIFI MicroMessenger/7.0.20.1781(0x6700143B) MacWechat/3.8.7(0x13080712) UnifiedPCMacWechat(0xf2641d55) XWEB/25511 Flue", "message": "成功", "duration": 32, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-22 17:57:40.468825+00', '2026-10-22 17:57:40.468825+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (7, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 26_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.78(0x18004e33) NetType/WIFI Language/zh_CN", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-22 18:01:34.090403+00', '2026-10-22 18:01:34.090403+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (8, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 26_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.78(0x18004e33) NetType/WIFI Language/zh_CN", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-22 18:01:37.480334+00', '2026-10-22 18:01:37.480334+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (9, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 26_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.78(0x18004e33) NetType/WIFI Language/zh_CN", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-22 18:01:40.225806+00', '2026-10-22 18:01:40.225806+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (10, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 26_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.78(0x18004e33) NetType/WIFI Language/zh_CN", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-22 18:01:46.780028+00', '2026-10-22 18:01:46.780028+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (11, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 26_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.78(0x18004e33) NetType/4G Language/zh_CN", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-22 18:04:13.020765+00', '2026-10-22 18:04:13.020765+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (12, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 26_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.78(0x18004e33) NetType/4G Language/zh_CN", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-22 18:04:20.219192+00', '2026-10-22 18:04:20.219192+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (13, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 26_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.78(0x18004e33) NetType/4G Language/zh_CN", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-22 18:04:22.822778+00', '2026-10-22 18:04:22.822778+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (14, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 26_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.78(0x18004e33) NetType/4G Language/zh_CN", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-22 18:04:24.761904+00', '2026-10-22 18:04:24.761904+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (15, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 26_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.78(0x18004e33) NetType/4G Language/zh_CN", "message": "成功", "duration": 42, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-22 18:05:37.461214+00', '2026-10-22 18:05:37.461214+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (16, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 16; PKT110 Build/BP2A.250605.015; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/146.0.7680.178 Mobile Safari/537.36 XWEB/1460249 MMWEBSDK/20251101 MMWEBID/5179 MicroMessenger/8.0.67.3000(0x28004351) WeChat/arm64 ", "message": "成功", "duration": 77, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-22 20:50:44.021405+00', '2026-10-22 20:50:44.021405+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (17, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-22 21:00:27.38775+00', '2026-10-22 21:00:27.38775+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (18, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:133.0) Gecko/20100101 Firefox/133.0", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-22 21:00:52.474482+00', '2026-10-22 21:00:52.474482+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (19, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 16; 2304FPN6DC Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.189 Mobile Safari/537.36 XWEB/1500145 MMWEBSDK/20260902 MMWEBID/8643 REV/7a621aa6f3b566344674877fd5a3408da08eb22a ", "message": "成功", "duration": 22, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-22 23:00:34.243369+00', '2026-10-22 23:00:34.243369+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (20, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 16; 2304FPN6DC Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.189 Mobile Safari/537.36 XWEB/1500145 MMWEBSDK/20260902 MMWEBID/8643 REV/7a621aa6f3b566344674877fd5a3408da08eb22a ", "message": "成功", "duration": 307, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/auth/login"}', '2026-10-22 23:01:47.06637+00', '2026-10-22 23:01:47.06637+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (21, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 16; 2304FPN6DC Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.189 Mobile Safari/537.36 XWEB/1500145 MMWEBSDK/20260902 MMWEBID/8643 REV/7a621aa6f3b566344674877fd5a3408da08eb22a ", "message": "成功", "duration": 5, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/blog/surfer/article/list"}', '2026-10-22 23:02:12.671577+00', '2026-10-22 23:02:12.671577+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (22, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 16; 2304FPN6DC Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.189 Mobile Safari/537.36 XWEB/1500145 MMWEBSDK/20260902 MMWEBID/8643 REV/7a621aa6f3b566344674877fd5a3408da08eb22a ", "message": "成功", "duration": 5, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/blog/surfer/article/list"}', '2026-10-22 23:02:35.544773+00', '2026-10-22 23:02:35.544773+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (23, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 16; 2304FPN6DC Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.189 Mobile Safari/537.36 XWEB/1500145 MMWEBSDK/20260902 MMWEBID/8643 REV/7a621aa6f3b566344674877fd5a3408da08eb22a ", "message": "成功", "duration": 5, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/blog/surfer/article/list"}', '2026-10-22 23:02:37.995088+00', '2026-10-22 23:02:37.995088+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (24, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 16; 2304FPN6DC Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.189 Mobile Safari/537.36 XWEB/1500145 MMWEBSDK/20260902 MMWEBID/8643 REV/7a621aa6f3b566344674877fd5a3408da08eb22a ", "message": "成功", "duration": 7, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/blog/surfer/article/list"}', '2026-10-22 23:03:00.306437+00', '2026-10-22 23:03:00.306437+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (25, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 16; 2304FPN6DC Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.189 Mobile Safari/537.36 XWEB/1500145 MMWEBSDK/20260902 MMWEBID/8643 REV/7a621aa6f3b566344674877fd5a3408da08eb22a ", "message": "成功", "duration": 4, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/blog/surfer/article/list"}', '2026-10-22 23:03:01.098554+00', '2026-10-22 23:03:01.098554+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (26, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 15; 24117RK2CC Build/AQ3A.240829.003; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.189 Mobile Safari/537.36 XWEB/1500145 MMWEBSDK/20260902 MMWEBID/2124 REV/d7a7151b615ac57c960e3558342f5b11ab5762d7 Mic", "message": "成功", "duration": 112, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-23 00:11:10.14497+00', '2026-10-23 00:11:10.14497+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (27, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 44, "errorMsg": "", "username": "", "description": "/api/auth/refresh"}', '2026-10-23 00:50:45.708678+00', '2026-10-23 00:50:45.708678+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (28, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 22, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-23 00:50:45.895837+00', '2026-10-23 00:50:45.895837+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (29, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 6, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/detail"}', '2026-10-23 00:50:57.638952+00', '2026-10-23 00:50:57.638952+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (30, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 18, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-23 01:03:52.816571+00', '2026-10-23 01:03:52.816571+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (31, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36 Edg/155.0.0.0", "message": "成功", "duration": 13, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-23 01:11:05.041408+00', '2026-10-23 01:11:05.041408+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (32, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 99, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-23 01:18:14.558846+00', '2026-10-23 01:18:14.558846+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (33, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/friend", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 47, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/friend"}', '2026-10-23 01:18:48.576972+00', '2026-10-23 01:18:48.576972+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (34, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/admin/friend/19/status", "action": "update", "method": "PATCH", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 66, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/admin/friend/19/status"}', '2026-10-23 01:19:06.410063+00', '2026-10-23 01:19:06.410063+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (35, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 19, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-23 01:19:10.132594+00', '2026-10-23 01:19:10.132594+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (36, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 75, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-23 01:48:05.357179+00', '2026-10-23 01:48:05.357179+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (37, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/admin/friend/1", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 68, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/admin/friend/1"}', '2026-10-23 01:48:22.032654+00', '2026-10-23 01:48:22.032654+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (38, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36 Edg/155.0.0.0", "message": "成功", "duration": 38, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-23 02:41:17.530279+00', '2026-10-23 02:41:17.530279+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (39, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36 Edg/155.0.0.0", "message": "成功", "duration": 31, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-23 02:41:43.96523+00', '2026-10-23 02:41:43.96523+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (40, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36 Edg/155.0.0.0", "message": "成功", "duration": 41, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-23 02:42:32.849635+00', '2026-10-23 02:42:32.849635+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (41, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Sogou web spider/4.0(+http://www.sogou.com/docs/help/webmasters.htm#07)", "message": "成功", "duration": 58, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-23 02:55:10.222993+00', '2026-10-23 02:55:10.222993+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (42, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-23 04:07:15.521169+00', '2026-10-23 04:07:15.521169+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (43, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 27_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.75(0x18004b66) NetType/4G Language/zh_CN", "message": "成功", "duration": 23, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-23 04:17:21.696154+00', '2026-10-23 04:17:21.696154+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (44, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 35, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-23 04:19:42.625724+00', '2026-10-23 04:19:42.625724+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (45, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-23 04:20:19.666485+00', '2026-10-23 04:20:19.666485+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (46, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/143.0.0.0 Safari/537.36", "message": "成功", "duration": 34, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-23 04:30:55.560827+00', '2026-10-23 04:30:55.560827+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (47, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 26_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.78(0x18004e33) NetType/4G Language/zh_CN", "message": "成功", "duration": 63, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-23 10:13:42.76605+00', '2026-10-23 10:13:42.76605+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (48, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 40, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-23 16:09:50.490422+00', '2026-10-23 16:09:50.490422+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (49, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 19, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-23 16:24:04.529337+00', '2026-10-23 16:24:04.529337+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (50, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/143.0.0.0 Safari/537.36", "message": "成功", "duration": 36, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-23 16:33:08.182283+00', '2026-10-23 16:33:08.182283+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (51, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36", "message": "成功", "duration": 29, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 01:51:19.808145+00', '2026-10-24 01:51:19.808145+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (52, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 79, "errorMsg": "", "username": "", "description": "/api/auth/refresh"}', '2026-10-24 03:32:34.217169+00', '2026-10-24 03:32:34.217169+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (53, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 22, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 03:32:34.677586+00', '2026-10-24 03:32:34.677586+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (54, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 9, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 03:32:56.531356+00', '2026-10-24 03:32:56.531356+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (55, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 7, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 03:33:01.116778+00', '2026-10-24 03:33:01.116778+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (56, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 04:07:29.834832+00', '2026-10-24 04:07:29.834832+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (57, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 18, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 04:14:13.843312+00', '2026-10-24 04:14:13.843312+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (58, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 41, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 04:21:36.072909+00', '2026-10-24 04:21:36.072909+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (59, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/143.0.0.0 Safari/537.36", "message": "成功", "duration": 31, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 04:29:40.986586+00', '2026-10-24 04:29:40.986586+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (60, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 30, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 05:11:26.285937+00', '2026-10-24 05:11:26.285937+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (61, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 7, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 05:11:28.927992+00', '2026-10-24 05:11:28.927992+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (62, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 11, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 05:11:30.635267+00', '2026-10-24 05:11:30.635267+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (63, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 34, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 05:27:56.035791+00', '2026-10-24 05:27:56.035791+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (64, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 14, "errorMsg": "", "username": "", "description": "/api/auth/refresh"}', '2026-10-24 06:06:24.239797+00', '2026-10-24 06:06:24.239797+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (65, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 33, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 06:06:24.784234+00', '2026-10-24 06:06:24.784234+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (66, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 13, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 06:06:26.060509+00', '2026-10-24 06:06:26.060509+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (67, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 5, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 06:07:11.236626+00', '2026-10-24 06:07:11.236626+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (68, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 11, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 06:07:12.666001+00', '2026-10-24 06:07:12.666001+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (69, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/api/blog/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 19, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/api/blog/surfer/category/article/list"}', '2026-10-24 06:07:17.898157+00', '2026-10-24 06:07:17.898157+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (70, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/api/blog/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 22, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/api/blog/surfer/category/article/list"}', '2026-10-24 06:07:17.898096+00', '2026-10-24 06:07:17.898096+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (71, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/api/blog/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 15, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/api/blog/surfer/tag/article/list"}', '2026-10-24 06:07:20.944515+00', '2026-10-24 06:07:20.944515+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (72, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/api/blog/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 13, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/api/blog/surfer/tag/article/list"}', '2026-10-24 06:07:20.944865+00', '2026-10-24 06:07:20.944865+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (73, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 20, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/archive/list"}', '2026-10-24 06:08:20.57046+00', '2026-10-24 06:08:20.57046+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (74, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 32, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 06:22:52.122867+00', '2026-10-24 06:22:52.122867+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (75, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 6, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 06:22:55.712594+00', '2026-10-24 06:22:55.712594+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (76, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 5, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 06:22:58.93127+00', '2026-10-24 06:22:58.93127+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (132, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 361, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 14:51:36.006684+00', '2026-10-24 14:51:36.006684+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (77, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 7, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 06:23:02.250427+00', '2026-10-24 06:23:02.250427+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (78, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 5, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 06:23:07.756866+00', '2026-10-24 06:23:07.756866+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (79, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 18, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/blog/surfer/article/list"}', '2026-10-24 06:31:15.129249+00', '2026-10-24 06:31:15.129249+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (80, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36 Edg/155.0.0.0", "message": "成功", "duration": 35, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 07:12:03.6946+00', '2026-10-24 07:12:03.6946+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (81, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36 Edg/155.0.0.0", "message": "成功", "duration": 24, "errorMsg": "", "username": "", "description": "/api/blog/surfer/message/list"}', '2026-10-24 07:12:30.669342+00', '2026-10-24 07:12:30.669342+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (82, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/api/blog/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36 Edg/155.0.0.0", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/api/blog/surfer/tag/article/list"}', '2026-10-24 07:12:44.28411+00', '2026-10-24 07:12:44.28411+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (83, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/api/blog/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36 Edg/155.0.0.0", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/api/blog/surfer/tag/article/list"}', '2026-10-24 07:12:44.292483+00', '2026-10-24 07:12:44.292483+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (84, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36", "message": "成功", "duration": 39, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 07:25:44.570263+00', '2026-10-24 07:25:44.570263+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (85, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 20, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 07:51:35.726979+00', '2026-10-24 07:51:35.726979+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (86, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 07:51:46.230401+00', '2026-10-24 07:51:46.230401+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (87, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 22, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 07:57:39.314015+00', '2026-10-24 07:57:39.314015+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (88, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 07:57:44.683866+00', '2026-10-24 07:57:44.683866+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (89, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/api/blog/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/api/blog/surfer/category/article/list"}', '2026-10-24 08:10:00.463065+00', '2026-10-24 08:10:00.463065+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (90, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/api/blog/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/api/blog/surfer/category/article/list"}', '2026-10-24 08:10:00.464185+00', '2026-10-24 08:10:00.464185+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (91, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 14, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 08:10:01.503906+00', '2026-10-24 08:10:01.503906+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (92, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 08:10:03.404+00', '2026-10-24 08:10:03.404+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (93, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 08:10:04.297555+00', '2026-10-24 08:10:04.297555+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (94, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 08:10:05.134655+00', '2026-10-24 08:10:05.134655+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (96, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 13, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 08:10:07.193032+00', '2026-10-24 08:10:07.193032+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (95, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 12, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 08:10:06.195265+00', '2026-10-24 08:10:06.195265+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (97, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 08:10:07.916521+00', '2026-10-24 08:10:07.916521+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (98, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 08:10:08.729931+00', '2026-10-24 08:10:08.729931+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (99, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 08:10:09.44292+00', '2026-10-24 08:10:09.44292+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (100, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 08:10:12.499304+00', '2026-10-24 08:10:12.499304+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (101, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36", "message": "成功", "duration": 18, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 08:21:15.790675+00', '2026-10-24 08:21:15.790675+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (102, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 08:39:39.65927+00', '2026-10-24 08:39:39.65927+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (103, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36", "message": "成功", "duration": 32, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 10:06:48.313965+00', '2026-10-24 10:06:48.313965+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (104, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 10:07:14.442813+00', '2026-10-24 10:07:14.442813+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (105, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 10:07:32.054679+00', '2026-10-24 10:07:32.054679+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (106, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 15, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 10:54:34.659975+00', '2026-10-24 10:54:34.659975+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (107, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 30, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 11:08:45.229602+00', '2026-10-24 11:08:45.229602+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (108, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 12, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 11:49:14.129064+00', '2026-10-24 11:49:14.129064+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (197, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 16:57:36.818896+00', '2026-10-27 16:57:36.818896+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (109, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/155.1 Mobile/15E148 Safari/604.1", "message": "成功", "duration": 15, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 12:24:26.559523+00', '2026-10-24 12:24:26.559523+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (110, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 13:06:22.445991+00', '2026-10-24 13:06:22.445991+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (111, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 13:07:21.551053+00', '2026-10-24 13:07:21.551053+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (112, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/155.1 Mobile/15E148 Safari/604.1", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 13:09:48.710651+00', '2026-10-24 13:09:48.710651+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (113, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/155.1 Mobile/15E148 Safari/604.1", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 13:18:32.919234+00', '2026-10-24 13:18:32.919234+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (114, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/155.1 Mobile/15E148 Safari/604.1", "message": "成功", "duration": 18, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 13:40:11.535479+00', '2026-10-24 13:40:11.535479+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (115, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 559, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 14:39:45.638853+00', '2026-10-24 14:39:45.638853+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (116, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 280, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 14:39:49.409429+00', '2026-10-24 14:39:49.409429+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (117, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 298, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 14:40:01.582762+00', '2026-10-24 14:40:01.582762+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (118, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 389, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 14:40:14.32476+00', '2026-10-24 14:40:14.32476+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (119, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 290, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 14:40:31.702667+00', '2026-10-24 14:40:31.702667+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (120, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 287, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 14:40:37.027699+00', '2026-10-24 14:40:37.027699+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (121, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 309, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 14:46:30.572842+00', '2026-10-24 14:46:30.572842+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (122, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 144, "errorMsg": "", "username": "", "description": "/api/blog/surfer/archive/list"}', '2026-10-24 14:46:41.748647+00', '2026-10-24 14:46:41.748647+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (123, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/api/blog/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 368, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/api/blog/surfer/tag/article/list"}', '2026-10-24 14:46:48.476112+00', '2026-10-24 14:46:48.476112+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (124, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/api/blog/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 361, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/api/blog/surfer/category/article/list"}', '2026-10-24 14:46:56.673644+00', '2026-10-24 14:46:56.673644+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (125, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 102, "errorMsg": "", "username": "", "description": "/api/blog/surfer/archive/list"}', '2026-10-24 14:47:02.243811+00', '2026-10-24 14:47:02.243811+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (126, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 97, "errorMsg": "", "username": "", "description": "/api/blog/surfer/archive/list"}', '2026-10-24 14:47:11.463987+00', '2026-10-24 14:47:11.463987+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (127, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 166, "errorMsg": "", "username": "", "description": "/api/blog/surfer/archive/list"}', '2026-10-24 14:47:16.852054+00', '2026-10-24 14:47:16.852054+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (128, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "fail", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "请求失败", "duration": 256, "errorMsg": "refresh_token_invalid", "username": "", "description": "/api/auth/refresh"}', '2026-10-24 14:50:16.749746+00', '2026-10-24 14:50:16.749746+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (129, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/auth/logout", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 60, "errorMsg": "", "username": "", "description": "/api/auth/logout"}', '2026-10-24 14:50:16.857155+00', '2026-10-24 14:50:16.857155+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (130, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 246, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 14:51:14.624261+00', '2026-10-24 14:51:14.624261+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (131, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 294, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 14:51:20.378867+00', '2026-10-24 14:51:20.378867+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (133, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/155.1 Mobile/15E148 Safari/604.1", "message": "成功", "duration": 16, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 14:51:58.65879+00', '2026-10-24 14:51:58.65879+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (134, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 93, "errorMsg": "", "username": "", "description": "/api/blog/surfer/archive/list"}', '2026-10-24 14:52:34.878663+00', '2026-10-24 14:52:34.878663+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (135, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 97, "errorMsg": "", "username": "", "description": "/api/blog/surfer/archive/list"}', '2026-10-24 14:53:04.562917+00', '2026-10-24 14:53:04.562917+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (136, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 280, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 14:53:10.946446+00', '2026-10-24 14:53:10.946446+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (137, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 286, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 14:53:30.450931+00', '2026-10-24 14:53:30.450931+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (138, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 299, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-24 14:53:36.302889+00', '2026-10-24 14:53:36.302889+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (139, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/article/api/blog/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 327, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/api/blog/surfer/category/article/list"}', '2026-10-24 14:54:16.477308+00', '2026-10-24 14:54:16.477308+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (140, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/blog/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 101, "errorMsg": "", "username": "", "description": "/api/blog/surfer/archive/list"}', '2026-10-24 14:54:30.852502+00', '2026-10-24 14:54:30.852502+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (141, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 16:12:01.102273+00', '2026-10-24 16:12:01.102273+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (142, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 16, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 16:26:55.948182+00', '2026-10-24 16:26:55.948182+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (143, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 13, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 16:27:33.996105+00', '2026-10-24 16:27:33.996105+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (144, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/143.0.0.0 Safari/537.36", "message": "成功", "duration": 36, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-24 16:35:47.521751+00', '2026-10-24 16:35:47.521751+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (145, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 21, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-25 03:58:52.985263+00', '2026-10-25 03:58:52.985263+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (146, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 12, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/detail"}', '2026-10-25 03:58:54.683098+00', '2026-10-25 03:58:54.683098+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (198, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 16:57:47.503538+00', '2026-10-27 16:57:47.503538+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (147, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-25 04:10:19.576847+00', '2026-10-25 04:10:19.576847+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (148, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 18, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-25 04:29:55.885605+00', '2026-10-25 04:29:55.885605+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (149, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/143.0.0.0 Safari/537.36", "message": "成功", "duration": 17, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-25 04:39:51.442408+00', '2026-10-25 04:39:51.442408+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (150, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 50, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-25 15:31:46.255531+00', '2026-10-25 15:31:46.255531+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (151, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-25 16:12:28.119396+00', '2026-10-25 16:12:28.119396+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (152, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 15, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-25 16:28:20.692178+00', '2026-10-25 16:28:20.692178+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (153, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-25 16:29:16.748056+00', '2026-10-25 16:29:16.748056+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (154, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/143.0.0.0 Safari/537.36", "message": "成功", "duration": 14, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-25 16:38:37.626538+00', '2026-10-25 16:38:37.626538+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (155, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 521, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/auth/login"}', '2026-10-25 17:16:32.85664+00', '2026-10-25 17:16:32.85664+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (156, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 53, "errorMsg": "", "username": "", "description": "/api/auth/refresh"}', '2026-10-26 01:45:37.980788+00', '2026-10-26 01:45:37.980788+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (157, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 306, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/auth/login"}', '2026-10-26 01:45:46.412176+00', '2026-10-26 01:45:46.412176+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (158, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 20, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/blog/surfer/article/list"}', '2026-10-26 01:47:51.841596+00', '2026-10-26 01:47:51.841596+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (159, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-26 04:10:14.960924+00', '2026-10-26 04:10:14.960924+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (160, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 10, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-26 04:11:15.559977+00', '2026-10-26 04:11:15.559977+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (161, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 18, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-26 04:25:24.853412+00', '2026-10-26 04:25:24.853412+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (162, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/143.0.0.0 Safari/537.36", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-26 04:34:14.224763+00', '2026-10-26 04:34:14.224763+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (910, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 10, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-31 16:28:28.038298+00', '2026-10-31 16:28:28.038298+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (163, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 32, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-26 10:45:53.746256+00', '2026-10-26 10:45:53.746256+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (164, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-26 16:10:45.499466+00', '2026-10-26 16:10:45.499466+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (165, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36", "message": "成功", "duration": 13, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-26 16:26:35.438951+00', '2026-10-26 16:26:35.438951+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (166, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/143.0.0.0 Safari/537.36", "message": "成功", "duration": 14, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-26 16:36:55.552571+00', '2026-10-26 16:36:55.552571+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (167, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/blog/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 42, "errorMsg": "", "username": "", "description": "/api/blog/surfer/article/list"}', '2026-10-27 00:39:05.941003+00', '2026-10-27 00:39:05.941003+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (168, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 1102, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/system/auth/login"}', '2026-10-27 03:21:49.941823+00', '2026-10-27 03:21:49.941823+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (169, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 325, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/system/auth/login"}', '2026-10-27 03:37:18.443409+00', '2026-10-27 03:37:18.443409+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (170, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 1044, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/system/auth/login"}', '2026-10-27 06:15:14.568197+00', '2026-10-27 06:15:14.568197+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (171, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 313, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/system/auth/login"}', '2026-10-27 07:33:55.323636+00', '2026-10-27 07:33:55.323636+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (172, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/users/4", "action": "update", "method": "PUT", "module": "users", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 42, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/system/users/4"}', '2026-10-27 07:34:06.279039+00', '2026-10-27 07:34:06.279039+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (173, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/users/2", "action": "update", "method": "PUT", "module": "users", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 14, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/system/users/2"}', '2026-10-27 07:35:41.781031+00', '2026-10-27 07:35:41.781031+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (174, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/users/3", "action": "update", "method": "PUT", "module": "users", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 17, "errorMsg": "", "username": "SuperAdmin666", "description": "/api/system/users/3"}', '2026-10-27 07:35:51.79606+00', '2026-10-27 07:35:51.79606+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (175, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "fail", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "请求失败", "duration": 166, "errorMsg": "login_invalid", "username": "SuperAdmin", "description": "/api/system/auth/login"}', '2026-10-27 07:36:43.846861+00', '2026-10-27 07:36:43.846861+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (176, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "fail", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "请求失败", "duration": 305, "errorMsg": "login_invalid", "username": "SuperAdmin", "description": "/api/system/auth/login"}', '2026-10-27 07:37:22.544062+00', '2026-10-27 07:37:22.544062+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (177, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 304, "errorMsg": "", "username": "SuperAdmin", "description": "/api/system/auth/login"}', '2026-10-27 07:37:33.094719+00', '2026-10-27 07:37:33.094719+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (178, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 358, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/system/auth/login"}', '2026-10-27 13:48:07.453379+00', '2026-10-27 13:48:07.453379+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (199, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 16:57:55.512138+00', '2026-10-27 16:57:55.512138+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (179, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "fail", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "请求失败", "duration": 153, "errorMsg": "login_invalid", "username": "GenerallyAdmin", "description": "/api/system/auth/login"}', '2026-10-27 13:49:05.020964+00', '2026-10-27 13:49:05.020964+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (180, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 305, "errorMsg": "", "username": "GenerallyAdmin", "description": "/api/system/auth/login"}', '2026-10-27 13:49:30.496243+00', '2026-10-27 13:49:30.496243+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (181, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/users/change-password", "action": "create", "method": "POST", "module": "users", "status": "fail", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "请求失败", "duration": 317, "errorMsg": "user_password_invalid", "username": "GenerallyAdmin", "description": "/api/system/users/change-password"}', '2026-10-27 13:50:14.612795+00', '2026-10-27 13:50:14.612795+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (182, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/users/change-password", "action": "create", "method": "POST", "module": "users", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 634, "errorMsg": "", "username": "GenerallyAdmin", "description": "/api/system/users/change-password"}', '2026-10-27 13:50:21.029008+00', '2026-10-27 13:50:21.029008+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (203, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:00:49.993226+00', '2026-10-27 17:00:49.993226+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (183, 'operationLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/logout", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 16, "errorMsg": "", "username": "GenerallyAdmin", "description": "/api/system/auth/logout"}', '2026-10-27 13:50:21.459692+00', '2026-10-27 13:50:21.459692+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (184, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 305, "errorMsg": "", "username": "GenerallyAdmin", "description": "/api/system/auth/login"}', '2026-10-27 13:50:33.750808+00', '2026-10-27 13:50:33.750808+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (185, 'loginLog', '{"ip": "172.17.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 993, "errorMsg": "", "username": "SuperAdmin", "description": "/api/system/auth/login"}', '2026-10-27 14:04:31.211549+00', '2026-10-27 14:04:31.211549+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (186, 'loginLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 1108, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/system/auth/login"}', '2026-10-27 16:03:19.353889+00', '2026-10-27 16:03:19.353889+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (187, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 25, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 16:55:24.631778+00', '2026-10-27 16:55:24.631778+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (188, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 23, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 16:55:37.724366+00', '2026-10-27 16:55:37.724366+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (189, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 16:56:42.616829+00', '2026-10-27 16:56:42.616829+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (190, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 16:56:45.536493+00', '2026-10-27 16:56:45.536493+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (191, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 16:56:46.687913+00', '2026-10-27 16:56:46.687913+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (192, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 16:56:47.67897+00', '2026-10-27 16:56:47.67897+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (193, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 13, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 16:56:48.553776+00', '2026-10-27 16:56:48.553776+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (194, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 16:56:50.049085+00', '2026-10-27 16:56:50.049085+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (195, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 16:56:50.834794+00', '2026-10-27 16:56:50.834794+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (196, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 13, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 16:57:26.375742+00', '2026-10-27 16:57:26.375742+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (200, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:00:44.378166+00', '2026-10-27 17:00:44.378166+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (201, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:00:48.057036+00', '2026-10-27 17:00:48.057036+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (202, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:00:49.06951+00', '2026-10-27 17:00:49.06951+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (204, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:03:33.374737+00', '2026-10-27 17:03:33.374737+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (205, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:03:42.346383+00', '2026-10-27 17:03:42.346383+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (206, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:03:47.421288+00', '2026-10-27 17:03:47.421288+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (207, 'loginLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 316, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/system/auth/login"}', '2026-10-27 17:10:43.46012+00', '2026-10-27 17:10:43.46012+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (208, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 17:10:46.521667+00', '2026-10-27 17:10:46.521667+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (209, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 17:10:50.000661+00', '2026-10-27 17:10:50.000661+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (210, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 17:11:04.381179+00', '2026-10-27 17:11:04.381179+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (211, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:14:22.919211+00', '2026-10-27 17:14:22.919211+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (212, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:17:07.770649+00', '2026-10-27 17:17:07.770649+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (213, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:20:22.912906+00', '2026-10-27 17:20:22.912906+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (214, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:22:48.831826+00', '2026-10-27 17:22:48.831826+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (215, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:22:50.891958+00', '2026-10-27 17:22:50.891958+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (216, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:28:48.906984+00', '2026-10-27 17:28:48.906984+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (217, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:29:08.845528+00', '2026-10-27 17:29:08.845528+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (218, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 17:32:44.033396+00', '2026-10-27 17:32:44.033396+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (219, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-27 17:33:20.898908+00', '2026-10-27 17:33:20.898908+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (220, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 17:33:43.61919+00', '2026-10-27 17:33:43.61919+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (221, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 17:44:02.326001+00', '2026-10-27 17:44:02.326001+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (222, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 17:55:07.997127+00', '2026-10-27 17:55:07.997127+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (223, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 18:03:56.754563+00', '2026-10-27 18:03:56.754563+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (224, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 18:14:09.907531+00', '2026-10-27 18:14:09.907531+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (225, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 18:23:46.262098+00', '2026-10-27 18:23:46.262098+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (226, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-27 18:45:11.162668+00', '2026-10-27 18:45:11.162668+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (227, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 18:51:15.666701+00', '2026-10-27 18:51:15.666701+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (228, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 19:02:22.174092+00', '2026-10-27 19:02:22.174092+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (229, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 19:13:01.924747+00', '2026-10-27 19:13:01.924747+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (230, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 19:26:02.051161+00', '2026-10-27 19:26:02.051161+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (231, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 19:30:15.058856+00', '2026-10-27 19:30:15.058856+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (232, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-27 19:36:07.475043+00', '2026-10-27 19:36:07.475043+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (233, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 19:52:52.523674+00', '2026-10-27 19:52:52.523674+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (234, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 20, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-27 20:04:06.431254+00', '2026-10-27 20:04:06.431254+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (235, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 10, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 20:15:55.708437+00', '2026-10-27 20:15:55.708437+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (236, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-27 20:18:20.916423+00', '2026-10-27 20:18:20.916423+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (237, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 20, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-27 20:40:06.970176+00', '2026-10-27 20:40:06.970176+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (238, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 20:55:19.541743+00', '2026-10-27 20:55:19.541743+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (239, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 21:13:07.253628+00', '2026-10-27 21:13:07.253628+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (240, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 21:22:29.160958+00', '2026-10-27 21:22:29.160958+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (241, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 21:43:12.357509+00', '2026-10-27 21:43:12.357509+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (242, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 21:53:29.741847+00', '2026-10-27 21:53:29.741847+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (243, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 22:13:34.02357+00', '2026-10-27 22:13:34.02357+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (244, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 22:23:33.597135+00', '2026-10-27 22:23:33.597135+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (245, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 22:35:26.600648+00', '2026-10-27 22:35:26.600648+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (246, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-27 22:44:23.110443+00', '2026-10-27 22:44:23.110443+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (247, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 22:53:18.589285+00', '2026-10-27 22:53:18.589285+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (248, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 23:11:28.982233+00', '2026-10-27 23:11:28.982233+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (249, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 23:19:55.919464+00', '2026-10-27 23:19:55.919464+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (250, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 23:32:33.91913+00', '2026-10-27 23:32:33.91913+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (251, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-27 23:44:36.625146+00', '2026-10-27 23:44:36.625146+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (252, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 00:02:00.064502+00', '2026-10-28 00:02:00.064502+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (253, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 00:13:04.645804+00', '2026-10-28 00:13:04.645804+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (254, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 00:23:13.370716+00', '2026-10-28 00:23:13.370716+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (255, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 00:32:07.342922+00', '2026-10-28 00:32:07.342922+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (256, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 00:43:09.875532+00', '2026-10-28 00:43:09.875532+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (257, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 66, "errorMsg": "", "username": "", "description": "/api/system/auth/refresh"}', '2026-10-28 00:51:57.142991+00', '2026-10-28 00:51:57.142991+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (258, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 00:51:57.71679+00', '2026-10-28 00:51:57.71679+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (259, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 00:51:59.606042+00', '2026-10-28 00:51:59.606042+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (260, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 00:52:00.278809+00', '2026-10-28 00:52:00.278809+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (261, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 00:52:07.374377+00', '2026-10-28 00:52:07.374377+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (262, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 00:54:59.779546+00', '2026-10-28 00:54:59.779546+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (263, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 01:01:26.424132+00', '2026-10-28 01:01:26.424132+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (264, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 01:01:33.493078+00', '2026-10-28 01:01:33.493078+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (265, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 01:13:48.320177+00', '2026-10-28 01:13:48.320177+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (266, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 01:22:38.646819+00', '2026-10-28 01:22:38.646819+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (267, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 01:33:22.166318+00', '2026-10-28 01:33:22.166318+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (268, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 01:44:00.961572+00', '2026-10-28 01:44:00.961572+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (269, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 02:02:27.143923+00', '2026-10-28 02:02:27.143923+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (270, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 02:10:15.995857+00', '2026-10-28 02:10:15.995857+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (271, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 02:11:29.180775+00', '2026-10-28 02:11:29.180775+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (272, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 02:22:43.523753+00', '2026-10-28 02:22:43.523753+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (273, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 02:23:27.508096+00', '2026-10-28 02:23:27.508096+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (274, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 02:30:26.512292+00', '2026-10-28 02:30:26.512292+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (275, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 02:41:38.522785+00', '2026-10-28 02:41:38.522785+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (276, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 02:53:32.81572+00', '2026-10-28 02:53:32.81572+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (277, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 03:01:42.999447+00', '2026-10-28 03:01:42.999447+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (278, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 03:13:38.029742+00', '2026-10-28 03:13:38.029742+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (279, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 03:22:00.357112+00', '2026-10-28 03:22:00.357112+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (280, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 03:25:49.98921+00', '2026-10-28 03:25:49.98921+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (281, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 03:32:00.638287+00', '2026-10-28 03:32:00.638287+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (282, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 03:41:49.680174+00', '2026-10-28 03:41:49.680174+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (283, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 03:52:47.772558+00', '2026-10-28 03:52:47.772558+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (284, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 04:02:54.984432+00', '2026-10-28 04:02:54.984432+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (285, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 04:09:48.566998+00', '2026-10-28 04:09:48.566998+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (286, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 04:10:44.818362+00', '2026-10-28 04:10:44.818362+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (287, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 04:13:08.648826+00', '2026-10-28 04:13:08.648826+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (288, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 04:22:36.121176+00', '2026-10-28 04:22:36.121176+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (289, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 04:24:24.949337+00', '2026-10-28 04:24:24.949337+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (290, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 04:25:20.574715+00', '2026-10-28 04:25:20.574715+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (291, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 04:33:08.538323+00', '2026-10-28 04:33:08.538323+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (292, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 04:33:18.066484+00', '2026-10-28 04:33:18.066484+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (293, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 04:41:55.997652+00', '2026-10-28 04:41:55.997652+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (294, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 04:52:55.936538+00', '2026-10-28 04:52:55.936538+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (295, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 05:03:14.71709+00', '2026-10-28 05:03:14.71709+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (296, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 05:14:15.981678+00', '2026-10-28 05:14:15.981678+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (297, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 05:21:46.744954+00', '2026-10-28 05:21:46.744954+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (298, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 05:31:45.455421+00', '2026-10-28 05:31:45.455421+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (299, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 05:41:47.91273+00', '2026-10-28 05:41:47.91273+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (300, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 05:52:10.030236+00', '2026-10-28 05:52:10.030236+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (301, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 06:01:57.909023+00', '2026-10-28 06:01:57.909023+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (302, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 06:11:41.285854+00', '2026-10-28 06:11:41.285854+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (303, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 06:21:38.5886+00', '2026-10-28 06:21:38.5886+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (304, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 06:24:32.242395+00', '2026-10-28 06:24:32.242395+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (305, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/system/auth/refresh"}', '2026-10-28 06:24:57.471557+00', '2026-10-28 06:24:57.471557+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (306, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 06:27:13.194288+00', '2026-10-28 06:27:13.194288+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (307, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 15, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 06:33:05.265763+00', '2026-10-28 06:33:05.265763+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (308, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 06:43:37.66538+00', '2026-10-28 06:43:37.66538+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (309, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 06:50:52.375912+00', '2026-10-28 06:50:52.375912+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (310, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 07:01:54.434126+00', '2026-10-28 07:01:54.434126+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (311, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 07:09:48.637933+00', '2026-10-28 07:09:48.637933+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (312, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 07:21:15.728099+00', '2026-10-28 07:21:15.728099+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (313, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 07:32:33.799145+00', '2026-10-28 07:32:33.799145+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (314, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 07:37:47.467923+00', '2026-10-28 07:37:47.467923+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (315, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 07:41:39.250219+00', '2026-10-28 07:41:39.250219+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (316, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 07:50:12.54129+00', '2026-10-28 07:50:12.54129+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (317, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 07:51:25.799394+00', '2026-10-28 07:51:25.799394+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (318, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:00:51.859132+00', '2026-10-28 08:00:51.859132+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (319, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 08:14:08.177333+00', '2026-10-28 08:14:08.177333+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (320, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:22:39.460937+00', '2026-10-28 08:22:39.460937+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (321, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 08:22:46.216047+00', '2026-10-28 08:22:46.216047+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (322, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 08:24:14.250244+00', '2026-10-28 08:24:14.250244+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (323, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 08:24:20.505657+00', '2026-10-28 08:24:20.505657+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (324, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 08:24:22.100593+00', '2026-10-28 08:24:22.100593+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (325, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 08:24:23.031904+00', '2026-10-28 08:24:23.031904+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (326, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 08:24:23.627069+00', '2026-10-28 08:24:23.627069+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (327, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 08:24:23.894971+00', '2026-10-28 08:24:23.894971+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (328, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 08:24:24.166307+00', '2026-10-28 08:24:24.166307+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (329, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 08:24:24.415031+00', '2026-10-28 08:24:24.415031+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (330, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 08:24:24.667564+00', '2026-10-28 08:24:24.667564+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (331, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:24:26.065074+00', '2026-10-28 08:24:26.065074+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (332, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 08:24:49.698642+00', '2026-10-28 08:24:49.698642+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (333, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 08:24:55.047181+00', '2026-10-28 08:24:55.047181+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (335, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-28 08:24:57.84489+00', '2026-10-28 08:24:57.84489+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (337, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 08:25:06.798152+00', '2026-10-28 08:25:06.798152+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (339, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:25:52.009463+00', '2026-10-28 08:25:52.009463+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (334, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:24:56.558046+00', '2026-10-28 08:24:56.558046+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (336, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-28 08:25:02.533954+00', '2026-10-28 08:25:02.533954+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (338, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:25:08.672908+00', '2026-10-28 08:25:08.672908+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (340, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 08:26:47.211595+00', '2026-10-28 08:26:47.211595+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (341, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 08:28:44.445222+00', '2026-10-28 08:28:44.445222+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (342, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:29:03.165788+00', '2026-10-28 08:29:03.165788+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (343, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/system/auth/refresh"}', '2026-10-28 08:30:30.891997+00', '2026-10-28 08:30:30.891997+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (344, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:31:08.53833+00', '2026-10-28 08:31:08.53833+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (345, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 08:31:12.463932+00', '2026-10-28 08:31:12.463932+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (346, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 16, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:31:21.143579+00', '2026-10-28 08:31:21.143579+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (347, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:31:26.36085+00', '2026-10-28 08:31:26.36085+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (348, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:31:31.588412+00', '2026-10-28 08:31:31.588412+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (349, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:31:32.99969+00', '2026-10-28 08:31:32.99969+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (350, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-28 08:31:46.585428+00', '2026-10-28 08:31:46.585428+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (351, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 08:31:56.02882+00', '2026-10-28 08:31:56.02882+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (352, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:32:19.968993+00', '2026-10-28 08:32:19.968993+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (353, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:32:44.659466+00', '2026-10-28 08:32:44.659466+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (354, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 08:32:51.238319+00', '2026-10-28 08:32:51.238319+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (355, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 08:33:03.732971+00', '2026-10-28 08:33:03.732971+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (356, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:34:06.268605+00', '2026-10-28 08:34:06.268605+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (357, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-28 08:34:08.365616+00', '2026-10-28 08:34:08.365616+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (358, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 08:36:26.296421+00', '2026-10-28 08:36:26.296421+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (359, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:36:53.809696+00', '2026-10-28 08:36:53.809696+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (360, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:38:01.251152+00', '2026-10-28 08:38:01.251152+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (361, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:38:05.267386+00', '2026-10-28 08:38:05.267386+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (362, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 08:38:45.647789+00', '2026-10-28 08:38:45.647789+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (363, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:40:11.122507+00', '2026-10-28 08:40:11.122507+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (364, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:40:19.641925+00', '2026-10-28 08:40:19.641925+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (365, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:40:20.999421+00', '2026-10-28 08:40:20.999421+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (366, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:40:22.107104+00', '2026-10-28 08:40:22.107104+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (367, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:40:23.242548+00', '2026-10-28 08:40:23.242548+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (368, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:40:24.533849+00', '2026-10-28 08:40:24.533849+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (369, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:40:28.823978+00', '2026-10-28 08:40:28.823978+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (370, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:40:30.960336+00', '2026-10-28 08:40:30.960336+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (371, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:40:33.287616+00', '2026-10-28 08:40:33.287616+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (372, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:40:34.109603+00', '2026-10-28 08:40:34.109603+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (373, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:41:42.113874+00', '2026-10-28 08:41:42.113874+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (374, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:41:43.222574+00', '2026-10-28 08:41:43.222574+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (375, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 08:42:22.928692+00', '2026-10-28 08:42:22.928692+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (376, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 08:52:29.424573+00', '2026-10-28 08:52:29.424573+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (377, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 08:59:58.424632+00', '2026-10-28 08:59:58.424632+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (378, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 09:04:16.397756+00', '2026-10-28 09:04:16.397756+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (379, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 09:06:02.814035+00', '2026-10-28 09:06:02.814035+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (380, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 09:11:20.148853+00', '2026-10-28 09:11:20.148853+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (381, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 09:12:08.604124+00', '2026-10-28 09:12:08.604124+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (382, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 09:22:24.745331+00', '2026-10-28 09:22:24.745331+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (383, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 09:32:36.86535+00', '2026-10-28 09:32:36.86535+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (384, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 09:39:00.521962+00', '2026-10-28 09:39:00.521962+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (385, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 09:40:34.375311+00', '2026-10-28 09:40:34.375311+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (386, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 09:51:37.959731+00', '2026-10-28 09:51:37.959731+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (387, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 09:59:54.053306+00', '2026-10-28 09:59:54.053306+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (388, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 10:08:44.518469+00', '2026-10-28 10:08:44.518469+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (389, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 10:09:54.273091+00', '2026-10-28 10:09:54.273091+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (390, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 10:10:07.794469+00', '2026-10-28 10:10:07.794469+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (391, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 10:17:46.883086+00', '2026-10-28 10:17:46.883086+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (392, 'loginLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/155.1 Mobile/15E148 Safari/604.1", "message": "成功", "duration": 458, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/system/auth/login"}', '2026-10-28 10:20:12.270875+00', '2026-10-28 10:20:12.270875+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (393, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 10:20:19.546994+00', '2026-10-28 10:20:19.546994+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (394, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 12, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 10:32:57.83345+00', '2026-10-28 10:32:57.83345+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (395, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 10:42:14.892594+00', '2026-10-28 10:42:14.892594+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (396, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 10:42:41.408799+00', '2026-10-28 10:42:41.408799+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (397, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 10:53:55.264513+00', '2026-10-28 10:53:55.264513+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (398, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 11:02:34.587771+00', '2026-10-28 11:02:34.587771+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (399, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 11:12:13.107269+00', '2026-10-28 11:12:13.107269+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (400, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 11:22:23.822388+00', '2026-10-28 11:22:23.822388+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (401, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 11:25:32.991373+00', '2026-10-28 11:25:32.991373+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (402, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 11:25:35.67878+00', '2026-10-28 11:25:35.67878+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (403, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 11:32:28.910018+00', '2026-10-28 11:32:28.910018+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (404, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 11:41:51.090956+00', '2026-10-28 11:41:51.090956+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (405, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "fail", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "请求失败", "duration": 34, "errorMsg": "refresh_token_invalid", "username": "", "description": "/api/system/auth/refresh"}', '2026-10-28 11:44:11.121944+00', '2026-10-28 11:44:11.121944+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (406, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/logout", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 10, "errorMsg": "", "username": "", "description": "/api/system/auth/logout"}', '2026-10-28 11:44:11.182671+00', '2026-10-28 11:44:11.182671+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (407, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 11:44:14.798513+00', '2026-10-28 11:44:14.798513+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (408, 'loginLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 303, "errorMsg": "", "username": "SuperAdmin", "description": "/api/system/auth/login"}', '2026-10-28 11:47:21.172999+00', '2026-10-28 11:47:21.172999+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (409, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/admin/friend/19/delete", "action": "update", "method": "PATCH", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 29, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/friend/19/delete"}', '2026-10-28 11:47:40.359165+00', '2026-10-28 11:47:40.359165+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (410, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 11:52:33.770777+00', '2026-10-28 11:52:33.770777+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (411, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 11:55:59.829998+00', '2026-10-28 11:55:59.829998+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (412, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 15, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 12:03:06.357336+00', '2026-10-28 12:03:06.357336+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (413, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 12:12:25.565235+00', '2026-10-28 12:12:25.565235+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (414, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 12:22:20.730657+00', '2026-10-28 12:22:20.730657+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (415, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 13:30:44.806987+00', '2026-10-28 13:30:44.806987+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (416, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 14:44:57.469171+00', '2026-10-28 14:44:57.469171+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (417, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 14:47:33.864819+00', '2026-10-28 14:47:33.864819+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (418, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 14:57:44.457184+00', '2026-10-28 14:57:44.457184+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (419, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 15:06:03.864235+00', '2026-10-28 15:06:03.864235+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (420, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 15:17:31.310313+00', '2026-10-28 15:17:31.310313+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (421, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 15:25:57.773794+00', '2026-10-28 15:25:57.773794+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (422, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 15:32:40.840876+00', '2026-10-28 15:32:40.840876+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (423, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 15:38:11.277312+00', '2026-10-28 15:38:11.277312+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (424, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 15:46:03.709302+00', '2026-10-28 15:46:03.709302+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (425, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 15:52:40.186839+00', '2026-10-28 15:52:40.186839+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (426, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 15:57:29.067029+00', '2026-10-28 15:57:29.067029+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (427, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 16:08:42.65277+00', '2026-10-28 16:08:42.65277+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (428, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 16:10:11.503468+00', '2026-10-28 16:10:11.503468+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (429, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 16:11:07.680396+00', '2026-10-28 16:11:07.680396+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (430, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 73, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 16:33:33.153822+00', '2026-10-28 16:33:33.153822+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (431, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 16:33:35.176479+00', '2026-10-28 16:33:35.176479+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (432, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 16:37:32.815012+00', '2026-10-28 16:37:32.815012+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (433, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 60, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 16:50:11.878177+00', '2026-10-28 16:50:11.878177+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (434, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 37, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-28 16:50:35.582115+00', '2026-10-28 16:50:35.582115+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (435, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 89, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 16:50:39.963845+00', '2026-10-28 16:50:39.963845+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (436, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 35, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-28 16:50:49.075164+00', '2026-10-28 16:50:49.075164+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (437, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 15, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 16:50:55.256935+00', '2026-10-28 16:50:55.256935+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (438, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 38, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-28 16:50:57.934795+00', '2026-10-28 16:50:57.934795+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (439, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-28 16:51:02.920115+00', '2026-10-28 16:51:02.920115+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (440, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 101, "errorMsg": "", "username": "", "description": "/api/system/auth/refresh"}', '2026-10-28 16:58:10.534309+00', '2026-10-28 16:58:10.534309+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (441, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/155.1 Mobile/15E148 Safari/604.1", "message": "成功", "duration": 13, "errorMsg": "", "username": "", "description": "/api/system/auth/refresh"}', '2026-10-28 17:00:59.396646+00', '2026-10-28 17:00:59.396646+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (442, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 17:01:54.124851+00', '2026-10-28 17:01:54.124851+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (443, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 17:01:57.946462+00', '2026-10-28 17:01:57.946462+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (444, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 17:02:45.07967+00', '2026-10-28 17:02:45.07967+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (445, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 33, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:02:50.973992+00', '2026-10-28 17:02:50.973992+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (446, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:03:14.847558+00', '2026-10-28 17:03:14.847558+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (447, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:03:39.796863+00', '2026-10-28 17:03:39.796863+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (448, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:03:49.331496+00', '2026-10-28 17:03:49.331496+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (449, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:04:28.685957+00', '2026-10-28 17:04:28.685957+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (450, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 18, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:04:44.601927+00', '2026-10-28 17:04:44.601927+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (451, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 17, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:04:48.060299+00', '2026-10-28 17:04:48.060299+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (452, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:04:57.064495+00', '2026-10-28 17:04:57.064495+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (453, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:05:02.973222+00', '2026-10-28 17:05:02.973222+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (454, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 22, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:05:20.447547+00', '2026-10-28 17:05:20.447547+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (455, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:05:38.152885+00', '2026-10-28 17:05:38.152885+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (456, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:05:55.523383+00', '2026-10-28 17:05:55.523383+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (457, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:06:10.354719+00', '2026-10-28 17:06:10.354719+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (458, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:06:12.584744+00', '2026-10-28 17:06:12.584744+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (459, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 17:08:11.587157+00', '2026-10-28 17:08:11.587157+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (460, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 17, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 17:08:30.392561+00', '2026-10-28 17:08:30.392561+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (461, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 17:10:17.759785+00', '2026-10-28 17:10:17.759785+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (462, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 21:19:10.881095+00', '2026-10-28 21:19:10.881095+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (463, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 21:23:58.014605+00', '2026-10-28 21:23:58.014605+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (464, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 21:33:49.255573+00', '2026-10-28 21:33:49.255573+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (465, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 17, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 21:42:47.186082+00', '2026-10-28 21:42:47.186082+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (466, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 21:42:48.07397+00', '2026-10-28 21:42:48.07397+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (467, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 21:42:50.01478+00', '2026-10-28 21:42:50.01478+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (468, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 21:43:13.339717+00', '2026-10-28 21:43:13.339717+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (469, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 21:43:15.562781+00', '2026-10-28 21:43:15.562781+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (470, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 21:52:45.554293+00', '2026-10-28 21:52:45.554293+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (471, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 16, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 21:58:33.311145+00', '2026-10-28 21:58:33.311145+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (472, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 21:59:24.476585+00', '2026-10-28 21:59:24.476585+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (473, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 22:02:08.172802+00', '2026-10-28 22:02:08.172802+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (474, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 22:10:54.544258+00', '2026-10-28 22:10:54.544258+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (475, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 22:23:29.710265+00', '2026-10-28 22:23:29.710265+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (476, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 22:33:16.725789+00', '2026-10-28 22:33:16.725789+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (477, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 22:43:18.724715+00', '2026-10-28 22:43:18.724715+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (478, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 22:52:36.945087+00', '2026-10-28 22:52:36.945087+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (479, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 22:56:55.51353+00', '2026-10-28 22:56:55.51353+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (480, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-28 22:59:00.004666+00', '2026-10-28 22:59:00.004666+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (481, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 23:02:39.461728+00', '2026-10-28 23:02:39.461728+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (482, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 23:10:04.512205+00', '2026-10-28 23:10:04.512205+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (483, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-28 23:20:31.397206+00', '2026-10-28 23:20:31.397206+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (484, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 10, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 23:32:32.251532+00', '2026-10-28 23:32:32.251532+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (485, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 23:43:00.650512+00', '2026-10-28 23:43:00.650512+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (486, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-28 23:52:36.975915+00', '2026-10-28 23:52:36.975915+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (487, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 00:00:39.107753+00', '2026-10-29 00:00:39.107753+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (488, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 00:12:39.255547+00', '2026-10-29 00:12:39.255547+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (489, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 00:20:37.641388+00', '2026-10-29 00:20:37.641388+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (490, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 00:33:09.741372+00', '2026-10-29 00:33:09.741372+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (491, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 00:43:14.192763+00', '2026-10-29 00:43:14.192763+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (492, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 00:52:59.449301+00', '2026-10-29 00:52:59.449301+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (493, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 01:00:57.472053+00', '2026-10-29 01:00:57.472053+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (494, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 01:01:03.033596+00', '2026-10-29 01:01:03.033596+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (495, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 01:01:10.711121+00', '2026-10-29 01:01:10.711121+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (496, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 01:01:12.117811+00', '2026-10-29 01:01:12.117811+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (497, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 01:01:13.644021+00', '2026-10-29 01:01:13.644021+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (498, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 01:01:14.591954+00', '2026-10-29 01:01:14.591954+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (499, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 01:01:15.900614+00', '2026-10-29 01:01:15.900614+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (500, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 01:01:17.205806+00', '2026-10-29 01:01:17.205806+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (501, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 2, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-29 01:01:31.005013+00', '2026-10-29 01:01:31.005013+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (502, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 01:01:37.61069+00', '2026-10-29 01:01:37.61069+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (503, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 2, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-29 01:01:51.804611+00', '2026-10-29 01:01:51.804611+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (504, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 01:01:53.383055+00', '2026-10-29 01:01:53.383055+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (505, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 01:02:02.028092+00', '2026-10-29 01:02:02.028092+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (506, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 01:02:40.399011+00', '2026-10-29 01:02:40.399011+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (507, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 12, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 01:09:24.301307+00', '2026-10-29 01:09:24.301307+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (508, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 01:09:28.875405+00', '2026-10-29 01:09:28.875405+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (509, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 01:09:31.057002+00', '2026-10-29 01:09:31.057002+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (510, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 01:09:53.56643+00', '2026-10-29 01:09:53.56643+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (511, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 01:12:22.843012+00', '2026-10-29 01:12:22.843012+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (512, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 01:16:12.97327+00', '2026-10-29 01:16:12.97327+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (513, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 01:16:22.351238+00', '2026-10-29 01:16:22.351238+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (514, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 01:18:02.621391+00', '2026-10-29 01:18:02.621391+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (515, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 01:18:04.708253+00', '2026-10-29 01:18:04.708253+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (516, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 2, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-29 01:18:05.794206+00', '2026-10-29 01:18:05.794206+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (517, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 01:18:07.476791+00', '2026-10-29 01:18:07.476791+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (518, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 01:24:39.097621+00', '2026-10-29 01:24:39.097621+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (519, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 01:32:49.917381+00', '2026-10-29 01:32:49.917381+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (520, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 01:44:24.528099+00', '2026-10-29 01:44:24.528099+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (521, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 01:51:18.756965+00', '2026-10-29 01:51:18.756965+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (522, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 02:02:05.060421+00', '2026-10-29 02:02:05.060421+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (523, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 02:12:27.709879+00', '2026-10-29 02:12:27.709879+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (524, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 02:21:53.921447+00', '2026-10-29 02:21:53.921447+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (525, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 02:32:22.624975+00', '2026-10-29 02:32:22.624975+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (526, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 02:42:25.23883+00', '2026-10-29 02:42:25.23883+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (527, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 02:53:14.848229+00', '2026-10-29 02:53:14.848229+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (528, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 13, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 03:02:24.050552+00', '2026-10-29 03:02:24.050552+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (529, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 03:10:28.356934+00', '2026-10-29 03:10:28.356934+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (530, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 03:23:24.263062+00', '2026-10-29 03:23:24.263062+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (531, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 03:33:16.377304+00', '2026-10-29 03:33:16.377304+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (532, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 03:59:48.838509+00', '2026-10-29 03:59:48.838509+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (533, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 04:03:56.181757+00', '2026-10-29 04:03:56.181757+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (534, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 04:11:53.573293+00', '2026-10-29 04:11:53.573293+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (535, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 04:12:49.566584+00', '2026-10-29 04:12:49.566584+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (536, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 04:14:12.062728+00', '2026-10-29 04:14:12.062728+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (537, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 04:21:45.351493+00', '2026-10-29 04:21:45.351493+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (538, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 04:28:48.043299+00', '2026-10-29 04:28:48.043299+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (539, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 04:29:43.799971+00', '2026-10-29 04:29:43.799971+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (540, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 04:32:03.798294+00', '2026-10-29 04:32:03.798294+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (541, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 04:38:39.345007+00', '2026-10-29 04:38:39.345007+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (542, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 04:41:54.250888+00', '2026-10-29 04:41:54.250888+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (543, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 04:45:53.060237+00', '2026-10-29 04:45:53.060237+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (544, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 04:53:54.3817+00', '2026-10-29 04:53:54.3817+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (545, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 05:03:23.286973+00', '2026-10-29 05:03:23.286973+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (546, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 05:15:55.821845+00', '2026-10-29 05:15:55.821845+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (547, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 05:22:13.520591+00', '2026-10-29 05:22:13.520591+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (548, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 05:34:56.516362+00', '2026-10-29 05:34:56.516362+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (549, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 2, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 05:42:28.555825+00', '2026-10-29 05:42:28.555825+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (550, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 05:52:06.437312+00', '2026-10-29 05:52:06.437312+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (551, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:01:50.033499+00', '2026-10-29 06:01:50.033499+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (552, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 06:02:51.743005+00', '2026-10-29 06:02:51.743005+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (553, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:13:36.08551+00', '2026-10-29 06:13:36.08551+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (554, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 06:17:49.794717+00', '2026-10-29 06:17:49.794717+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (555, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 06:18:10.898838+00', '2026-10-29 06:18:10.898838+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (556, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 06:21:22.332193+00', '2026-10-29 06:21:22.332193+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (557, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:22:38.445529+00', '2026-10-29 06:22:38.445529+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (558, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 06:23:31.669218+00', '2026-10-29 06:23:31.669218+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (559, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-29 06:24:20.806136+00', '2026-10-29 06:24:20.806136+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (560, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:24:22.344779+00', '2026-10-29 06:24:22.344779+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (561, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:24:23.4308+00', '2026-10-29 06:24:23.4308+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (562, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:24:24.915858+00', '2026-10-29 06:24:24.915858+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (563, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:24:27.927653+00', '2026-10-29 06:24:27.927653+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (564, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:24:30.658733+00', '2026-10-29 06:24:30.658733+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (565, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 06:24:52.028467+00', '2026-10-29 06:24:52.028467+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (566, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:25:22.095764+00', '2026-10-29 06:25:22.095764+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (567, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:25:23.668367+00', '2026-10-29 06:25:23.668367+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (568, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:25:24.76325+00', '2026-10-29 06:25:24.76325+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (569, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:25:25.819929+00', '2026-10-29 06:25:25.819929+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (570, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:32:00.414267+00', '2026-10-29 06:32:00.414267+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (571, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:44:48.058124+00', '2026-10-29 06:44:48.058124+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (572, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:44:50.923643+00', '2026-10-29 06:44:50.923643+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (573, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:44:51.557477+00', '2026-10-29 06:44:51.557477+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (574, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:44:51.981273+00', '2026-10-29 06:44:51.981273+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (575, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:44:52.39872+00', '2026-10-29 06:44:52.39872+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (576, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:44:53.490447+00', '2026-10-29 06:44:53.490447+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (577, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:44:54.492245+00', '2026-10-29 06:44:54.492245+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (578, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:44:54.835211+00', '2026-10-29 06:44:54.835211+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (579, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:44:55.012804+00', '2026-10-29 06:44:55.012804+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (580, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:44:55.824339+00', '2026-10-29 06:44:55.824339+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (581, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:44:57.059044+00', '2026-10-29 06:44:57.059044+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (582, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:44:58.74707+00', '2026-10-29 06:44:58.74707+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (583, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:45:01.308358+00', '2026-10-29 06:45:01.308358+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (584, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:45:05.855354+00', '2026-10-29 06:45:05.855354+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (585, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:45:08.173871+00', '2026-10-29 06:45:08.173871+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (586, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:45:15.45474+00', '2026-10-29 06:45:15.45474+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (587, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:45:16.992027+00', '2026-10-29 06:45:16.992027+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (588, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:45:27.957022+00', '2026-10-29 06:45:27.957022+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (589, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:45:30.429443+00', '2026-10-29 06:45:30.429443+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (590, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:45:32.659782+00', '2026-10-29 06:45:32.659782+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (591, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 06:45:34.032179+00', '2026-10-29 06:45:34.032179+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (592, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 06:53:53.239367+00', '2026-10-29 06:53:53.239367+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (593, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 07:04:56.603097+00', '2026-10-29 07:04:56.603097+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (594, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 07:12:09.273791+00', '2026-10-29 07:12:09.273791+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (595, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 07:19:20.383725+00', '2026-10-29 07:19:20.383725+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (596, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 07:24:35.47012+00', '2026-10-29 07:24:35.47012+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (597, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 07:32:18.871664+00', '2026-10-29 07:32:18.871664+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (598, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 07:44:22.907339+00', '2026-10-29 07:44:22.907339+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (599, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 07:53:41.23909+00', '2026-10-29 07:53:41.23909+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (600, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 08:05:25.194755+00', '2026-10-29 08:05:25.194755+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (601, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 30, "errorMsg": "", "username": "", "description": "/api/system/auth/refresh"}', '2026-10-29 09:28:18.779726+00', '2026-10-29 09:28:18.779726+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (602, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/login", "action": "create", "method": "POST", "module": "login", "status": "fail", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36", "message": "请求失败", "duration": 0, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/login"}', '2026-10-29 10:08:18.109595+00', '2026-10-29 10:08:18.109595+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (603, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/v1/login", "action": "create", "method": "POST", "module": "v1", "status": "fail", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36", "message": "请求失败", "duration": 0, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/v1/login"}', '2026-10-29 10:08:19.303978+00', '2026-10-29 10:08:19.303978+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (604, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 10:40:31.732774+00', '2026-10-29 10:40:31.732774+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (605, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 10:44:46.660209+00', '2026-10-29 10:44:46.660209+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (606, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 10:48:30.998331+00', '2026-10-29 10:48:30.998331+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (607, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 10:58:03.993039+00', '2026-10-29 10:58:03.993039+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (608, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 11:07:26.474963+00', '2026-10-29 11:07:26.474963+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (609, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 11:17:47.585207+00', '2026-10-29 11:17:47.585207+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (610, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 11:27:57.017325+00', '2026-10-29 11:27:57.017325+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (611, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 11:37:20.621999+00', '2026-10-29 11:37:20.621999+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (612, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 15, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 11:57:19.608803+00', '2026-10-29 11:57:19.608803+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (613, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 14, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 11:57:32.396749+00', '2026-10-29 11:57:32.396749+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (614, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 12:05:29.588153+00', '2026-10-29 12:05:29.588153+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (615, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 12:06:29.968823+00', '2026-10-29 12:06:29.968823+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (616, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 12:08:56.955606+00', '2026-10-29 12:08:56.955606+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (617, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 12:17:49.494491+00', '2026-10-29 12:17:49.494491+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (618, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 12:27:49.960178+00', '2026-10-29 12:27:49.960178+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (619, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 12:38:06.720163+00', '2026-10-29 12:38:06.720163+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (620, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 15, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 12:49:11.215354+00', '2026-10-29 12:49:11.215354+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (621, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 12:58:09.674544+00', '2026-10-29 12:58:09.674544+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (622, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 13:06:25.630209+00', '2026-10-29 13:06:25.630209+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (623, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 13:18:01.44014+00', '2026-10-29 13:18:01.44014+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (624, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 13:27:37.523316+00', '2026-10-29 13:27:37.523316+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (625, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 13:35:41.512515+00', '2026-10-29 13:35:41.512515+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (626, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 13:48:12.131597+00', '2026-10-29 13:48:12.131597+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (627, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 13:58:03.962992+00', '2026-10-29 13:58:03.962992+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (628, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 14:06:16.064072+00', '2026-10-29 14:06:16.064072+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (629, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 10, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 14:23:01.715589+00', '2026-10-29 14:23:01.715589+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (630, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 14:26:25.161742+00', '2026-10-29 14:26:25.161742+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (631, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 14:36:00.035024+00', '2026-10-29 14:36:00.035024+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (632, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 14:45:48.16716+00', '2026-10-29 14:45:48.16716+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (633, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 14:58:04.346202+00', '2026-10-29 14:58:04.346202+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (634, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 10, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 15:10:02.441051+00', '2026-10-29 15:10:02.441051+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (635, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 15:17:57.839296+00', '2026-10-29 15:17:57.839296+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (636, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 15:25:50.725788+00', '2026-10-29 15:25:50.725788+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (637, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 12, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 15:38:14.715987+00', '2026-10-29 15:38:14.715987+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (638, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 15:48:16.456462+00', '2026-10-29 15:48:16.456462+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (868, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 137, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:35:17.688818+00', '2026-10-31 01:35:17.688818+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (639, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 16:12:00.22666+00', '2026-10-29 16:12:00.22666+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (640, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 16:12:56.552776+00', '2026-10-29 16:12:56.552776+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (641, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 16:28:30.727231+00', '2026-10-29 16:28:30.727231+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (642, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 16:29:26.899336+00', '2026-10-29 16:29:26.899336+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (643, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 16:38:43.410692+00', '2026-10-29 16:38:43.410692+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (644, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 16:54:54.997856+00', '2026-10-29 16:54:54.997856+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (645, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 17:00:28.204788+00', '2026-10-29 17:00:28.204788+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (646, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-29 17:02:11.566908+00', '2026-10-29 17:02:11.566908+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (647, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 17:12:17.639408+00', '2026-10-29 17:12:17.639408+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (648, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 17:19:39.727366+00', '2026-10-29 17:19:39.727366+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (649, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 17:29:01.792117+00', '2026-10-29 17:29:01.792117+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (650, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 17:39:12.341024+00', '2026-10-29 17:39:12.341024+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (651, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 17:47:10.851519+00', '2026-10-29 17:47:10.851519+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (652, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 17:54:47.490697+00', '2026-10-29 17:54:47.490697+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (653, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 2, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 17:58:53.794745+00', '2026-10-29 17:58:53.794745+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (654, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 18:03:42.096004+00', '2026-10-29 18:03:42.096004+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (655, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 18:09:01.717237+00', '2026-10-29 18:09:01.717237+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (656, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 18:18:26.96116+00', '2026-10-29 18:18:26.96116+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (657, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 18:28:07.803411+00', '2026-10-29 18:28:07.803411+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (658, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 2, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 18:39:53.524384+00', '2026-10-29 18:39:53.524384+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (659, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 18:45:45.952044+00', '2026-10-29 18:45:45.952044+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (660, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 19:00:18.459771+00', '2026-10-29 19:00:18.459771+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (661, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 19:08:31.132416+00', '2026-10-29 19:08:31.132416+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (662, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 19:41:22.863829+00', '2026-10-29 19:41:22.863829+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (663, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 19:45:09.6456+00', '2026-10-29 19:45:09.6456+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (664, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 19:57:47.95128+00', '2026-10-29 19:57:47.95128+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (665, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 20:08:39.100045+00', '2026-10-29 20:08:39.100045+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (666, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 20:21:06.573839+00', '2026-10-29 20:21:06.573839+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (667, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 20:26:20.463553+00', '2026-10-29 20:26:20.463553+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (668, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 20:37:55.523603+00', '2026-10-29 20:37:55.523603+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (669, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 2, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 20:47:41.973447+00', '2026-10-29 20:47:41.973447+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (670, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 20:55:00.366747+00', '2026-10-29 20:55:00.366747+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (671, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 21:05:36.588133+00', '2026-10-29 21:05:36.588133+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (672, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 21:14:18.199451+00', '2026-10-29 21:14:18.199451+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (673, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 21:26:11.470937+00', '2026-10-29 21:26:11.470937+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (674, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 21:34:42.161638+00', '2026-10-29 21:34:42.161638+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (675, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-29 21:46:33.767799+00', '2026-10-29 21:46:33.767799+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (676, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 21:55:13.155758+00', '2026-10-29 21:55:13.155758+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (677, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 22:05:53.017951+00', '2026-10-29 22:05:53.017951+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (678, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 22:14:47.652244+00', '2026-10-29 22:14:47.652244+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (679, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 22:24:16.36641+00', '2026-10-29 22:24:16.36641+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (680, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 22:37:20.798483+00', '2026-10-29 22:37:20.798483+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (681, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 22:45:43.425589+00', '2026-10-29 22:45:43.425589+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (682, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 22:54:36.68944+00', '2026-10-29 22:54:36.68944+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (683, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 23:05:02.020186+00', '2026-10-29 23:05:02.020186+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (684, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-29 23:09:50.231557+00', '2026-10-29 23:09:50.231557+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (685, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 23:15:14.151145+00', '2026-10-29 23:15:14.151145+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (686, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 23:25:41.82243+00', '2026-10-29 23:25:41.82243+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (687, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 23:35:22.202135+00', '2026-10-29 23:35:22.202135+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (688, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 23:44:05.130384+00', '2026-10-29 23:44:05.130384+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (689, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-29 23:53:59.063048+00', '2026-10-29 23:53:59.063048+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (690, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 00:05:30.237174+00', '2026-10-30 00:05:30.237174+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (691, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 00:15:39.530073+00', '2026-10-30 00:15:39.530073+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (692, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 00:48:07.758577+00', '2026-10-30 00:48:07.758577+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (693, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 00:50:32.39033+00', '2026-10-30 00:50:32.39033+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (694, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 01:01:45.659745+00', '2026-10-30 01:01:45.659745+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (695, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 01:10:58.185168+00', '2026-10-30 01:10:58.185168+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (696, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 01:12:33.424075+00', '2026-10-30 01:12:33.424075+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (697, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 01:31:12.930226+00', '2026-10-30 01:31:12.930226+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (698, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 01:41:03.701182+00', '2026-10-30 01:41:03.701182+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (699, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 01:48:47.503802+00', '2026-10-30 01:48:47.503802+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (700, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 01:51:37.33756+00', '2026-10-30 01:51:37.33756+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (701, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 02:01:20.258619+00', '2026-10-30 02:01:20.258619+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (702, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 02:07:41.84216+00', '2026-10-30 02:07:41.84216+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (703, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 02:08:53.294739+00', '2026-10-30 02:08:53.294739+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (704, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 02:18:56.636207+00', '2026-10-30 02:18:56.636207+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (705, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 02:31:21.161068+00', '2026-10-30 02:31:21.161068+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (706, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 02:40:39.567874+00', '2026-10-30 02:40:39.567874+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (707, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 02:49:08.318213+00', '2026-10-30 02:49:08.318213+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (708, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 02:59:07.953245+00', '2026-10-30 02:59:07.953245+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (709, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 10, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 03:09:07.838599+00', '2026-10-30 03:09:07.838599+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (710, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 03:21:30.721448+00', '2026-10-30 03:21:30.721448+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (711, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 03:28:46.109248+00', '2026-10-30 03:28:46.109248+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (712, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 03:40:38.429755+00', '2026-10-30 03:40:38.429755+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (713, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 14, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 03:51:09.356803+00', '2026-10-30 03:51:09.356803+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (714, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 03:59:26.078298+00', '2026-10-30 03:59:26.078298+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (715, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 04:06:21.751272+00', '2026-10-30 04:06:21.751272+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (716, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 04:08:52.452454+00', '2026-10-30 04:08:52.452454+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (717, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 04:09:54.054519+00', '2026-10-30 04:09:54.054519+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (718, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 04:10:50.677185+00', '2026-10-30 04:10:50.677185+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (719, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 12, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 04:21:28.458468+00', '2026-10-30 04:21:28.458468+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (720, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 04:27:46.262331+00', '2026-10-30 04:27:46.262331+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (721, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 04:28:42.056504+00', '2026-10-30 04:28:42.056504+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (722, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 04:32:15.801169+00', '2026-10-30 04:32:15.801169+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (723, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 13, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 04:39:41.297247+00', '2026-10-30 04:39:41.297247+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (724, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 04:43:01.127379+00', '2026-10-30 04:43:01.127379+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (725, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 04:52:30.367609+00', '2026-10-30 04:52:30.367609+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (726, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 05:01:50.242737+00', '2026-10-30 05:01:50.242737+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (727, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 05:10:05.607117+00', '2026-10-30 05:10:05.607117+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (728, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 05:22:30.195134+00', '2026-10-30 05:22:30.195134+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (729, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 05:27:46.251038+00', '2026-10-30 05:27:46.251038+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (730, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 12, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 05:31:00.016889+00', '2026-10-30 05:31:00.016889+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (731, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 34, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 05:39:04.336698+00', '2026-10-30 05:39:04.336698+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (732, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 05:49:15.596142+00', '2026-10-30 05:49:15.596142+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (733, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 05:59:12.53422+00', '2026-10-30 05:59:12.53422+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (734, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 06:09:16.993052+00', '2026-10-30 06:09:16.993052+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (735, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 06:20:53.577611+00', '2026-10-30 06:20:53.577611+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (736, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 06:29:06.421178+00', '2026-10-30 06:29:06.421178+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (737, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 30, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 06:39:09.600745+00', '2026-10-30 06:39:09.600745+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (738, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 06:51:31.08202+00', '2026-10-30 06:51:31.08202+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (739, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 07:01:42.65922+00', '2026-10-30 07:01:42.65922+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (740, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 07:09:01.972419+00', '2026-10-30 07:09:01.972419+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (741, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 07:16:05.614719+00', '2026-10-30 07:16:05.614719+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (742, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 07:22:33.164108+00', '2026-10-30 07:22:33.164108+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (743, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 07:30:56.593942+00', '2026-10-30 07:30:56.593942+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (744, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 07:41:17.887681+00', '2026-10-30 07:41:17.887681+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (745, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 07:51:17.046045+00', '2026-10-30 07:51:17.046045+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (746, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 07:58:40.831022+00', '2026-10-30 07:58:40.831022+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (747, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 08:01:17.689265+00', '2026-10-30 08:01:17.689265+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (748, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 08:12:16.876921+00', '2026-10-30 08:12:16.876921+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (749, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 08:22:28.877128+00', '2026-10-30 08:22:28.877128+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (750, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 08:28:05.39388+00', '2026-10-30 08:28:05.39388+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (751, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 08:30:40.302933+00', '2026-10-30 08:30:40.302933+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (752, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 12, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 08:31:33.287581+00', '2026-10-30 08:31:33.287581+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (753, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 08:39:35.112633+00', '2026-10-30 08:39:35.112633+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (754, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 08:50:54.899171+00', '2026-10-30 08:50:54.899171+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (755, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 09:04:17.620652+00', '2026-10-30 09:04:17.620652+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (756, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 0, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 09:12:00.8805+00', '2026-10-30 09:12:00.8805+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (757, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/graphql", "action": "create", "method": "POST", "module": "graphql", "status": "fail", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36", "message": "请求失败", "duration": 0, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/graphql"}', '2026-10-30 11:34:49.612419+00', '2026-10-30 11:34:49.612419+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (758, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 11:54:12.421662+00', '2026-10-30 11:54:12.421662+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (759, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 12:01:22.601585+00', '2026-10-30 12:01:22.601585+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (760, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 13:29:16.275296+00', '2026-10-30 13:29:16.275296+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (761, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 14:25:15.089158+00', '2026-10-30 14:25:15.089158+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (762, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 15:52:51.310884+00', '2026-10-30 15:52:51.310884+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (763, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 15:52:52.326791+00', '2026-10-30 15:52:52.326791+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (764, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 2, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-30 15:52:53.030737+00', '2026-10-30 15:52:53.030737+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (765, 'loginLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 870, "errorMsg": "", "username": "SuperAdmin", "description": "/api/system/auth/login"}', '2026-10-30 16:04:57.257716+00', '2026-10-30 16:04:57.257716+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (766, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 250, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:06:08.252719+00', '2026-10-30 16:06:08.252719+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (767, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 238, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:06:58.580568+00', '2026-10-30 16:06:58.580568+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (768, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 217, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:07:01.064805+00', '2026-10-30 16:07:01.064805+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (769, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 217, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:07:01.862598+00', '2026-10-30 16:07:01.862598+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (770, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 219, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:07:02.947691+00', '2026-10-30 16:07:02.947691+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (773, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 225, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:07:09.932589+00', '2026-10-30 16:07:09.932589+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (774, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 230, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:07:10.727263+00', '2026-10-30 16:07:10.727263+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (777, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 446, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:07:13.05249+00', '2026-10-30 16:07:13.05249+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (771, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 238, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:07:05.397496+00', '2026-10-30 16:07:05.397496+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (775, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 352, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:07:11.437476+00', '2026-10-30 16:07:11.437476+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (779, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 230, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 16:07:28.617511+00', '2026-10-30 16:07:28.617511+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (772, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 225, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:07:06.312002+00', '2026-10-30 16:07:06.312002+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (776, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 220, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:07:12.032383+00', '2026-10-30 16:07:12.032383+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (778, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 232, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 16:07:15.817272+00', '2026-10-30 16:07:15.817272+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (780, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 115, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:11:02.163123+00', '2026-10-30 16:11:02.163123+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (781, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 412, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 16:11:24.994841+00', '2026-10-30 16:11:24.994841+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (782, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 214, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:11:39.645051+00', '2026-10-30 16:11:39.645051+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (783, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 407, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 16:11:43.111882+00', '2026-10-30 16:11:43.111882+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (784, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:11:44.485634+00', '2026-10-30 16:11:44.485634+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (785, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 231, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:11:46.457554+00', '2026-10-30 16:11:46.457554+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (786, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 578, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 16:11:55.327473+00', '2026-10-30 16:11:55.327473+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (787, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 2, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:13:45.482019+00', '2026-10-30 16:13:45.482019+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (788, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 2, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:13:45.991822+00', '2026-10-30 16:13:45.991822+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (789, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-30 16:13:46.445254+00', '2026-10-30 16:13:46.445254+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (790, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 220, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:13:48.497094+00', '2026-10-30 16:13:48.497094+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (791, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 217, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 16:13:52.917452+00', '2026-10-30 16:13:52.917452+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (792, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 401, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:15:36.097429+00', '2026-10-30 16:15:36.097429+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (793, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 278, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 16:15:38.207699+00', '2026-10-30 16:15:38.207699+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (794, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 522, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:16:50.481869+00', '2026-10-30 16:16:50.481869+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (795, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 271, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-30 16:17:02.006869+00', '2026-10-30 16:17:02.006869+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (796, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 465, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:18:43.018922+00', '2026-10-30 16:18:43.018922+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (797, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 207, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:23:04.832694+00', '2026-10-30 16:23:04.832694+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (798, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 216, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:23:14.062779+00', '2026-10-30 16:23:14.062779+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (799, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 251, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:23:15.922655+00', '2026-10-30 16:23:15.922655+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (800, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 209, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-30 16:23:34.998184+00', '2026-10-30 16:23:34.998184+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (801, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 204, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-30 16:23:42.658217+00', '2026-10-30 16:23:42.658217+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (802, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:30:45.994416+00', '2026-10-30 16:30:45.994416+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (803, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:31:23.843059+00', '2026-10-30 16:31:23.843059+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (804, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:40:33.394955+00', '2026-10-30 16:40:33.394955+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (805, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:47:21.756985+00', '2026-10-30 16:47:21.756985+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (806, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 2, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 16:47:22.927576+00', '2026-10-30 16:47:22.927576+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (807, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-30 16:47:23.389246+00', '2026-10-30 16:47:23.389246+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (808, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-30 16:49:42.222643+00', '2026-10-30 16:49:42.222643+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (809, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-30 16:49:43.145198+00', '2026-10-30 16:49:43.145198+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (810, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 2, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-30 16:49:43.744784+00', '2026-10-30 16:49:43.744784+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (811, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-30 16:58:00.262296+00', '2026-10-30 16:58:00.262296+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (812, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 1, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-30 16:58:00.33579+00', '2026-10-30 16:58:00.33579+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (813, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 3, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-30 16:58:00.416283+00', '2026-10-30 16:58:00.416283+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (814, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 17:03:58.817509+00', '2026-10-30 17:03:58.817509+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (815, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 2, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 17:07:04.237585+00', '2026-10-30 17:07:04.237585+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (816, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 17:35:01.316909+00', '2026-10-30 17:35:01.316909+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (817, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 17:37:58.148529+00', '2026-10-30 17:37:58.148529+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (818, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 18:21:25.715417+00', '2026-10-30 18:21:25.715417+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (819, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 19:31:09.176308+00', '2026-10-30 19:31:09.176308+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (820, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 12, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 20:14:21.936277+00', '2026-10-30 20:14:21.936277+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (821, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 4, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 21:38:23.3172+00', '2026-10-30 21:38:23.3172+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (822, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-30 22:59:48.878973+00', '2026-10-30 22:59:48.878973+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (823, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 00:24:11.98968+00', '2026-10-31 00:24:11.98968+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (824, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 4, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 00:49:04.423429+00', '2026-10-31 00:49:04.423429+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (825, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 2, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 00:49:08.727675+00', '2026-10-31 00:49:08.727675+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (826, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 00:49:11.733117+00', '2026-10-31 00:49:11.733117+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (827, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 2, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 00:49:12.700132+00', '2026-10-31 00:49:12.700132+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (828, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/system/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 360, "errorMsg": "", "username": "", "description": "/api/system/auth/refresh"}', '2026-10-31 01:04:30.86401+00', '2026-10-31 01:04:30.86401+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (829, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:04:55.230297+00', '2026-10-31 01:04:55.230297+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (830, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 4, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:04:58.814086+00', '2026-10-31 01:04:58.814086+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (831, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 2, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:05:03.27495+00', '2026-10-31 01:05:03.27495+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (832, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 2, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:05:04.12051+00', '2026-10-31 01:05:04.12051+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (833, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 2, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:05:06.76763+00', '2026-10-31 01:05:06.76763+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (834, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 180, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:05:30.466768+00', '2026-10-31 01:05:30.466768+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (835, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 132, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:05:34.492774+00', '2026-10-31 01:05:34.492774+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (836, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 169, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-31 01:05:42.866663+00', '2026-10-31 01:05:42.866663+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (837, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 92, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-31 01:05:51.924508+00', '2026-10-31 01:05:51.924508+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (838, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 148, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:06:01.074376+00', '2026-10-31 01:06:01.074376+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (839, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 133, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:06:12.284309+00', '2026-10-31 01:06:12.284309+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (840, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 137, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:06:15.338954+00', '2026-10-31 01:06:15.338954+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (841, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 134, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:06:33.348275+00', '2026-10-31 01:06:33.348275+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (844, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 139, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:06:41.830931+00', '2026-10-31 01:06:41.830931+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (847, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 133, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:06:43.47116+00', '2026-10-31 01:06:43.47116+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (842, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 132, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:06:39.891855+00', '2026-10-31 01:06:39.891855+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (845, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 132, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:06:42.415588+00', '2026-10-31 01:06:42.415588+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (848, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 131, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:06:44.087395+00', '2026-10-31 01:06:44.087395+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (843, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 129, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:06:40.897033+00', '2026-10-31 01:06:40.897033+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (846, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 129, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:06:43.00381+00', '2026-10-31 01:06:43.00381+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (849, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 136, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:06:44.792593+00', '2026-10-31 01:06:44.792593+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (850, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 142, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-31 01:10:13.987337+00', '2026-10-31 01:10:13.987337+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (851, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 134, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-31 01:14:47.352973+00', '2026-10-31 01:14:47.352973+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (852, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 131, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:15:09.500749+00', '2026-10-31 01:15:09.500749+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (853, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 137, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:20:57.468057+00', '2026-10-31 01:20:57.468057+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (854, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 142, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:21:06.39198+00', '2026-10-31 01:21:06.39198+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (855, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 148, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:21:29.509992+00', '2026-10-31 01:21:29.509992+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (856, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 138, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-31 01:22:57.406167+00', '2026-10-31 01:22:57.406167+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (857, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 136, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-31 01:23:57.418427+00', '2026-10-31 01:23:57.418427+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (858, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 139, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:24:01.911454+00', '2026-10-31 01:24:01.911454+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (859, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 136, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:25:36.326792+00', '2026-10-31 01:25:36.326792+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (860, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 142, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:25:44.398669+00', '2026-10-31 01:25:44.398669+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (861, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/tag/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 135, "errorMsg": "", "username": "", "description": "/api/surfer/tag/article/list"}', '2026-10-31 01:26:51.808022+00', '2026-10-31 01:26:51.808022+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (862, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 135, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:27:15.306537+00', '2026-10-31 01:27:15.306537+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (863, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 135, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:27:16.35503+00', '2026-10-31 01:27:16.35503+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (864, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 136, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:30:22.205138+00', '2026-10-31 01:30:22.205138+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (865, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 133, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:30:25.589916+00', '2026-10-31 01:30:25.589916+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (866, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 135, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 01:32:09.550436+00', '2026-10-31 01:32:09.550436+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (867, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 137, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-31 01:33:21.880746+00', '2026-10-31 01:33:21.880746+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (869, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 404, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions"}', '2026-10-31 01:37:18.791355+00', '2026-10-31 01:37:18.791355+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (870, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 388, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions"}', '2026-10-31 01:37:28.055302+00', '2026-10-31 01:37:28.055302+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (871, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/93", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 415, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/93"}', '2026-10-31 01:37:36.871804+00', '2026-10-31 01:37:36.871804+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (872, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/93", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 423, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/93"}', '2026-10-31 01:38:09.530069+00', '2026-10-31 01:38:09.530069+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (873, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/94", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 397, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/94"}', '2026-10-31 01:38:27.186964+00', '2026-10-31 01:38:27.186964+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (874, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 382, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions"}', '2026-10-31 01:38:42.738233+00', '2026-10-31 01:38:42.738233+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (875, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/94", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 412, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/94"}', '2026-10-31 01:41:07.107672+00', '2026-10-31 01:41:07.107672+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (876, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 383, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions"}', '2026-10-31 01:41:25.110761+00', '2026-10-31 01:41:25.110761+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (877, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/articles/2060392182262665216", "action": "update", "method": "PUT", "module": "admin", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 730, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/articles/2060392182262665216"}', '2026-10-31 01:44:47.245147+00', '2026-10-31 01:44:47.245147+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (878, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 135, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:44:55.923922+00', '2026-10-31 01:44:55.923922+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (879, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/refresh", "action": "create", "method": "POST", "module": "auth", "status": "fail", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "请求失败", "duration": 15, "errorMsg": "refresh_token_invalid", "username": "", "description": "/api/system/auth/refresh"}', '2026-10-31 01:50:33.628069+00', '2026-10-31 01:50:33.628069+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (880, 'operationLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/logout", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 28, "errorMsg": "", "username": "", "description": "/api/system/auth/logout"}', '2026-10-31 01:50:34.845647+00', '2026-10-31 01:50:34.845647+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (881, 'loginLog', '{"ip": "::ffff:172.19.0.2", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 450, "errorMsg": "", "username": "SuperAdmin", "description": "/api/system/auth/login"}', '2026-10-31 01:50:44.493545+00', '2026-10-31 01:50:44.493545+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (882, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tag/2113187978510733313", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 367, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tag/2113187978510733313"}', '2026-10-31 01:51:22.765643+00', '2026-10-31 01:51:22.765643+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (883, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/93", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 402, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/93"}', '2026-10-31 01:51:44.900641+00', '2026-10-31 01:51:44.900641+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (884, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 130, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 01:52:13.0489+00', '2026-10-31 01:52:13.0489+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (885, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/articles/2060392182262665216", "action": "update", "method": "PATCH", "module": "admin", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 683, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/articles/2060392182262665216"}', '2026-10-31 01:58:49.957134+00', '2026-10-31 01:58:49.957134+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (888, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 145, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 02:01:35.81266+00', '2026-10-31 02:01:35.81266+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (886, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/articles/2060392182262665216", "action": "update", "method": "PATCH", "module": "admin", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 704, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/articles/2060392182262665216"}', '2026-10-31 01:58:52.585215+00', '2026-10-31 01:58:52.585215+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (887, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 3, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 02:01:26.008907+00', '2026-10-31 02:01:26.008907+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (889, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 187, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-31 02:01:37.919438+00', '2026-10-31 02:01:37.919438+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (890, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/resources", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 711, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/resources"}', '2026-10-31 02:02:28.58058+00', '2026-10-31 02:02:28.58058+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (891, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/navigation-tags/2113187978510733313", "action": "update", "method": "PATCH", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 356, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/navigation-tags/2113187978510733313"}', '2026-10-31 02:05:32.000608+00', '2026-10-31 02:05:32.000608+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (892, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/93", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 382, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/93"}', '2026-10-31 02:36:52.136754+00', '2026-10-31 02:36:52.136754+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (893, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/94", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 417, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/94"}', '2026-10-31 02:37:00.194944+00', '2026-10-31 02:37:00.194944+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (894, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/91", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 380, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/91"}', '2026-10-31 02:37:14.71955+00', '2026-10-31 02:37:14.71955+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (895, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/91", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 410, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/91"}', '2026-10-31 02:37:39.515807+00', '2026-10-31 02:37:39.515807+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (896, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/96", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 386, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/96"}', '2026-10-31 02:37:48.721959+00', '2026-10-31 02:37:48.721959+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (897, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/95", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 400, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/95"}', '2026-10-31 02:38:00.413246+00', '2026-10-31 02:38:00.413246+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (898, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/95", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 420, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/95"}', '2026-10-31 02:55:51.263572+00', '2026-10-31 02:55:51.263572+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (899, 'operationLog', '{"ip": "127.0.0.1", "os": "", "url": "/api/admin/tags/2113187978510733313/versions/96", "action": "delete", "method": "DELETE", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 424, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/tags/2113187978510733313/versions/96"}', '2026-10-31 02:56:01.11705+00', '2026-10-31 02:56:01.11705+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (900, 'operationLog', '{"ip": "::ffff:172.19.0.6", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "fail", "browser": "node", "message": "请求失败", "duration": 5, "errorMsg": "REQUEST_FAILED", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 02:56:38.619327+00', '2026-10-31 02:56:38.619327+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (901, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 16, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 16:19:23.839294+00', '2026-10-31 16:19:23.839294+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (902, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 22, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 16:19:29.607282+00', '2026-10-31 16:19:29.607282+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (903, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 12, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 16:19:35.672132+00', '2026-10-31 16:19:35.672132+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (904, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 53, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-31 16:19:38.17421+00', '2026-10-31 16:19:38.17421+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (905, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-31 16:19:53.569102+00', '2026-10-31 16:19:53.569102+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (906, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 10, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-31 16:19:56.755767+00', '2026-10-31 16:19:56.755767+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (907, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 8, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-31 16:19:58.283412+00', '2026-10-31 16:19:58.283412+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (908, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 6, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-31 16:20:00.4243+00', '2026-10-31 16:20:00.4243+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (909, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 14, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 16:28:20.974629+00', '2026-10-31 16:28:20.974629+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (911, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-31 16:28:34.625426+00', '2026-10-31 16:28:34.625426+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (912, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 10, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-31 16:28:44.485402+00', '2026-10-31 16:28:44.485402+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (913, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 12, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 16:28:47.994214+00', '2026-10-31 16:28:47.994214+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (914, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-10-31 16:28:50.614533+00', '2026-10-31 16:28:50.614533+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (915, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 10, "errorMsg": "", "username": "", "description": "/api/surfer/article/list"}', '2026-10-31 16:28:52.35402+00', '2026-10-31 16:28:52.35402+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (916, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 7, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-31 16:28:54.074425+00', '2026-10-31 16:28:54.074425+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (917, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 9, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-31 16:29:00.77792+00', '2026-10-31 16:29:00.77792+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (918, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-31 16:30:41.720754+00', '2026-10-31 16:30:41.720754+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (919, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-31 16:30:45.9753+00', '2026-10-31 16:30:45.9753+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (920, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 4, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-31 16:31:17.877858+00', '2026-10-31 16:31:17.877858+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (921, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-31 16:31:22.938844+00', '2026-10-31 16:31:22.938844+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (922, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-31 16:31:51.232045+00', '2026-10-31 16:31:51.232045+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (923, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/message/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 5, "errorMsg": "", "username": "", "description": "/api/surfer/message/list"}', '2026-10-31 16:31:52.751263+00', '2026-10-31 16:31:52.751263+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (924, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/archive/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 10, "errorMsg": "", "username": "", "description": "/api/surfer/archive/list"}', '2026-10-31 16:31:58.958944+00', '2026-10-31 16:31:58.958944+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (925, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/category/article/list", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 25, "errorMsg": "", "username": "", "description": "/api/surfer/category/article/list"}', '2026-10-31 16:41:21.956306+00', '2026-10-31 16:41:21.956306+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (926, 'loginLog', '{"ip": "::1", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36", "message": "成功", "duration": 546, "errorMsg": "", "username": "VisitorAdmin", "description": "/api/system/auth/login"}', '2026-11-01 04:54:27.794517+00', '2026-11-01 04:54:27.794517+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (927, 'loginLog', '{"ip": "::1", "os": "", "url": "/api/system/auth/login", "action": "create", "method": "POST", "module": "auth", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 274, "errorMsg": "", "username": "SuperAdmin", "description": "/api/system/auth/login"}', '2026-11-01 04:55:04.703265+00', '2026-11-01 04:55:04.703265+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (928, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/admin/column/2095086327090515968", "action": "delete", "method": "DELETE", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 39, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/column/2095086327090515968"}', '2026-11-01 04:55:13.707611+00', '2026-11-01 04:55:13.707611+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (929, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/admin/column/2080126342950686720", "action": "delete", "method": "DELETE", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 15, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/column/2080126342950686720"}', '2026-11-01 04:55:19.229345+00', '2026-11-01 04:55:19.229345+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (930, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/admin/column/2077753941604569088", "action": "delete", "method": "DELETE", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 10, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/column/2077753941604569088"}', '2026-11-01 04:55:22.276732+00', '2026-11-01 04:55:22.276732+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (931, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/admin/column/1/catalog", "action": "update", "method": "PUT", "module": "blog", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 92, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/column/1/catalog"}', '2026-11-01 04:55:35.523471+00', '2026-11-01 04:55:35.523471+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (932, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 36, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-11-01 04:55:48.145592+00', '2026-11-01 04:55:48.145592+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (933, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/admin/articles/2060392182262665216", "action": "update", "method": "PUT", "module": "admin", "status": "success", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/159.0.0.0 Safari/537.36", "message": "成功", "duration": 113, "errorMsg": "", "username": "SuperAdmin", "description": "/api/admin/articles/2060392182262665216"}', '2026-11-01 06:16:37.604694+00', '2026-11-01 06:16:37.604694+00');
INSERT INTO "public"."sys_admin_record" ("id", "resource", "data", "create_time", "update_time") VALUES (934, 'operationLog', '{"ip": "::1", "os": "", "url": "/api/surfer/article/detail", "action": "create", "method": "POST", "module": "blog", "status": "success", "browser": "node", "message": "成功", "duration": 11, "errorMsg": "", "username": "", "description": "/api/surfer/article/detail"}', '2026-11-01 06:16:49.852338+00', '2026-11-01 06:16:49.852338+00');
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
INSERT INTO "public"."sys_role" ("id", "name", "code", "description", "create_time", "update_time") VALUES (2, '管理员', 'ROLE_ADMIN', '', '2026-10-12 02:42:44.893779+00', '2026-10-12 02:42:44.893779+00');
INSERT INTO "public"."sys_role" ("id", "name", "code", "description", "create_time", "update_time") VALUES (3, '访客', 'ROLE_VISITOR', '', '2026-10-12 02:42:44.893779+00', '2026-10-12 02:42:44.893779+00');
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
INSERT INTO "public"."sys_user" ("id", "username", "display_name", "password", "is_deleted", "create_time", "update_time", "status", "email", "phone", "avatar", "gender", "birth_date", "bio") VALUES (3, 'VisitorAdmin', '演示用户', '$2a$12$VAlB.T8seA7mL1YS5TJmPOPjjSiUqGDHFbpd.V6Z4U4JH63S0iRcy', 0, '2025-08-25 11:39:10', '2026-10-27 07:35:41.770922', 'active', '', '', '', '', '', '');
INSERT INTO "public"."sys_user" ("id", "username", "display_name", "password", "is_deleted", "create_time", "update_time", "status", "email", "phone", "avatar", "gender", "birth_date", "bio") VALUES (1, 'SuperAdmin', '程序员杨工子', '$2a$12$0W8IIRTD5Ito8gw5K/i0aujnTmAmzKGDjhVRFP8gU90/D/u9u.T4q', 0, '2023-07-03 11:57:18', '2026-10-31 03:20:00.585139', 'active', '', '', '', '', '', '');
INSERT INTO "public"."sys_user" ("id", "username", "display_name", "password", "is_deleted", "create_time", "update_time", "status", "email", "phone", "avatar", "gender", "birth_date", "bio") VALUES (2, 'GenerallyAdmin', '普通管理员', '$2a$12$R.bO/xE.h15UnQKhFzHv2e8PuenumsHGZaMPmTdIILPGvdqokqhQO', 0, '2023-07-07 01:22:05', '2026-10-31 03:20:40.840237', 'active', '', '', '', '', '', '');
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
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115129075516444672, 3, '2FB516D0B3DB05C3A7EEF8C4B9BD6C93D2B5673C0D0BCF07F56E0CCCA2CB6F61', '2026-11-03 17:10:43.455031+00', 1, '2026-10-28 00:51:57.113022+00', '2026-10-27 17:10:43.455276+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115245147351552000, 3, '554B5E313E4005CFDCB6F4C01B432DE9AA3D00CE4E0485EE5A555DDA6E030C31', '2026-11-04 00:51:57.113022+00', 1, '2026-10-28 06:24:57.464669+00', '2026-10-28 00:51:57.118754+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2114405765249896448, 4, '66884FE29F1EFA7DB5B7CC5B25814D61917BCCDA06648091C2AC88D0EEBF2C8A', '2026-11-01 17:16:32.827945+00', 1, '2026-10-26 01:45:37.94618+00', '2026-10-25 17:16:32.832084+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2114533880743727104, 4, 'C21E1FFBAC75E0EE79D0CFE8626D9CABEBC73766042348EB3626B219C5E24115', '2026-11-02 01:45:37.94618+00', 1, '2026-10-27 03:21:49.835608+00', '2026-10-26 01:45:37.950005+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2114920477737750528, 4, 'A4A35C76EAA1208EE84DCE9FD24FD47DE4234B2194139BE3F95F8D069EB5B678', '2026-11-03 03:21:49.76997+00', 1, '2026-10-27 03:37:18.440274+00', '2026-10-27 03:21:49.797806+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2114533916160430080, 2, '40C61E0C93C6BC9220FFD47DFF4CF0192A2FD023B8669338C63FA2CE686FF242', '2026-11-02 01:45:46.407182+00', 1, '2026-10-27 06:15:14.490978+00', '2026-10-26 01:45:46.407382+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2114924372438421504, 4, '248EE4D8018B48657116623D6BCD5A1A3F8642259EB9DD788FB96B39358700C1', '2026-11-03 03:37:18.436771+00', 1, '2026-10-27 07:33:55.32023+00', '2026-10-27 03:37:18.43704+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2114983918468993024, 4, '5FFBE04E24678035B8C8058EA0C7F87C8C7C4DF75A83101407D9AD63090FB5F9', '2026-11-03 07:33:55.310643+00', 0, NULL, '2026-10-27 07:33:55.316644+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2114964117973504000, 2, 'A3C7DDE6576AB742B8001086F2CD4542EB00869D4EEF8916FD9D31DD7B9CC53F', '2026-11-03 06:15:14.442957+00', 1, '2026-10-27 13:49:30.4928+00', '2026-10-27 06:15:14.462288+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115078437831053312, 2, '4C4BD97EFE97B84425ABBD6652F0E9233D1926B8038A15179ADA5263752C1A62', '2026-11-03 13:49:30.490554+00', 1, '2026-10-27 13:50:21.027191+00', '2026-10-27 13:49:30.490775+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2114984831866769408, 1, 'B171AE1BBD412C6E51DA8B6B7010C02E6A27DF6E1C2C1C195B69BE33489B2D86', '2026-11-03 07:37:33.089888+00', 1, '2026-10-27 14:04:31.134328+00', '2026-10-27 07:37:33.090087+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115078089515077632, 3, 'BB33F5889F87F5F7709A3A91049449A99667EA23CD37AEE25ABE5D1A8F41F212', '2026-11-03 13:48:07.442297+00', 1, '2026-10-27 16:03:19.29154+00', '2026-10-27 13:48:07.445579+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115112113134505984, 3, '5F29788A7E494901D2745F39B40736F00C58894BB0A4AA105F3CD7902ABD0550', '2026-11-03 16:03:19.250896+00', 1, '2026-10-27 17:10:43.45761+00', '2026-10-27 16:03:19.267241+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115328950925398016, 3, 'BCF3D782737C7D43D28EB1CB6A47B8D17C2C3A75384AACC3927038748EBB5F27', '2026-11-04 06:24:57.464669+00', 1, '2026-10-28 08:30:30.88442+00', '2026-10-28 06:24:57.466692+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115360548374843392, 3, 'CE834FB6DE82E1097C6C4F1812B8BA42C925F91CA7AA742FE17C0C88C84DD7DB', '2026-11-04 08:30:30.88442+00', 1, '2026-10-28 10:20:12.246366+00', '2026-10-28 08:30:30.88583+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115082215498059776, 1, 'C27EFBB3538AFF22D1C841548C6D146F3846298358051D22D648C8797D41280D', '2026-11-03 14:04:31.080473+00', 1, '2026-10-28 11:47:21.17022+00', '2026-10-27 14:04:31.099635+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115410084287877120, 1, '117A04FD4FB50E154E1AC1FB36BDFE413C268A7A4E75F3B37D245CB06808C3A3', '2026-11-04 11:47:21.168276+00', 1, '2026-10-28 16:58:10.459972+00', '2026-10-28 11:47:21.168462+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115388152628776960, 3, '52CCE18A278172502B1F131AF93DBD5625F1E786963F8BDDC27EAF81BB7CE4FC', '2026-11-04 10:20:12.187846+00', 1, '2026-10-28 17:00:59.390039+00', '2026-10-28 10:20:12.218002+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115488305301819392, 1, '78F4C6F79B854092C94F2F523634804EC84BB7621AF6CEC4C6FF057C00966185', '2026-11-04 16:58:10.459972+00', 1, '2026-10-29 09:28:18.757261+00', '2026-10-28 16:58:10.475508+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115737481621147648, 1, 'F71384A3E06849C19A4A953F57FC8DDAEE77589E0F866827F5A0214BC05B0053', '2026-11-05 09:28:18.757261+00', 1, '2026-10-30 16:04:56.796951+00', '2026-10-29 09:28:18.763628+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2116199685940187136, 1, '99E448A9BB863C2EFED65CD78179997E05B344F83A26C846CBF55ABDD296381F', '2026-11-06 16:04:56.707449+00', 1, '2026-10-31 01:04:30.59538+00', '2026-10-30 16:04:56.714386+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2116335471801012224, 1, '25349292115D3FC7EEE9C77AAB2D1377F4D8B3974B61DFDACEB54944B7653284', '2026-11-07 01:04:30.59538+00', 1, '2026-10-31 01:50:44.490541+00', '2026-10-31 01:04:30.642755+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2116347105730760704, 1, 'F346B0C67519CEA96B47FBC253EE749CD404B580AA7A574F65073F562C34E3FA', '2026-11-07 01:50:44.48353+00', 1, '2026-10-31 03:20:00.59031+00', '2026-10-31 01:50:44.484978+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115078703141752832, 2, 'A64DB0F3D811AA204D43FAB2E8A7C39320F9C58CA16280A94FEE416A99E9EDE8', '2026-11-03 13:50:33.746106+00', 1, '2026-10-31 03:20:26.526317+00', '2026-10-27 13:50:33.746306+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2116369679625883648, 2, 'E8A2C81A4D38E506CD475EF204CAB487599796380BC7B9E10DAC42412D95BBE4', '2026-11-07 03:20:26.524956+00', 1, '2026-10-31 03:20:40.844926+00', '2026-10-31 03:20:26.525088+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2116369758810148864, 2, '32B73068E8CF308BD00DF07D4EABEFC647C8DBBF9DA133BDC9C3C14FA601A004', '2026-11-07 03:20:45.403908+00', 0, NULL, '2026-10-31 03:20:45.404163+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2115489013640073216, 3, '0CCC8D932D4701B4C411614D31AAEF21FFF1053AB42DFA766A539274627099F4', '2026-11-04 17:00:59.390039+00', 1, '2026-11-01 04:54:27.738965+00', '2026-10-28 17:00:59.391571+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2116755728512454656, 3, '051FEC48DBBB9493AD256C2C99A5A456968D5CC2866B0A017AC66674F9C9F68A', '2026-11-08 04:54:27.710719+00', 0, NULL, '2026-11-01 04:54:27.724146+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2116547000139911168, 1, '2E45C149966C7F087607D87D8A13DB032CD55AAADEE28B8E8A8E02EEE5CC1487', '2026-11-07 15:05:02.990874+00', 1, '2026-11-01 04:55:04.699825+00', '2026-10-31 15:05:03.003333+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2116755883479404544, 1, '232C37FBE9D31C83A0968EAE33A491F03481E1977C8A87FD5B0409C945F006F6', '2026-11-08 04:55:04.697107+00', 0, NULL, '2026-11-01 04:55:04.697265+00');
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
INSERT INTO "public"."sys_user_role" ("id", "username", "role", "create_time", "user_id", "role_id") VALUES (1, 'SuperAdmin', 'ROLE_SUPER', '2023-07-07 01:21:15', 1, 1);
INSERT INTO "public"."sys_user_role" ("id", "username", "role", "create_time", "user_id", "role_id") VALUES (2, 'GenerallyAdmin', 'ROLE_ADMIN', '2026-04-19 00:03:25', 2, 2);
INSERT INTO "public"."sys_user_role" ("id", "username", "role", "create_time", "user_id", "role_id") VALUES (3, 'VisitorAdmin', 'ROLE_VISITOR', '2023-07-07 01:23:33', 3, 3);
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
SELECT setval('"public"."blog_friend_id_seq"', 19, true);

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
ALTER SEQUENCE "public"."blog_resource_id_seq"
OWNED BY "public"."blog_resource"."id";
SELECT setval('"public"."blog_resource_id_seq"', 1, false);

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
SELECT setval('"public"."blog_tag_id_seq"', 2113187978510733315, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."blog_tag_version_id_seq"
OWNED BY "public"."blog_tag_version"."id";
SELECT setval('"public"."blog_tag_version_id_seq"', 1, false);

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
SELECT setval('"public"."sys_admin_record_id_seq"', 934, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_permission_id_seq"
OWNED BY "public"."sys_permission"."id";
SELECT setval('"public"."sys_permission_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_role_id_seq"
OWNED BY "public"."sys_role"."id";
SELECT setval('"public"."sys_role_id_seq"', 1, false);

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
CREATE INDEX "ix_blog_article_tag_version" ON "public"."blog_article" USING btree (
  "tag_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "tag_version_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "ix_blog_article_version_tag" ON "public"."blog_article" USING btree (
  "tag_version_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "tag_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_article
-- ----------------------------
ALTER TABLE "public"."blog_article" ADD CONSTRAINT "blog_article_pkey" PRIMARY KEY ("id");

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
-- Indexes structure for table blog_article_draft
-- ----------------------------
CREATE INDEX "ix_blog_article_draft_tag_version" ON "public"."blog_article_draft" USING btree (
  "tag_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "tag_version_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "ix_blog_article_draft_version_tag" ON "public"."blog_article_draft" USING btree (
  "tag_version_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "tag_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_article_draft
-- ----------------------------
ALTER TABLE "public"."blog_article_draft" ADD CONSTRAINT "blog_article_draft_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table blog_article_draft_content
-- ----------------------------
ALTER TABLE "public"."blog_article_draft_content" ADD CONSTRAINT "blog_article_draft_content_pkey" PRIMARY KEY ("id");

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
-- Auto increment value for blog_resource
-- ----------------------------
SELECT setval('"public"."blog_resource_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table blog_resource
-- ----------------------------
CREATE INDEX "ix_blog_resource_tag_version_kind_sort" ON "public"."blog_resource" USING btree (
  "tag_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "tag_version_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "is_deleted" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "kind" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "sort" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "ix_blog_resource_version_tag" ON "public"."blog_resource" USING btree (
  "tag_version_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "tag_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_resource
-- ----------------------------
ALTER TABLE "public"."blog_resource" ADD CONSTRAINT "blog_resource_pkey" PRIMARY KEY ("id");

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
CREATE INDEX "ix_blog_tag_category" ON "public"."blog_tag" USING btree (
  "category_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "sort" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "ix_blog_tag_navigation_category" ON "public"."blog_tag" USING btree (
  "category_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "sort" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "id" "pg_catalog"."int8_ops" ASC NULLS LAST
) WHERE show_in_navigation = 1 AND is_deleted = 0;
CREATE UNIQUE INDEX "uk_name_tag" ON "public"."blog_tag" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table blog_tag
-- ----------------------------
ALTER TABLE "public"."blog_tag" ADD CONSTRAINT "blog_tag_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for blog_tag_version
-- ----------------------------
SELECT setval('"public"."blog_tag_version_id_seq"', 1, false);

-- ----------------------------
-- Indexes structure for table blog_tag_version
-- ----------------------------
CREATE INDEX "ix_blog_tag_version_tag_sort" ON "public"."blog_tag_version" USING btree (
  "tag_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "is_deleted" "pg_catalog"."int2_ops" ASC NULLS LAST,
  "sort" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uq_blog_tag_version_general" ON "public"."blog_tag_version" USING btree (
  "tag_id" "pg_catalog"."int8_ops" ASC NULLS LAST
) WHERE is_general = 1;

-- ----------------------------
-- Primary Key structure for table blog_tag_version
-- ----------------------------
ALTER TABLE "public"."blog_tag_version" ADD CONSTRAINT "blog_tag_version_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for sys_admin_record
-- ----------------------------
SELECT setval('"public"."sys_admin_record_id_seq"', 934, true);

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
-- Primary Key structure for table sys_admin_record
-- ----------------------------
ALTER TABLE "public"."sys_admin_record" ADD CONSTRAINT "sys_admin_record_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for sys_permission
-- ----------------------------
SELECT setval('"public"."sys_permission_id_seq"', 1, false);

-- ----------------------------
-- Primary Key structure for table sys_permission
-- ----------------------------
ALTER TABLE "public"."sys_permission" ADD CONSTRAINT "sys_permission_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Auto increment value for sys_role
-- ----------------------------
SELECT setval('"public"."sys_role_id_seq"', 1, false);

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
-- Foreign Keys structure for table blog_article
-- ----------------------------
ALTER TABLE "public"."blog_article" ADD CONSTRAINT "fk_blog_article_tag" FOREIGN KEY ("tag_id") REFERENCES "public"."blog_tag" ("id") ON DELETE RESTRICT ON UPDATE NO ACTION;
