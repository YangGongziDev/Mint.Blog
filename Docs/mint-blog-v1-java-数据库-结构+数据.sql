/*
 Navicat Premium Dump SQL

 Source Server         : Local_Docker-YangMufa666
 Source Server Type    : PostgreSQL
 Source Server Version : 180003 (180003)
 Source Host           : localhost:5432
 Source Catalog        : MintBlog
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180003 (180003)
 File Encoding         : 65001

 Date: 24/05/2026 20:54:37
*/


-- ----------------------------
-- Sequence structure for r_friend_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."r_friend_id_seq";
CREATE SEQUENCE "public"."r_friend_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."r_friend_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_article_category_rel_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_article_category_rel_id_seq";
CREATE SEQUENCE "public"."t_article_category_rel_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_article_category_rel_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_article_content_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_article_content_id_seq";
CREATE SEQUENCE "public"."t_article_content_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_article_content_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_article_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_article_id_seq";
CREATE SEQUENCE "public"."t_article_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_article_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_article_tag_rel_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_article_tag_rel_id_seq";
CREATE SEQUENCE "public"."t_article_tag_rel_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_article_tag_rel_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_blog_settings_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_blog_settings_id_seq";
CREATE SEQUENCE "public"."t_blog_settings_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_blog_settings_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_category_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_category_id_seq";
CREATE SEQUENCE "public"."t_category_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_category_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_comment_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_comment_id_seq";
CREATE SEQUENCE "public"."t_comment_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_comment_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_statistics_article_pv_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_statistics_article_pv_id_seq";
CREATE SEQUENCE "public"."t_statistics_article_pv_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_statistics_article_pv_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_tag_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_tag_id_seq";
CREATE SEQUENCE "public"."t_tag_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_tag_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_user_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_user_id_seq";
CREATE SEQUENCE "public"."t_user_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_user_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_user_role_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_user_role_id_seq";
CREATE SEQUENCE "public"."t_user_role_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_user_role_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_wiki_catalog_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_wiki_catalog_id_seq";
CREATE SEQUENCE "public"."t_wiki_catalog_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_wiki_catalog_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for t_wiki_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_wiki_id_seq";
CREATE SEQUENCE "public"."t_wiki_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."t_wiki_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Table structure for r_article
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_article";
CREATE TABLE "public"."r_article" (
  "id" int8 NOT NULL DEFAULT nextval('t_article_id_seq'::regclass),
  "title" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "cover" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "summary" varchar(160) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0,
  "read_num" int4 NOT NULL DEFAULT 1,
  "weight" int4 NOT NULL DEFAULT 0,
  "type" int2 NOT NULL DEFAULT 1
)
;
ALTER TABLE "public"."r_article" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_article"."id" IS '文章id';
COMMENT ON COLUMN "public"."r_article"."title" IS '文章标题';
COMMENT ON COLUMN "public"."r_article"."cover" IS '文章封面';
COMMENT ON COLUMN "public"."r_article"."summary" IS '文章摘要';
COMMENT ON COLUMN "public"."r_article"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."r_article"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."r_article"."is_deleted" IS '删除标志位：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."r_article"."read_num" IS '被阅读次数';
COMMENT ON COLUMN "public"."r_article"."weight" IS '文章权重，用于是否置顶（0: 未置顶；>0: 参与置顶，权重值越高越靠前）';
COMMENT ON COLUMN "public"."r_article"."type" IS '文章类型 - 1：普通文章，2：收录于知识库';
COMMENT ON TABLE "public"."r_article" IS '文章表';

-- ----------------------------
-- Records of r_article
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (19, '的点点滴滴', 'http://127.0.0.1:9000/blog/19646419add74bdf992bc4df2856a965.jpg', '我问问', '2025-09-15 13:28:18.012713', '2026-04-26 01:56:28.150942', 0, 11, 0, 1);
INSERT INTO "public"."r_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (31, '呃呃呃', 'http://127.0.0.1:9000/mint-blog/b7662dff124f4aeb97b8878245fe0dc5.jpg', '', '2025-12-10 16:28:59.993208', '2025-12-10 16:28:59.993208', 0, 15, 0, 1);
INSERT INTO "public"."r_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (1, 'HelloWorld', 'http://127.0.0.1:9000/blog/b7cbddadb4284110be72a6e102d170ca.jpg', '是公司给', '2023-06-01 15:16:44', '2026-05-24 20:28:02.890648', 0, 1223, 1, 2);
INSERT INTO "public"."r_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (32, '热额', 'http://127.0.0.1:9000/mint-blog/59c9f1ba55f943dbb7216cf7ed167aeb.webp', '', '2025-12-10 16:29:45.413586', '2025-12-10 16:29:45.413586', 0, 21, 0, 1);
INSERT INTO "public"."r_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (28, '对对对收到滴答滴答滴答滴答哒哒哒哒哒哒哒哒哒的的点点滴滴的点点滴滴哒哒哒哒哒哒1', 'http://127.0.0.1:9000/mint-blog/96b16205de6a43a4b6b0e8390d6d4738.jpg', '事实上事实上少时诵诗书是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒事实上事实上少时诵诗书是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒事实上事实上少时诵诗书1', '2025-10-13 09:29:53.183741', '2025-10-13 09:36:22.840566', 0, 22, 0, 1);
INSERT INTO "public"."r_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (24, '测试1', 'http://127.0.0.1:9000/mint-blog/6c2f5a28d5a94d89b82756a70abf1b2e.png', '', '2025-09-26 13:59:27.552137', '2026-04-26 23:12:05.22946', 0, 23, 0, 2);
INSERT INTO "public"."r_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (27, '555', 'http://127.0.0.1:9000/mint-blog/9eb7fb4ccb0840ba82c657710490ae16.png', '', '2025-10-10 15:07:59.795302', '2025-10-13 09:30:35.075991', 0, 7, 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for r_article_category_rel
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_article_category_rel";
CREATE TABLE "public"."r_article_category_rel" (
  "id" int8 NOT NULL DEFAULT nextval('t_article_category_rel_id_seq'::regclass),
  "article_id" int8 NOT NULL,
  "category_id" int8 NOT NULL
)
;
ALTER TABLE "public"."r_article_category_rel" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_article_category_rel"."id" IS 'id';
COMMENT ON COLUMN "public"."r_article_category_rel"."article_id" IS '文章id';
COMMENT ON COLUMN "public"."r_article_category_rel"."category_id" IS '分类id';
COMMENT ON TABLE "public"."r_article_category_rel" IS '文章所属分类关联表';

-- ----------------------------
-- Records of r_article_category_rel
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_article_category_rel" ("id", "article_id", "category_id") VALUES (128, 27, 22);
INSERT INTO "public"."r_article_category_rel" ("id", "article_id", "category_id") VALUES (131, 28, 17);
INSERT INTO "public"."r_article_category_rel" ("id", "article_id", "category_id") VALUES (162, 31, 11);
INSERT INTO "public"."r_article_category_rel" ("id", "article_id", "category_id") VALUES (163, 32, 23);
INSERT INTO "public"."r_article_category_rel" ("id", "article_id", "category_id") VALUES (166, 19, 6);
INSERT INTO "public"."r_article_category_rel" ("id", "article_id", "category_id") VALUES (178, 24, 5);
INSERT INTO "public"."r_article_category_rel" ("id", "article_id", "category_id") VALUES (179, 1, 5);
COMMIT;

-- ----------------------------
-- Table structure for r_article_content
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_article_content";
CREATE TABLE "public"."r_article_content" (
  "id" int8 NOT NULL DEFAULT nextval('t_article_content_id_seq'::regclass),
  "article_id" int8 NOT NULL,
  "content" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."r_article_content" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_article_content"."id" IS '文章内容id';
COMMENT ON COLUMN "public"."r_article_content"."article_id" IS '文章id';
COMMENT ON COLUMN "public"."r_article_content"."content" IS '教程正文';
COMMENT ON TABLE "public"."r_article_content" IS '文章内容表';

-- ----------------------------
-- Records of r_article_content
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_article_content" ("id", "article_id", "content") VALUES (27, 27, '555
![](http://127.0.0.1:9000/mint-blog/c55e74519be142ffbda25381ee643cab.png)
');
INSERT INTO "public"."r_article_content" ("id", "article_id", "content") VALUES (28, 28, '呃呃呃大胆
![](http://127.0.0.1:9000/mint-blog/00f07d86961342c7937abfcbfe647eb6.png)
![](http://127.0.0.1:9000/mint-blog/af0282e44bfe4658a5b0e2d0a30c8df1.png)

');
INSERT INTO "public"."r_article_content" ("id", "article_id", "content") VALUES (31, 31, '![](http://127.0.0.1:9000/mint-blog/b7662dff124f4aeb97b8878245fe0dc5.jpg)
');
INSERT INTO "public"."r_article_content" ("id", "article_id", "content") VALUES (32, 32, '![](http://127.0.0.1:9000/mint-blog/aebb844982d14ec5a4b98fae7160017f.jpg)
');
INSERT INTO "public"."r_article_content" ("id", "article_id", "content") VALUES (19, 19, '额鹅鹅鹅');
INSERT INTO "public"."r_article_content" ("id", "article_id", "content") VALUES (24, 24, '原有图片删除1![](http://127.0.0.1:9000/mint-blog/ee900214d6174d3887238798b758cea1.png)
原有图片保留2![](http://127.0.0.1:9000/mint-blog/3befd347c50946ae8022a43a36e6c1ea.png)

编辑新增![](http://127.0.0.1:9000/mint-blog/d1ea1b25fdca4fdeb59dbd678ac759f6.png)
编辑新增本地删除![](http://127.0.0.1:9000/mint-blog/27515b875c6f47e58199fccdc6249d5b.png)

## 上肯定是抠脚大汉
大傻吊
#### 好贱啊放假啊
大大大
## 多少多少
与太热
## 额问问
太远天通苑
### 额热热
额外额外
');
INSERT INTO "public"."r_article_content" ("id", "article_id", "content") VALUES (1, 1, '## 👋 自我介绍



![](http://127.0.0.1:9000/mint-blog/599ba5b9189f49d99bdf0b5c115a3a7b.jpg)





> 大家好，我是 程序员-杨工子。前某厂.Net全栈工程师，Mint.Blog作者。00后，码龄 3 年，目前供职于制造业互联网领域，主导负责过MES、数据传输、日志平台、任务调度、文件平台等产品，以支撑各部门业务线。喜欢分享知识，热爱技术，也不止于技术，不只是写 .Net，业余也爱玩前端、AI 等，是个活跃的技术折腾者。

```java

  @Test
  void testLog() {
      log.info("这是一行 Info 级别日志");
      log.warn("这是一行 Warn 级别日志");
      log.error("这是一行 Error 级别日志");

      // 占位符
      String author = "程序员-杨工子";
      log.info("这是一行带有占位符日志，作者：{}", author);
  }
  
```
---

> 本项目 1.0 版本已部署到云服务器上，可点击下面链接进行访问，查看实际效果：
>
> 演示地址：[https://www.yangmufa.cn](https://www.yangmufa.cn)
>
> 后台登录演示账号:
> 
> - 账号：test
> - 密码：test');
COMMIT;

-- ----------------------------
-- Table structure for r_article_tag_rel
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_article_tag_rel";
CREATE TABLE "public"."r_article_tag_rel" (
  "id" int8 NOT NULL DEFAULT nextval('t_article_tag_rel_id_seq'::regclass),
  "article_id" int8 NOT NULL,
  "tag_id" int8 NOT NULL
)
;
ALTER TABLE "public"."r_article_tag_rel" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_article_tag_rel"."id" IS 'id';
COMMENT ON COLUMN "public"."r_article_tag_rel"."article_id" IS '文章id';
COMMENT ON COLUMN "public"."r_article_tag_rel"."tag_id" IS '标签id';
COMMENT ON TABLE "public"."r_article_tag_rel" IS '文章对应标签关联表';

-- ----------------------------
-- Records of r_article_tag_rel
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_article_tag_rel" ("id", "article_id", "tag_id") VALUES (211, 27, 17);
INSERT INTO "public"."r_article_tag_rel" ("id", "article_id", "tag_id") VALUES (307, 31, 12);
INSERT INTO "public"."r_article_tag_rel" ("id", "article_id", "tag_id") VALUES (214, 28, 5);
INSERT INTO "public"."r_article_tag_rel" ("id", "article_id", "tag_id") VALUES (308, 32, 5);
INSERT INTO "public"."r_article_tag_rel" ("id", "article_id", "tag_id") VALUES (313, 19, 10);
INSERT INTO "public"."r_article_tag_rel" ("id", "article_id", "tag_id") VALUES (314, 19, 5);
INSERT INTO "public"."r_article_tag_rel" ("id", "article_id", "tag_id") VALUES (344, 24, 15);
INSERT INTO "public"."r_article_tag_rel" ("id", "article_id", "tag_id") VALUES (345, 1, 1);
INSERT INTO "public"."r_article_tag_rel" ("id", "article_id", "tag_id") VALUES (346, 1, 5);
INSERT INTO "public"."r_article_tag_rel" ("id", "article_id", "tag_id") VALUES (347, 1, 12);
COMMIT;

-- ----------------------------
-- Table structure for r_blog_settings
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_blog_settings";
CREATE TABLE "public"."r_blog_settings" (
  "id" int8 NOT NULL DEFAULT nextval('t_blog_settings_id_seq'::regclass),
  "logo" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "name" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "author" varchar(20) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "introduction" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "copyright_declaration" varchar(255) COLLATE "pg_catalog"."default",
  "avatar" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "github_homepage" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "csdn_homepage" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "gitee_homepage" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "zhihu_homepage" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "mail" varchar(60) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "is_comment_sensi_word_open" bool NOT NULL,
  "is_comment_examine_open" bool NOT NULL,
  "is_auto_theme" bool
)
;
ALTER TABLE "public"."r_blog_settings" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_blog_settings"."id" IS 'id';
COMMENT ON COLUMN "public"."r_blog_settings"."logo" IS '博客Logo';
COMMENT ON COLUMN "public"."r_blog_settings"."name" IS '博客名称';
COMMENT ON COLUMN "public"."r_blog_settings"."author" IS '作者名';
COMMENT ON COLUMN "public"."r_blog_settings"."introduction" IS '介绍语';
COMMENT ON COLUMN "public"."r_blog_settings"."copyright_declaration" IS '版权声明';
COMMENT ON COLUMN "public"."r_blog_settings"."avatar" IS '作者头像';
COMMENT ON COLUMN "public"."r_blog_settings"."github_homepage" IS 'GitHub 主页访问地址';
COMMENT ON COLUMN "public"."r_blog_settings"."csdn_homepage" IS 'CSDN 主页访问地址';
COMMENT ON COLUMN "public"."r_blog_settings"."gitee_homepage" IS 'Gitee 主页访问地址';
COMMENT ON COLUMN "public"."r_blog_settings"."zhihu_homepage" IS '知乎主页访问地址';
COMMENT ON COLUMN "public"."r_blog_settings"."mail" IS '博主邮箱地址';
COMMENT ON COLUMN "public"."r_blog_settings"."is_comment_sensi_word_open" IS '是否开启评论敏感词过滤, 0:不开启；1：开启';
COMMENT ON COLUMN "public"."r_blog_settings"."is_comment_examine_open" IS '是否开启评论审核, 0: 未开启；1：开启';
COMMENT ON COLUMN "public"."r_blog_settings"."is_auto_theme" IS '是否根据时间自动调整白天黑夜主题';
COMMENT ON TABLE "public"."r_blog_settings" IS '博客设置表';

-- ----------------------------
-- Records of r_blog_settings
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_blog_settings" ("id", "logo", "name", "author", "introduction", "copyright_declaration", "avatar", "github_homepage", "csdn_homepage", "gitee_homepage", "zhihu_homepage", "mail", "is_comment_sensi_word_open", "is_comment_examine_open", "is_auto_theme") VALUES (1, 'http://127.0.0.1:9000/blog/37149dac923e41528de8d80b0f5f4a43.webp', 'MintBlog', '程序员-杨工子', '大家好,我是程序员-杨工子,练习编程两年半,喜欢CV、Tab、Agent。', '保留所有权利，转载须注明出处和原文连接。', 'http://127.0.0.1:9000/blog/0539a7a5c6924f2398411a1b757c9d24.jpg', 'https://github.com/YangMufa/MintBlog', 'https://blog.csdn.net/YangMufa', 'https://gitee.com/YangMufa/MintBlog', 'https://www.zhihu.com/people/MintBlog', 'yangmufa@163.com', 't', 'f', 't');
COMMIT;

-- ----------------------------
-- Table structure for r_category
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_category";
CREATE TABLE "public"."r_category" (
  "id" int8 NOT NULL DEFAULT nextval('t_category_id_seq'::regclass),
  "name" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0,
  "articles_total" int4 NOT NULL DEFAULT 0,
  "sort" int8
)
;
ALTER TABLE "public"."r_category" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_category"."id" IS '分类id';
COMMENT ON COLUMN "public"."r_category"."name" IS '分类名称';
COMMENT ON COLUMN "public"."r_category"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."r_category"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."r_category"."is_deleted" IS '逻辑删除标志位：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."r_category"."articles_total" IS '此分类下文章总数';
COMMENT ON COLUMN "public"."r_category"."sort" IS '排序';
COMMENT ON TABLE "public"."r_category" IS '文章分类表';

-- ----------------------------
-- Records of r_category
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (17, '1112', '2025-09-14 23:24:02.722188', '2025-09-14 23:24:02.722188', 0, 1, 3);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (1, 'java', '2024-06-01 04:10:39', '2024-06-01 04:10:39', 0, 0, 3);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (5, 'CSharp', '2025-08-30 11:52:14', '2025-08-30 11:52:14', 0, 2, 1);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (20, '44441', '2025-09-14 23:24:16.552863', '2025-09-14 23:24:16.552863', 0, 0, 3);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (19, '4111', '2025-09-14 23:24:11.583695', '2025-09-14 23:24:11.583695', 0, 0, 4);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (8, '3333', '2025-09-14 23:23:03.91072', '2025-09-14 23:23:03.91072', 0, 0, 4);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (6, '三十岁', '2025-08-31 09:35:39', '2025-08-31 09:35:39', 0, 1, 5);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (22, '555555', '2025-09-14 23:24:30.741527', '2025-09-14 23:24:30.741527', 0, 1, 4);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (14, '9999991', '2025-09-14 23:23:44.635907', '2025-09-14 23:23:44.635907', 0, 0, 1);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (16, '1133', '2025-09-14 23:23:57.015623', '2025-09-14 23:23:57.015623', 0, 0, 2);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (18, '1113', '2025-09-14 23:24:07.277198', '2025-09-14 23:24:07.277198', 0, 0, 2);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (28, 'test', '2025-10-12 11:22:30.529926', '2025-10-12 11:22:30.530436', 0, 0, 0);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (10, '55555', '2025-09-14 23:23:14.015701', '2025-09-14 23:23:14.015701', 0, 0, 9);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (24, '71', '2025-09-14 23:24:39.176506', '2025-09-14 23:24:39.176506', 0, 0, 7);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (26, '72', '2025-09-14 23:53:12.432991', '2025-10-06 15:09:27.235862', 0, 0, 7);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (15, '74', '2025-09-14 23:23:50.166817', '2025-09-14 23:23:50.166817', 0, 0, 7);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (13, '999999999', '2025-09-14 23:23:31.689365', '2025-09-14 23:23:31.689365', 0, 0, 7);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (9, '4444', '2025-09-14 23:23:08.30614', '2025-09-14 23:23:08.30614', 0, 0, 5);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (11, '99999', '2025-09-14 23:23:20.007407', '2025-09-14 23:23:20.007407', 0, 1, 6);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (21, '44455', '2025-09-14 23:24:27.466987', '2025-09-14 23:24:27.466987', 0, 0, 5);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (23, '555551', '2025-09-14 23:24:34.799228', '2025-09-14 23:24:34.799228', 0, 1, 6);
INSERT INTO "public"."r_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (12, '73', '2025-09-14 23:23:25.862073', '2025-09-14 23:23:25.862073', 0, 0, 8);
COMMIT;

-- ----------------------------
-- Table structure for r_comment
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_comment";
CREATE TABLE "public"."r_comment" (
  "id" int8 NOT NULL DEFAULT nextval('t_comment_id_seq'::regclass),
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
ALTER TABLE "public"."r_comment" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_comment"."id" IS 'id';
COMMENT ON COLUMN "public"."r_comment"."content" IS '评论内容';
COMMENT ON COLUMN "public"."r_comment"."avatar" IS '头像';
COMMENT ON COLUMN "public"."r_comment"."nickname" IS '昵称';
COMMENT ON COLUMN "public"."r_comment"."mail" IS '邮箱';
COMMENT ON COLUMN "public"."r_comment"."website" IS '网站地址';
COMMENT ON COLUMN "public"."r_comment"."router_url" IS '评论所属的路由';
COMMENT ON COLUMN "public"."r_comment"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."r_comment"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."r_comment"."is_deleted" IS '删除标志位：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."r_comment"."reply_comment_id" IS '回复的评论 ID';
COMMENT ON COLUMN "public"."r_comment"."parent_comment_id" IS '父评论 ID';
COMMENT ON COLUMN "public"."r_comment"."reason" IS '原因描述';
COMMENT ON COLUMN "public"."r_comment"."status" IS '1: 待审核；2：正常；3：审核未通过;';
COMMENT ON TABLE "public"."r_comment" IS '评论表';

-- ----------------------------
-- Records of r_comment
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2, '三十岁', '', '我问问', 'yagnmufa@qq.com', '我问问', '/surfer/wiki/3', '2025-08-31 19:57:45', '2025-08-31 11:57:44', 0, NULL, NULL, '', 2);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (5, '放大发的', '', '我问问', 'yagnmufa@qq.com', '我问问', '/surfer/article/1', '2025-09-14 23:53:59.692747', '2025-09-14 23:53:59.697841', 0, NULL, NULL, '系统自动拦截，包含敏感词：[的]', 3);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (6, '放大发的发大发', '', '我问问', 'yagnmufa@qq.com', '我问问', '/surfer/article/1', '2025-09-14 23:54:05.372051', '2025-09-14 23:54:05.374887', 0, NULL, NULL, '系统自动拦截，包含敏感词：[的]', 3);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (8, '我问问', NULL, '', '', NULL, '', '2025-09-14 15:54:50.972091', '2025-09-14 15:54:50.972091', 0, NULL, NULL, '', 1);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (9, '呜呜呜呜', NULL, '', '', NULL, '', '2025-09-14 15:54:55.225906', '2025-09-14 15:54:55.225906', 0, NULL, NULL, '', 1);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (11, '呜呜呜呜呜呜', NULL, '', '', NULL, '', '2025-09-14 15:55:01.317563', '2025-09-14 15:55:01.317563', 0, NULL, NULL, '', 1);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (13, '呜呜呜呜呜呜呜', NULL, '', '', NULL, '', '2025-09-14 15:55:07.928365', '2025-09-14 15:55:07.928365', 0, NULL, NULL, '', 1);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (7, '放大发的发对对对大发', '', '我问问三四十岁', 'ya三十岁gnmufa@qq.com', '我对对对问问', '/surfer/article/1', '2025-09-14 23:54:16.525481', '2025-10-06 15:26:55.102678', 0, NULL, NULL, '', 2);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (10, '吾问无为谓', NULL, '', '', NULL, '', '2025-09-14 15:54:58.612195', '2025-09-14 15:54:58.612195', 1, NULL, NULL, '', 1);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (15, '对对对对对', '', '你猜', 'yangmufa@163.com', '你猜', '/surfer/articles/28', '2026-04-26 19:04:26.997428', '2026-04-26 19:04:26.998016', 0, NULL, NULL, '', 2);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (16, '😱👌😂😃😱😭😵', '', '你猜', 'yangmufa@163.com', '你猜', '/surfer/articles/28', '2026-04-26 19:05:15.569971', '2026-04-26 19:05:15.570115', 0, NULL, NULL, '', 2);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (17, '😂', '', '快乐小狗', '123@qq.com', '', '/surfer/wiki/3', '2026-04-29 23:14:00.233568', '2026-04-29 23:14:00.233707', 0, NULL, NULL, '', 2);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (18, '时间打开方式', '', '痛苦小狗', '123@qq.com', '', '/surfer/wiki/3', '2026-04-29 23:14:22.513093', '2026-04-29 23:14:22.514797', 0, 17, 17, '', 2);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (19, '试试顶顶顶顶', '', '忧郁小狗', '123@qq.com', '', '/surfer/wiki/3', '2026-04-29 23:14:34.770037', '2026-04-29 23:14:34.770458', 0, 18, 17, '', 2);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (20, '你说说你', '', '忧郁小狗', '123@qq.com', '', '/surfer/articles/8', '2026-04-29 23:15:03.561187', '2026-04-29 23:15:03.562158', 0, NULL, NULL, '', 2);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (21, '上帝视角可抵扣', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/8', '2026-04-29 23:15:27.588651', '2026-04-29 23:15:27.588723', 0, 20, 20, '', 2);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (22, '上帝视角可抵扣', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/8', '2026-04-29 23:15:32.186479', '2026-04-29 23:15:32.187475', 0, 20, 20, '', 2);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (23, '😃🙄🤩🙄🤭', '', '忧郁大狗', '123@qq.com', '', '/surfer/articles/8', '2026-04-29 23:35:05.827832', '2026-04-29 23:35:05.827574', 0, NULL, NULL, '', 2);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (24, '😘u😏uu', '', '忧郁大狗', '123@qq.com', '', '/surfer/wiki/3', '2026-04-29 23:35:23.359664', '2026-04-29 23:35:23.359611', 0, NULL, NULL, '', 2);
INSERT INTO "public"."r_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (3, '三十岁1', '', '我问问', 'yagnmufa@qq.com', '我问问', '/surfer/wiki/3', '2025-08-31 19:57:52', '2025-08-31 11:57:52', 0, 2, 2, '', 2);
COMMIT;

-- ----------------------------
-- Table structure for r_friend
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_friend";
CREATE TABLE "public"."r_friend" (
  "id" int4 NOT NULL DEFAULT nextval('r_friend_id_seq'::regclass),
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
ALTER TABLE "public"."r_friend" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_friend"."id" IS '友链ID，主键自增';
COMMENT ON COLUMN "public"."r_friend"."name" IS '友链名称';
COMMENT ON COLUMN "public"."r_friend"."description" IS '友链描述';
COMMENT ON COLUMN "public"."r_friend"."url" IS '友链地址';
COMMENT ON COLUMN "public"."r_friend"."avatar" IS '友链头像URL';
COMMENT ON COLUMN "public"."r_friend"."status" IS '友链状态：active-正常，inactive-停用，pending-待审核';
COMMENT ON COLUMN "public"."r_friend"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."r_friend"."category" IS 'tech技术类 tools工具类 avigation导航类 news新闻类 aggregate聚合类 life生活类 MintBlog优秀站点';
COMMENT ON COLUMN "public"."r_friend"."is_top" IS '是否置顶';
COMMENT ON COLUMN "public"."r_friend"."email" IS '联系邮箱';
COMMENT ON COLUMN "public"."r_friend"."sort" IS '排序权重';
COMMENT ON COLUMN "public"."r_friend"."is_deleted" IS '删除标志位：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."r_friend"."update_time" IS '更新时间，自动更新';
COMMENT ON TABLE "public"."r_friend" IS '友情链接表';

-- ----------------------------
-- Records of r_friend
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (7, '我问问', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'pending', '2025-10-20 16:31:25', 'aggregate', 'f', '', 1, 0, '2025-10-20 16:31:25.405073');
INSERT INTO "public"."r_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (4, '呃呃呃', '三十岁', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'active', '2025-10-20 16:27:45', 'tools', 'f', NULL, 1, 0, '2025-10-20 16:27:44.993882');
INSERT INTO "public"."r_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (6, 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'active', '2025-10-20 16:31:05', 'navigation', 'f', '', 5, 0, '2025-10-20 16:31:05.021387');
INSERT INTO "public"."r_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (5, '对对对', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'active', '2025-10-20 16:28:07', 'tools', 'f', NULL, 2, 0, '2025-10-20 16:28:06.796584');
INSERT INTO "public"."r_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (3, '发大发', '三十岁', 'http://localhost:9200/admin/friend/list', '大幅度', 'active', '2025-10-20 14:48:18', 'tech', 't', NULL, 3, 0, '2025-10-20 14:48:17.936368');
COMMIT;

-- ----------------------------
-- Table structure for r_statistics_article_pv
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_statistics_article_pv";
CREATE TABLE "public"."r_statistics_article_pv" (
  "id" int8 NOT NULL DEFAULT nextval('t_statistics_article_pv_id_seq'::regclass),
  "pv_date" date NOT NULL,
  "pv_count" int8 NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "public"."r_statistics_article_pv" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_statistics_article_pv"."id" IS 'id';
COMMENT ON COLUMN "public"."r_statistics_article_pv"."pv_date" IS '被统计的日期';
COMMENT ON COLUMN "public"."r_statistics_article_pv"."pv_count" IS 'pv访问量';
COMMENT ON COLUMN "public"."r_statistics_article_pv"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."r_statistics_article_pv"."update_time" IS '最后一次更新时间';
COMMENT ON TABLE "public"."r_statistics_article_pv" IS '统计表 - 文章 PV (访问量)';

-- ----------------------------
-- Records of r_statistics_article_pv
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (187, '2025-09-01', 0, '2025-08-31 02:18:36', '2025-08-31 02:18:36');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (189, '2025-09-12', 0, '2025-09-11 23:00:00.008798', '2025-09-11 23:00:00.008798');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (190, '2025-09-15', 0, '2025-09-14 23:23:39.237248', '2025-09-14 23:23:39.237248');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (191, '2025-09-19', 42, '2025-09-18 22:59:59.978008', '2025-09-18 22:59:59.978008');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (192, '2025-09-21', 7, '2025-09-20 23:00:00.017366', '2025-09-20 23:00:00.017366');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (193, '2025-09-23', 23, '2025-09-22 23:00:00.009551', '2025-09-22 23:00:00.009551');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (194, '2025-09-26', 7, '2025-09-25 23:38:58.456187', '2025-09-25 23:38:58.456187');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (195, '2025-10-02', 0, '2025-10-01 22:59:59.893081', '2025-10-01 22:59:59.893081');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (196, '2025-10-07', 49, '2025-10-06 00:04:48.182743', '2025-10-06 00:04:48.182743');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (197, '2025-10-09', 0, '2025-10-08 23:00:00.012131', '2025-10-08 23:00:00.012131');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (198, '2025-10-15', 0, '2025-10-14 22:59:59.943897', '2025-10-14 22:59:59.943897');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (199, '2025-12-18', 36, '2025-12-17 22:59:59.970538', '2025-12-17 22:59:59.970538');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (200, '2025-12-24', 0, '2025-12-23 22:59:58.054141', '2025-12-23 22:59:58.054141');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (0, '2026-04-14', 0, '2026-04-13 14:57:35.84666', '2026-04-13 14:57:35.846699');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (201, '2026-04-16', 0, '2026-04-15 16:06:53.727479', '2026-04-15 16:06:53.727491');
INSERT INTO "public"."r_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (202, '2026-04-17', 0, '2026-04-16 00:16:03.103552', '2026-04-16 00:16:03.103586');
COMMIT;

-- ----------------------------
-- Table structure for r_tag
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_tag";
CREATE TABLE "public"."r_tag" (
  "id" int8 NOT NULL DEFAULT nextval('t_tag_id_seq'::regclass),
  "name" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0,
  "articles_total" int4 NOT NULL DEFAULT 0,
  "sort" int8
)
;
ALTER TABLE "public"."r_tag" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_tag"."id" IS '标签id';
COMMENT ON COLUMN "public"."r_tag"."name" IS '标签名称';
COMMENT ON COLUMN "public"."r_tag"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."r_tag"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."r_tag"."is_deleted" IS '逻辑删除标志位：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."r_tag"."articles_total" IS '此标签下文章总数';
COMMENT ON COLUMN "public"."r_tag"."sort" IS '排序';
COMMENT ON TABLE "public"."r_tag" IS '文章标签表';

-- ----------------------------
-- Records of r_tag
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (1, 'test', '2024-06-01 12:11:18', '2024-06-01 12:11:18', 0, 1, 0);
INSERT INTO "public"."r_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (19, '呃呃呃呃呃呃', '2025-09-15 13:33:32.10755', '2025-09-15 13:33:32.10755', 0, 0, 6);
INSERT INTO "public"."r_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (12, '顶顶顶顶大胆', '2025-09-15 13:33:04.512558', '2025-09-15 13:33:04.512558', 0, 2, 2);
INSERT INTO "public"."r_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (18, '的点点滴滴', '2025-09-15 13:33:32.10755', '2025-11-06 20:30:33.477664', 1, 0, 7);
INSERT INTO "public"."r_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (10, '顶顶顶顶', '2025-08-31 17:35:46', '2025-08-31 17:35:46', 0, 1, 1);
INSERT INTO "public"."r_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (5, '就阿巴巴44', '2024-06-03 01:24:02', '2025-10-06 14:56:33.5207', 0, 4, 1);
INSERT INTO "public"."r_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (15, '达4', '2025-09-15 13:33:04.512558', '2025-09-15 13:33:04.512558', 0, 1, 2);
INSERT INTO "public"."r_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (17, '5555哈哈哈', '2025-09-15 13:33:04.512558', '2025-09-15 13:33:04.512558', 0, 1, 4);
COMMIT;

-- ----------------------------
-- Table structure for r_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_user";
CREATE TABLE "public"."r_user" (
  "id" int8 NOT NULL DEFAULT nextval('t_user_id_seq'::regclass),
  "username" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0
)
;
ALTER TABLE "public"."r_user" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_user"."id" IS 'id';
COMMENT ON COLUMN "public"."r_user"."username" IS '用户名';
COMMENT ON COLUMN "public"."r_user"."password" IS '密码';
COMMENT ON COLUMN "public"."r_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."r_user"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."r_user"."is_deleted" IS '逻辑删除：0：未删除 1：已删除';
COMMENT ON TABLE "public"."r_user" IS '用户表';

-- ----------------------------
-- Records of r_user
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_user" ("id", "username", "password", "create_time", "update_time", "is_deleted") VALUES (1, 'admin', '$2a$10$1YPbk/jdruITckB8o2ijauLRc.ecUMA1BdgLPraefUnf7lIm7l0Xi', '2023-07-03 11:57:18', '2023-09-24 16:23:29', 0);
INSERT INTO "public"."r_user" ("id", "username", "password", "create_time", "update_time", "is_deleted") VALUES (2, 'test', '$2a$10$v85pQHNk5jYrT0x2Jg9rVevH5K15jZdHqnPgekJz8HoWSd3ZloqY6', '2023-07-07 01:22:05', '2023-07-07 01:22:05', 0);
INSERT INTO "public"."r_user" ("id", "username", "password", "create_time", "update_time", "is_deleted") VALUES (5, '杨工子', '123456', '2025-08-25 11:39:10', '2025-08-25 11:39:10', 0);
COMMIT;

-- ----------------------------
-- Table structure for r_user_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_user_role";
CREATE TABLE "public"."r_user_role" (
  "id" int8 NOT NULL DEFAULT nextval('t_user_role_id_seq'::regclass),
  "username" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "role" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "public"."r_user_role" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_user_role"."id" IS 'id';
COMMENT ON COLUMN "public"."r_user_role"."username" IS '用户名';
COMMENT ON COLUMN "public"."r_user_role"."role" IS '角色';
COMMENT ON COLUMN "public"."r_user_role"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."r_user_role" IS '用户角色表';

-- ----------------------------
-- Records of r_user_role
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_user_role" ("id", "username", "role", "create_time") VALUES (1, 'admin', 'ROLE_ADMIN', '2023-07-07 01:21:15');
INSERT INTO "public"."r_user_role" ("id", "username", "role", "create_time") VALUES (2, 'test', 'ROLE_VISITOR', '2023-07-07 01:23:33');
COMMIT;

-- ----------------------------
-- Table structure for r_wiki
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_wiki";
CREATE TABLE "public"."r_wiki" (
  "id" int8 NOT NULL DEFAULT nextval('t_wiki_id_seq'::regclass),
  "title" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "cover" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "summary" varchar(160) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_deleted" int2 NOT NULL DEFAULT 0,
  "weight" int4 NOT NULL DEFAULT 0,
  "is_publish" int2 NOT NULL DEFAULT 1,
  "sort" int8
)
;
ALTER TABLE "public"."r_wiki" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_wiki"."id" IS 'id';
COMMENT ON COLUMN "public"."r_wiki"."title" IS '标题';
COMMENT ON COLUMN "public"."r_wiki"."cover" IS '封面';
COMMENT ON COLUMN "public"."r_wiki"."summary" IS '摘要';
COMMENT ON COLUMN "public"."r_wiki"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."r_wiki"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."r_wiki"."is_deleted" IS '删除标志位：0：未删除 1：已删除';
COMMENT ON COLUMN "public"."r_wiki"."weight" IS '权重，用于是否置顶（0: 未置顶；>0: 参与置顶，权重值越高越靠前）';
COMMENT ON COLUMN "public"."r_wiki"."is_publish" IS '是否发布：0：未发布 1：已发布';
COMMENT ON COLUMN "public"."r_wiki"."sort" IS '排序';
COMMENT ON TABLE "public"."r_wiki" IS '知识库表';

-- ----------------------------
-- Records of r_wiki
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_wiki" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (13, '三十岁5', 'http://127.0.0.1:9000/mint-blog/9846b0f06b4e47b4a374027a824080e7.png', '43434', '2025-09-15 13:34:15.022504', '2025-09-15 13:34:15.022504', 0, 0, 1, 4);
INSERT INTO "public"."r_wiki" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (16, '柔柔弱弱', 'http://127.0.0.1:9000/mint-blog/031779431d054fa5bc8c1a945eb822c4.webp', '柔柔弱弱', '2025-09-19 16:40:10.934364', '2025-09-19 16:40:10.934364', 0, 0, 1, 11);
INSERT INTO "public"."r_wiki" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (3, '测试知识库', 'http://127.0.0.1:9000/blog/78727197d828490eb83350d9b496e314.webp', '哎哟,测试知识库888', '2024-11-24 16:53:28', '2024-11-24 16:53:28', 0, 3, 1, 8);
COMMIT;

-- ----------------------------
-- Table structure for r_wiki_catalog
-- ----------------------------
DROP TABLE IF EXISTS "public"."r_wiki_catalog";
CREATE TABLE "public"."r_wiki_catalog" (
  "id" int8 NOT NULL DEFAULT nextval('t_wiki_catalog_id_seq'::regclass),
  "wiki_id" int8 NOT NULL,
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
ALTER TABLE "public"."r_wiki_catalog" OWNER TO "postgres";
COMMENT ON COLUMN "public"."r_wiki_catalog"."id" IS 'id';
COMMENT ON COLUMN "public"."r_wiki_catalog"."wiki_id" IS '知识库id';
COMMENT ON COLUMN "public"."r_wiki_catalog"."article_id" IS '文章id';
COMMENT ON COLUMN "public"."r_wiki_catalog"."title" IS '标题';
COMMENT ON COLUMN "public"."r_wiki_catalog"."level" IS '目录层级';
COMMENT ON COLUMN "public"."r_wiki_catalog"."parent_id" IS '父目录id';
COMMENT ON COLUMN "public"."r_wiki_catalog"."sort" IS '排序';
COMMENT ON COLUMN "public"."r_wiki_catalog"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."r_wiki_catalog"."update_time" IS '最后一次更新时间';
COMMENT ON COLUMN "public"."r_wiki_catalog"."is_deleted" IS '删除标志位：0：未删除 1：已删除';
COMMENT ON TABLE "public"."r_wiki_catalog" IS '知识库目录表';

-- ----------------------------
-- Records of r_wiki_catalog
-- ----------------------------
BEGIN;
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (51, 13, NULL, '概述', 1, NULL, 1, '2025-09-15 13:34:15.027063', '2025-09-15 13:34:15.027063', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (52, 13, NULL, '基础', 1, NULL, 2, '2025-09-15 13:34:15.027063', '2025-09-15 13:34:15.027063', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (57, 16, NULL, '概述', 1, NULL, 1, '2025-09-19 16:40:10.93642', '2025-09-19 16:40:10.93642', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (58, 16, NULL, '基础', 1, NULL, 2, '2025-09-19 16:40:10.93642', '2025-09-19 16:40:10.93642', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (714, 3, NULL, '概述', 1, NULL, 1, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (715, 3, 20, '请输入标题', 2, 714, 1, '2025-10-20 15:12:59.657106', '2025-10-20 15:12:59.657106', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (716, 3, 1, 'HelloWorld', 2, 714, 2, '2025-10-20 15:12:59.657106', '2025-10-20 15:12:59.657106', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (717, 3, 24, '测试1', 2, 714, 3, '2025-10-20 15:12:59.657106', '2025-10-20 15:12:59.657106', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (718, 3, 12, '我问问666', 2, 714, 4, '2025-10-20 15:12:59.657106', '2025-10-20 15:12:59.657106', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (719, 3, NULL, '基础', 1, NULL, 2, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (720, 3, NULL, '他666', 1, NULL, 3, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (721, 3, NULL, '777', 1, NULL, 4, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (722, 3, NULL, '888', 1, NULL, 5, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (723, 3, NULL, '999', 1, NULL, 6, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (724, 3, NULL, '111', 1, NULL, 7, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (725, 3, NULL, '111', 1, NULL, 8, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (726, 3, NULL, '1112', 1, NULL, 9, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (727, 3, NULL, '1113', 1, NULL, 10, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (728, 3, NULL, '1114', 1, NULL, 11, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (729, 3, NULL, '1115', 1, NULL, 12, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (730, 3, NULL, '1116', 1, NULL, 13, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (731, 3, NULL, '111167', 1, NULL, 14, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
INSERT INTO "public"."r_wiki_catalog" ("id", "wiki_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (732, 3, NULL, '1119', 1, NULL, 15, '2025-10-20 15:12:59.646983', '2025-10-20 15:12:59.646983', 0);
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
ALTER SEQUENCE "public"."r_friend_id_seq"
OWNED BY "public"."r_friend"."id";
SELECT setval('"public"."r_friend_id_seq"', 7, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_article_category_rel_id_seq"
OWNED BY "public"."r_article_category_rel"."id";
SELECT setval('"public"."t_article_category_rel_id_seq"', 179, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_article_content_id_seq"
OWNED BY "public"."r_article_content"."id";
SELECT setval('"public"."t_article_content_id_seq"', 32, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_article_id_seq"
OWNED BY "public"."r_article"."id";
SELECT setval('"public"."t_article_id_seq"', 32, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_article_tag_rel_id_seq"
OWNED BY "public"."r_article_tag_rel"."id";
SELECT setval('"public"."t_article_tag_rel_id_seq"', 347, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."t_blog_settings_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_category_id_seq"
OWNED BY "public"."r_category"."id";
SELECT setval('"public"."t_category_id_seq"', 28, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_comment_id_seq"
OWNED BY "public"."r_comment"."id";
SELECT setval('"public"."t_comment_id_seq"', 24, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_statistics_article_pv_id_seq"
OWNED BY "public"."r_statistics_article_pv"."id";
SELECT setval('"public"."t_statistics_article_pv_id_seq"', 200, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_tag_id_seq"
OWNED BY "public"."r_tag"."id";
SELECT setval('"public"."t_tag_id_seq"', 25, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_user_id_seq"
OWNED BY "public"."r_user"."id";
SELECT setval('"public"."t_user_id_seq"', 7, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_user_role_id_seq"
OWNED BY "public"."r_user_role"."id";
SELECT setval('"public"."t_user_role_id_seq"', 3, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_wiki_catalog_id_seq"
OWNED BY "public"."r_wiki_catalog"."id";
SELECT setval('"public"."t_wiki_catalog_id_seq"', 732, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_wiki_id_seq"
OWNED BY "public"."r_wiki"."id";
SELECT setval('"public"."t_wiki_id_seq"', 16, true);

-- ----------------------------
-- Indexes structure for table r_article
-- ----------------------------
CREATE INDEX "idx_create_time" ON "public"."r_article" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table r_article
-- ----------------------------
ALTER TABLE "public"."r_article" ADD CONSTRAINT "t_article_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table r_article_category_rel
-- ----------------------------
CREATE INDEX "idx_category_id" ON "public"."r_article_category_rel" USING btree (
  "category_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uni_article_id" ON "public"."r_article_category_rel" USING btree (
  "article_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table r_article_category_rel
-- ----------------------------
ALTER TABLE "public"."r_article_category_rel" ADD CONSTRAINT "t_article_category_rel_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table r_article_content
-- ----------------------------
CREATE INDEX "idx_article_id" ON "public"."r_article_content" USING btree (
  "article_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table r_article_content
-- ----------------------------
ALTER TABLE "public"."r_article_content" ADD CONSTRAINT "t_article_content_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table r_article_tag_rel
-- ----------------------------
CREATE INDEX "idx_article_id_tag" ON "public"."r_article_tag_rel" USING btree (
  "article_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_tag_id" ON "public"."r_article_tag_rel" USING btree (
  "tag_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table r_article_tag_rel
-- ----------------------------
ALTER TABLE "public"."r_article_tag_rel" ADD CONSTRAINT "t_article_tag_rel_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table r_blog_settings
-- ----------------------------
ALTER TABLE "public"."r_blog_settings" ADD CONSTRAINT "r_blog_settings_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table r_category
-- ----------------------------
CREATE INDEX "idx_create_time_category" ON "public"."r_category" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uk_name" ON "public"."r_category" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table r_category
-- ----------------------------
ALTER TABLE "public"."r_category" ADD CONSTRAINT "t_category_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table r_comment
-- ----------------------------
CREATE INDEX "idx_create_time_comment" ON "public"."r_comment" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_parent_comment_id" ON "public"."r_comment" USING btree (
  "parent_comment_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_reply_comment_id" ON "public"."r_comment" USING btree (
  "reply_comment_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_router_url" ON "public"."r_comment" USING btree (
  "router_url" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table r_comment
-- ----------------------------
ALTER TABLE "public"."r_comment" ADD CONSTRAINT "t_comment_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table r_friend
-- ----------------------------
ALTER TABLE "public"."r_friend" ADD CONSTRAINT "r_friend_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table r_statistics_article_pv
-- ----------------------------
CREATE UNIQUE INDEX "uk_pv_date" ON "public"."r_statistics_article_pv" USING btree (
  "pv_date" "pg_catalog"."date_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table r_statistics_article_pv
-- ----------------------------
ALTER TABLE "public"."r_statistics_article_pv" ADD CONSTRAINT "t_statistics_article_pv_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table r_tag
-- ----------------------------
CREATE INDEX "idx_create_time_tag" ON "public"."r_tag" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uk_name_tag" ON "public"."r_tag" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table r_tag
-- ----------------------------
ALTER TABLE "public"."r_tag" ADD CONSTRAINT "t_tag_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table r_user
-- ----------------------------
CREATE UNIQUE INDEX "uk_username" ON "public"."r_user" USING btree (
  "username" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table r_user
-- ----------------------------
ALTER TABLE "public"."r_user" ADD CONSTRAINT "t_user_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table r_user_role
-- ----------------------------
CREATE INDEX "idx_username" ON "public"."r_user_role" USING btree (
  "username" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table r_user_role
-- ----------------------------
ALTER TABLE "public"."r_user_role" ADD CONSTRAINT "t_user_role_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table r_wiki
-- ----------------------------
CREATE INDEX "idx_create_time_wiki" ON "public"."r_wiki" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uk_title_wiki" ON "public"."r_wiki" USING btree (
  "title" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table r_wiki
-- ----------------------------
ALTER TABLE "public"."r_wiki" ADD CONSTRAINT "t_wiki_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table r_wiki_catalog
-- ----------------------------
CREATE INDEX "idx_parent_id_catalog" ON "public"."r_wiki_catalog" USING btree (
  "parent_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sort" ON "public"."r_wiki_catalog" USING btree (
  "sort" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_wiki_id" ON "public"."r_wiki_catalog" USING btree (
  "wiki_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "uk_article_id_catalog" ON "public"."r_wiki_catalog" USING btree (
  "article_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table r_wiki_catalog
-- ----------------------------
ALTER TABLE "public"."r_wiki_catalog" ADD CONSTRAINT "t_wiki_catalog_pkey" PRIMARY KEY ("id");
