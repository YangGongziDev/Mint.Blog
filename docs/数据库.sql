/*
 Navicat Premium Dump SQL

 Source Server         : Local_Docker-YangMufa666
 Source Server Type    : PostgreSQL
 Source Server Version : 180003 (180003)
 Source Host           : localhost:5432
 Source Catalog        : Mint.Blog
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180003 (180003)
 File Encoding         : 65001

 Date: 30/05/2026 00:18:52
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
COMMENT ON COLUMN "public"."blog_article"."visibility" IS '文章可见性，1：公开可见 2：仅专栏可见';
COMMENT ON TABLE "public"."blog_article" IS '文章表';

-- ----------------------------
-- Records of blog_article
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (11, '呜呜呜呜', 'http://127.0.0.1:9000/roc-blog/defa867aae8a459c97abf6bcad52ffb0.png', '', '2025-08-31 17:35:33', '2025-09-14 21:02:31.531838', 0, 4, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (32, '热额', 'http://127.0.0.1:9000/blog-article/%E6%9A%97%E9%BB%91%20%E5%A5%B3%E5%AD%A9%E8%83%8C%E5%BD%B1%20%E9%97%A8%20%E5%85%89%E5%BD%B14k%E5%8A%A8%E6%BC%AB%E5%A3%81%E7%BA%B8_%E5%BD%BC%E5%B2%B8%E5%9B%BE%E7%BD%91.jpg', '哒哒哒', '2025-11-27 16:29:45.413586', '2026-05-23 18:12:06.014173', 0, 48, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (24, '测试1', 'http://127.0.0.1:9000/roc-blog/6c2f5a28d5a94d89b82756a70abf1b2e.png', '', '2025-09-12 05:59:27.552137', '2025-09-12 06:02:12.298849', 0, 52, 0, 2);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (16, '对对对', 'http://127.0.0.1:9000/roc-blog/220f1c4e1ced470485e79d506d49625a.jpg', '', '2025-09-14 15:36:49.75829', '2025-09-14 15:36:49.75829', 0, 3, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (20, '654323', 'http://127.0.0.1:9000/roc-blog/a68d632550044364a04de5298fcdb75b.png', '', '2025-09-18 23:31:22.584622', '2025-09-18 23:31:22.584622', 1, 20, 0, 2);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (31, '呃呃呃', 'http://127.0.0.1:9000/blog-article/%E6%9A%97%E9%BB%91%20%E5%A5%B3%E5%AD%A9%E8%83%8C%E5%BD%B1%20%E9%97%A8%20%E5%85%89%E5%BD%B14k%E5%8A%A8%E6%BC%AB%E5%A3%81%E7%BA%B8_%E5%BD%BC%E5%B2%B8%E5%9B%BE%E7%BD%91.jpg', '呃呃呃', '2025-12-07 16:28:59.993208', '2026-05-24 02:07:45.318227', 0, 8, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (28, '对对对收到滴答滴答滴答滴答哒哒哒哒哒哒哒哒哒的的点点滴滴的点点滴滴哒哒哒哒哒哒1', 'http://127.0.0.1:9000/roc-blog/96b16205de6a43a4b6b0e8390d6d4738.jpg', '事实上事实上少时诵诗书是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒事实上事实上少时诵诗书是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒是撒事实上事实上少时诵诗书1', '2025-10-07 09:29:53.183741', '2025-10-07 09:36:22.840566', 0, 34, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (17, '三十岁', 'http://127.0.0.1:9000/roc-blog/2cbe14f46e694ed98b7c269270b922f3.png', '', '2025-09-13 23:37:13.908353', '2025-09-13 23:37:13.908353', 0, 5, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (8, '吞吞吐吐88', 'http://127.0.0.1:9000/blog-article/89056c263d5b45a1a37eb353e308a0c2.jpg', '88', '2025-03-26 17:28:13', '2026-05-25 13:19:20.36947', 0, 490, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (10, '打发打发发方法', 'http://127.0.0.1:9000/blog-article/BingWallpaper.jpg', '热热热', '2025-08-02 09:12:25', '2026-05-25 13:19:22.203119', 0, 110, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (14, '额鹅鹅鹅', 'http://127.0.0.1:9000/roc-blog/9de62585956545ce8fcc309696815706.ico', '', '2025-09-12 20:56:42.967417', '2025-09-12 20:56:42.967417', 0, 10, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (9, '5555', 'http://127.0.0.1:9000/roc-blog/8ae62f57a7e7472c9c9d761aa4534db8.png', '', '2025-08-24 17:33:39', '2025-09-12 13:03:37.283973', 0, 14, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (12, '我问问666', 'http://127.0.0.1:9000/roc-blog/db82f25715494699acbbb8de82047dc0.png', '我问问', '2025-08-19 03:27:05', '2025-10-25 05:17:47.315291', 0, 54, 2, 2);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (27, '555', 'http://127.0.0.1:9000/roc-blog/9eb7fb4ccb0840ba82c657710490ae16.png', '', '2025-10-10 07:07:59.795302', '2025-10-13 01:30:35.075991', 0, 7, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (19, '的点点滴滴', 'http://127.0.0.1:9000/blog-article/19646419add74bdf992bc4df2856a965.jpg', '我问问', '2025-09-13 21:28:18.012713', '2025-09-13 21:28:18.012713', 0, 15, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (18, '呃呃呃顶顶顶顶', 'http://127.0.0.1:9000/roc-blog/6420c86e629b478fa5badc771c22dde3.jpg', '', '2025-09-14 08:06:35.656392', '2025-09-14 08:06:35.656392', 0, 5, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (2056031402947907584, '谁放松放松', 'http://127.0.0.1:9000/blog-article/4.png', '大傻吊', '2026-05-08 07:17:40.327355', '2026-05-28 23:54:05.271088', 0, 24, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (2060251596750721024, '特提斯', 'http://127.0.0.1:9000/blog-article/15F50DB1BFF841CCE736F962D4B1E56D.png', '哒哒哒', '2026-05-23 06:47:12.942947', '2026-05-28 01:21:10.183875', 0, 16, 0, 1);
INSERT INTO "public"."blog_article" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "read_num", "weight", "type") VALUES (1, 'HelloWorld', 'http://127.0.0.1:9000/blog-article/b7cbddadb4284110be72a6e102d170ca.jpg', '是公司给', '2023-01-16 15:16:44', '2026-04-28 05:19:52.246709', 0, 1627, 1, 1);
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
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (78, 14, 5);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (82, 11, 5);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (84, 9, 5);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (86, 16, 11);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (87, 17, 11);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (88, 18, 12);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (89, 19, 6);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (92, 20, 11);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (97, 24, 5);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (128, 27, 22);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (131, 28, 17);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (138, 12, 5);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (2058731716784295936, 31, 11);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (2058732810205794304, 32, 23);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (2058900726490468352, 8, 0);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (2058900734178627584, 10, 5);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (2058900860183908352, 1, 5);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (2060268425703460864, 2056031402947907584, 20);
INSERT INTO "public"."blog_article_category_rel" ("id", "article_id", "category_id") VALUES (2060290340681814016, 2060251596750721024, 17);
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
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (14, 14, '额鹅鹅鹅');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (11, 11, '请输入内容');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (9, 9, '请输入内容555');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (16, 16, '对对对');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (17, 17, '对对对');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (18, 18, '呃呃呃');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (19, 19, '额鹅鹅鹅');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (20, 20, '555555555');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (27, 27, '555
![](http://127.0.0.1:9000/roc-blog/c55e74519be142ffbda25381ee643cab.png)
');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (28, 28, '呃呃呃大胆
![](http://127.0.0.1:9000/roc-blog/00f07d86961342c7937abfcbfe647eb6.png)
![](http://127.0.0.1:9000/roc-blog/af0282e44bfe4658a5b0e2d0a30c8df1.png)

');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (12, 12, '请输入内容我问问');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (24, 24, '## 👋 自我介绍



![](http://127.0.0.1:9000/roc-blog/599ba5b9189f49d99bdf0b5c115a3a7b.jpg)





> 大家好，我是鲲鲲。前某厂中台架构，公众号 程序员菜鲲 作者。95后，码龄 2 年，先后供职于支付、共享等互联网领域，主导负责过数据传输、日志平台、任务调度、文件平台等产品，以支撑各部门业务线。喜欢分享知识，热爱技术，也不止于技术，不只是写 Java，业余也爱玩前端、.Net 等，是个活跃的技术折腾者。

```java

  @Test
  void testLog() {
      log.info("这是一行 Info 级别日志");
      log.warn("这是一行 Warn 级别日志");
      log.error("这是一行 Error 级别日志");

      // 占位符
      String author = "鲲鲲";
      log.info("这是一行带有占位符日志，作者：{}", author);
  }
  
```
---

> 本项目 1.0 版本已部署到云服务器上，可点击下面链接进行访问，查看实际效果：
>
> 演示地址：[https://www.yanggongzi.dev](https://www.yanggongzi.dev)
>
> 后台登录演示账号:
> 
> - 账号：GenerallyAdmin
> - 密码：GenerallyAdmin

## 🏃 关于实战项目

知识星球是个私密学习圈子，我会在星球内部，出**一系列从 0 到 1 的实战项目，贴合真实的企业级项目开发规范，使用主流的企业技术栈，全程手写后端 + 前端完整代码，通过专栏的形式，把每个功能点的开发的步骤，手摸手，通过丰富的图片 + 文字，保姆级教学（PS: 同时按小节进度提供代码，不至于一上来代码量太多，不知道从哪入手）**。


![](https://img.yanggongzi.dev/ibp/169361945065538)

目前，我已经给自己的网站：[练习生基地](https://www.yanggongzi.dev/column "练习生基地") 新开发了专栏模块，可以让小伙伴们只需跟着实战专栏，按照章节顺序教学来，上手敲，即可搞定每个功能点的开发，成体系地完成一个独立项目。*目前加入的小伙伴，都给出了超高评价，以下了截取了部分好评*：

![](https://img.yanggongzi.dev/ibp/169733756405612)

![](https://img.yanggongzi.dev/ibp/169733761293187)

![](https://img.yanggongzi.dev/ibp/169733762195775)

另外，在跟随小节内容上手的过程中，若遇到问题，可在星球内发起 *1v1 提问，鲲鲲亲自解答*。

!["星球内提问"](https://img.yanggongzi.dev/ibp/169396126861858 "星球内提问")

星球说不清楚的，项目进度因为某一块搞不定的，微信发我源码，帮忙看问题出在哪：

![搞不定的，微信发我源码，帮忙看问题出在哪](https://img.yanggongzi.dev/ibp/169406285385964 "搞不定的，微信发我源码，帮忙看问题出在哪")


陪伴式写项目，到最终部署到云服务器上，能够通过域名来访问，完成项目上线。

> 💡 TIP : 后期也会尝试分享一些适合程序员的技术副业，比如开发一些小工具网站，进行推广运营，有了一定用户量，能够挣点零花钱啥的。当然，这都是后话了，前提还需要你能够自行完整的开发一个独立应用，前期还是以项目实战为主。

既然鲲鲲是准备出一系列的实战项目，我希望这些项目的难度是循序渐进的，能够让你真实的感受到自己的功力在慢慢增强。但是又不想写那种纯纯的 CRUD 型管理后台项目，太枯燥。那么，第一个项目鲲鲲就定位在难度不大，易上手，有趣，并且非常有代表性，实际工作中也能够被频繁用到的。

脑瓜子一转，想到之前好多读者问我博客的事情，今年 4 月份的时候，又有读者微信问我: *你的博客有没有开源，感觉还挺好看，也想学习、部署一个。*

![](https://img.yanggongzi.dev/ibp/169355366112215)

于是乎，花了点时间整了第一个实战项目 —— **前后端分离的博客 ibp**。


## 💁 项目介绍

每个技术人都应该有属于自己的博客！相比较直接使用第三方博客平台，自行搭建博客更有成就感；另外就是没有平台限制，比如你想发个二维码引流啥的，平台基本都是不允许的，还有，你可以自由 `div` 定制自己想要的博客 `css` 样式，哪天 UI 看不爽了，咱就自己换；最后，*面试的时候，如果简历贴上的是自己开发博客地址，也会很加分*！

### 🔗 演示地址

目前 1.0 版本已经部署到了阿里云服务器上，可点击下面链接进行访问，查看实际效果：

[https://www.yanggongzi.dev](https://www.yanggongzi.dev "https://www.yanggongzi.dev")

管理后台登录账号/密码:

- 账号：test
- 密码：test

> ⚠️ 注意：该账号的角色为*游客*角色，*仅支持查询操作*，新增、修改、删除操作会提示不允许。

### ⚒️ 功能模块

> 💡 TIP : 以下*只是 1.0 版本的功能，后续鲲鲲将添加更多功能进去, 比如图库管理、知识库、在线人数统计、SSR（服务端渲染） 等等*，能够想到的高逼格功能，咱都整上，附带超详细的实战图文笔记 ...

![ibp 功能模块一览](https://img.yanggongzi.dev/ibp/169560157482464 "ibp 功能模块一览")

### ✏️ 技术栈

![ibp 技术栈一览](https://img.yanggongzi.dev/ibp/169560181378937 "ibp 技术栈一览")

## 🎉 专栏目标

学完本项目，你将具备如下能力：

- 掌握独立开发全栈项目的能力（*后端 + 前端*）；
- 掌握 Spring Boot 相关技术栈，以及构建后端项目能力，写出符合企业级的代码规范；
- 掌握 Vue 3.2 + Element Plus + Vite 4 技术构建前端工程的能力，并能够手动搭建 Admin 后台管理系统；
- 掌握前端页面响应式设计（同时适配不同屏幕），排版布局，能够根据自己需求，`div` 自己想要的前端效果；
- ...

## 💡 专栏亮点

- 在技术选型上，鲲鲲选择了目前主流热门的技术栈，对标企业级项目开发；
- 严格把控代码质量，数据库设计，写出令同事称道的代码；
- 熟悉后端工程的搭建，如一些通用的基础设施：参数校验、全局异常捕获、`API` 统一出入参日志打印等等；
- 能够独立完成整个网站的部署流程，从功能开发到服务器、域名选购，再到网站备案，最终公网可访问；
- 对象存储 `Minio` 的使用, 能够独立搭建个人图床；
- 从 0 到 1 ，通过 `Element Plus` 纯手搭 `Admin` 管理后台前端骨架；
- 使用 Vue 3 `setup` 等语法糖新特性；
- 博客前台页面在设计上美观大气；
- ...

## 📖 专栏大纲

整个实战专栏，鲲鲲按功能点开发进度来做的目录，目前已经更新到了第第五章，目录大致如下：

> 💡 TIP : 如下目录不代表最终内容，只会更多，目前只是把已完成的部分详细的罗列了出来，其中大部分功能正在开发中，所属具体小节的标题也会陆续更新进来。

- 一、[项目介绍](https://www.yanggongzi.dev/column/10000.html)
- 二、开发环境搭建
  - [2.1 【后端】环境安装&工具准备](https://www.yanggongzi.dev/column/10003.html)
  - [2.2 【前端】开发环境&工具安装](https://www.yanggongzi.dev/column/10004.html)

- 三、Spring Boot 后端工程搭建
  - [3.1 搭建 Spring Boot 多模块工程](https://www.yanggongzi.dev/column/10005.html)
  - [3.2 Spring Boot 多环境配置](https://www.yanggongzi.dev/column/10006.html)
  - [3.3 配置 Lombok](https://www.yanggongzi.dev/column/10007.html)
  - [3.4 Spring Boot 整合 Lockback 日志](https://www.yanggongzi.dev/column/10008.html)
  - [3.5 Spring Boot 自定义注解，实现 API 请求日志切面](https://www.yanggongzi.dev/column/10009.html)
  - [3.6 Spring Boot 通过 MDC 实现日志跟踪](https://www.yanggongzi.dev/column/10010.html)
  - [3.7 Spring Boot 实现优雅的参数校验](https://www.yanggongzi.dev/column/10011.html)
  - [3.8 Spring Boot 自定义响应工具类](https://www.yanggongzi.dev/column/10012.html)
  - [3.9 Spring Boot 实现全局异常管理](https://www.yanggongzi.dev/column/10013.html)
  - [3.10 全局异常处理器+参数校验（最佳实践）](https://www.yanggongzi.dev/column/10014.html)
  - [3.11 整合 Knife4j：提升接口调试效率](https://www.yanggongzi.dev/column/10015.html)
  - [3.12 自定义 Jackson 序列化、反序列化，支持 Java 8 日期新特性](https://www.yanggongzi.dev/column/10016.html)
  - [3.13 小结](https://www.yanggongzi.dev/column/10017.html)

- 四、使用 Vue 3 + Vite 4 搭建前端工程
  - [4.1 Vue 3 环境安装& ibp 项目搭建](https://www.yanggongzi.dev/column/10018.html)
  - [4.2 安装 VSCode 开发工具](https://www.yanggongzi.dev/column/10019.html)
  - [4.3 添加 vue-router 路由管理器](https://www.yanggongzi.dev/column/10020.html)
  - [4.4 Vite 配置路径别名：更方便的引用文件](https://www.yanggongzi.dev/column/10021.html)
  - [4.5 整合 Tailwind CSS](https://www.yanggongzi.dev/column/10022.html)
  - [4.6 整合 Tailwind CSS 组件库：Flowbite](https://www.yanggongzi.dev/column/10023.html)
  - [4.7 整合饿了么 Element Plus 组件库](https://www.yanggongzi.dev/column/10024.html)

- 五、登录模块开发
  - [5.1 登录页设计：支持响应式布局](https://www.yanggongzi.dev/column/10025.html)
  - [5.2 登录页加点盐：通过 Animate.css 添加动画](https://www.yanggongzi.dev/column/10026.html)
  - [5.3 整合 Mybatis Plus](https://www.yanggongzi.dev/column/10027.html)
  - [5.4 p6spy 组件打印完整的 SQL 语句、执行耗时](https://www.yanggongzi.dev/column/10028.html)
  - [5.5 整合 Spring Security](https://www.yanggongzi.dev/column/10029.html)
  - [5.6 Spring Security 整合 JWT ：实现身份认证](https://www.yanggongzi.dev/column/10030.html)
  - [5.7 Spring Security 整合 JWT ：实现接口鉴权](https://www.yanggongzi.dev/column/10031.html)
  - [5.8 Vue 整合 Axios 实现登录功能](https://www.yanggongzi.dev/column/10032.html)
  - [5.9 登录页表单验证](https://www.yanggongzi.dev/column/10033.html)
  - [5.10 登录消息提示、回车键监听、按钮加载 Loading](https://www.yanggongzi.dev/column/10034.html)
  - [5.11 存储 Token 到 Cookie 中](https://www.yanggongzi.dev/column/10035.html)
  - [5.12 Axios 添加请求拦截器、响应拦截器](https://www.yanggongzi.dev/column/10036.html)
  - [5.13 全局路由拦截：实现页面标题动态设置、后台路由跳转的登录判断](https://www.yanggongzi.dev/column/10037.html)
  - [5.14 实现页面顶部加载 Loading 效果](https://www.yanggongzi.dev/column/10038.html)
  - [5.15 重复登录问题优化、密码框可显示密码](https://www.yanggongzi.dev/column/10040.html)
  - [5.16 角色鉴权：添加演示账号，仅支持查询操作](https://www.yanggongzi.dev/column/10089.html)
  
  
  

- 六、Element Plus 手搭 Admin 管理后台骨架
  - [6.1 搭建管理后台基本布局](https://www.yanggongzi.dev/column/10039.html)
  - [6.2 后台公共 Header 头：样式布局](https://www.yanggongzi.dev/column/10041.html)
  - [6.3 后台公共左侧 Menu 菜单栏：样式布局](https://www.yanggongzi.dev/column/10042.html)
  - [6.4 整合全局状态管理库 Pinia](https://www.yanggongzi.dev/column/10043.html)
  - [6.5 左边菜单栏点击收缩、展开功能实现](https://www.yanggongzi.dev/column/10044.html)
  - [6.6 支持全屏展示、页面点击刷新](https://www.yanggongzi.dev/column/10045.html)
  - [6.7 标签导航栏组件实现：样式布局](https://www.yanggongzi.dev/column/10046.html)
  - [6.8 标签导航栏组件实现：路由同步 (1)](https://www.yanggongzi.dev/column/10047.html)
  - [6.9 标签导航栏组件实现：路由同步 (2)](https://www.yanggongzi.dev/column/10048.html)
  - [6.10 标签导航栏组件实现：标签页关闭](https://www.yanggongzi.dev/column/10049.html)
  - [6.11 标签导航栏组件实现：关闭其他、全部标签页](https://www.yanggongzi.dev/column/10050.html)
  - [6.12 后台公共 Footer 页脚：样式布局](https://www.yanggongzi.dev/column/10051.html)
  - [6.13 使用 KeepAlive 缓存组件，提高页面切换性能和响应速度](https://www.yanggongzi.dev/column/10052.html)
  - [6.14 使用 Transition 组件添加全局过渡动画](https://www.yanggongzi.dev/column/10053.html)
  - [6.15 修改用户密码接口开发](https://www.yanggongzi.dev/column/10054.html)
  - [6.16 获取当前登录用户信息接口开发](https://www.yanggongzi.dev/column/10055.html)
  - [6.17 Pinia 存储用户信息，动态显示登录用户名](https://www.yanggongzi.dev/column/10056.html)
  - [6.18 使用 pinia-persist 插件实现 Pinia 数据持久化](https://www.yanggongzi.dev/column/10057.html)
  - [6.19 用户修改密码、退出登录功能开发](https://www.yanggongzi.dev/column/10058.html)
  - [6.20 小结](https://www.yanggongzi.dev/column/10059.html)

  

  
- 七、管理后台：文章分类模块开发
  - [7.1 分类模块接口分析](https://www.yanggongzi.dev/column/10060.html)
  - [7.2 文章分类：新增接口开发](https://www.yanggongzi.dev/column/10061.html)
  - [7.3 文章分类：分页接口开发](https://www.yanggongzi.dev/column/10062.html)
  - [7.4 文章分类：删除接口开发](https://www.yanggongzi.dev/column/10063.html)
  - [7.5 文章发布：分类 Select 下拉列表接口开发](https://www.yanggongzi.dev/column/10064.html)
  - [7.6 后台分类管理页面：样式布局](https://www.yanggongzi.dev/column/10065.html)
  - [7.7 Config Provider 全局配置: 实现组件中文化](https://www.yanggongzi.dev/column/10066.html)
  - [7.8 文章分类：分页列表数据动态渲染](https://www.yanggongzi.dev/column/10067.html)
  - [7.9 文章分类：新增功能开发](https://www.yanggongzi.dev/column/10068.html)
  - [7.10 文章分类：删除功能开发](https://www.yanggongzi.dev/column/10069.html)
  - [7.11 通用表单对话框组件封装](https://www.yanggongzi.dev/column/10070.html)
  - [7.12 添加 Table 组件加载 Loading 、表单对话框提交按钮 Loading 动画](https://www.yanggongzi.dev/column/10071.html)
  


- 八、管理后台：标签模块开发
  - [8.1 标签模块接口分析【视频讲解】](https://www.yanggongzi.dev/column/10072.html)
  - [8.2 标签管理：新增标签接口开发【视频讲解】](https://www.yanggongzi.dev/column/10073.html)
  - [8.3 标签管理：标签分页接口开发【视频讲解】](https://www.yanggongzi.dev/column/10074.html)
  - [8.4 标签管理：删除标签接口开发【视频讲解】](https://www.yanggongzi.dev/column/10075.html)
  - [8.5 标签关键词模糊查询 select 列表接口开发【视频讲解】](https://www.yanggongzi.dev/column/10076.html)
  - [8.6 标签管理页面开发：分页列表【视频讲解】](https://www.yanggongzi.dev/column/10077.html)
  - [8.7 标签管理页面开发：新增&删除标签功能【视频讲解】](https://www.yanggongzi.dev/column/10078.html)
  
  
  
- 九、管理后台：博客设置模块开发
  - [9.1 博客设置模块功能分析、表设计](https://www.yanggongzi.dev/column/10079.html)
  - [9.2 Docker 本地安装 Minio 对象存储](https://www.yanggongzi.dev/column/10080.html)
  - [9.3 文件上传接口开发](https://www.yanggongzi.dev/column/10081.html)
  - [9.4 博客设置: 更新接口开发](https://www.yanggongzi.dev/column/10082.html)
  - [9.5 整合 Mapstruct : 简化属性映射](https://www.yanggongzi.dev/column/10083.html)
  - [9.6 博客设置：获取详情接口开发](https://www.yanggongzi.dev/column/10084.html)
  - [9.7 博客设置页面：样式布局](https://www.yanggongzi.dev/column/10085.html)
  - [9.8 管理后台：滚动样式优化](https://www.yanggongzi.dev/column/10086.html)
  - [9.9 博客设置页：数据渲染、图片上传](https://www.yanggongzi.dev/column/10087.html)
  - [9.10 博客设置页：更新设置](https://www.yanggongzi.dev/column/10088.html)
  



- 十、管理后台：文章模块开发
  - [10.1 文章管理模块功能分析、表设计](https://www.yanggongzi.dev/column/10090.html)
  - [10.2 文章管理：文章发布接口开发（1）](https://www.yanggongzi.dev/column/10091.html)
  - [10.3 文章管理：文章发布接口开发（2）—— SQL 注入器实现批量插入](https://www.yanggongzi.dev/column/10092.html)
  - [10.4 文章管理：文章删除接口开发](https://www.yanggongzi.dev/column/10093.html)
  - [10.5 文章管理：分页接口开发](https://www.yanggongzi.dev/column/10094.html)
  - [10.6 文章管理：获取文章详情接口开发](https://www.yanggongzi.dev/column/10095.html)
  - [10.7 文章管理：文章更新接口开发](https://www.yanggongzi.dev/column/10096.html)
  - [10.8 文章管理：分页列表开发](https://www.yanggongzi.dev/column/10097.html)
  - [10.9 文章管理页：删除文章开发](https://www.yanggongzi.dev/column/10098.html)
  - [10.10 文章管理页：写文章对话框样式布局](https://www.yanggongzi.dev/column/10099.html)
  - [10.11 文章管理页：文章发布功能开发](https://www.yanggongzi.dev/column/10100.html)
  - [10.12 文章管理：获取所有标签 Select 列表接口开发](https://www.yanggongzi.dev/column/10101.html)
  - [10.13 文章管理页：文章编辑功能开发](https://www.yanggongzi.dev/column/10102.html)
  - [10.14 Bug 修复：分类、标签删除接口添加是否关联文章校验; 前端 token 过期问题 fixed](https://www.yanggongzi.dev/column/10103.html)
  
  
  
  
  

- 十一、博客前台：首页开发
   - [11.1 前台首页、归档页接口分析](https://www.yanggongzi.dev/column/10104.html)
   - [11.2 前台首页：文章分页接口开发](https://www.yanggongzi.dev/column/10105.html)
   - [11.3 公共侧边栏：获取分类、标签列表接口开发](https://www.yanggongzi.dev/column/10106.html)
   - [11.4 公共部分：获取博客设置信息接口开发](https://www.yanggongzi.dev/column/10107.html)
   - [11.5 前台 Header 头组件封装](https://www.yanggongzi.dev/column/10108.html)   
   - [11.6 首页样式布局设计（1）](https://www.yanggongzi.dev/column/10109.html)
   - [11.7 首页样式布局设计（2） —— 侧边栏博主信息卡片](https://www.yanggongzi.dev/column/10110.html)
   - [11.8 首页样式布局设计（3） —— 侧边栏分类、标签卡片](https://www.yanggongzi.dev/column/10111.html)
   - [11.9 首页样式布局设计（4） —— Footer 组件封装](https://www.yanggongzi.dev/column/10112.html)
   - [11.10 首页文章分页数据渲染](https://www.yanggongzi.dev/column/10113.html)
   - [11.11 公共右边栏：博主信息卡片组件封装](https://www.yanggongzi.dev/column/10114.html)
   - [11.12 公共右边栏：分类、标签卡片组件封装](https://www.yanggongzi.dev/column/10115.html)
   - [11.13 公共 Header 头：跳转后台、退出登录功能开发](https://www.yanggongzi.dev/column/10116.html)
   
   

- 十二、博客前台：归档列表页、分类列表页、标签列表页开发
   - [12.1 归档页、分类列表页接口分析](https://www.yanggongzi.dev/column/10117.html)
   - [12.2 文章归档分页接口开发](https://www.yanggongzi.dev/column/10118.html)
   - [12.3 前台归档页：样式布局设计](https://www.yanggongzi.dev/column/10119.html)
   - [12.4 前台归档页：分页列表功能开发](https://www.yanggongzi.dev/column/10120.html)
   - [12.5 前台分类页开发](https://www.yanggongzi.dev/column/10121.html)
   - [12.6 获取某个分类下的文章列表——分页接口开发](https://www.yanggongzi.dev/column/10122.html)
   - [12.7 前台分类-文章列表页: 样式布局开发](https://www.yanggongzi.dev/column/10123.html)
   - [12.8 分类-文章列表页开发](https://www.yanggongzi.dev/column/10124.html)
   - [12.9 前台标签列表页：样式布局&功能开发](https://www.yanggongzi.dev/column/10125.html)
   - [12.10 获取某个标签下的文章列表——分页接口开发](https://www.yanggongzi.dev/column/10130.html)
   - [12.11 标签-文章列表页开发](https://www.yanggongzi.dev/column/10131.html)


- 十三、博客前台：文章详情页开发
   - [13.1 文章详情页接口分析](https://www.yanggongzi.dev/column/10126.html)
   - [13.2 后端封装 Markdown 装换工具类](https://www.yanggongzi.dev/column/10127.html)
   - [13.3 获取文章详情接口开发](https://www.yanggongzi.dev/column/10128.html)
   - [13.4 文章详情页：样式布局设计](https://www.yanggongzi.dev/column/10129.html)

   - *努力爆肝中，每天更新两小节, 按目前的更新速度，1.0 版本差不多还剩1个半月更新完毕...*
- 十四、管理后台：仪表盘模块开发
- 十五、项目部署上线
  - 云服务器选购
  - 相关环境安装（JDK、Docker、Nginx、Mysql）
  - Nginx 配合 Spring Boot 部署
  - 部署前端项目以及通过 IP 访问
  - 域名选购
  - 网站备案
  - 域名映射，项目正式上线



## 👨🏻‍💻 适用人群

- **在校学生**，有一定基础，想做毕业设计，或者为找工作准备，需要实战项目加分；

  > 💡 TIP: 小白也没关系，鲲鲲将会告诉你学习路线是啥，哪里有免费的高质量学习视频可以白嫖，学完这些技术栈后再来做实战项目，或者学一点基础边实战边学习都可以。

- **已经参与工作，对前后端分离感兴趣**，想学习 Vue 3 前端，对独立上线自己网站感兴趣的童鞋；
- **想独立接私活**，需要同时会后端、前端技术栈的童鞋；

## ✊ 如何加入？

鲲鲲已经将本站的专栏模块接入了知识星球，想要查看专栏内容，需要订阅我星球后，*微信扫码授权登录后即可解锁所有内容*。因为目前也是刚开始运营，所以价格不会太高，星球官方定价最低必须是 50 元。鲲鲲最终定价为 <font class="text-xl" style=''color: red''><b>限时 35 元（附 15 元的优惠券，记得扫码领取下方优惠券加入哟）</b></font>，后续随着内容慢慢的更新迭代，会慢慢涨上去，所以早加入更具性价比哟~ 

<font class="text-xl" style=''color: red''><b>星球支持 3 天无理由退费</b></font>，感兴趣的小伙伴*可先加入，看看内容质量如何，不合适直接退款就行，觉得确实内容很干货，就留下来学习，无套路!*

<div class="flex items-center justify-center text-lg text-red-500 font-bold mb-2">扫描下方二维码加入, 星球支持 3 天无理由退款，可以先进去看看合不合适👇👇</div>

!["领取优惠券加入，更划算"](https://img.yanggongzi.dev/ibp/169355760680941 "领取优惠券加入，更划算")

<div class="flex items-center justify-center text-lg text-red-500 font-bold">扫描上方二维码加入, 星球支持 3 天无理由退款，可以先进去看看合不合适👆👆</div>




## ❓ 关于答疑

小伙伴们如果在跟着专栏学习，手敲项目的过程中遇到问题，碰到无法解决的问题，**可在鲲鲲的知识星球内部提问**，我会统一来解答, 如果星球说不清楚的，就加私人微信，打包发项目，亲自给你看哪一步有问题，保证跟上项目进度，不落下任何一个小伙伴，大家一起冲冲冲~

## 😃 加微信咨询

对专栏感兴趣的小伙伴，也可以加鲲鲲私人微信来咨询，扫描下方二维码即可，记得备注【*咨询*】哟：

![扫描二维码，添加鲲鲲私人微信](https://img.yanggongzi.dev/ibp/169536889316499 "扫描二维码，添加鲲鲲私人微信")









## 👋 自我介绍



![](http://127.0.0.1:9000/roc-blog/599ba5b9189f49d99bdf0b5c115a3a7b.jpg)





> 大家好，我是鲲鲲。前某厂中台架构，公众号 程序员菜鲲 作者。95后，码龄 2 年，先后供职于支付、共享等互联网领域，主导负责过数据传输、日志平台、任务调度、文件平台等产品，以支撑各部门业务线。喜欢分享知识，热爱技术，也不止于技术，不只是写 Java，业余也爱玩前端、.Net 等，是个活跃的技术折腾者。

```java

  @Test
  void testLog() {
      log.info("这是一行 Info 级别日志");
      log.warn("这是一行 Warn 级别日志");
      log.error("这是一行 Error 级别日志");

      // 占位符
      String author = "鲲鲲";
      log.info("这是一行带有占位符日志，作者：{}", author);
  }
  
```
---

> 本项目 1.0 版本已部署到云服务器上，可点击下面链接进行访问，查看实际效果：
>
> 演示地址：[https://www.yanggongzi.dev](https://www.yanggongzi.dev)
>
> 后台登录演示账号:
> 
> - 账号：test
> - 密码：test

## 🏃 关于实战项目

知识星球是个私密学习圈子，我会在星球内部，出**一系列从 0 到 1 的实战项目，贴合真实的企业级项目开发规范，使用主流的企业技术栈，全程手写后端 + 前端完整代码，通过专栏的形式，把每个功能点的开发的步骤，手摸手，通过丰富的图片 + 文字，保姆级教学（PS: 同时按小节进度提供代码，不至于一上来代码量太多，不知道从哪入手）**。


![](https://img.yanggongzi.dev/ibp/169361945065538)

目前，我已经给自己的网站：[练习生基地](https://www.yanggongzi.dev/column "练习生基地") 新开发了专栏模块，可以让小伙伴们只需跟着实战专栏，按照章节顺序教学来，上手敲，即可搞定每个功能点的开发，成体系地完成一个独立项目。*目前加入的小伙伴，都给出了超高评价，以下了截取了部分好评*：

![](https://img.yanggongzi.dev/ibp/169733756405612)

![](https://img.yanggongzi.dev/ibp/169733761293187)

![](https://img.yanggongzi.dev/ibp/169733762195775)

另外，在跟随小节内容上手的过程中，若遇到问题，可在星球内发起 *1v1 提问，鲲鲲亲自解答*。

!["星球内提问"](https://img.yanggongzi.dev/ibp/169396126861858 "星球内提问")

星球说不清楚的，项目进度因为某一块搞不定的，微信发我源码，帮忙看问题出在哪：

![搞不定的，微信发我源码，帮忙看问题出在哪](https://img.yanggongzi.dev/ibp/169406285385964 "搞不定的，微信发我源码，帮忙看问题出在哪")


陪伴式写项目，到最终部署到云服务器上，能够通过域名来访问，完成项目上线。

> 💡 TIP : 后期也会尝试分享一些适合程序员的技术副业，比如开发一些小工具网站，进行推广运营，有了一定用户量，能够挣点零花钱啥的。当然，这都是后话了，前提还需要你能够自行完整的开发一个独立应用，前期还是以项目实战为主。

既然鲲鲲是准备出一系列的实战项目，我希望这些项目的难度是循序渐进的，能够让你真实的感受到自己的功力在慢慢增强。但是又不想写那种纯纯的 CRUD 型管理后台项目，太枯燥。那么，第一个项目鲲鲲就定位在难度不大，易上手，有趣，并且非常有代表性，实际工作中也能够被频繁用到的。

脑瓜子一转，想到之前好多读者问我博客的事情，今年 4 月份的时候，又有读者微信问我: *你的博客有没有开源，感觉还挺好看，也想学习、部署一个。*

![](https://img.yanggongzi.dev/ibp/169355366112215)

于是乎，花了点时间整了第一个实战项目 —— **前后端分离的博客 ibp**。


## 💁 项目介绍

每个技术人都应该有属于自己的博客！相比较直接使用第三方博客平台，自行搭建博客更有成就感；另外就是没有平台限制，比如你想发个二维码引流啥的，平台基本都是不允许的，还有，你可以自由 `div` 定制自己想要的博客 `css` 样式，哪天 UI 看不爽了，咱就自己换；最后，*面试的时候，如果简历贴上的是自己开发博客地址，也会很加分*！

### 🔗 演示地址

目前 1.0 版本已经部署到了阿里云服务器上，可点击下面链接进行访问，查看实际效果：

[https://www.yanggongzi.dev](https://www.yanggongzi.dev "https://www.yanggongzi.dev")

管理后台登录账号/密码:

- 账号：test
- 密码：test

> ⚠️ 注意：该账号的角色为*游客*角色，*仅支持查询操作*，新增、修改、删除操作会提示不允许。

### ⚒️ 功能模块

> 💡 TIP : 以下*只是 1.0 版本的功能，后续鲲鲲将添加更多功能进去, 比如图库管理、知识库、在线人数统计、SSR（服务端渲染） 等等*，能够想到的高逼格功能，咱都整上，附带超详细的实战图文笔记 ...

![ibp 功能模块一览](https://img.yanggongzi.dev/ibp/169560157482464 "ibp 功能模块一览")

### ✏️ 技术栈

![ibp 技术栈一览](https://img.yanggongzi.dev/ibp/169560181378937 "ibp 技术栈一览")

## 🎉 专栏目标

学完本项目，你将具备如下能力：

- 掌握独立开发全栈项目的能力（*后端 + 前端*）；
- 掌握 Spring Boot 相关技术栈，以及构建后端项目能力，写出符合企业级的代码规范；
- 掌握 Vue 3.2 + Element Plus + Vite 4 技术构建前端工程的能力，并能够手动搭建 Admin 后台管理系统；
- 掌握前端页面响应式设计（同时适配不同屏幕），排版布局，能够根据自己需求，`div` 自己想要的前端效果；
- ...

## 💡 专栏亮点

- 在技术选型上，鲲鲲选择了目前主流热门的技术栈，对标企业级项目开发；
- 严格把控代码质量，数据库设计，写出令同事称道的代码；
- 熟悉后端工程的搭建，如一些通用的基础设施：参数校验、全局异常捕获、`API` 统一出入参日志打印等等；
- 能够独立完成整个网站的部署流程，从功能开发到服务器、域名选购，再到网站备案，最终公网可访问；
- 对象存储 `Minio` 的使用, 能够独立搭建个人图床；
- 从 0 到 1 ，通过 `Element Plus` 纯手搭 `Admin` 管理后台前端骨架；
- 使用 Vue 3 `setup` 等语法糖新特性；
- 博客前台页面在设计上美观大气；
- ...

## 📖 专栏大纲

整个实战专栏，鲲鲲按功能点开发进度来做的目录，目前已经更新到了第第五章，目录大致如下：

> 💡 TIP : 如下目录不代表最终内容，只会更多，目前只是把已完成的部分详细的罗列了出来，其中大部分功能正在开发中，所属具体小节的标题也会陆续更新进来。

- 一、[项目介绍](https://www.yanggongzi.dev/column/10000.html)
- 二、开发环境搭建
  - [2.1 【后端】环境安装&工具准备](https://www.yanggongzi.dev/column/10003.html)
  - [2.2 【前端】开发环境&工具安装](https://www.yanggongzi.dev/column/10004.html)

- 三、Spring Boot 后端工程搭建
  - [3.1 搭建 Spring Boot 多模块工程](https://www.yanggongzi.dev/column/10005.html)
  - [3.2 Spring Boot 多环境配置](https://www.yanggongzi.dev/column/10006.html)
  - [3.3 配置 Lombok](https://www.yanggongzi.dev/column/10007.html)
  - [3.4 Spring Boot 整合 Lockback 日志](https://www.yanggongzi.dev/column/10008.html)
  - [3.5 Spring Boot 自定义注解，实现 API 请求日志切面](https://www.yanggongzi.dev/column/10009.html)
  - [3.6 Spring Boot 通过 MDC 实现日志跟踪](https://www.yanggongzi.dev/column/10010.html)
  - [3.7 Spring Boot 实现优雅的参数校验](https://www.yanggongzi.dev/column/10011.html)
  - [3.8 Spring Boot 自定义响应工具类](https://www.yanggongzi.dev/column/10012.html)
  - [3.9 Spring Boot 实现全局异常管理](https://www.yanggongzi.dev/column/10013.html)
  - [3.10 全局异常处理器+参数校验（最佳实践）](https://www.yanggongzi.dev/column/10014.html)
  - [3.11 整合 Knife4j：提升接口调试效率](https://www.yanggongzi.dev/column/10015.html)
  - [3.12 自定义 Jackson 序列化、反序列化，支持 Java 8 日期新特性](https://www.yanggongzi.dev/column/10016.html)
  - [3.13 小结](https://www.yanggongzi.dev/column/10017.html)

- 四、使用 Vue 3 + Vite 4 搭建前端工程
  - [4.1 Vue 3 环境安装& ibp 项目搭建](https://www.yanggongzi.dev/column/10018.html)
  - [4.2 安装 VSCode 开发工具](https://www.yanggongzi.dev/column/10019.html)
  - [4.3 添加 vue-router 路由管理器](https://www.yanggongzi.dev/column/10020.html)
  - [4.4 Vite 配置路径别名：更方便的引用文件](https://www.yanggongzi.dev/column/10021.html)
  - [4.5 整合 Tailwind CSS](https://www.yanggongzi.dev/column/10022.html)
  - [4.6 整合 Tailwind CSS 组件库：Flowbite](https://www.yanggongzi.dev/column/10023.html)
  - [4.7 整合饿了么 Element Plus 组件库](https://www.yanggongzi.dev/column/10024.html)

- 五、登录模块开发
  - [5.1 登录页设计：支持响应式布局](https://www.yanggongzi.dev/column/10025.html)
  - [5.2 登录页加点盐：通过 Animate.css 添加动画](https://www.yanggongzi.dev/column/10026.html)
  - [5.3 整合 Mybatis Plus](https://www.yanggongzi.dev/column/10027.html)
  - [5.4 p6spy 组件打印完整的 SQL 语句、执行耗时](https://www.yanggongzi.dev/column/10028.html)
  - [5.5 整合 Spring Security](https://www.yanggongzi.dev/column/10029.html)
  - [5.6 Spring Security 整合 JWT ：实现身份认证](https://www.yanggongzi.dev/column/10030.html)
  - [5.7 Spring Security 整合 JWT ：实现接口鉴权](https://www.yanggongzi.dev/column/10031.html)
  - [5.8 Vue 整合 Axios 实现登录功能](https://www.yanggongzi.dev/column/10032.html)
  - [5.9 登录页表单验证](https://www.yanggongzi.dev/column/10033.html)
  - [5.10 登录消息提示、回车键监听、按钮加载 Loading](https://www.yanggongzi.dev/column/10034.html)
  - [5.11 存储 Token 到 Cookie 中](https://www.yanggongzi.dev/column/10035.html)
  - [5.12 Axios 添加请求拦截器、响应拦截器](https://www.yanggongzi.dev/column/10036.html)
  - [5.13 全局路由拦截：实现页面标题动态设置、后台路由跳转的登录判断](https://www.yanggongzi.dev/column/10037.html)
  - [5.14 实现页面顶部加载 Loading 效果](https://www.yanggongzi.dev/column/10038.html)
  - [5.15 重复登录问题优化、密码框可显示密码](https://www.yanggongzi.dev/column/10040.html)
  - [5.16 角色鉴权：添加演示账号，仅支持查询操作](https://www.yanggongzi.dev/column/10089.html)
  
  
  

- 六、Element Plus 手搭 Admin 管理后台骨架
  - [6.1 搭建管理后台基本布局](https://www.yanggongzi.dev/column/10039.html)
  - [6.2 后台公共 Header 头：样式布局](https://www.yanggongzi.dev/column/10041.html)
  - [6.3 后台公共左侧 Menu 菜单栏：样式布局](https://www.yanggongzi.dev/column/10042.html)
  - [6.4 整合全局状态管理库 Pinia](https://www.yanggongzi.dev/column/10043.html)
  - [6.5 左边菜单栏点击收缩、展开功能实现](https://www.yanggongzi.dev/column/10044.html)
  - [6.6 支持全屏展示、页面点击刷新](https://www.yanggongzi.dev/column/10045.html)
  - [6.7 标签导航栏组件实现：样式布局](https://www.yanggongzi.dev/column/10046.html)
  - [6.8 标签导航栏组件实现：路由同步 (1)](https://www.yanggongzi.dev/column/10047.html)
  - [6.9 标签导航栏组件实现：路由同步 (2)](https://www.yanggongzi.dev/column/10048.html)
  - [6.10 标签导航栏组件实现：标签页关闭](https://www.yanggongzi.dev/column/10049.html)
  - [6.11 标签导航栏组件实现：关闭其他、全部标签页](https://www.yanggongzi.dev/column/10050.html)
  - [6.12 后台公共 Footer 页脚：样式布局](https://www.yanggongzi.dev/column/10051.html)
  - [6.13 使用 KeepAlive 缓存组件，提高页面切换性能和响应速度](https://www.yanggongzi.dev/column/10052.html)
  - [6.14 使用 Transition 组件添加全局过渡动画](https://www.yanggongzi.dev/column/10053.html)
  - [6.15 修改用户密码接口开发](https://www.yanggongzi.dev/column/10054.html)
  - [6.16 获取当前登录用户信息接口开发](https://www.yanggongzi.dev/column/10055.html)
  - [6.17 Pinia 存储用户信息，动态显示登录用户名](https://www.yanggongzi.dev/column/10056.html)
  - [6.18 使用 pinia-persist 插件实现 Pinia 数据持久化](https://www.yanggongzi.dev/column/10057.html)
  - [6.19 用户修改密码、退出登录功能开发](https://www.yanggongzi.dev/column/10058.html)
  - [6.20 小结](https://www.yanggongzi.dev/column/10059.html)

  

  
- 七、管理后台：文章分类模块开发
  - [7.1 分类模块接口分析](https://www.yanggongzi.dev/column/10060.html)
  - [7.2 文章分类：新增接口开发](https://www.yanggongzi.dev/column/10061.html)
  - [7.3 文章分类：分页接口开发](https://www.yanggongzi.dev/column/10062.html)
  - [7.4 文章分类：删除接口开发](https://www.yanggongzi.dev/column/10063.html)
  - [7.5 文章发布：分类 Select 下拉列表接口开发](https://www.yanggongzi.dev/column/10064.html)
  - [7.6 后台分类管理页面：样式布局](https://www.yanggongzi.dev/column/10065.html)
  - [7.7 Config Provider 全局配置: 实现组件中文化](https://www.yanggongzi.dev/column/10066.html)
  - [7.8 文章分类：分页列表数据动态渲染](https://www.yanggongzi.dev/column/10067.html)
  - [7.9 文章分类：新增功能开发](https://www.yanggongzi.dev/column/10068.html)
  - [7.10 文章分类：删除功能开发](https://www.yanggongzi.dev/column/10069.html)
  - [7.11 通用表单对话框组件封装](https://www.yanggongzi.dev/column/10070.html)
  - [7.12 添加 Table 组件加载 Loading 、表单对话框提交按钮 Loading 动画](https://www.yanggongzi.dev/column/10071.html)
  


- 八、管理后台：标签模块开发
  - [8.1 标签模块接口分析【视频讲解】](https://www.yanggongzi.dev/column/10072.html)
  - [8.2 标签管理：新增标签接口开发【视频讲解】](https://www.yanggongzi.dev/column/10073.html)
  - [8.3 标签管理：标签分页接口开发【视频讲解】](https://www.yanggongzi.dev/column/10074.html)
  - [8.4 标签管理：删除标签接口开发【视频讲解】](https://www.yanggongzi.dev/column/10075.html)
  - [8.5 标签关键词模糊查询 select 列表接口开发【视频讲解】](https://www.yanggongzi.dev/column/10076.html)
  - [8.6 标签管理页面开发：分页列表【视频讲解】](https://www.yanggongzi.dev/column/10077.html)
  - [8.7 标签管理页面开发：新增&删除标签功能【视频讲解】](https://www.yanggongzi.dev/column/10078.html)
  
  
  
- 九、管理后台：博客设置模块开发
  - [9.1 博客设置模块功能分析、表设计](https://www.yanggongzi.dev/column/10079.html)
  - [9.2 Docker 本地安装 Minio 对象存储](https://www.yanggongzi.dev/column/10080.html)
  - [9.3 文件上传接口开发](https://www.yanggongzi.dev/column/10081.html)
  - [9.4 博客设置: 更新接口开发](https://www.yanggongzi.dev/column/10082.html)
  - [9.5 整合 Mapstruct : 简化属性映射](https://www.yanggongzi.dev/column/10083.html)
  - [9.6 博客设置：获取详情接口开发](https://www.yanggongzi.dev/column/10084.html)
  - [9.7 博客设置页面：样式布局](https://www.yanggongzi.dev/column/10085.html)
  - [9.8 管理后台：滚动样式优化](https://www.yanggongzi.dev/column/10086.html)
  - [9.9 博客设置页：数据渲染、图片上传](https://www.yanggongzi.dev/column/10087.html)
  - [9.10 博客设置页：更新设置](https://www.yanggongzi.dev/column/10088.html)
  



- 十、管理后台：文章模块开发
  - [10.1 文章管理模块功能分析、表设计](https://www.yanggongzi.dev/column/10090.html)
  - [10.2 文章管理：文章发布接口开发（1）](https://www.yanggongzi.dev/column/10091.html)
  - [10.3 文章管理：文章发布接口开发（2）—— SQL 注入器实现批量插入](https://www.yanggongzi.dev/column/10092.html)
  - [10.4 文章管理：文章删除接口开发](https://www.yanggongzi.dev/column/10093.html)
  - [10.5 文章管理：分页接口开发](https://www.yanggongzi.dev/column/10094.html)
  - [10.6 文章管理：获取文章详情接口开发](https://www.yanggongzi.dev/column/10095.html)
  - [10.7 文章管理：文章更新接口开发](https://www.yanggongzi.dev/column/10096.html)
  - [10.8 文章管理：分页列表开发](https://www.yanggongzi.dev/column/10097.html)
  - [10.9 文章管理页：删除文章开发](https://www.yanggongzi.dev/column/10098.html)
  - [10.10 文章管理页：写文章对话框样式布局](https://www.yanggongzi.dev/column/10099.html)
  - [10.11 文章管理页：文章发布功能开发](https://www.yanggongzi.dev/column/10100.html)
  - [10.12 文章管理：获取所有标签 Select 列表接口开发](https://www.yanggongzi.dev/column/10101.html)
  - [10.13 文章管理页：文章编辑功能开发](https://www.yanggongzi.dev/column/10102.html)
  - [10.14 Bug 修复：分类、标签删除接口添加是否关联文章校验; 前端 token 过期问题 fixed](https://www.yanggongzi.dev/column/10103.html)
  
  
  
  
  

- 十一、博客前台：首页开发
   - [11.1 前台首页、归档页接口分析](https://www.yanggongzi.dev/column/10104.html)
   - [11.2 前台首页：文章分页接口开发](https://www.yanggongzi.dev/column/10105.html)
   - [11.3 公共侧边栏：获取分类、标签列表接口开发](https://www.yanggongzi.dev/column/10106.html)
   - [11.4 公共部分：获取博客设置信息接口开发](https://www.yanggongzi.dev/column/10107.html)
   - [11.5 前台 Header 头组件封装](https://www.yanggongzi.dev/column/10108.html)   
   - [11.6 首页样式布局设计（1）](https://www.yanggongzi.dev/column/10109.html)
   - [11.7 首页样式布局设计（2） —— 侧边栏博主信息卡片](https://www.yanggongzi.dev/column/10110.html)
   - [11.8 首页样式布局设计（3） —— 侧边栏分类、标签卡片](https://www.yanggongzi.dev/column/10111.html)
   - [11.9 首页样式布局设计（4） —— Footer 组件封装](https://www.yanggongzi.dev/column/10112.html)
   - [11.10 首页文章分页数据渲染](https://www.yanggongzi.dev/column/10113.html)
   - [11.11 公共右边栏：博主信息卡片组件封装](https://www.yanggongzi.dev/column/10114.html)
   - [11.12 公共右边栏：分类、标签卡片组件封装](https://www.yanggongzi.dev/column/10115.html)
   - [11.13 公共 Header 头：跳转后台、退出登录功能开发](https://www.yanggongzi.dev/column/10116.html)
   
   

- 十二、博客前台：归档列表页、分类列表页、标签列表页开发
   - [12.1 归档页、分类列表页接口分析](https://www.yanggongzi.dev/column/10117.html)
   - [12.2 文章归档分页接口开发](https://www.yanggongzi.dev/column/10118.html)
   - [12.3 前台归档页：样式布局设计](https://www.yanggongzi.dev/column/10119.html)
   - [12.4 前台归档页：分页列表功能开发](https://www.yanggongzi.dev/column/10120.html)
   - [12.5 前台分类页开发](https://www.yanggongzi.dev/column/10121.html)
   - [12.6 获取某个分类下的文章列表——分页接口开发](https://www.yanggongzi.dev/column/10122.html)
   - [12.7 前台分类-文章列表页: 样式布局开发](https://www.yanggongzi.dev/column/10123.html)
   - [12.8 分类-文章列表页开发](https://www.yanggongzi.dev/column/10124.html)
   - [12.9 前台标签列表页：样式布局&功能开发](https://www.yanggongzi.dev/column/10125.html)
   - [12.10 获取某个标签下的文章列表——分页接口开发](https://www.yanggongzi.dev/column/10130.html)
   - [12.11 标签-文章列表页开发](https://www.yanggongzi.dev/column/10131.html)


- 十三、博客前台：文章详情页开发
   - [13.1 文章详情页接口分析](https://www.yanggongzi.dev/column/10126.html)
   - [13.2 后端封装 Markdown 装换工具类](https://www.yanggongzi.dev/column/10127.html)
   - [13.3 获取文章详情接口开发](https://www.yanggongzi.dev/column/10128.html)
   - [13.4 文章详情页：样式布局设计](https://www.yanggongzi.dev/column/10129.html)

   - *努力爆肝中，每天更新两小节, 按目前的更新速度，1.0 版本差不多还剩1个半月更新完毕...*
- 十四、管理后台：仪表盘模块开发
- 十五、项目部署上线
  - 云服务器选购
  - 相关环境安装（JDK、Docker、Nginx、Mysql）
  - Nginx 配合 Spring Boot 部署
  - 部署前端项目以及通过 IP 访问
  - 域名选购
  - 网站备案
  - 域名映射，项目正式上线



## 👨🏻‍💻 适用人群

- **在校学生**，有一定基础，想做毕业设计，或者为找工作准备，需要实战项目加分；

  > 💡 TIP: 小白也没关系，鲲鲲将会告诉你学习路线是啥，哪里有免费的高质量学习视频可以白嫖，学完这些技术栈后再来做实战项目，或者学一点基础边实战边学习都可以。

- **已经参与工作，对前后端分离感兴趣**，想学习 Vue 3 前端，对独立上线自己网站感兴趣的童鞋；
- **想独立接私活**，需要同时会后端、前端技术栈的童鞋；

## ✊ 如何加入？

鲲鲲已经将本站的专栏模块接入了知识星球，想要查看专栏内容，需要订阅我星球后，*微信扫码授权登录后即可解锁所有内容*。因为目前也是刚开始运营，所以价格不会太高，星球官方定价最低必须是 50 元。鲲鲲最终定价为 <font class="text-xl" style=''color: red''><b>限时 35 元（附 15 元的优惠券，记得扫码领取下方优惠券加入哟）</b></font>，后续随着内容慢慢的更新迭代，会慢慢涨上去，所以早加入更具性价比哟~ 

<font class="text-xl" style=''color: red''><b>星球支持 3 天无理由退费</b></font>，感兴趣的小伙伴*可先加入，看看内容质量如何，不合适直接退款就行，觉得确实内容很干货，就留下来学习，无套路!*

<div class="flex items-center justify-center text-lg text-red-500 font-bold mb-2">扫描下方二维码加入, 星球支持 3 天无理由退款，可以先进去看看合不合适👇👇</div>

!["领取优惠券加入，更划算"](https://img.yanggongzi.dev/ibp/169355760680941 "领取优惠券加入，更划算")

<div class="flex items-center justify-center text-lg text-red-500 font-bold">扫描上方二维码加入, 星球支持 3 天无理由退款，可以先进去看看合不合适👆👆</div>




## ❓ 关于答疑

小伙伴们如果在跟着专栏学习，手敲项目的过程中遇到问题，碰到无法解决的问题，**可在鲲鲲的知识星球内部提问**，我会统一来解答, 如果星球说不清楚的，就加私人微信，打包发项目，亲自给你看哪一步有问题，保证跟上项目进度，不落下任何一个小伙伴，大家一起冲冲冲~

## 😃 加微信咨询

对专栏感兴趣的小伙伴，也可以加鲲鲲私人微信来咨询，扫描下方二维码即可，记得备注【*咨询*】哟：

![扫描二维码，添加鲲鲲私人微信](https://img.yanggongzi.dev/ibp/169536889316499 "扫描二维码，添加鲲鲲私人微信")');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (31, 31, '![](https://tse1-mm.cn.bing.net/th/id/OIP-C.4Kn7tCYsT05EL_jfHw7u-AHaEC?r=0&o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (32, 32, '![](http://127.0.0.1:9000/roc-blog/aebb844982d14ec5a4b98fae7160017f.jpg)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (8, 8, '![](http://127.0.0.1:9000/roc-blog/d1ca5dfe1229438e8183a![](http://127.0.0.1:9000/blog-article/4d22df609b114052ba6a89491a579a7f.jpg)

![](http://127.0.0.1:9000/blog-article/f97f3c48df0c46d7aaef12155cfab80e.jpg)

## 👋 自我介绍88



![](http://127.0.0.1:9000/roc-blog/599ba5b9189f49d99bdf0b5c115a3a7b.jpg)



> 大家好，我是鲲鲲。前某厂中台架构，公众号 程序员菜鲲 作者。95后，码龄 2 年，先后供职于支付、共享等互联网领域，主导负责过数据传输、日志平台、任务调度、文件平台等产品，以支撑各部门业务线。喜欢分享知识，热爱技术，也不止于技术，不只是写 Java，业余也爱玩前端、.Net 等，是个活跃的技术折腾者。

```java

  @Test
  void testLog() {
      log.info("这是一行 Info 级别日志");
      log.warn("这是一行 Warn 级别日志");
      log.error("这是一行 Error 级别日志");

      // 占位符
      String author = "鲲鲲";
      log.info("这是一行带有占位符日志，作者：{}", author);
  }
  
```
---

> 本项目 1.0 版本已部署到云服务器上，可点击下面链接进行访问，查看实际效果：
>
> 演示地址：[https://www.yanggongzi.dev](https://www.yanggongzi.dev)
>
> 后台登录演示账号:
> 
> - 账号：test
> - 密码：test

### 🏃 关于实战项目附加费大健康合法会计法哈卡看好看

知识星球是个私密学习圈子，我会在星球内部，出**一系列从 0 到 1 的实战项目，贴合真实的企业级项目开发规范，使用主流的企业技术栈，全程手写后端 + 前端完整代码，通过专栏的形式，把每个功能点的开发的步骤，手摸手，通过丰富的图片 + 文字，保姆级教学（PS: 同时按小节进度提供代码，不至于一上来代码量太多，不知道从哪入手）**。


![](https://img.yanggongzi.dev/ibp/169361945065538)

目前，我已经给自己的网站：[练习生基地](https://www.yanggongzi.dev/column "练习生基地") 新开发了专栏模块，可以让小伙伴们只需跟着实战专栏，按照章节顺序教学来，上手敲，即可搞定每个功能点的开发，成体系地完成一个独立项目。*目前加入的小伙伴，都给出了超高评价，以下了截取了部分好评*：

![](https://img.yanggongzi.dev/ibp/169733756405612)

![](https://img.yanggongzi.dev/ibp/169733761293187)

![](https://img.yanggongzi.dev/ibp/169733762195775)

另外，在跟随小节内容上手的过程中，若遇到问题，可在星球内发起 *1v1 提问，鲲鲲亲自解答*。

!["星球内提问"](https://img.yanggongzi.dev/ibp/169396126861858 "星球内提问")

星球说不清楚的，项目进度因为某一块搞不定的，微信发我源码，帮忙看问题出在哪：

![搞不定的，微信发我源码，帮忙看问题出在哪](https://img.yanggongzi.dev/ibp/169406285385964 "搞不定的，微信发我源码，帮忙看问题出在哪")


陪伴式写项目，到最终部署到云服务器上，能够通过域名来访问，完成项目上线。

> 💡 TIP : 后期也会尝试分享一些适合程序员的技术副业，比如开发一些小工具网站，进行推广运营，有了一定用户量，能够挣点零花钱啥的。当然，这都是后话了，前提还需要你能够自行完整的开发一个独立应用，前期还是以项目实战为主。

既然鲲鲲是准备出一系列的实战项目，我希望这些项目的难度是循序渐进的，能够让你真实的感受到自己的功力在慢慢增强。但是又不想写那种纯纯的 CRUD 型管理后台项目，太枯燥。那么，第一个项目鲲鲲就定位在难度不大，易上手，有趣，并且非常有代表性，实际工作中也能够被频繁用到的。

脑瓜子一转，想到之前好多读者问我博客的事情，今年 4 月份的时候，又有读者微信问我: *你的博客有没有开源，感觉还挺好看，也想学习、部署一个。*

![](https://img.yanggongzi.dev/ibp/169355366112215)

于是乎，花了点时间整了第一个实战项目 —— **前后端分离的博客 ibp**。


#### 💁 项目介绍防守反击杀戮空间射流风机失蜡法较大看见了甲基硫菌灵叽叽叽叽

每个技术人都应该有属于自己的博客！相比较直接使用第三方博客平台，自行搭建博客更有成就感；另外就是没有平台限制，比如你想发个二维码引流啥的，平台基本都是不允许的，还有，你可以自由 `div` 定制自己想要的博客 `css` 样式，哪天 UI 看不爽了，咱就自己换；最后，*面试的时候，如果简历贴上的是自己开发博客地址，也会很加分*！

## 🔗 演示地址

目前 1.0 版本已经部署到了阿里云服务器上，可点击下面链接进行访问，查看实际效果：

[https://www.yanggongzi.dev](https://www.yanggongzi.dev "https://www.yanggongzi.dev")

管理后台登录账号/密码:

- 账号：test
- 密码：test

> ⚠️ 注意：该账号的角色为*游客*角色，*仅支持查询操作*，新增、修改、删除操作会提示不允许。

### ⚒️ 功能模块

> 💡 TIP : 以下*只是 1.0 版本的功能，后续鲲鲲将添加更多功能进去, 比如图库管理、知识库、在线人数统计、SSR（服务端渲染） 等等*，能够想到的高逼格功能，咱都整上，附带超详细的实战图文笔记 ...

![ibp 功能模块一览](https://img.yanggongzi.dev/ibp/169560157482464 "ibp 功能模块一览")

## ✏️ 技术栈

![ibp 技术栈一览](https://img.yanggongzi.dev/ibp/169560181378937 "ibp 技术栈一览")

## 🎉 专栏目标

学完本项目，你将具备如下能力：

- 掌握独立开发全栈项目的能力（*后端 + 前端*）；
- 掌握 Spring Boot 相关技术栈，以及构建后端项目能力，写出符合企业级的代码规范；
- 掌握 Vue 3.2 + Element Plus + Vite 4 技术构建前端工程的能力，并能够手动搭建 Admin 后台管理系统；
- 掌握前端页面响应式设计（同时适配不同屏幕），排版布局，能够根据自己需求，`div` 自己想要的前端效果；
- ...

### 💡 专栏亮点

- 在技术选型上，鲲鲲选择了目前主流热门的技术栈，对标企业级项目开发；
- 严格把控代码质量，数据库设计，写出令同事称道的代码；
- 熟悉后端工程的搭建，如一些通用的基础设施：参数校验、全局异常捕获、`API` 统一出入参日志打印等等；
- 能够独立完成整个网站的部署流程，从功能开发到服务器、域名选购，再到网站备案，最终公网可访问；
- 对象存储 `Minio` 的使用, 能够独立搭建个人图床；
- 从 0 到 1 ，通过 `Element Plus` 纯手搭 `Admin` 管理后台前端骨架；
- 使用 Vue 3 `setup` 等语法糖新特性；
- 博客前台页面在设计上美观大气；
- ...

#### 📖 专栏大纲

整个实战专栏，鲲鲲按功能点开发进度来做的目录，目前已经更新到了第第五章，目录大致如下：

> 💡 TIP : 如下目录不代表最终内容，只会更多，目前只是把已完成的部分详细的罗列了出来，其中大部分功能正在开发中，所属具体小节的标题也会陆续更新进来。

- 一、[项目介绍](https://www.yanggongzi.dev/column/10000.html)
- 二、开发环境搭建
  - [2.1 【后端】环境安装&工具准备](https://www.yanggongzi.dev/column/10003.html)
  - [2.2 【前端】开发环境&工具安装](https://www.yanggongzi.dev/column/10004.html)

- 三、Spring Boot 后端工程搭建
  - [3.1 搭建 Spring Boot 多模块工程](https://www.yanggongzi.dev/column/10005.html)
  - [3.2 Spring Boot 多环境配置](https://www.yanggongzi.dev/column/10006.html)
  - [3.3 配置 Lombok](https://www.yanggongzi.dev/column/10007.html)
  - [3.4 Spring Boot 整合 Lockback 日志](https://www.yanggongzi.dev/column/10008.html)
  - [3.5 Spring Boot 自定义注解，实现 API 请求日志切面](https://www.yanggongzi.dev/column/10009.html)
  - [3.6 Spring Boot 通过 MDC 实现日志跟踪](https://www.yanggongzi.dev/column/10010.html)
  - [3.7 Spring Boot 实现优雅的参数校验](https://www.yanggongzi.dev/column/10011.html)
  - [3.8 Spring Boot 自定义响应工具类](https://www.yanggongzi.dev/column/10012.html)
  - [3.9 Spring Boot 实现全局异常管理](https://www.yanggongzi.dev/column/10013.html)
  - [3.10 全局异常处理器+参数校验（最佳实践）](https://www.yanggongzi.dev/column/10014.html)
  - [3.11 整合 Knife4j：提升接口调试效率](https://www.yanggongzi.dev/column/10015.html)
  - [3.12 自定义 Jackson 序列化、反序列化，支持 Java 8 日期新特性](https://www.yanggongzi.dev/column/10016.html)
  - [3.13 小结](https://www.yanggongzi.dev/column/10017.html)

- 四、使用 Vue 3 + Vite 4 搭建前端工程
  - [4.1 Vue 3 环境安装& ibp 项目搭建](https://www.yanggongzi.dev/column/10018.html)
  - [4.2 安装 VSCode 开发工具](https://www.yanggongzi.dev/column/10019.html)
  - [4.3 添加 vue-router 路由管理器](https://www.yanggongzi.dev/column/10020.html)
  - [4.4 Vite 配置路径别名：更方便的引用文件](https://www.yanggongzi.dev/column/10021.html)
  - [4.5 整合 Tailwind CSS](https://www.yanggongzi.dev/column/10022.html)
  - [4.6 整合 Tailwind CSS 组件库：Flowbite](https://www.yanggongzi.dev/column/10023.html)
  - [4.7 整合饿了么 Element Plus 组件库](https://www.yanggongzi.dev/column/10024.html)

- 五、登录模块开发
  - [5.1 登录页设计：支持响应式布局](https://www.yanggongzi.dev/column/10025.html)
  - [5.2 登录页加点盐：通过 Animate.css 添加动画](https://www.yanggongzi.dev/column/10026.html)
  - [5.3 整合 Mybatis Plus](https://www.yanggongzi.dev/column/10027.html)
  - [5.4 p6spy 组件打印完整的 SQL 语句、执行耗时](https://www.yanggongzi.dev/column/10028.html)
  - [5.5 整合 Spring Security](https://www.yanggongzi.dev/column/10029.html)
  - [5.6 Spring Security 整合 JWT ：实现身份认证](https://www.yanggongzi.dev/column/10030.html)
  - [5.7 Spring Security 整合 JWT ：实现接口鉴权](https://www.yanggongzi.dev/column/10031.html)
  - [5.8 Vue 整合 Axios 实现登录功能](https://www.yanggongzi.dev/column/10032.html)
  - [5.9 登录页表单验证](https://www.yanggongzi.dev/column/10033.html)
  - [5.10 登录消息提示、回车键监听、按钮加载 Loading](https://www.yanggongzi.dev/column/10034.html)
  - [5.11 存储 Token 到 Cookie 中](https://www.yanggongzi.dev/column/10035.html)
  - [5.12 Axios 添加请求拦截器、响应拦截器](https://www.yanggongzi.dev/column/10036.html)
  - [5.13 全局路由拦截：实现页面标题动态设置、后台路由跳转的登录判断](https://www.yanggongzi.dev/column/10037.html)
  - [5.14 实现页面顶部加载 Loading 效果](https://www.yanggongzi.dev/column/10038.html)
  - [5.15 重复登录问题优化、密码框可显示密码](https://www.yanggongzi.dev/column/10040.html)
  - [5.16 角色鉴权：添加演示账号，仅支持查询操作](https://www.yanggongzi.dev/column/10089.html)
  
  
  

- 六、Element Plus 手搭 Admin 管理后台骨架
  - [6.1 搭建管理后台基本布局](https://www.yanggongzi.dev/column/10039.html)
  - [6.2 后台公共 Header 头：样式布局](https://www.yanggongzi.dev/column/10041.html)
  - [6.3 后台公共左侧 Menu 菜单栏：样式布局](https://www.yanggongzi.dev/column/10042.html)
  - [6.4 整合全局状态管理库 Pinia](https://www.yanggongzi.dev/column/10043.html)
  - [6.5 左边菜单栏点击收缩、展开功能实现](https://www.yanggongzi.dev/column/10044.html)
  - [6.6 支持全屏展示、页面点击刷新](https://www.yanggongzi.dev/column/10045.html)
  - [6.7 标签导航栏组件实现：样式布局](https://www.yanggongzi.dev/column/10046.html)
  - [6.8 标签导航栏组件实现：路由同步 (1)](https://www.yanggongzi.dev/column/10047.html)
  - [6.9 标签导航栏组件实现：路由同步 (2)](https://www.yanggongzi.dev/column/10048.html)
  - [6.10 标签导航栏组件实现：标签页关闭](https://www.yanggongzi.dev/column/10049.html)
  - [6.11 标签导航栏组件实现：关闭其他、全部标签页](https://www.yanggongzi.dev/column/10050.html)
  - [6.12 后台公共 Footer 页脚：样式布局](https://www.yanggongzi.dev/column/10051.html)
  - [6.13 使用 KeepAlive 缓存组件，提高页面切换性能和响应速度](https://www.yanggongzi.dev/column/10052.html)
  - [6.14 使用 Transition 组件添加全局过渡动画](https://www.yanggongzi.dev/column/10053.html)
  - [6.15 修改用户密码接口开发](https://www.yanggongzi.dev/column/10054.html)
  - [6.16 获取当前登录用户信息接口开发](https://www.yanggongzi.dev/column/10055.html)
  - [6.17 Pinia 存储用户信息，动态显示登录用户名](https://www.yanggongzi.dev/column/10056.html)
  - [6.18 使用 pinia-persist 插件实现 Pinia 数据持久化](https://www.yanggongzi.dev/column/10057.html)
  - [6.19 用户修改密码、退出登录功能开发](https://www.yanggongzi.dev/column/10058.html)
  - [6.20 小结](https://www.yanggongzi.dev/column/10059.html)

  

  
- 七、管理后台：文章分类模块开发
  - [7.1 分类模块接口分析](https://www.yanggongzi.dev/column/10060.html)
  - [7.2 文章分类：新增接口开发](https://www.yanggongzi.dev/column/10061.html)
  - [7.3 文章分类：分页接口开发](https://www.yanggongzi.dev/column/10062.html)
  - [7.4 文章分类：删除接口开发](https://www.yanggongzi.dev/column/10063.html)
  - [7.5 文章发布：分类 Select 下拉列表接口开发](https://www.yanggongzi.dev/column/10064.html)
  - [7.6 后台分类管理页面：样式布局](https://www.yanggongzi.dev/column/10065.html)
  - [7.7 Config Provider 全局配置: 实现组件中文化](https://www.yanggongzi.dev/column/10066.html)
  - [7.8 文章分类：分页列表数据动态渲染](https://www.yanggongzi.dev/column/10067.html)
  - [7.9 文章分类：新增功能开发](https://www.yanggongzi.dev/column/10068.html)
  - [7.10 文章分类：删除功能开发](https://www.yanggongzi.dev/column/10069.html)
  - [7.11 通用表单对话框组件封装](https://www.yanggongzi.dev/column/10070.html)
  - [7.12 添加 Table 组件加载 Loading 、表单对话框提交按钮 Loading 动画](https://www.yanggongzi.dev/column/10071.html)
  


- 八、管理后台：标签模块开发
  - [8.1 标签模块接口分析【视频讲解】](https://www.yanggongzi.dev/column/10072.html)
  - [8.2 标签管理：新增标签接口开发【视频讲解】](https://www.yanggongzi.dev/column/10073.html)
  - [8.3 标签管理：标签分页接口开发【视频讲解】](https://www.yanggongzi.dev/column/10074.html)
  - [8.4 标签管理：删除标签接口开发【视频讲解】](https://www.yanggongzi.dev/column/10075.html)
  - [8.5 标签关键词模糊查询 select 列表接口开发【视频讲解】](https://www.yanggongzi.dev/column/10076.html)
  - [8.6 标签管理页面开发：分页列表【视频讲解】](https://www.yanggongzi.dev/column/10077.html)
  - [8.7 标签管理页面开发：新增&删除标签功能【视频讲解】](https://www.yanggongzi.dev/column/10078.html)
  
  
  
- 九、管理后台：博客设置模块开发
  - [9.1 博客设置模块功能分析、表设计](https://www.yanggongzi.dev/column/10079.html)
  - [9.2 Docker 本地安装 Minio 对象存储](https://www.yanggongzi.dev/column/10080.html)
  - [9.3 文件上传接口开发](https://www.yanggongzi.dev/column/10081.html)
  - [9.4 博客设置: 更新接口开发](https://www.yanggongzi.dev/column/10082.html)
  - [9.5 整合 Mapstruct : 简化属性映射](https://www.yanggongzi.dev/column/10083.html)
  - [9.6 博客设置：获取详情接口开发](https://www.yanggongzi.dev/column/10084.html)
  - [9.7 博客设置页面：样式布局](https://www.yanggongzi.dev/column/10085.html)
  - [9.8 管理后台：滚动样式优化](https://www.yanggongzi.dev/column/10086.html)
  - [9.9 博客设置页：数据渲染、图片上传](https://www.yanggongzi.dev/column/10087.html)
  - [9.10 博客设置页：更新设置](https://www.yanggongzi.dev/column/10088.html)
  



- 十、管理后台：文章模块开发
  - [10.1 文章管理模块功能分析、表设计](https://www.yanggongzi.dev/column/10090.html)
  - [10.2 文章管理：文章发布接口开发（1）](https://www.yanggongzi.dev/column/10091.html)
  - [10.3 文章管理：文章发布接口开发（2）—— SQL 注入器实现批量插入](https://www.yanggongzi.dev/column/10092.html)
  - [10.4 文章管理：文章删除接口开发](https://www.yanggongzi.dev/column/10093.html)
  - [10.5 文章管理：分页接口开发](https://www.yanggongzi.dev/column/10094.html)
  - [10.6 文章管理：获取文章详情接口开发](https://www.yanggongzi.dev/column/10095.html)
  - [10.7 文章管理：文章更新接口开发](https://www.yanggongzi.dev/column/10096.html)
  - [10.8 文章管理：分页列表开发](https://www.yanggongzi.dev/column/10097.html)
  - [10.9 文章管理页：删除文章开发](https://www.yanggongzi.dev/column/10098.html)
  - [10.10 文章管理页：写文章对话框样式布局](https://www.yanggongzi.dev/column/10099.html)
  - [10.11 文章管理页：文章发布功能开发](https://www.yanggongzi.dev/column/10100.html)
  - [10.12 文章管理：获取所有标签 Select 列表接口开发](https://www.yanggongzi.dev/column/10101.html)
  - [10.13 文章管理页：文章编辑功能开发](https://www.yanggongzi.dev/column/10102.html)
  - [10.14 Bug 修复：分类、标签删除接口添加是否关联文章校验; 前端 token 过期问题 fixed](https://www.yanggongzi.dev/column/10103.html)
  
  
  
  
  

- 十一、博客前台：首页开发
   - [11.1 前台首页、归档页接口分析](https://www.yanggongzi.dev/column/10104.html)
   - [11.2 前台首页：文章分页接口开发](https://www.yanggongzi.dev/column/10105.html)
   - [11.3 公共侧边栏：获取分类、标签列表接口开发](https://www.yanggongzi.dev/column/10106.html)
   - [11.4 公共部分：获取博客设置信息接口开发](https://www.yanggongzi.dev/column/10107.html)
   - [11.5 前台 Header 头组件封装](https://www.yanggongzi.dev/column/10108.html)   
   - [11.6 首页样式布局设计（1）](https://www.yanggongzi.dev/column/10109.html)
   - [11.7 首页样式布局设计（2） —— 侧边栏博主信息卡片](https://www.yanggongzi.dev/column/10110.html)
   - [11.8 首页样式布局设计（3） —— 侧边栏分类、标签卡片](https://www.yanggongzi.dev/column/10111.html)
   - [11.9 首页样式布局设计（4） —— Footer 组件封装](https://www.yanggongzi.dev/column/10112.html)
   - [11.10 首页文章分页数据渲染](https://www.yanggongzi.dev/column/10113.html)
   - [11.11 公共右边栏：博主信息卡片组件封装](https://www.yanggongzi.dev/column/10114.html)
   - [11.12 公共右边栏：分类、标签卡片组件封装](https://www.yanggongzi.dev/column/10115.html)
   - [11.13 公共 Header 头：跳转后台、退出登录功能开发](https://www.yanggongzi.dev/column/10116.html)
   
   

- 十二、博客前台：归档列表页、分类列表页、标签列表页开发
   - [12.1 归档页、分类列表页接口分析](https://www.yanggongzi.dev/column/10117.html)
   - [12.2 文章归档分页接口开发](https://www.yanggongzi.dev/column/10118.html)
   - [12.3 前台归档页：样式布局设计](https://www.yanggongzi.dev/column/10119.html)
   - [12.4 前台归档页：分页列表功能开发](https://www.yanggongzi.dev/column/10120.html)
   - [12.5 前台分类页开发](https://www.yanggongzi.dev/column/10121.html)
   - [12.6 获取某个分类下的文章列表——分页接口开发](https://www.yanggongzi.dev/column/10122.html)
   - [12.7 前台分类-文章列表页: 样式布局开发](https://www.yanggongzi.dev/column/10123.html)
   - [12.8 分类-文章列表页开发](https://www.yanggongzi.dev/column/10124.html)
   - [12.9 前台标签列表页：样式布局&功能开发](https://www.yanggongzi.dev/column/10125.html)
   - [12.10 获取某个标签下的文章列表——分页接口开发](https://www.yanggongzi.dev/column/10130.html)
   - [12.11 标签-文章列表页开发](https://www.yanggongzi.dev/column/10131.html)


- 十三、博客前台：文章详情页开发
   - [13.1 文章详情页接口分析](https://www.yanggongzi.dev/column/10126.html)
   - [13.2 后端封装 Markdown 装换工具类](https://www.yanggongzi.dev/column/10127.html)
   - [13.3 获取文章详情接口开发](https://www.yanggongzi.dev/column/10128.html)
   - [13.4 文章详情页：样式布局设计](https://www.yanggongzi.dev/column/10129.html)

   - *努力爆肝中，每天更新两小节, 按目前的更新速度，1.0 版本差不多还剩1个半月更新完毕...*
- 十四、管理后台：仪表盘模块开发
- 十五、项目部署上线
  - 云服务器选购
  - 相关环境安装（JDK、Docker、Nginx、Mysql）
  - Nginx 配合 Spring Boot 部署
  - 部署前端项目以及通过 IP 访问
  - 域名选购
  - 网站备案
  - 域名映射，项目正式上线



## 👨🏻‍💻 适用人群

- **在校学生**，有一定基础，想做毕业设计，或者为找工作准备，需要实战项目加分；

  > 💡 TIP: 小白也没关系，鲲鲲将会告诉你学习路线是啥，哪里有免费的高质量学习视频可以白嫖，学完这些技术栈后再来做实战项目，或者学一点基础边实战边学习都可以。

- **已经参与工作，对前后端分离感兴趣**，想学习 Vue 3 前端，对独立上线自己网站感兴趣的童鞋；
- **想独立接私活**，需要同时会后端、前端技术栈的童鞋；

## ✊ 如何加入？

鲲鲲已经将本站的专栏模块接入了知识星球，想要查看专栏内容，需要订阅我星球后，*微信扫码授权登录后即可解锁所有内容*。因为目前也是刚开始运营，所以价格不会太高，星球官方定价最低必须是 50 元。鲲鲲最终定价为 <font class="text-xl" style=''color: red''><b>限时 35 元（附 15 元的优惠券，记得扫码领取下方优惠券加入哟）</b></font>，后续随着内容慢慢的更新迭代，会慢慢涨上去，所以早加入更具性价比哟~ 

<font class="text-xl" style=''color: red''><b>星球支持 3 天无理由退费</b></font>，感兴趣的小伙伴*可先加入，看看内容质量如何，不合适直接退款就行，觉得确实内容很干货，就留下来学习，无套路!*

<div class="flex items-center justify-center text-lg text-red-500 font-bold mb-2">扫描下方二维码加入, 星球支持 3 天无理由退款，可以先进去看看合不合适👇👇</div>

!["领取优惠券加入，更划算"](https://img.yanggongzi.dev/ibp/169355760680941 "领取优惠券加入，更划算")

<div class="flex items-center justify-center text-lg text-red-500 font-bold">扫描上方二维码加入, 星球支持 3 天无理由退款，可以先进去看看合不合适👆👆</div>




## ❓ 关于答疑

小伙伴们如果在跟着专栏学习，手敲项目的过程中遇到问题，碰到无法解决的问题，**可在鲲鲲的知识星球内部提问**，我会统一来解答, 如果星球说不清楚的，就加私人微信，打包发项目，亲自给你看哪一步有问题，保证跟上项目进度，不落下任何一个小伙伴，大家一起冲冲冲~

## 😃 加微信咨询

对专栏感兴趣的小伙伴，也可以加鲲鲲私人微信来咨询，扫描下方二维码即可，记得备注【*咨询*】哟：

![扫描二维码，添加鲲鲲私人微信](https://img.yanggongzi.dev/ibp/169536889316499 "扫描二维码，添加鲲鲲私人微信")');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (10, 10, '请输入内容天天电饭锅第三个发的
图片1![](http://127.0.0.1:9000/roc-blog/12f87fef76564ba9acde1c0fec4cf7d5.png)
图片2![](http://127.0.0.1:9000/roc-blog/8566fcf578434e07a7e55521456047f.jpg)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (1, 1, '## 👋 自我介绍



![](http://127.0.0.1:9000/roc-blog/599ba5b9189f49d99bdf0b5c115a3a7b.jpg)





> 大家好，我是 程序员-杨工子。前某厂中台架构，公众号 程序员菜鲲 作者。95后，码龄 2 年，先后供职于支付、共享等互联网领域，主导负责过数据传输、日志平台、任务调度、文件平台等产品，以支撑各部门业务线。喜欢分享知识，热爱技术，也不止于技术，不只是写 Java，业余也爱玩前端、.Net 等，是个活跃的技术折腾者。

```java

  @Test
  void testLog() {
      log.info("这是一行 Info 级别日志");
      log.warn("这是一行 Warn 级别日志");
      log.error("这是一行 Error 级别日志");

      // 占位符
      String author = "鲲鲲";
      log.info("这是一行带有占位符日志，作者：{}", author);
  }
  
```
---

> 本项目 1.0 版本已部署到云服务器上，可点击下面链接进行访问，查看实际效果：
>
> 演示地址：[https://www.yanggongzi.dev](https://www.yanggongzi.dev)
>
> 后台登录演示账号:
> 
> - 账号：test
> - 密码：test

## 🏃 关于实战项目

知识星球是个私密学习圈子，我会在星球内部，出**一系列从 0 到 1 的实战项目，贴合真实的企业级项目开发规范，使用主流的企业技术栈，全程手写后端 + 前端完整代码，通过专栏的形式，把每个功能点的开发的步骤，手摸手，通过丰富的图片 + 文字，保姆级教学（PS: 同时按小节进度提供代码，不至于一上来代码量太多，不知道从哪入手）**。


![](https://img.yanggongzi.dev/ibp/169361945065538)

目前，我已经给自己的网站：[练习生基地](https://www.yanggongzi.dev/column "练习生基地") 新开发了专栏模块，可以让小伙伴们只需跟着实战专栏，按照章节顺序教学来，上手敲，即可搞定每个功能点的开发，成体系地完成一个独立项目。*目前加入的小伙伴，都给出了超高评价，以下了截取了部分好评*：

![](https://img.yanggongzi.dev/ibp/169733756405612)

![](https://img.yanggongzi.dev/ibp/169733761293187)

![](https://img.yanggongzi.dev/ibp/169733762195775)

另外，在跟随小节内容上手的过程中，若遇到问题，可在星球内发起 *1v1 提问，鲲鲲亲自解答*。

!["星球内提问"](https://img.yanggongzi.dev/ibp/169396126861858 "星球内提问")

星球说不清楚的，项目进度因为某一块搞不定的，微信发我源码，帮忙看问题出在哪：

![搞不定的，微信发我源码，帮忙看问题出在哪](https://img.yanggongzi.dev/ibp/169406285385964 "搞不定的，微信发我源码，帮忙看问题出在哪")


陪伴式写项目，到最终部署到云服务器上，能够通过域名来访问，完成项目上线。

> 💡 TIP : 后期也会尝试分享一些适合程序员的技术副业，比如开发一些小工具网站，进行推广运营，有了一定用户量，能够挣点零花钱啥的。当然，这都是后话了，前提还需要你能够自行完整的开发一个独立应用，前期还是以项目实战为主。

既然鲲鲲是准备出一系列的实战项目，我希望这些项目的难度是循序渐进的，能够让你真实的感受到自己的功力在慢慢增强。但是又不想写那种纯纯的 CRUD 型管理后台项目，太枯燥。那么，第一个项目鲲鲲就定位在难度不大，易上手，有趣，并且非常有代表性，实际工作中也能够被频繁用到的。

脑瓜子一转，想到之前好多读者问我博客的事情，今年 4 月份的时候，又有读者微信问我: *你的博客有没有开源，感觉还挺好看，也想学习、部署一个。*

![](https://img.yanggongzi.dev/ibp/169355366112215)

于是乎，花了点时间整了第一个实战项目 —— **前后端分离的博客 ibp**。


## 💁 项目介绍

每个技术人都应该有属于自己的博客！相比较直接使用第三方博客平台，自行搭建博客更有成就感；另外就是没有平台限制，比如你想发个二维码引流啥的，平台基本都是不允许的，还有，你可以自由 `div` 定制自己想要的博客 `css` 样式，哪天 UI 看不爽了，咱就自己换；最后，*面试的时候，如果简历贴上的是自己开发博客地址，也会很加分*！

### 🔗 演示地址

目前 1.0 版本已经部署到了阿里云服务器上，可点击下面链接进行访问，查看实际效果：

[https://www.yanggongzi.dev](https://www.yanggongzi.dev "https://www.yanggongzi.dev")

管理后台登录账号/密码:

- 账号：test
- 密码：test

> ⚠️ 注意：该账号的角色为*游客*角色，*仅支持查询操作*，新增、修改、删除操作会提示不允许。

### ⚒️ 功能模块

> 💡 TIP : 以下*只是 1.0 版本的功能，后续鲲鲲将添加更多功能进去, 比如图库管理、知识库、在线人数统计、SSR（服务端渲染） 等等*，能够想到的高逼格功能，咱都整上，附带超详细的实战图文笔记 ...

![ibp 功能模块一览](https://img.yanggongzi.dev/ibp/169560157482464 "ibp 功能模块一览")

### ✏️ 技术栈

![ibp 技术栈一览](https://img.yanggongzi.dev/ibp/169560181378937 "ibp 技术栈一览")

## 🎉 专栏目标

学完本项目，你将具备如下能力：

- 掌握独立开发全栈项目的能力（*后端 + 前端*）；
- 掌握 Spring Boot 相关技术栈，以及构建后端项目能力，写出符合企业级的代码规范；
- 掌握 Vue 3.2 + Element Plus + Vite 4 技术构建前端工程的能力，并能够手动搭建 Admin 后台管理系统；
- 掌握前端页面响应式设计（同时适配不同屏幕），排版布局，能够根据自己需求，`div` 自己想要的前端效果；
- ...

## 💡 专栏亮点

- 在技术选型上，鲲鲲选择了目前主流热门的技术栈，对标企业级项目开发；
- 严格把控代码质量，数据库设计，写出令同事称道的代码；
- 熟悉后端工程的搭建，如一些通用的基础设施：参数校验、全局异常捕获、`API` 统一出入参日志打印等等；
- 能够独立完成整个网站的部署流程，从功能开发到服务器、域名选购，再到网站备案，最终公网可访问；
- 对象存储 `Minio` 的使用, 能够独立搭建个人图床；
- 从 0 到 1 ，通过 `Element Plus` 纯手搭 `Admin` 管理后台前端骨架；
- 使用 Vue 3 `setup` 等语法糖新特性；
- 博客前台页面在设计上美观大气；
- ...

## 📖 专栏大纲

整个实战专栏，鲲鲲按功能点开发进度来做的目录，目前已经更新到了第第五章，目录大致如下：

> 💡 TIP : 如下目录不代表最终内容，只会更多，目前只是把已完成的部分详细的罗列了出来，其中大部分功能正在开发中，所属具体小节的标题也会陆续更新进来。

- 一、[项目介绍](https://www.yanggongzi.dev/column/10000.html)
- 二、开发环境搭建
  - [2.1 【后端】环境安装&工具准备](https://www.yanggongzi.dev/column/10003.html)
  - [2.2 【前端】开发环境&工具安装](https://www.yanggongzi.dev/column/10004.html)

- 三、Spring Boot 后端工程搭建
  - [3.1 搭建 Spring Boot 多模块工程](https://www.yanggongzi.dev/column/10005.html)
  - [3.2 Spring Boot 多环境配置](https://www.yanggongzi.dev/column/10006.html)
  - [3.3 配置 Lombok](https://www.yanggongzi.dev/column/10007.html)
  - [3.4 Spring Boot 整合 Lockback 日志](https://www.yanggongzi.dev/column/10008.html)
  - [3.5 Spring Boot 自定义注解，实现 API 请求日志切面](https://www.yanggongzi.dev/column/10009.html)
  - [3.6 Spring Boot 通过 MDC 实现日志跟踪](https://www.yanggongzi.dev/column/10010.html)
  - [3.7 Spring Boot 实现优雅的参数校验](https://www.yanggongzi.dev/column/10011.html)
  - [3.8 Spring Boot 自定义响应工具类](https://www.yanggongzi.dev/column/10012.html)
  - [3.9 Spring Boot 实现全局异常管理](https://www.yanggongzi.dev/column/10013.html)
  - [3.10 全局异常处理器+参数校验（最佳实践）](https://www.yanggongzi.dev/column/10014.html)
  - [3.11 整合 Knife4j：提升接口调试效率](https://www.yanggongzi.dev/column/10015.html)
  - [3.12 自定义 Jackson 序列化、反序列化，支持 Java 8 日期新特性](https://www.yanggongzi.dev/column/10016.html)
  - [3.13 小结](https://www.yanggongzi.dev/column/10017.html)

- 四、使用 Vue 3 + Vite 4 搭建前端工程
  - [4.1 Vue 3 环境安装& ibp 项目搭建](https://www.yanggongzi.dev/column/10018.html)
  - [4.2 安装 VSCode 开发工具](https://www.yanggongzi.dev/column/10019.html)
  - [4.3 添加 vue-router 路由管理器](https://www.yanggongzi.dev/column/10020.html)
  - [4.4 Vite 配置路径别名：更方便的引用文件](https://www.yanggongzi.dev/column/10021.html)
  - [4.5 整合 Tailwind CSS](https://www.yanggongzi.dev/column/10022.html)
  - [4.6 整合 Tailwind CSS 组件库：Flowbite](https://www.yanggongzi.dev/column/10023.html)
  - [4.7 整合饿了么 Element Plus 组件库](https://www.yanggongzi.dev/column/10024.html)

- 五、登录模块开发
  - [5.1 登录页设计：支持响应式布局](https://www.yanggongzi.dev/column/10025.html)
  - [5.2 登录页加点盐：通过 Animate.css 添加动画](https://www.yanggongzi.dev/column/10026.html)
  - [5.3 整合 Mybatis Plus](https://www.yanggongzi.dev/column/10027.html)
  - [5.4 p6spy 组件打印完整的 SQL 语句、执行耗时](https://www.yanggongzi.dev/column/10028.html)
  - [5.5 整合 Spring Security](https://www.yanggongzi.dev/column/10029.html)
  - [5.6 Spring Security 整合 JWT ：实现身份认证](https://www.yanggongzi.dev/column/10030.html)
  - [5.7 Spring Security 整合 JWT ：实现接口鉴权](https://www.yanggongzi.dev/column/10031.html)
  - [5.8 Vue 整合 Axios 实现登录功能](https://www.yanggongzi.dev/column/10032.html)
  - [5.9 登录页表单验证](https://www.yanggongzi.dev/column/10033.html)
  - [5.10 登录消息提示、回车键监听、按钮加载 Loading](https://www.yanggongzi.dev/column/10034.html)
  - [5.11 存储 Token 到 Cookie 中](https://www.yanggongzi.dev/column/10035.html)
  - [5.12 Axios 添加请求拦截器、响应拦截器](https://www.yanggongzi.dev/column/10036.html)
  - [5.13 全局路由拦截：实现页面标题动态设置、后台路由跳转的登录判断](https://www.yanggongzi.dev/column/10037.html)
  - [5.14 实现页面顶部加载 Loading 效果](https://www.yanggongzi.dev/column/10038.html)
  - [5.15 重复登录问题优化、密码框可显示密码](https://www.yanggongzi.dev/column/10040.html)
  - [5.16 角色鉴权：添加演示账号，仅支持查询操作](https://www.yanggongzi.dev/column/10089.html)
  
  
  

- 六、Element Plus 手搭 Admin 管理后台骨架
  - [6.1 搭建管理后台基本布局](https://www.yanggongzi.dev/column/10039.html)
  - [6.2 后台公共 Header 头：样式布局](https://www.yanggongzi.dev/column/10041.html)
  - [6.3 后台公共左侧 Menu 菜单栏：样式布局](https://www.yanggongzi.dev/column/10042.html)
  - [6.4 整合全局状态管理库 Pinia](https://www.yanggongzi.dev/column/10043.html)
  - [6.5 左边菜单栏点击收缩、展开功能实现](https://www.yanggongzi.dev/column/10044.html)
  - [6.6 支持全屏展示、页面点击刷新](https://www.yanggongzi.dev/column/10045.html)
  - [6.7 标签导航栏组件实现：样式布局](https://www.yanggongzi.dev/column/10046.html)
  - [6.8 标签导航栏组件实现：路由同步 (1)](https://www.yanggongzi.dev/column/10047.html)
  - [6.9 标签导航栏组件实现：路由同步 (2)](https://www.yanggongzi.dev/column/10048.html)
  - [6.10 标签导航栏组件实现：标签页关闭](https://www.yanggongzi.dev/column/10049.html)
  - [6.11 标签导航栏组件实现：关闭其他、全部标签页](https://www.yanggongzi.dev/column/10050.html)
  - [6.12 后台公共 Footer 页脚：样式布局](https://www.yanggongzi.dev/column/10051.html)
  - [6.13 使用 KeepAlive 缓存组件，提高页面切换性能和响应速度](https://www.yanggongzi.dev/column/10052.html)
  - [6.14 使用 Transition 组件添加全局过渡动画](https://www.yanggongzi.dev/column/10053.html)
  - [6.15 修改用户密码接口开发](https://www.yanggongzi.dev/column/10054.html)
  - [6.16 获取当前登录用户信息接口开发](https://www.yanggongzi.dev/column/10055.html)
  - [6.17 Pinia 存储用户信息，动态显示登录用户名](https://www.yanggongzi.dev/column/10056.html)
  - [6.18 使用 pinia-persist 插件实现 Pinia 数据持久化](https://www.yanggongzi.dev/column/10057.html)
  - [6.19 用户修改密码、退出登录功能开发](https://www.yanggongzi.dev/column/10058.html)
  - [6.20 小结](https://www.yanggongzi.dev/column/10059.html)

  

  
- 七、管理后台：文章分类模块开发
  - [7.1 分类模块接口分析](https://www.yanggongzi.dev/column/10060.html)
  - [7.2 文章分类：新增接口开发](https://www.yanggongzi.dev/column/10061.html)
  - [7.3 文章分类：分页接口开发](https://www.yanggongzi.dev/column/10062.html)
  - [7.4 文章分类：删除接口开发](https://www.yanggongzi.dev/column/10063.html)
  - [7.5 文章发布：分类 Select 下拉列表接口开发](https://www.yanggongzi.dev/column/10064.html)
  - [7.6 后台分类管理页面：样式布局](https://www.yanggongzi.dev/column/10065.html)
  - [7.7 Config Provider 全局配置: 实现组件中文化](https://www.yanggongzi.dev/column/10066.html)
  - [7.8 文章分类：分页列表数据动态渲染](https://www.yanggongzi.dev/column/10067.html)
  - [7.9 文章分类：新增功能开发](https://www.yanggongzi.dev/column/10068.html)
  - [7.10 文章分类：删除功能开发](https://www.yanggongzi.dev/column/10069.html)
  - [7.11 通用表单对话框组件封装](https://www.yanggongzi.dev/column/10070.html)
  - [7.12 添加 Table 组件加载 Loading 、表单对话框提交按钮 Loading 动画](https://www.yanggongzi.dev/column/10071.html)
  


- 八、管理后台：标签模块开发
  - [8.1 标签模块接口分析【视频讲解】](https://www.yanggongzi.dev/column/10072.html)
  - [8.2 标签管理：新增标签接口开发【视频讲解】](https://www.yanggongzi.dev/column/10073.html)
  - [8.3 标签管理：标签分页接口开发【视频讲解】](https://www.yanggongzi.dev/column/10074.html)
  - [8.4 标签管理：删除标签接口开发【视频讲解】](https://www.yanggongzi.dev/column/10075.html)
  - [8.5 标签关键词模糊查询 select 列表接口开发【视频讲解】](https://www.yanggongzi.dev/column/10076.html)
  - [8.6 标签管理页面开发：分页列表【视频讲解】](https://www.yanggongzi.dev/column/10077.html)
  - [8.7 标签管理页面开发：新增&删除标签功能【视频讲解】](https://www.yanggongzi.dev/column/10078.html)
  
  
  
- 九、管理后台：博客设置模块开发
  - [9.1 博客设置模块功能分析、表设计](https://www.yanggongzi.dev/column/10079.html)
  - [9.2 Docker 本地安装 Minio 对象存储](https://www.yanggongzi.dev/column/10080.html)
  - [9.3 文件上传接口开发](https://www.yanggongzi.dev/column/10081.html)
  - [9.4 博客设置: 更新接口开发](https://www.yanggongzi.dev/column/10082.html)
  - [9.5 整合 Mapstruct : 简化属性映射](https://www.yanggongzi.dev/column/10083.html)
  - [9.6 博客设置：获取详情接口开发](https://www.yanggongzi.dev/column/10084.html)
  - [9.7 博客设置页面：样式布局](https://www.yanggongzi.dev/column/10085.html)
  - [9.8 管理后台：滚动样式优化](https://www.yanggongzi.dev/column/10086.html)
  - [9.9 博客设置页：数据渲染、图片上传](https://www.yanggongzi.dev/column/10087.html)
  - [9.10 博客设置页：更新设置](https://www.yanggongzi.dev/column/10088.html)
  



- 十、管理后台：文章模块开发
  - [10.1 文章管理模块功能分析、表设计](https://www.yanggongzi.dev/column/10090.html)
  - [10.2 文章管理：文章发布接口开发（1）](https://www.yanggongzi.dev/column/10091.html)
  - [10.3 文章管理：文章发布接口开发（2）—— SQL 注入器实现批量插入](https://www.yanggongzi.dev/column/10092.html)
  - [10.4 文章管理：文章删除接口开发](https://www.yanggongzi.dev/column/10093.html)
  - [10.5 文章管理：分页接口开发](https://www.yanggongzi.dev/column/10094.html)
  - [10.6 文章管理：获取文章详情接口开发](https://www.yanggongzi.dev/column/10095.html)
  - [10.7 文章管理：文章更新接口开发](https://www.yanggongzi.dev/column/10096.html)
  - [10.8 文章管理：分页列表开发](https://www.yanggongzi.dev/column/10097.html)
  - [10.9 文章管理页：删除文章开发](https://www.yanggongzi.dev/column/10098.html)
  - [10.10 文章管理页：写文章对话框样式布局](https://www.yanggongzi.dev/column/10099.html)
  - [10.11 文章管理页：文章发布功能开发](https://www.yanggongzi.dev/column/10100.html)
  - [10.12 文章管理：获取所有标签 Select 列表接口开发](https://www.yanggongzi.dev/column/10101.html)
  - [10.13 文章管理页：文章编辑功能开发](https://www.yanggongzi.dev/column/10102.html)
  - [10.14 Bug 修复：分类、标签删除接口添加是否关联文章校验; 前端 token 过期问题 fixed](https://www.yanggongzi.dev/column/10103.html)
  
  
  
  
  

- 十一、博客前台：首页开发
   - [11.1 前台首页、归档页接口分析](https://www.yanggongzi.dev/column/10104.html)
   - [11.2 前台首页：文章分页接口开发](https://www.yanggongzi.dev/column/10105.html)
   - [11.3 公共侧边栏：获取分类、标签列表接口开发](https://www.yanggongzi.dev/column/10106.html)
   - [11.4 公共部分：获取博客设置信息接口开发](https://www.yanggongzi.dev/column/10107.html)
   - [11.5 前台 Header 头组件封装](https://www.yanggongzi.dev/column/10108.html)   
   - [11.6 首页样式布局设计（1）](https://www.yanggongzi.dev/column/10109.html)
   - [11.7 首页样式布局设计（2） —— 侧边栏博主信息卡片](https://www.yanggongzi.dev/column/10110.html)
   - [11.8 首页样式布局设计（3） —— 侧边栏分类、标签卡片](https://www.yanggongzi.dev/column/10111.html)
   - [11.9 首页样式布局设计（4） —— Footer 组件封装](https://www.yanggongzi.dev/column/10112.html)
   - [11.10 首页文章分页数据渲染](https://www.yanggongzi.dev/column/10113.html)
   - [11.11 公共右边栏：博主信息卡片组件封装](https://www.yanggongzi.dev/column/10114.html)
   - [11.12 公共右边栏：分类、标签卡片组件封装](https://www.yanggongzi.dev/column/10115.html)
   - [11.13 公共 Header 头：跳转后台、退出登录功能开发](https://www.yanggongzi.dev/column/10116.html)
   
   

- 十二、博客前台：归档列表页、分类列表页、标签列表页开发
   - [12.1 归档页、分类列表页接口分析](https://www.yanggongzi.dev/column/10117.html)
   - [12.2 文章归档分页接口开发](https://www.yanggongzi.dev/column/10118.html)
   - [12.3 前台归档页：样式布局设计](https://www.yanggongzi.dev/column/10119.html)
   - [12.4 前台归档页：分页列表功能开发](https://www.yanggongzi.dev/column/10120.html)
   - [12.5 前台分类页开发](https://www.yanggongzi.dev/column/10121.html)
   - [12.6 获取某个分类下的文章列表——分页接口开发](https://www.yanggongzi.dev/column/10122.html)
   - [12.7 前台分类-文章列表页: 样式布局开发](https://www.yanggongzi.dev/column/10123.html)
   - [12.8 分类-文章列表页开发](https://www.yanggongzi.dev/column/10124.html)
   - [12.9 前台标签列表页：样式布局&功能开发](https://www.yanggongzi.dev/column/10125.html)
   - [12.10 获取某个标签下的文章列表——分页接口开发](https://www.yanggongzi.dev/column/10130.html)
   - [12.11 标签-文章列表页开发](https://www.yanggongzi.dev/column/10131.html)


- 十三、博客前台：文章详情页开发
   - [13.1 文章详情页接口分析](https://www.yanggongzi.dev/column/10126.html)
   - [13.2 后端封装 Markdown 装换工具类](https://www.yanggongzi.dev/column/10127.html)
   - [13.3 获取文章详情接口开发](https://www.yanggongzi.dev/column/10128.html)
   - [13.4 文章详情页：样式布局设计](https://www.yanggongzi.dev/column/10129.html)

   - *努力爆肝中，每天更新两小节, 按目前的更新速度，1.0 版本差不多还剩1个半月更新完毕...*
- 十四、管理后台：仪表盘模块开发
- 十五、项目部署上线
  - 云服务器选购
  - 相关环境安装（JDK、Docker、Nginx、Mysql）
  - Nginx 配合 Spring Boot 部署
  - 部署前端项目以及通过 IP 访问
  - 域名选购
  - 网站备案
  - 域名映射，项目正式上线



## 👨🏻‍💻 适用人群

- **在校学生**，有一定基础，想做毕业设计，或者为找工作准备，需要实战项目加分；

  > 💡 TIP: 小白也没关系，鲲鲲将会告诉你学习路线是啥，哪里有免费的高质量学习视频可以白嫖，学完这些技术栈后再来做实战项目，或者学一点基础边实战边学习都可以。

- **已经参与工作，对前后端分离感兴趣**，想学习 Vue 3 前端，对独立上线自己网站感兴趣的童鞋；
- **想独立接私活**，需要同时会后端、前端技术栈的童鞋；

## ✊ 如何加入？

鲲鲲已经将本站的专栏模块接入了知识星球，想要查看专栏内容，需要订阅我星球后，*微信扫码授权登录后即可解锁所有内容*。因为目前也是刚开始运营，所以价格不会太高，星球官方定价最低必须是 50 元。鲲鲲最终定价为 <font class="text-xl" style=''color: red''><b>限时 35 元（附 15 元的优惠券，记得扫码领取下方优惠券加入哟）</b></font>，后续随着内容慢慢的更新迭代，会慢慢涨上去，所以早加入更具性价比哟~ 

<font class="text-xl" style=''color: red''><b>星球支持 3 天无理由退费</b></font>，感兴趣的小伙伴*可先加入，看看内容质量如何，不合适直接退款就行，觉得确实内容很干货，就留下来学习，无套路!*

<div class="flex items-center justify-center text-lg text-red-500 font-bold mb-2">扫描下方二维码加入, 星球支持 3 天无理由退款，可以先进去看看合不合适👇👇</div>

!["领取优惠券加入，更划算"](https://img.yanggongzi.dev/ibp/169355760680941 "领取优惠券加入，更划算")

<div class="flex items-center justify-center text-lg text-red-500 font-bold">扫描上方二维码加入, 星球支持 3 天无理由退款，可以先进去看看合不合适👆👆</div>




## ❓ 关于答疑

小伙伴们如果在跟着专栏学习，手敲项目的过程中遇到问题，碰到无法解决的问题，**可在鲲鲲的知识星球内部提问**，我会统一来解答, 如果星球说不清楚的，就加私人微信，打包发项目，亲自给你看哪一步有问题，保证跟上项目进度，不落下任何一个小伙伴，大家一起冲冲冲~

## 😃 加微信咨询

对专栏感兴趣的小伙伴，也可以加鲲鲲私人微信来咨询，扫描下方二维码即可，记得备注【*咨询*】哟：

![扫描二维码，添加鲲鲲私人微信](https://img.yanggongzi.dev/ibp/169536889316499 "扫描二维码，添加鲲鲲私人微信")









## 👋 自我介绍



![](http://127.0.0.1:9000/roc-blog/599ba5b9189f49d99bdf0b5c115a3a7b.jpg)





> 大家好，我是鲲鲲。前某厂中台架构，公众号 程序员菜鲲 作者。95后，码龄 2 年，先后供职于支付、共享等互联网领域，主导负责过数据传输、日志平台、任务调度、文件平台等产品，以支撑各部门业务线。喜欢分享知识，热爱技术，也不止于技术，不只是写 Java，业余也爱玩前端、.Net 等，是个活跃的技术折腾者。

```java

  @Test
  void testLog() {
      log.info("这是一行 Info 级别日志");
      log.warn("这是一行 Warn 级别日志");
      log.error("这是一行 Error 级别日志");

      // 占位符
      String author = "鲲鲲";
      log.info("这是一行带有占位符日志，作者：{}", author);
  }
  
```
---

> 本项目 1.0 版本已部署到云服务器上，可点击下面链接进行访问，查看实际效果：
>
> 演示地址：[https://www.yanggongzi.dev](https://www.yanggongzi.dev)
>
> 后台登录演示账号:
> 
> - 账号：test
> - 密码：test

## 🏃 关于实战项目

知识星球是个私密学习圈子，我会在星球内部，出**一系列从 0 到 1 的实战项目，贴合真实的企业级项目开发规范，使用主流的企业技术栈，全程手写后端 + 前端完整代码，通过专栏的形式，把每个功能点的开发的步骤，手摸手，通过丰富的图片 + 文字，保姆级教学（PS: 同时按小节进度提供代码，不至于一上来代码量太多，不知道从哪入手）**。


![](https://img.yanggongzi.dev/ibp/169361945065538)

目前，我已经给自己的网站：[练习生基地](https://www.yanggongzi.dev/column "练习生基地") 新开发了专栏模块，可以让小伙伴们只需跟着实战专栏，按照章节顺序教学来，上手敲，即可搞定每个功能点的开发，成体系地完成一个独立项目。*目前加入的小伙伴，都给出了超高评价，以下了截取了部分好评*：

![](https://img.yanggongzi.dev/ibp/169733756405612)

![](https://img.yanggongzi.dev/ibp/169733761293187)

![](https://img.yanggongzi.dev/ibp/169733762195775)

另外，在跟随小节内容上手的过程中，若遇到问题，可在星球内发起 *1v1 提问，鲲鲲亲自解答*。

!["星球内提问"](https://img.yanggongzi.dev/ibp/169396126861858 "星球内提问")

星球说不清楚的，项目进度因为某一块搞不定的，微信发我源码，帮忙看问题出在哪：

![搞不定的，微信发我源码，帮忙看问题出在哪](https://img.yanggongzi.dev/ibp/169406285385964 "搞不定的，微信发我源码，帮忙看问题出在哪")


陪伴式写项目，到最终部署到云服务器上，能够通过域名来访问，完成项目上线。

> 💡 TIP : 后期也会尝试分享一些适合程序员的技术副业，比如开发一些小工具网站，进行推广运营，有了一定用户量，能够挣点零花钱啥的。当然，这都是后话了，前提还需要你能够自行完整的开发一个独立应用，前期还是以项目实战为主。

既然鲲鲲是准备出一系列的实战项目，我希望这些项目的难度是循序渐进的，能够让你真实的感受到自己的功力在慢慢增强。但是又不想写那种纯纯的 CRUD 型管理后台项目，太枯燥。那么，第一个项目鲲鲲就定位在难度不大，易上手，有趣，并且非常有代表性，实际工作中也能够被频繁用到的。

脑瓜子一转，想到之前好多读者问我博客的事情，今年 4 月份的时候，又有读者微信问我: *你的博客有没有开源，感觉还挺好看，也想学习、部署一个。*

![](https://img.yanggongzi.dev/ibp/169355366112215)

于是乎，花了点时间整了第一个实战项目 —— **前后端分离的博客 ibp**。


## 💁 项目介绍

每个技术人都应该有属于自己的博客！相比较直接使用第三方博客平台，自行搭建博客更有成就感；另外就是没有平台限制，比如你想发个二维码引流啥的，平台基本都是不允许的，还有，你可以自由 `div` 定制自己想要的博客 `css` 样式，哪天 UI 看不爽了，咱就自己换；最后，*面试的时候，如果简历贴上的是自己开发博客地址，也会很加分*！

### 🔗 演示地址

目前 1.0 版本已经部署到了阿里云服务器上，可点击下面链接进行访问，查看实际效果：

[https://www.yanggongzi.dev](https://www.yanggongzi.dev "https://www.yanggongzi.dev")

管理后台登录账号/密码:

- 账号：test
- 密码：test

> ⚠️ 注意：该账号的角色为*游客*角色，*仅支持查询操作*，新增、修改、删除操作会提示不允许。

### ⚒️ 功能模块

> 💡 TIP : 以下*只是 1.0 版本的功能，后续鲲鲲将添加更多功能进去, 比如图库管理、知识库、在线人数统计、SSR（服务端渲染） 等等*，能够想到的高逼格功能，咱都整上，附带超详细的实战图文笔记 ...

![ibp 功能模块一览](https://img.yanggongzi.dev/ibp/169560157482464 "ibp 功能模块一览")

### ✏️ 技术栈

![ibp 技术栈一览](https://img.yanggongzi.dev/ibp/169560181378937 "ibp 技术栈一览")

## 🎉 专栏目标

学完本项目，你将具备如下能力：

- 掌握独立开发全栈项目的能力（*后端 + 前端*）；
- 掌握 Spring Boot 相关技术栈，以及构建后端项目能力，写出符合企业级的代码规范；
- 掌握 Vue 3.2 + Element Plus + Vite 4 技术构建前端工程的能力，并能够手动搭建 Admin 后台管理系统；
- 掌握前端页面响应式设计（同时适配不同屏幕），排版布局，能够根据自己需求，`div` 自己想要的前端效果；
- ...

## 💡 专栏亮点

- 在技术选型上，鲲鲲选择了目前主流热门的技术栈，对标企业级项目开发；
- 严格把控代码质量，数据库设计，写出令同事称道的代码；
- 熟悉后端工程的搭建，如一些通用的基础设施：参数校验、全局异常捕获、`API` 统一出入参日志打印等等；
- 能够独立完成整个网站的部署流程，从功能开发到服务器、域名选购，再到网站备案，最终公网可访问；
- 对象存储 `Minio` 的使用, 能够独立搭建个人图床；
- 从 0 到 1 ，通过 `Element Plus` 纯手搭 `Admin` 管理后台前端骨架；
- 使用 Vue 3 `setup` 等语法糖新特性；
- 博客前台页面在设计上美观大气；
- ...

## 📖 专栏大纲

整个实战专栏，鲲鲲按功能点开发进度来做的目录，目前已经更新到了第第五章，目录大致如下：

> 💡 TIP : 如下目录不代表最终内容，只会更多，目前只是把已完成的部分详细的罗列了出来，其中大部分功能正在开发中，所属具体小节的标题也会陆续更新进来。

- 一、[项目介绍](https://www.yanggongzi.dev/column/10000.html)
- 二、开发环境搭建
  - [2.1 【后端】环境安装&工具准备](https://www.yanggongzi.dev/column/10003.html)
  - [2.2 【前端】开发环境&工具安装](https://www.yanggongzi.dev/column/10004.html)

- 三、Spring Boot 后端工程搭建
  - [3.1 搭建 Spring Boot 多模块工程](https://www.yanggongzi.dev/column/10005.html)
  - [3.2 Spring Boot 多环境配置](https://www.yanggongzi.dev/column/10006.html)
  - [3.3 配置 Lombok](https://www.yanggongzi.dev/column/10007.html)
  - [3.4 Spring Boot 整合 Lockback 日志](https://www.yanggongzi.dev/column/10008.html)
  - [3.5 Spring Boot 自定义注解，实现 API 请求日志切面](https://www.yanggongzi.dev/column/10009.html)
  - [3.6 Spring Boot 通过 MDC 实现日志跟踪](https://www.yanggongzi.dev/column/10010.html)
  - [3.7 Spring Boot 实现优雅的参数校验](https://www.yanggongzi.dev/column/10011.html)
  - [3.8 Spring Boot 自定义响应工具类](https://www.yanggongzi.dev/column/10012.html)
  - [3.9 Spring Boot 实现全局异常管理](https://www.yanggongzi.dev/column/10013.html)
  - [3.10 全局异常处理器+参数校验（最佳实践）](https://www.yanggongzi.dev/column/10014.html)
  - [3.11 整合 Knife4j：提升接口调试效率](https://www.yanggongzi.dev/column/10015.html)
  - [3.12 自定义 Jackson 序列化、反序列化，支持 Java 8 日期新特性](https://www.yanggongzi.dev/column/10016.html)
  - [3.13 小结](https://www.yanggongzi.dev/column/10017.html)

- 四、使用 Vue 3 + Vite 4 搭建前端工程
  - [4.1 Vue 3 环境安装& ibp 项目搭建](https://www.yanggongzi.dev/column/10018.html)
  - [4.2 安装 VSCode 开发工具](https://www.yanggongzi.dev/column/10019.html)
  - [4.3 添加 vue-router 路由管理器](https://www.yanggongzi.dev/column/10020.html)
  - [4.4 Vite 配置路径别名：更方便的引用文件](https://www.yanggongzi.dev/column/10021.html)
  - [4.5 整合 Tailwind CSS](https://www.yanggongzi.dev/column/10022.html)
  - [4.6 整合 Tailwind CSS 组件库：Flowbite](https://www.yanggongzi.dev/column/10023.html)
  - [4.7 整合饿了么 Element Plus 组件库](https://www.yanggongzi.dev/column/10024.html)

- 五、登录模块开发
  - [5.1 登录页设计：支持响应式布局](https://www.yanggongzi.dev/column/10025.html)
  - [5.2 登录页加点盐：通过 Animate.css 添加动画](https://www.yanggongzi.dev/column/10026.html)
  - [5.3 整合 Mybatis Plus](https://www.yanggongzi.dev/column/10027.html)
  - [5.4 p6spy 组件打印完整的 SQL 语句、执行耗时](https://www.yanggongzi.dev/column/10028.html)
  - [5.5 整合 Spring Security](https://www.yanggongzi.dev/column/10029.html)
  - [5.6 Spring Security 整合 JWT ：实现身份认证](https://www.yanggongzi.dev/column/10030.html)
  - [5.7 Spring Security 整合 JWT ：实现接口鉴权](https://www.yanggongzi.dev/column/10031.html)
  - [5.8 Vue 整合 Axios 实现登录功能](https://www.yanggongzi.dev/column/10032.html)
  - [5.9 登录页表单验证](https://www.yanggongzi.dev/column/10033.html)
  - [5.10 登录消息提示、回车键监听、按钮加载 Loading](https://www.yanggongzi.dev/column/10034.html)
  - [5.11 存储 Token 到 Cookie 中](https://www.yanggongzi.dev/column/10035.html)
  - [5.12 Axios 添加请求拦截器、响应拦截器](https://www.yanggongzi.dev/column/10036.html)
  - [5.13 全局路由拦截：实现页面标题动态设置、后台路由跳转的登录判断](https://www.yanggongzi.dev/column/10037.html)
  - [5.14 实现页面顶部加载 Loading 效果](https://www.yanggongzi.dev/column/10038.html)
  - [5.15 重复登录问题优化、密码框可显示密码](https://www.yanggongzi.dev/column/10040.html)
  - [5.16 角色鉴权：添加演示账号，仅支持查询操作](https://www.yanggongzi.dev/column/10089.html)
  
  
  

- 六、Element Plus 手搭 Admin 管理后台骨架
  - [6.1 搭建管理后台基本布局](https://www.yanggongzi.dev/column/10039.html)
  - [6.2 后台公共 Header 头：样式布局](https://www.yanggongzi.dev/column/10041.html)
  - [6.3 后台公共左侧 Menu 菜单栏：样式布局](https://www.yanggongzi.dev/column/10042.html)
  - [6.4 整合全局状态管理库 Pinia](https://www.yanggongzi.dev/column/10043.html)
  - [6.5 左边菜单栏点击收缩、展开功能实现](https://www.yanggongzi.dev/column/10044.html)
  - [6.6 支持全屏展示、页面点击刷新](https://www.yanggongzi.dev/column/10045.html)
  - [6.7 标签导航栏组件实现：样式布局](https://www.yanggongzi.dev/column/10046.html)
  - [6.8 标签导航栏组件实现：路由同步 (1)](https://www.yanggongzi.dev/column/10047.html)
  - [6.9 标签导航栏组件实现：路由同步 (2)](https://www.yanggongzi.dev/column/10048.html)
  - [6.10 标签导航栏组件实现：标签页关闭](https://www.yanggongzi.dev/column/10049.html)
  - [6.11 标签导航栏组件实现：关闭其他、全部标签页](https://www.yanggongzi.dev/column/10050.html)
  - [6.12 后台公共 Footer 页脚：样式布局](https://www.yanggongzi.dev/column/10051.html)
  - [6.13 使用 KeepAlive 缓存组件，提高页面切换性能和响应速度](https://www.yanggongzi.dev/column/10052.html)
  - [6.14 使用 Transition 组件添加全局过渡动画](https://www.yanggongzi.dev/column/10053.html)
  - [6.15 修改用户密码接口开发](https://www.yanggongzi.dev/column/10054.html)
  - [6.16 获取当前登录用户信息接口开发](https://www.yanggongzi.dev/column/10055.html)
  - [6.17 Pinia 存储用户信息，动态显示登录用户名](https://www.yanggongzi.dev/column/10056.html)
  - [6.18 使用 pinia-persist 插件实现 Pinia 数据持久化](https://www.yanggongzi.dev/column/10057.html)
  - [6.19 用户修改密码、退出登录功能开发](https://www.yanggongzi.dev/column/10058.html)
  - [6.20 小结](https://www.yanggongzi.dev/column/10059.html)

  

  
- 七、管理后台：文章分类模块开发
  - [7.1 分类模块接口分析](https://www.yanggongzi.dev/column/10060.html)
  - [7.2 文章分类：新增接口开发](https://www.yanggongzi.dev/column/10061.html)
  - [7.3 文章分类：分页接口开发](https://www.yanggongzi.dev/column/10062.html)
  - [7.4 文章分类：删除接口开发](https://www.yanggongzi.dev/column/10063.html)
  - [7.5 文章发布：分类 Select 下拉列表接口开发](https://www.yanggongzi.dev/column/10064.html)
  - [7.6 后台分类管理页面：样式布局](https://www.yanggongzi.dev/column/10065.html)
  - [7.7 Config Provider 全局配置: 实现组件中文化](https://www.yanggongzi.dev/column/10066.html)
  - [7.8 文章分类：分页列表数据动态渲染](https://www.yanggongzi.dev/column/10067.html)
  - [7.9 文章分类：新增功能开发](https://www.yanggongzi.dev/column/10068.html)
  - [7.10 文章分类：删除功能开发](https://www.yanggongzi.dev/column/10069.html)
  - [7.11 通用表单对话框组件封装](https://www.yanggongzi.dev/column/10070.html)
  - [7.12 添加 Table 组件加载 Loading 、表单对话框提交按钮 Loading 动画](https://www.yanggongzi.dev/column/10071.html)
  


- 八、管理后台：标签模块开发
  - [8.1 标签模块接口分析【视频讲解】](https://www.yanggongzi.dev/column/10072.html)
  - [8.2 标签管理：新增标签接口开发【视频讲解】](https://www.yanggongzi.dev/column/10073.html)
  - [8.3 标签管理：标签分页接口开发【视频讲解】](https://www.yanggongzi.dev/column/10074.html)
  - [8.4 标签管理：删除标签接口开发【视频讲解】](https://www.yanggongzi.dev/column/10075.html)
  - [8.5 标签关键词模糊查询 select 列表接口开发【视频讲解】](https://www.yanggongzi.dev/column/10076.html)
  - [8.6 标签管理页面开发：分页列表【视频讲解】](https://www.yanggongzi.dev/column/10077.html)
  - [8.7 标签管理页面开发：新增&删除标签功能【视频讲解】](https://www.yanggongzi.dev/column/10078.html)
  
  
  
- 九、管理后台：博客设置模块开发
  - [9.1 博客设置模块功能分析、表设计](https://www.yanggongzi.dev/column/10079.html)
  - [9.2 Docker 本地安装 Minio 对象存储](https://www.yanggongzi.dev/column/10080.html)
  - [9.3 文件上传接口开发](https://www.yanggongzi.dev/column/10081.html)
  - [9.4 博客设置: 更新接口开发](https://www.yanggongzi.dev/column/10082.html)
  - [9.5 整合 Mapstruct : 简化属性映射](https://www.yanggongzi.dev/column/10083.html)
  - [9.6 博客设置：获取详情接口开发](https://www.yanggongzi.dev/column/10084.html)
  - [9.7 博客设置页面：样式布局](https://www.yanggongzi.dev/column/10085.html)
  - [9.8 管理后台：滚动样式优化](https://www.yanggongzi.dev/column/10086.html)
  - [9.9 博客设置页：数据渲染、图片上传](https://www.yanggongzi.dev/column/10087.html)
  - [9.10 博客设置页：更新设置](https://www.yanggongzi.dev/column/10088.html)
  



- 十、管理后台：文章模块开发
  - [10.1 文章管理模块功能分析、表设计](https://www.yanggongzi.dev/column/10090.html)
  - [10.2 文章管理：文章发布接口开发（1）](https://www.yanggongzi.dev/column/10091.html)
  - [10.3 文章管理：文章发布接口开发（2）—— SQL 注入器实现批量插入](https://www.yanggongzi.dev/column/10092.html)
  - [10.4 文章管理：文章删除接口开发](https://www.yanggongzi.dev/column/10093.html)
  - [10.5 文章管理：分页接口开发](https://www.yanggongzi.dev/column/10094.html)
  - [10.6 文章管理：获取文章详情接口开发](https://www.yanggongzi.dev/column/10095.html)
  - [10.7 文章管理：文章更新接口开发](https://www.yanggongzi.dev/column/10096.html)
  - [10.8 文章管理：分页列表开发](https://www.yanggongzi.dev/column/10097.html)
  - [10.9 文章管理页：删除文章开发](https://www.yanggongzi.dev/column/10098.html)
  - [10.10 文章管理页：写文章对话框样式布局](https://www.yanggongzi.dev/column/10099.html)
  - [10.11 文章管理页：文章发布功能开发](https://www.yanggongzi.dev/column/10100.html)
  - [10.12 文章管理：获取所有标签 Select 列表接口开发](https://www.yanggongzi.dev/column/10101.html)
  - [10.13 文章管理页：文章编辑功能开发](https://www.yanggongzi.dev/column/10102.html)
  - [10.14 Bug 修复：分类、标签删除接口添加是否关联文章校验; 前端 token 过期问题 fixed](https://www.yanggongzi.dev/column/10103.html)
  
  
  
  
  

- 十一、博客前台：首页开发
   - [11.1 前台首页、归档页接口分析](https://www.yanggongzi.dev/column/10104.html)
   - [11.2 前台首页：文章分页接口开发](https://www.yanggongzi.dev/column/10105.html)
   - [11.3 公共侧边栏：获取分类、标签列表接口开发](https://www.yanggongzi.dev/column/10106.html)
   - [11.4 公共部分：获取博客设置信息接口开发](https://www.yanggongzi.dev/column/10107.html)
   - [11.5 前台 Header 头组件封装](https://www.yanggongzi.dev/column/10108.html)   
   - [11.6 首页样式布局设计（1）](https://www.yanggongzi.dev/column/10109.html)
   - [11.7 首页样式布局设计（2） —— 侧边栏博主信息卡片](https://www.yanggongzi.dev/column/10110.html)
   - [11.8 首页样式布局设计（3） —— 侧边栏分类、标签卡片](https://www.yanggongzi.dev/column/10111.html)
   - [11.9 首页样式布局设计（4） —— Footer 组件封装](https://www.yanggongzi.dev/column/10112.html)
   - [11.10 首页文章分页数据渲染](https://www.yanggongzi.dev/column/10113.html)
   - [11.11 公共右边栏：博主信息卡片组件封装](https://www.yanggongzi.dev/column/10114.html)
   - [11.12 公共右边栏：分类、标签卡片组件封装](https://www.yanggongzi.dev/column/10115.html)
   - [11.13 公共 Header 头：跳转后台、退出登录功能开发](https://www.yanggongzi.dev/column/10116.html)
   
   

- 十二、博客前台：归档列表页、分类列表页、标签列表页开发
   - [12.1 归档页、分类列表页接口分析](https://www.yanggongzi.dev/column/10117.html)
   - [12.2 文章归档分页接口开发](https://www.yanggongzi.dev/column/10118.html)
   - [12.3 前台归档页：样式布局设计](https://www.yanggongzi.dev/column/10119.html)
   - [12.4 前台归档页：分页列表功能开发](https://www.yanggongzi.dev/column/10120.html)
   - [12.5 前台分类页开发](https://www.yanggongzi.dev/column/10121.html)
   - [12.6 获取某个分类下的文章列表——分页接口开发](https://www.yanggongzi.dev/column/10122.html)
   - [12.7 前台分类-文章列表页: 样式布局开发](https://www.yanggongzi.dev/column/10123.html)
   - [12.8 分类-文章列表页开发](https://www.yanggongzi.dev/column/10124.html)
   - [12.9 前台标签列表页：样式布局&功能开发](https://www.yanggongzi.dev/column/10125.html)
   - [12.10 获取某个标签下的文章列表——分页接口开发](https://www.yanggongzi.dev/column/10130.html)
   - [12.11 标签-文章列表页开发](https://www.yanggongzi.dev/column/10131.html)


- 十三、博客前台：文章详情页开发
   - [13.1 文章详情页接口分析](https://www.yanggongzi.dev/column/10126.html)
   - [13.2 后端封装 Markdown 装换工具类](https://www.yanggongzi.dev/column/10127.html)
   - [13.3 获取文章详情接口开发](https://www.yanggongzi.dev/column/10128.html)
   - [13.4 文章详情页：样式布局设计](https://www.yanggongzi.dev/column/10129.html)

   - *努力爆肝中，每天更新两小节, 按目前的更新速度，1.0 版本差不多还剩1个半月更新完毕...*
- 十四、管理后台：仪表盘模块开发
- 十五、项目部署上线
  - 云服务器选购
  - 相关环境安装（JDK、Docker、Nginx、Mysql）
  - Nginx 配合 Spring Boot 部署
  - 部署前端项目以及通过 IP 访问
  - 域名选购
  - 网站备案
  - 域名映射，项目正式上线



## 👨🏻‍💻 适用人群

- **在校学生**，有一定基础，想做毕业设计，或者为找工作准备，需要实战项目加分；

  > 💡 TIP: 小白也没关系，鲲鲲将会告诉你学习路线是啥，哪里有免费的高质量学习视频可以白嫖，学完这些技术栈后再来做实战项目，或者学一点基础边实战边学习都可以。

- **已经参与工作，对前后端分离感兴趣**，想学习 Vue 3 前端，对独立上线自己网站感兴趣的童鞋；
- **想独立接私活**，需要同时会后端、前端技术栈的童鞋；

## ✊ 如何加入？

鲲鲲已经将本站的专栏模块接入了知识星球，想要查看专栏内容，需要订阅我星球后，*微信扫码授权登录后即可解锁所有内容*。因为目前也是刚开始运营，所以价格不会太高，星球官方定价最低必须是 50 元。鲲鲲最终定价为 <font class="text-xl" style=''color: red''><b>限时 35 元（附 15 元的优惠券，记得扫码领取下方优惠券加入哟）</b></font>，后续随着内容慢慢的更新迭代，会慢慢涨上去，所以早加入更具性价比哟~ 

<font class="text-xl" style=''color: red''><b>星球支持 3 天无理由退费</b></font>，感兴趣的小伙伴*可先加入，看看内容质量如何，不合适直接退款就行，觉得确实内容很干货，就留下来学习，无套路!*

<div class="flex items-center justify-center text-lg text-red-500 font-bold mb-2">扫描下方二维码加入, 星球支持 3 天无理由退款，可以先进去看看合不合适👇👇</div>

!["领取优惠券加入，更划算"](https://img.yanggongzi.dev/ibp/169355760680941 "领取优惠券加入，更划算")

<div class="flex items-center justify-center text-lg text-red-500 font-bold">扫描上方二维码加入, 星球支持 3 天无理由退款，可以先进去看看合不合适👆👆</div>




## ❓ 关于答疑

小伙伴们如果在跟着专栏学习，手敲项目的过程中遇到问题，碰到无法解决的问题，**可在鲲鲲的知识星球内部提问**，我会统一来解答, 如果星球说不清楚的，就加私人微信，打包发项目，亲自给你看哪一步有问题，保证跟上项目进度，不落下任何一个小伙伴，大家一起冲冲冲~

## 😃 加微信咨询

对专栏感兴趣的小伙伴，也可以加鲲鲲私人微信来咨询，扫描下方二维码即可，记得备注【*咨询*】哟：

![扫描二维码，添加鲲鲲私人微信](https://img.yanggongzi.dev/ibp/169536889316499 "扫描二维码，添加鲲鲲私人微信")');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2056031402964684800, 2056031402947907584, '发发发
![](http://127.0.0.1:9000/blog/5158cb66f1e34b249017ed3deab83b.webp)
圣斗士
![](https://ts2.tc.mm.bing.net/th/id/OIP-C.wTEDnsVhWfBNsbxWhav7sAHaEK?r=0&rs=1&pid=ImgDetMain&o=7&rm=3)


都算是
![](http://127.0.0.1:9000/blog/7dbb44a4e7d2431580ad78ecda9101b.png)
多少多少

![](http://127.0.0.1:9000/blog-article/5FC563CA209DF3B7FFE4AD3E33A02313.png)');
INSERT INTO "public"."blog_article_content" ("id", "article_id", "content") VALUES (2060251596771692544, 2060251596750721024, '![](http://127.0.0.1:9000/blog-article/640.webp)

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
  -v /opt/docker/datas/RustFS/data:/data \
  -v /opt/docker/datas/RustFS/logs:/logs \
  -e RUSTFS_ACCESS_KEY=CHANGE_ME_RUSTFS_ACCESS_KEY \
  -e RUSTFS_SECRET_KEY=CHANGE_ME_RUSTFS_SECRET_KEY \
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
dmc alias set rustfs http://host.docker.internal:9000 CHANGE_ME_RUSTFS_ACCESS_KEY CHANGE_ME_RUSTFS_SECRET_KEY
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
  -e POSTGRES_PASSWORD=CHANGE_ME_DB_PASSWORD \
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
scp "docs/PostgreSQL数据库脚本/Mint.Blog-数据库-结构+数据.sql" root@服务器IP:/opt/docker/datas/postgresql/backup/
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
    "AccessKey": "CHANGE_ME_RUSTFS_ACCESS_KEY",
    "SecretKey": "CHANGE_ME_RUSTFS_SECRET_KEY",
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

# HTTPS：非 www 域名重定向到 www
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;
    server_name example.com rocblog.example.com blog.example.com;

    ssl_certificate /etc/nginx/cert/fullchain.example.com.pem;
    ssl_certificate_key /etc/nginx/cert/private.example.com.key;

    return 301 https://www.example.com$request_uri;
}

# HTTPS：主站点（www.example.com）
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

> **proxy_pass 末尾斜杠规则**：有 `/` 会替换掉 location 前缀，无 `/` 保留完整路径。
>
> ```
> location /api/ { proxy_pass http://host:8000;   }   → /api/system/auth/login → /api/system/auth/login ✅
> location /api/ { proxy_pass http://host:8000/;  }   → /api/system/auth/login → /system/auth/login   ❌
> ```
>
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
  "visibility" int2 NOT NULL,
  "create_time" timestamp(6) NOT NULL,
  "update_time" timestamp(6) NOT NULL
)
;
ALTER TABLE "public"."blog_article_draft" OWNER TO "postgres";

COMMENT ON COLUMN "public"."blog_article_draft"."visibility" IS '1 ：公开可见 2 ：仅专栏可见';

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
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (139, 14, 5);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (144, 11, 5);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (146, 9, 5);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (149, 16, 5);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (150, 17, 10);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (151, 18, 5);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (152, 19, 10);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (153, 19, 5);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (156, 20, 14);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (161, 24, 15);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (211, 27, 17);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (214, 28, 5);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (241, 12, 5);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (309, 2051609138701668352, 2051609138001219584);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (310, 2051609513676640256, 2051609513538228224);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (313, 2055960627280744448, 1);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (314, 2055960627280744448, 19);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (316, 31, 12);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (318, 32, 5);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (322, 8, 1);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (323, 8, 5);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (324, 10, 1);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (325, 1, 12);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (326, 1, 1);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (327, 1, 5);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (329, 2056031402947907584, 10);
INSERT INTO "public"."blog_article_tag_rel" ("id", "article_id", "tag_id") VALUES (330, 2060251596750721024, 21);
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
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (12, '73', '2025-09-14 23:23:25.862073', '2025-09-14 23:23:25.862073', 0, 1, 8);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (17, '1112', '2025-09-14 23:24:02.722188', '2025-09-14 23:24:02.722188', 0, 1, 3);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (1, 'java', '2024-06-01 04:10:39', '2024-06-01 04:10:39', 0, 0, 3);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (5, 'CSharp', '2025-08-30 11:52:14', '2025-08-30 11:52:14', 0, 7, 1);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (20, '44441', '2025-09-14 23:24:16.552863', '2025-09-14 23:24:16.552863', 0, 0, 3);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (8, '3333', '2025-09-14 23:23:03.91072', '2025-09-14 23:23:03.91072', 0, 0, 4);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (6, '三十岁', '2025-08-31 09:35:39', '2025-08-31 09:35:39', 0, 1, 5);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (22, '555555', '2025-09-14 23:24:30.741527', '2025-09-14 23:24:30.741527', 0, 2, 4);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (14, '9999991', '2025-09-14 23:23:44.635907', '2025-09-14 23:23:44.635907', 0, 0, 1);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (16, '1133', '2025-09-14 23:23:57.015623', '2025-09-14 23:23:57.015623', 0, 0, 2);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (26, '72', '2025-09-14 23:53:12.432991', '2025-10-06 15:09:27.235862', 0, 0, 7);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (13, '999999999', '2025-09-14 23:23:31.689365', '2025-09-14 23:23:31.689365', 0, 0, 7);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (9, '4444', '2025-09-14 23:23:08.30614', '2025-09-14 23:23:08.30614', 0, 0, 5);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (21, '44455', '2025-09-14 23:24:27.466987', '2025-09-14 23:24:27.466987', 0, 0, 5);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (23, '555551', '2025-09-14 23:24:34.799228', '2025-09-14 23:24:34.799228', 0, 1, 6);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (19, '4111-1', '2025-09-14 15:24:11.583695', '2026-05-07 13:10:12.169944', 0, 0, 4);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (10, '55555', '2025-09-14 15:23:14.015701', '2026-05-07 13:10:29.618909', 1, 0, 9);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (28, 'test', '2025-10-12 11:22:30.529926', '2026-05-11 17:37:40.869291', 0, 0, 2);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (18, '1113', '2025-09-14 23:24:07.277198', '2026-05-11 17:37:48.600156', 0, 0, 1);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (24, '71', '2025-09-14 23:24:39.176506', '2026-05-25 05:22:31.897142', 0, 0, 6);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (11, '99999', '2025-09-14 23:23:20.007407', '2026-05-27 14:24:34.414004', 1, 4, 7);
INSERT INTO "public"."blog_category" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (15, '741', '2025-09-14 15:23:50.166817', '2026-05-27 14:26:55.417675', 0, 0, 7);
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
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (14, '543456654567', 'http://127.0.0.1:9000/roc-blog/e065c6dd1b5b4ca3b56de6fe6e6b06d1.png', '额娃儿', '2025-09-15 13:34:30.196699', '2025-09-15 13:34:30.197242', 0, 0, 1, 3);
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (13, '三十岁5', 'http://127.0.0.1:9000/roc-blog/9846b0f06b4e47b4a374027a824080e7.png', '43434', '2025-09-15 13:34:15.022504', '2025-09-15 13:34:15.022504', 0, 0, 1, 4);
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (2059636683401465856, '哎哟,测试知识库888', 'http://127.0.0.1:9000/blog-article/column_1779890626005.png', '反反复复', '2026-05-27 14:03:46.168595', '2026-05-27 14:03:46.168595', 0, 0, 1, 0);
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (3, '测试知识库', 'http://127.0.0.1:9000/blog-article/logo_1780037348776_600.webp', '哎哟,测试知识库888', '2024-11-19 08:53:28', '2026-05-29 06:51:09.386391', 0, 3, 1, 17);
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (8, '对对对', 'http://127.0.0.1:9000/roc-blog/f252fa40364c4bb3a0848fae761466c5.jpg', '对对对', '2025-09-14 23:50:56.054275', '2025-09-14 23:50:56.054885', 0, 0, 1, 6);
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (10, '热特', 'http://127.0.0.1:9000/roc-blog/58e2d87006134b4db9a7310e8832a9f0.png', '对对对', '2025-09-14 23:51:19.001576', '2025-09-14 23:51:19.001576', 0, 0, 1, 7);
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (5, '呃呃呃', 'http://127.0.0.1:9000/blog/6430cf5675c54f519e3ff6d18ec17e66.png', '呃呃呃', '2025-08-31 11:08:57', '2026-05-25 03:25:56.731384', 1, 0, 1, 0);
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (2051609138382901248, '接口冒烟知识库-1777976710', 'https://example.com/wiki-cover.png', '接口级可回滚冒烟测试-updated', '2026-05-03 18:25:10.300615', '2026-05-25 03:25:57.625873', 1, 0, 1, 1);
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (2051609445343039488, '接口冒烟知识库-1777976783', 'https://example.com/wiki-cover.png', '接口级可回滚冒烟测试-updated', '2026-05-03 18:26:23.487183', '2026-05-25 03:25:58.543856', 1, 0, 1, 1);
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (6, '热特1', 'http://127.0.0.1:9000/blog/6430cf5675c54f519e3ff6d18ec17e66.png', '我问问', '2025-08-30 19:24:12', '2026-05-25 03:26:00.16942', 0, 0, 1, 10);
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (12, '发发发大', 'http://127.0.0.1:9000/roc-blog/58163ce8b66e4258ba5b95fc0a45a007.png', '阿打发', '2025-09-14 07:51:38.041194', '2026-05-25 03:26:28.25209', 0, 0, 1, 14);
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (16, '柔柔弱弱', 'http://127.0.0.1:9000/roc-blog/031779431d054fa5bc8c1a945eb822c4.webp', '柔柔弱弱', '2025-09-16 16:40:10.934364', '2026-05-25 03:26:32.629459', 0, 0, 1, 16);
INSERT INTO "public"."blog_column" ("id", "title", "cover", "summary", "create_time", "update_time", "is_deleted", "weight", "is_publish", "sort") VALUES (15, '333', 'http://127.0.0.1:9000/blog/6430cf5675c54f519e3ff6d18ec17e66.png', '额鹅鹅鹅', '2025-09-15 19:44:53.43292', '2026-05-25 03:26:36.394103', 0, 0, 1, 15);
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
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (36, 5, NULL, '概述', 1, NULL, 1, '2025-08-31 11:08:57', '2025-08-31 11:08:57', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (37, 5, NULL, '基础', 1, NULL, 2, '2025-08-31 11:08:57', '2025-08-31 11:08:57', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (38, 6, NULL, '概述', 1, NULL, 1, '2025-08-31 11:24:11', '2025-08-31 11:24:11', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (39, 6, NULL, '基础', 1, NULL, 2, '2025-08-31 11:24:11', '2025-08-31 11:24:11', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (41, 8, NULL, '概述', 1, NULL, 1, '2025-09-14 23:50:56.057174', '2025-09-14 23:50:56.057174', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (42, 8, NULL, '基础', 1, NULL, 2, '2025-09-14 23:50:56.057174', '2025-09-14 23:50:56.057174', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (45, 10, NULL, '概述', 1, NULL, 1, '2025-09-14 23:51:19.002861', '2025-09-14 23:51:19.002861', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (46, 10, NULL, '基础', 1, NULL, 2, '2025-09-14 23:51:19.002861', '2025-09-14 23:51:19.002861', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (47, 11, NULL, '概述', 1, NULL, 1, '2025-09-14 23:51:28.464237', '2025-09-14 23:51:28.464237', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (48, 11, NULL, '基础', 1, NULL, 2, '2025-09-14 23:51:28.464237', '2025-09-14 23:51:28.464237', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (49, 12, NULL, '概述', 1, NULL, 1, '2025-09-14 23:51:38.043985', '2025-09-14 23:51:38.043985', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (50, 12, NULL, '基础', 1, NULL, 2, '2025-09-14 23:51:38.043985', '2025-09-14 23:51:38.043985', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (51, 13, NULL, '概述', 1, NULL, 1, '2025-09-15 13:34:15.027063', '2025-09-15 13:34:15.027063', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (52, 13, NULL, '基础', 1, NULL, 2, '2025-09-15 13:34:15.027063', '2025-09-15 13:34:15.027063', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (53, 14, NULL, '概述', 1, NULL, 1, '2025-09-15 13:34:30.200136', '2025-09-15 13:34:30.200136', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (54, 14, NULL, '基础', 1, NULL, 2, '2025-09-15 13:34:30.200136', '2025-09-15 13:34:30.200136', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (55, 15, NULL, '概述', 1, NULL, 1, '2025-09-19 11:44:53.455143', '2025-09-19 11:44:53.455143', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (56, 15, NULL, '基础', 1, NULL, 2, '2025-09-19 11:44:53.455143', '2025-09-19 11:44:53.455143', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (57, 16, NULL, '概述', 1, NULL, 1, '2025-09-19 16:40:10.93642', '2025-09-19 16:40:10.93642', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (58, 16, NULL, '基础', 1, NULL, 2, '2025-09-19 16:40:10.93642', '2025-09-19 16:40:10.93642', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (59, 3, NULL, '概述', 1, 0, 1, '2026-05-27 14:22:16.7102', '2026-05-27 14:22:16.7102', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (60, 3, NULL, '哈哈哈', 1, 0, 2, '2026-05-27 14:22:16.711524', '2026-05-27 14:22:16.711524', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (61, 3, 1, 'HelloWorld', 2, 59, 1, '2026-05-27 14:22:16.712522', '2026-05-27 14:22:16.712522', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (62, 3, 10, '打发打发发方法', 2, 59, 2, '2026-05-27 14:22:16.712523', '2026-05-27 14:22:16.712523', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (63, 3, 27, '555', 2, 59, 3, '2026-05-27 14:22:16.712523', '2026-05-27 14:22:16.712523', 0);
INSERT INTO "public"."blog_column_catalog" ("id", "column_id", "article_id", "title", "level", "parent_id", "sort", "create_time", "update_time", "is_deleted") VALUES (64, 3, 12, '我问问666', 2, 59, 4, '2026-05-27 14:22:16.712523', '2026-05-27 14:22:16.712523', 0);
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
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (2, '三十岁', '', '我问问', 'yagnmufa@qq.com', '我问问', '/surfer/wiki/3', '2025-08-31 19:57:45', '2025-08-31 11:57:44', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (3, '三十岁1', '', '我问问', 'yagnmufa@qq.com', '我问问', '/surfer/wiki/3', '2025-08-31 19:57:52', '2025-08-31 11:57:52', 0, 2, 2, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (5, '放大发的', '', '我问问', 'yagnmufa@qq.com', '我问问', '/surfer/article/1', '2025-09-14 23:53:59.692747', '2025-09-14 23:53:59.697841', 0, NULL, NULL, '系统自动拦截，包含敏感词：[的]', 3);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (6, '放大发的发大发', '', '我问问', 'yagnmufa@qq.com', '我问问', '/surfer/article/1', '2025-09-14 23:54:05.372051', '2025-09-14 23:54:05.374887', 0, NULL, NULL, '系统自动拦截，包含敏感词：[的]', 3);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (8, '我问问', NULL, '', '', NULL, '', '2025-09-14 15:54:50.972091', '2025-09-14 15:54:50.972091', 0, NULL, NULL, '', 1);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (9, '呜呜呜呜', NULL, '', '', NULL, '', '2025-09-14 15:54:55.225906', '2025-09-14 15:54:55.225906', 0, NULL, NULL, '', 1);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (11, '呜呜呜呜呜呜', NULL, '', '', NULL, '', '2025-09-14 15:55:01.317563', '2025-09-14 15:55:01.317563', 0, NULL, NULL, '', 1);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (13, '呜呜呜呜呜呜呜', NULL, '', '', NULL, '', '2025-09-14 15:55:07.928365', '2025-09-14 15:55:07.928365', 0, NULL, NULL, '', 1);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (7, '放大发的发对对对大发', '', '我问问三四十岁', 'ya三十岁gnmufa@qq.com', '我对对对问问', '/surfer/article/1', '2025-09-14 23:54:16.525481', '2025-10-06 15:26:55.102678', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (15, '对对对对对', '', '你猜', 'yanggongzi@163.com', '你猜', '/surfer/articles/28', '2026-04-26 19:04:26.997428', '2026-04-26 19:04:26.998016', 0, NULL, NULL, '', 2);
INSERT INTO "public"."blog_comment" ("id", "content", "avatar", "nickname", "mail", "website", "router_url", "create_time", "update_time", "is_deleted", "reply_comment_id", "parent_comment_id", "reason", "status") VALUES (16, '😱👌😂😃😱😭😵', '', '你猜', 'yanggongzi@163.com', '你猜', '/surfer/articles/28', '2026-04-26 19:05:15.569971', '2026-04-26 19:05:15.570115', 0, NULL, NULL, '', 2);
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
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (3, '发大发', '三十岁', 'http://localhost:9200/admin/friend/list', '大幅度', 'active', '2025-10-20 14:48:18', 'tech', 'f', '', 1, 0, '2026-05-14 07:58:09.40027');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (4, '呃呃呃', '三十岁', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'active', '2025-10-20 16:27:45', 'tools', 't', '', 8, 0, '2026-05-14 07:58:09.400276');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (6, 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'active', '2025-10-20 16:31:05', 'navigation', 'f', '', 2, 0, '2026-05-14 07:58:16.825029');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (7, '我问问', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'active', '2025-10-20 16:31:25', 'aggregate', 'f', '', 1, 0, '2026-05-14 07:58:56.543593');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (5, '对对对', 'http://localhost:9200/admin/friend/list', 'http://localhost:9200/admin/friend/list', 'https://img.yanggongzi.dev/roc-blog/8c492941ce294ff597feb51f4fd8ff92.jpg', 'active', '2025-10-20 16:28:07', 'tools', 'f', '', 5, 0, '2026-05-14 07:59:43.885175');
INSERT INTO "public"."blog_friend" ("id", "name", "description", "url", "avatar", "status", "create_time", "category", "is_top", "email", "sort", "is_deleted", "update_time") VALUES (8, '阶段7友链测试 1777917169', '阶段7自动化友链申请验证', 'https://example.com/phase7-1777917169', 'https://example.com/avatar.png', 'pending', '2026-05-04 17:52:50', '阶段7测试', 'f', 'friend-phase7-1777917169@example.com', 0, 0, '2026-05-13 16:39:24.435354');
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
  "logo" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "author" varchar(200) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "introduction" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "copyright_declaration" text COLLATE "pg_catalog"."default",
  "avatar" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "github_homepage" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "csdn_homepage" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "gitee_homepage" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "zhihu_homepage" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "mail" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "is_comment_sensi_word_open" bool NOT NULL,
  "is_comment_examine_open" bool NOT NULL,
  "is_auto_theme" bool,
  "douyin_homepage" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying
)
;
ALTER TABLE "public"."blog_settings" OWNER TO "postgres";
COMMENT ON COLUMN "public"."blog_settings"."id" IS 'id';
COMMENT ON COLUMN "public"."blog_settings"."logo" IS '博客Logo';
COMMENT ON COLUMN "public"."blog_settings"."name" IS '博客名称';
COMMENT ON COLUMN "public"."blog_settings"."author" IS '作者名';
COMMENT ON COLUMN "public"."blog_settings"."introduction" IS '介绍语';
COMMENT ON COLUMN "public"."blog_settings"."copyright_declaration" IS '版权声明';
COMMENT ON COLUMN "public"."blog_settings"."avatar" IS '作者头像';
COMMENT ON COLUMN "public"."blog_settings"."github_homepage" IS 'GitHub 主页访问地址';
COMMENT ON COLUMN "public"."blog_settings"."csdn_homepage" IS 'CSDN 主页访问地址';
COMMENT ON COLUMN "public"."blog_settings"."gitee_homepage" IS 'Gitee 主页访问地址';
COMMENT ON COLUMN "public"."blog_settings"."zhihu_homepage" IS '知乎主页访问地址';
COMMENT ON COLUMN "public"."blog_settings"."mail" IS '博主邮箱地址';
COMMENT ON COLUMN "public"."blog_settings"."is_comment_sensi_word_open" IS '是否开启评论敏感词过滤, 0:不开启；1：开启';
COMMENT ON COLUMN "public"."blog_settings"."is_comment_examine_open" IS '是否开启评论审核, 0: 未开启；1：开启';
COMMENT ON COLUMN "public"."blog_settings"."is_auto_theme" IS '是否根据时间自动调整白天黑夜主题';
COMMENT ON COLUMN "public"."blog_settings"."douyin_homepage" IS '抖音主页访问地址';
COMMENT ON TABLE "public"."blog_settings" IS '博客设置表';

-- ----------------------------
-- Records of blog_settings
-- ----------------------------
BEGIN;
INSERT INTO "public"."blog_settings" ("id", "logo", "name", "author", "introduction", "copyright_declaration", "avatar", "github_homepage", "csdn_homepage", "gitee_homepage", "zhihu_homepage", "mail", "is_comment_sensi_word_open", "is_comment_examine_open", "is_auto_theme", "douyin_homepage") VALUES (1, 'http://127.0.0.1:9000/blog-article/logo_1780037348776_600.webp', 'Mint.Blog', '程序员-杨工子', '大家好,我是练习编程两年半的"程序员-杨工子",喜欢CV、Tab、Agent。', '本文为 程序员-杨工子 原创文章，遵循 CC BY 4.0 版权协议，转载请附上原文出处和链接。
如您认为本文内容侵犯了您的合法权益，请通过以下方式提供书面证明材料，我将在核实后24小时内处理。
📧 联系邮箱：yanggongzi@163.com', 'http://127.0.0.1:9000/blog-article/avatar_1780037348841_640.jpg', 'https://github.com/YangGongziDev', 'https://blog.csdn.net/YangMufa', 'https://gitee.com/YangGongziDev', 'https://www.zhihu.com/people/YangMufa', 'yanggongzi@163.com', 't', 'f', 't', 'https://v.douyin.com/8r27sSQYrz0');
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
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (240, '2026-05-29', 40, '2026-05-28 01:17:08.718974', '2026-05-29 10:05:14.806425');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (233, '2026-05-21', 36, '2026-05-21 13:15:20.817646', '2026-05-21 16:59:15.405243');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (234, '2026-05-23', 0, '2026-05-22 06:09:08.473552', '2026-05-22 06:09:08.473594');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (236, '2026-05-25', 43, '2026-05-24 00:53:06.674567', '2026-05-25 13:33:43.927763');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (222, '2026-05-10', 9, '2026-05-10 16:01:47.957639', '2026-05-10 17:38:06.967999');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (221, '2026-05-11', 1, '2026-05-10 13:17:11.256083', '2026-05-11 16:48:50.56198');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (224, '2026-05-13', 160, '2026-05-12 05:53:02.230803', '2026-05-13 16:50:02.864013');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (226, '2026-05-15', 0, '2026-05-14 01:32:05.010943', '2026-05-14 01:32:05.010992');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (225, '2026-05-14', 7, '2026-05-13 00:52:48.792054', '2026-05-14 15:58:03.116066');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (232, '2026-05-22', 14, '2026-05-21 01:58:24.42557', '2026-05-22 09:49:15.564506');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (227, '2026-05-17', 50, '2026-05-16 06:52:22.749708', '2026-05-17 17:48:47.533376');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (230, '2026-05-19', 0, '2026-05-18 15:21:14.783154', '2026-05-18 15:21:14.783197');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (235, '2026-05-24', 1, '2026-05-23 04:44:45.034737', '2026-05-24 07:23:41.23329');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (237, '2026-05-26', 0, '2026-05-25 01:29:05.453258', '2026-05-25 01:29:05.453269');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (239, '2026-05-27', 66, '2026-05-27 14:04:14.288241', '2026-05-27 17:10:56.865836');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (238, '2026-05-28', 1, '2026-05-27 13:44:48.527107', '2026-05-28 01:18:53.725793');
INSERT INTO "public"."blog_statistics_article_pv" ("id", "pv_date", "pv_count", "create_time", "update_time") VALUES (241, '2026-05-30', 0, '2026-05-29 06:44:21.262094', '2026-05-29 06:44:21.262135');
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
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (13, '打打打5', '2025-09-15 13:33:04.512558', '2025-09-15 13:33:04.512558', 0, 1, 3);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (12, '顶顶顶顶大胆', '2025-09-15 13:33:04.512558', '2025-09-15 13:33:04.512558', 0, 3, 2);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (10, '顶顶顶顶', '2025-08-31 17:35:46', '2025-08-31 17:35:46', 0, 3, 1);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (14, '热热热热热', '2025-09-15 13:33:04.512558', '2025-09-15 13:33:04.512558', 0, 2, 1);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (20, '额鹅鹅鹅666', '2025-09-15 13:33:32.10755', '2025-10-06 14:55:58.552656', 0, 1, 1);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (21, 'IU666', '2025-09-15 13:33:32.10755', '2025-10-06 14:56:09.940685', 0, 1, 1);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (15, '达4', '2025-09-15 13:33:04.512558', '2025-09-15 13:33:04.512558', 0, 1, 2);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (16, '333', '2025-09-15 13:33:04.512558', '2025-09-15 13:33:04.512558', 0, 0, 3);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (17, '5555哈哈哈', '2025-09-15 13:33:04.512558', '2025-09-15 13:33:04.512558', 0, 1, 4);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (1, 'test', '2024-06-01 12:11:18', '2024-06-01 12:11:18', 0, 3, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2052375606020149248, '测试的啦', '2026-05-07 13:10:50.420397', '2026-05-07 13:10:50.420397', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2052375751210176512, '测试的啦1', '2026-05-07 13:11:25.043247', '2026-05-07 13:11:25.043247', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (5, '就阿巴巴44烦都烦死防守打法是否', '2024-06-02 17:24:02', '2026-05-13 12:42:08.703727', 0, 12, 1);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (19, '呃呃呃呃呃呃', '2025-09-15 13:33:32.10755', '2026-05-14 15:15:49.791807', 0, 1, -1);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059632418566049792, '热热热', '2026-05-27 13:46:49.360821', '2026-05-27 13:46:49.360821', 0, 0, 0);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (22, '呃呃呃呃呃通天塔1', '2025-09-15 05:33:32.10755', '2026-05-27 13:47:54.53492', 1, 1, 5);
INSERT INTO "public"."blog_tag" ("id", "name", "create_time", "update_time", "is_deleted", "articles_total", "sort") VALUES (2059635639967682560, '呜呜呜呜', '2026-05-27 13:59:37.405585', '2026-05-27 13:59:37.405585', 0, 0, 0);
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
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
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
INSERT INTO "public"."sys_user" ("id", "username", "display_name", "password", "is_deleted", "create_time", "update_time") VALUES (1, 'SuperAdmin', '超级管理员', '$2a$12$WCmQ8F2eUQ.NWziniY1VrenENCeUi/ySIkIYuDJ8zKBsbK3wfoid6', 0, '2023-07-03 11:57:18', '2023-09-24 16:23:29');
INSERT INTO "public"."sys_user" ("id", "username", "display_name", "password", "is_deleted", "create_time", "update_time") VALUES (2, 'VisitorAdmin', '演示管理员', '$2a$12$VAlB.T8seA7mL1YS5TJmPOPjjSiUqGDHFbpd.V6Z4U4JH63S0iRcy', 0, '2025-08-25 11:39:10', '2026-05-16 12:39:09.819159');
INSERT INTO "public"."sys_user" ("id", "username", "display_name", "password", "is_deleted", "create_time", "update_time") VALUES (3, 'GenerallyAdmin', '一般管理员', '$2a$12$n.0TTXF6LQjXD2lBdPNfv.SAQtE7q6YZ8nBzjId2Ip1eS6dRP81Nq', 0, '2023-07-07 01:22:05', '2026-05-17 08:59:19.709202');
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
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054182026189344768, 3, 'B075E40AB2EBA43B0BBBA949D4FCB180DDEB37E0733E17E7A682203FEEFF8926', '2026-05-19 12:48:54.514874+00', 1, '2026-05-12 13:24:12.42719+00', '2026-05-12 12:48:54.526597+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054190909188345856, 3, '684D5B2E2B0F5F5DE2602499535A6FDAF4B6DE253F53F57F17469CCC2D5060F2', '2026-05-19 13:24:12.426079+00', 1, '2026-05-12 15:25:39.53589+00', '2026-05-12 13:24:12.42625+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054221473652019200, 3, '9250D1F035B65B6C9095659300440D412E4C332C122659A01FC23377F0D2C60B', '2026-05-19 15:25:39.53589+00', 1, '2026-05-13 00:56:53.062005+00', '2026-05-12 15:25:39.545621+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054365227390210048, 3, 'FA352C282C5F31C7CDE6FA462A27472C4B133FC67E89EB3A1DC5BF64360C25F7', '2026-05-20 00:56:53.062005+00', 1, '2026-05-13 02:57:42.019938+00', '2026-05-13 00:56:53.068352+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054395631476281344, 3, 'ABD63C26472A5A1FC917FD795E079769BC0458473F02CFF59406EBBC6348A974', '2026-05-20 02:57:42.019938+00', 1, '2026-05-13 03:56:14.328746+00', '2026-05-13 02:57:42.020234+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054410363142803456, 3, 'DD06A4A0EED7019328A4A35F62D2767A142E9F09587CF3EE64E57780EB3EF28B', '2026-05-20 03:56:14.325776+00', 1, '2026-05-13 07:46:09.882373+00', '2026-05-13 03:56:14.326008+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054468225902710784, 3, 'D33599DAEF8C861BDCD6801E6304AFFF6AE4BF3EF69C6EE09E15D85439EC4169', '2026-05-20 07:46:09.882373+00', 1, '2026-05-13 08:36:25.959138+00', '2026-05-13 07:46:09.882746+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054480876233953280, 3, 'DBF9CAB25EFB43D3D9E18767071D2C336DEF3E0F1FC25EC70CDBACA79395D9E9', '2026-05-20 08:36:25.952769+00', 1, '2026-05-13 08:38:53.834377+00', '2026-05-13 08:36:25.952977+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054481496466657280, 3, 'A8E2AAEDF00ED9FFBA78ED66BB6A264C59F4164B11FC198199F90B081B13F220', '2026-05-20 08:38:53.832076+00', 1, '2026-05-13 10:06:03.526823+00', '2026-05-13 08:38:53.832198+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054503431384731648, 3, '8A49FC8DA7408430F8747EA8882C2BF506FB0EF043BECBC11F2B8F73DA5BF960', '2026-05-20 10:06:03.523863+00', 1, '2026-05-13 10:06:15.073186+00', '2026-05-13 10:06:03.524115+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054503479816359936, 3, 'E384C2EE203655FDDD44C8714052799C94CC4495D9E9A9BF3E3029AE9FBF715E', '2026-05-20 10:06:15.070677+00', 1, '2026-05-13 10:13:56.511926+00', '2026-05-13 10:06:15.070819+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054505415227609088, 3, '25AEE38843A8050E779E65930B63D2DE48F5C71CAD16733B1E63C5EC6E011729', '2026-05-20 10:13:56.509543+00', 1, '2026-05-13 10:14:08.188999+00', '2026-05-13 10:13:56.509839+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054505464204496896, 3, 'F7F7590D1BD9D9F1EA14F62295E57BD6156B69E2F587591E70FD710E30C7BA9F', '2026-05-20 10:14:08.186788+00', 1, '2026-05-13 12:18:35.395704+00', '2026-05-13 10:14:08.186973+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054536783944880128, 3, 'C0FF890308A37D813F88D6927E211933EECBCB389388EDB54A57B97E92FEEC0D', '2026-05-20 12:18:35.390668+00', 1, '2026-05-13 12:18:54.247193+00', '2026-05-13 12:18:35.390842+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054536863011704832, 3, '5FC8EA6C5F3FFA62E496269ACD0ADFE68A90A2FC27A78C1B8DAC655E1F670AC0', '2026-05-20 12:18:54.244529+00', 1, '2026-05-13 12:25:16.043508+00', '2026-05-13 12:18:54.244725+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054538464380194816, 3, '910219EF2D7DE56BF35828B35ACC7105F5E70105120D7DF9F99383801D9A6650', '2026-05-20 12:25:16.040502+00', 1, '2026-05-13 12:28:31.086334+00', '2026-05-13 12:25:16.040732+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054539282449829888, 3, '8E90BA808CA1A4F29F8D26B9898B5DEB02A8ACF84D4BE0B7DBDE1474C3910132', '2026-05-20 12:28:31.083723+00', 1, '2026-05-13 12:32:57.903472+00', '2026-05-13 12:28:31.083885+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054540401561440256, 3, '365E3E49667B8BECB52FE724843C0D7B355273742C3522CF4742A0D426BC07A8', '2026-05-20 12:32:57.900584+00', 1, '2026-05-13 12:35:45.947708+00', '2026-05-13 12:32:57.900675+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054541106389061632, 3, 'D51F99D1275E3680A37F8F00B5A951B3DAFEEA6839C439B42CE59493ACB244D9', '2026-05-20 12:35:45.945188+00', 1, '2026-05-13 12:35:53.25336+00', '2026-05-13 12:35:45.945366+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054541137032646656, 3, '138EC5BF2F79E26E2A3573B057D04D126E1BC43ABEF4933AB076AAD13E303BBB', '2026-05-20 12:35:53.25055+00', 1, '2026-05-13 12:40:53.859682+00', '2026-05-13 12:35:53.250828+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054542397865594880, 3, '896C1C24299A51D469A659C75EE8D7C3DBD53ACEEA4EAAD935ED4D8988A1FC41', '2026-05-20 12:40:53.856836+00', 1, '2026-05-13 12:54:05.078333+00', '2026-05-13 12:40:53.857113+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054545716478611456, 3, 'CD58D49E85456D877B45CA057E1433E9C0176F405AD2651694111CE5E2950AE4', '2026-05-20 12:54:05.075583+00', 1, '2026-05-13 14:29:39.287012+00', '2026-05-13 12:54:05.075666+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054569767544688640, 3, '9858D49BE31845CCFBAD1C7684BC9AA552D9FC2E5F96EDECB8B3B4C7D2CF173D', '2026-05-20 14:29:39.261738+00', 1, '2026-05-13 15:03:52.987611+00', '2026-05-13 14:29:39.266866+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054578381336481792, 3, '0D670382A85D65BA148CEF8E4264E4906678039F723430E663A54D52CECEC920', '2026-05-20 15:03:52.984669+00', 1, '2026-05-13 15:04:56.211256+00', '2026-05-13 15:03:52.984848+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054578646517157888, 3, '9113A01EBD03DF5DF7F504B31EE1D1A2C3DBF93B7BEBB538BE3D10A05349364A', '2026-05-20 15:04:56.20901+00', 1, '2026-05-13 15:05:59.136016+00', '2026-05-13 15:04:56.209108+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054578910443737088, 3, '66EE4306456BE0FCCBC5193932BAA6BD3DA7C91901F818347A1ED8734898B575', '2026-05-20 15:05:59.133786+00', 1, '2026-05-13 15:06:08.492294+00', '2026-05-13 15:05:59.133908+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054578949685645312, 3, '3F2C44A5B39CE4F1D2602F22746BB74158AF3C9330D4CC5AA5CD33315E70F26E', '2026-05-20 15:06:08.490364+00', 1, '2026-05-13 15:11:42.142366+00', '2026-05-13 15:06:08.490488+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054580349115174912, 3, 'FAA733E77596A6EAB2F60FCA9ABBCC5ED1662DC641D77F20DD2A2C51042838A5', '2026-05-20 15:11:42.139702+00', 1, '2026-05-13 15:11:49.060714+00', '2026-05-13 15:11:42.1399+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054580378135564288, 3, 'D15690EEA7B5BDB3F86AEFD8ED7142497C0D074E937DB34BD9563FAC01FDA423', '2026-05-20 15:11:49.058488+00', 1, '2026-05-13 15:12:53.749893+00', '2026-05-13 15:11:49.058614+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054580649456701440, 3, 'CAC50566BF691ECA7D0FFBBB8095C4E9989EE859E35EED5AAA6DABB6E5522F40', '2026-05-20 15:12:53.748262+00', 1, '2026-05-13 16:29:25.516177+00', '2026-05-13 15:12:53.748362+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054599908740173824, 3, 'BBEBC28D1CEF029E608474B14FBE51F86156CAB3521E0637FC65EDA412E74F5A', '2026-05-20 16:29:25.499908+00', 1, '2026-05-14 01:32:11.133657+00', '2026-05-13 16:29:25.504438+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054736498875568128, 3, 'FA3F5AF62AE9FE5F31DB02FA7BD2F1EEA48CF5B0E4304D4B3E2A43D5F912DE47', '2026-05-21 01:32:11.097138+00', 1, '2026-05-14 02:00:23.894736+00', '2026-05-14 01:32:11.10884+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054743598775275520, 3, '7856A5A209A2B3396A687490C545B435B2B6E5DB82DC2EAF42482AED357B143C', '2026-05-21 02:00:23.890933+00', 1, '2026-05-14 02:01:28.820767+00', '2026-05-14 02:00:23.891111+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054743871094657024, 3, 'D4B4F9B2DD4F631E81E466CDCB5A5144D73DDF5C000372F7FB7A7D441FAB8C25', '2026-05-21 02:01:28.81852+00', 1, '2026-05-14 02:01:52.605045+00', '2026-05-14 02:01:28.818647+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054743970851983360, 3, '2B0AE6B85AC5A753CE1EAFF293E539FCF91E3D64CF23FB8702B1426F6A491058', '2026-05-21 02:01:52.60349+00', 1, '2026-05-14 02:04:20.110084+00', '2026-05-14 02:01:52.603646+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054744589532794880, 3, 'B9AACC366E217CAC258B1557377A580F841ED86B2C782BF991F6D0E4200078FE', '2026-05-21 02:04:20.108148+00', 1, '2026-05-14 02:04:36.435969+00', '2026-05-14 02:04:20.108262+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054744658013196288, 3, 'F628F4F6F1D3BBAC4A25AFF8B523DE997AF13DEFB435DC69C7FCBA08384634FB', '2026-05-21 02:04:36.434057+00', 1, '2026-05-14 07:22:17.929203+00', '2026-05-14 02:04:36.434172+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054824607747280896, 3, '8C3958044DA55EB2C2BCA22FBA3118F95A7496E33A74A999AEBBB202820B7F20', '2026-05-21 07:22:17.929203+00', 1, '2026-05-14 07:42:27.45543+00', '2026-05-14 07:22:17.929585+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054829680829272064, 3, '5D0B2536C140F2FC837BBBE5A8C01E0013DF40AC1201B53D089839B2F55883F3', '2026-05-21 07:42:27.453083+00', 1, '2026-05-14 07:46:54.113595+00', '2026-05-14 07:42:27.453217+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054830799278182400, 3, 'B5527003DC48D0F4E7ADE1C9CEF32D64ED38FCEC55C0D4ACB4741F7753EA42C8', '2026-05-21 07:46:54.109883+00', 1, '2026-05-14 07:47:00.274051+00', '2026-05-14 07:46:54.110022+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054830825119289344, 3, 'FD2D60EBEB54CF36FCDDD858792F9A99CCA80B5C02F6F9062669113323CDCCF1', '2026-05-21 07:47:00.272529+00', 1, '2026-05-14 08:32:28.310578+00', '2026-05-14 07:47:00.272696+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054842267327401984, 3, '9E2690905D19FEDB868834FA8E60C2C0E8E9EBF729D8CA7AF921A7AE944F1C10', '2026-05-21 08:32:28.306908+00', 1, '2026-05-14 08:41:37.579252+00', '2026-05-14 08:32:28.307068+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054844571128565760, 3, 'B5F114F775FD97B5DE06EC046AFA192DB6433D893FDC2F0CC21CDE1BCEE6790D', '2026-05-21 08:41:37.576465+00', 1, '2026-05-14 11:04:16.847768+00', '2026-05-14 08:41:37.576646+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054880471367684096, 3, 'C6F47A5837DD89723B6BF43FACA1F36B727C06E7E64D959F1C66801DC2F95BD9', '2026-05-21 11:04:16.808053+00', 1, '2026-05-14 13:29:49.377236+00', '2026-05-14 11:04:16.822357+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054917098311913472, 3, 'F0E2350EC9F923D9207F58C968C9E6CBCE95F17D79273DEB824D59F65F8E177C', '2026-05-21 13:29:49.377236+00', 1, '2026-05-14 15:30:20.879128+00', '2026-05-14 13:29:49.38818+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2054947429370957824, 3, '8F1720FB1C3EDF62EF19B34D121D559D60ECD6BE3F8B819A83050E9B8AEE3A71', '2026-05-21 15:30:20.879128+00', 1, '2026-05-16 07:07:44.70727+00', '2026-05-14 15:30:20.883385+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055583061139132416, 3, '8B134CB40C16FD970EE930BF1C8797A8B3B0F4AE173CA8736D27AF419D63428A', '2026-05-23 09:36:07.299928+00', 1, '2026-05-16 11:38:12.359959+00', '2026-05-16 09:36:07.300018+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055545720928342016, 3, 'F4791201A70E496EAE54E661C3DF72D55205D92E014BB9B3ECE5A4A865D6CFE6', '2026-05-23 07:07:44.67239+00', 1, '2026-05-16 09:36:07.299928+00', '2026-05-16 07:07:44.684563+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055583061072023552, 3, 'A36CB2F58E3E5D9326EE1A7963B581FEF624A5D102634C72E23215BD7254E316', '2026-05-23 09:36:07.263703+00', 1, '2026-05-16 14:38:00.222623+00', '2026-05-16 09:36:07.264207+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055613784508207104, 3, '29697F076ACDE5BBD43F3BEDB807E3DA203B69F55859656114878C5A54A23034', '2026-05-23 11:38:12.292756+00', 1, '2026-05-16 14:38:00.222623+00', '2026-05-16 11:38:12.297925+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055583061130743808, 3, 'D328F64D704EEB4F06DCC44CB59508D4D7611B3F2C40AD8B7179E2AA59E5178C', '2026-05-23 09:36:07.259133+00', 1, '2026-05-16 14:38:00.222623+00', '2026-05-16 09:36:07.264199+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055613784587898880, 3, '407063235AEA3496A96F0BBB3F4A46616EB1060043323FEAB4F7DCA89AFDECB5', '2026-05-23 11:38:12.294925+00', 1, '2026-05-16 14:38:00.222623+00', '2026-05-16 11:38:12.297932+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055613784596287488, 3, '5FD2444A4DC69E114D5972A5D6B45993BD73866A6D19D74102E712BC30F9995A', '2026-05-23 11:38:12.359959+00', 1, '2026-05-16 14:38:00.222623+00', '2026-05-16 11:38:12.36007+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055659032231940096, 3, 'F849DF414B0E68B3C176E4FC1C6EA8429FA52F5193D3A3C31F8B3C309E2CA900', '2026-05-23 14:38:00.184323+00', 1, '2026-05-17 05:03:49.263685+00', '2026-05-16 14:38:00.197227+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055876922465980416, 3, '9FB47EF30085B7F43DDF85626224BCEB36DB5C5F6359E17CC45D99E8AA9EF47C', '2026-05-24 05:03:49.263685+00', 1, '2026-05-17 08:36:11.089815+00', '2026-05-17 05:03:49.269533+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055930365352218624, 3, '02C7E40986247C7FAF59540F134912C918BBAE62BE259CA31D9D9E9E60B1F847', '2026-05-24 08:36:11.089815+00', 1, '2026-05-17 08:54:42.521038+00', '2026-05-17 08:36:11.09003+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055935027010736128, 3, 'C428B3DF2FE00B0BD05BBC1232CD8B3BE42D383D7A18C767C2D81C8C7861ED97', '2026-05-24 08:54:42.517721+00', 1, '2026-05-17 08:54:58.300937+00', '2026-05-17 08:54:42.517963+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055935703958818816, 3, '279BC16B6F4AA522D64B08A22E9EF41AD8D6C160FBDCB5531FB2C07C507FC0E2', '2026-05-24 08:57:23.91575+00', 1, '2026-05-17 08:59:19.73778+00', '2026-05-17 08:57:23.915879+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055936203349430272, 3, '3606C86CB147E8947C09003BA1FF9E0D353BD5647C426A193AC7EB3F1F8244E3', '2026-05-24 08:59:22.981358+00', 1, '2026-05-17 09:00:20.755135+00', '2026-05-17 08:59:22.981482+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055936445666955264, 3, 'C1C7B652C2AC454A79294A3679E17B49B319C906C74F5B6B140C1DF847C0DBF9', '2026-05-24 09:00:20.752608+00', 1, '2026-05-17 09:01:44.989709+00', '2026-05-17 09:00:20.752777+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055936798969958400, 3, '7C45CD432AA9A898846CBA1FF138E1A8694657818056DD9D40526F3F80921221', '2026-05-24 09:01:44.987393+00', 1, '2026-05-17 09:15:36.518209+00', '2026-05-17 09:01:44.98751+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055940286655369216, 3, 'DD4ED72A8E739DA5730A77D91841ABC896D9C5F9997B63DC18D6198119114F20', '2026-05-24 09:15:36.51588+00', 1, '2026-05-17 10:11:50.627887+00', '2026-05-17 09:15:36.516028+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2055954438723604480, 3, '814B5CED3136635AEC320C366804B98568F1943B811C8A9E495BA0DCA98BE111', '2026-05-24 10:11:50.603489+00', 1, '2026-05-17 13:57:36.04407+00', '2026-05-17 10:11:50.614781+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2056011252349669376, 3, 'FFE5A88BF31BBB6F9F81F904D367D7F4DE79791B0C81C200708F9E473B6D39E2', '2026-05-24 13:57:36.00663+00', 1, '2026-05-17 16:01:47.832758+00', '2026-05-17 13:57:36.01986+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2056042507581657088, 3, '41EC7F629E317BB21445DC0A51813309649E422F257901E5470506AE3803B95A', '2026-05-24 16:01:47.832758+00', 1, '2026-05-18 15:23:00.40087+00', '2026-05-17 16:01:47.838288+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2056395133481521152, 3, '4E978D61AB34C474732624C0B417ECD251325765C5C2138320F6434A40459641', '2026-05-25 15:23:00.40087+00', 1, '2026-05-18 16:16:56.605873+00', '2026-05-18 15:23:00.406821+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2056407024597602304, 2, '63860B0869F6398EE32E9A71ED96C013FBEA841DA47C3F79A7C86C6F254BC3CC', '2026-05-25 16:10:15.467651+00', 1, '2026-05-18 16:17:34.926506+00', '2026-05-18 16:10:15.478638+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2056408706895187968, 3, 'B89BCA8E3E97DE7678A0A4EF4D9B1AF0D506CE7B73424D7C530BCC98AFEDF8DC', '2026-05-25 16:16:56.602613+00', 1, '2026-05-19 13:59:59.260095+00', '2026-05-18 16:16:56.602745+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058132769300680704, 2, '40D228F19B5C2BFC347266897DCC88FBDB18DCC28FB898F7E5AED9953FB7241D', '2026-05-30 10:27:45.080906+00', 1, '2026-05-24 05:50:42.816426+00', '2026-05-23 10:27:45.08867+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2056736628768116736, 3, '8800CEE7AC8AD3651208676D96A607D9BB999385BA2EA7D6391B0B3AF55A173C', '2026-05-26 13:59:59.222501+00', 1, '2026-05-19 16:47:44.940328+00', '2026-05-19 13:59:59.234415+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2056408867620917248, 2, '91B3B6A96D61C60351599AD548DEA3399B999256FDA2B00A805C4D92DE5D4690', '2026-05-25 16:17:34.9254+00', 1, '2026-05-21 13:13:32.033854+00', '2026-05-18 16:17:34.925495+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2057449714030350336, 2, 'B13EB20469EA03FAD1D70F6C25D07A5238BCA28CF96749A9D0FD3BAF540AA8D8', '2026-05-28 13:13:31.989451+00', 1, '2026-05-21 15:43:33.528549+00', '2026-05-21 13:13:32.005048+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2057487469011668992, 2, '566498804FAF4247315256C5110087137A6C0EC85C748D7E3C9EE3D3FF1B546D', '2026-05-28 15:43:33.528549+00', 1, '2026-05-21 15:43:33.760001+00', '2026-05-21 15:43:33.532231+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2057503823097892864, 2, 'C14C5845C50B3A51B0BFB96827C5F9207F17A5446EB6CB14C526926422852160', '2026-05-28 16:48:32.605602+00', 1, '2026-05-21 17:19:45.629919+00', '2026-05-21 16:48:32.616174+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2057511678991536128, 2, 'FD30476A59DAC88AFF0F6C141078784004648B5B9F1BE8D49352ECCB9218008D', '2026-05-28 17:19:45.595964+00', 1, '2026-05-22 06:34:12.401413+00', '2026-05-21 17:19:45.60673+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2057711607898836992, 2, 'EA2E67ADF0F2898705993114F4D545124418CD5D7A0A2FB07C57BBDAFA8DF718', '2026-05-29 06:34:12.368024+00', 1, '2026-05-22 11:51:01.472196+00', '2026-05-22 06:34:12.377973+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2057791337700397056, 2, 'FD24AEF4FD98499DB3C47535AB58D22C5EA759813FDCD0C5E2B2853321052D49', '2026-05-29 11:51:01.445448+00', 1, '2026-05-22 18:32:52.026251+00', '2026-05-22 11:51:01.454351+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2057892464693481472, 2, 'BDC88C172D574CBED06BAD0FE1199F4F80DBD89198245622406EF7773A3E026B', '2026-05-29 18:32:52.026267+00', 1, '2026-05-23 09:01:19.670266+00', '2026-05-22 18:32:52.028798+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2057892464706064384, 2, '3F26822AD7CFBB2E5F5B19E1AD489E0C2EF6EB89BFCCCE1C45D093FC0DC604F5', '2026-05-29 18:32:52.026251+00', 1, '2026-05-23 10:27:45.105557+00', '2026-05-22 18:32:52.028801+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058111020173496320, 2, '51307BE975CA7916E40B60866DFDE499C9A4B39F9C9938B38A4CF89E173BBAC4', '2026-05-30 09:01:19.670266+00', 1, '2026-05-23 10:27:45.105557+00', '2026-05-23 09:01:19.679304+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2056778847310974976, 3, '4CF571940641021F197EC2CBA7A4BB865A176F4B62663D3419D0A1EF6024EEE6', '2026-05-26 16:47:44.889371+00', 1, '2026-05-23 10:31:04.083724+00', '2026-05-19 16:47:44.908352+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2056778847369695232, 3, '8A481BF225F5D6B6F5AF64775CFC2FDCFEF69BF26B79707FEA17CF3CC3C3DC3E', '2026-05-26 16:47:44.940328+00', 1, '2026-05-23 10:31:04.083724+00', '2026-05-19 16:47:44.941458+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058133603837153280, 3, '2B142949FD8F092F3F6F15F0DF711FB57709B565C058298F4A5C16B38BCB3FE5', '2026-05-30 10:31:04.081581+00', 1, '2026-05-23 12:59:51.59262+00', '2026-05-23 10:31:04.081681+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058171048649691136, 3, '13D53E4CA420AE518870C5A5639A45C4E8D4DA370C29E5B2BD37F8328FC9EFF7', '2026-05-30 12:59:51.59262+00', 1, '2026-05-23 13:56:35.911567+00', '2026-05-23 12:59:51.597451+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058185327272660992, 3, '40A3C6F615E5F6DBDA0D3920CB16C38C92A493F1D6889F3982000D471F766B98', '2026-05-30 13:56:35.908225+00', 1, '2026-05-23 15:57:54.931058+00', '2026-05-23 13:56:35.908424+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058215857888301056, 3, 'A4C24964B4BF0699EB4DC7A404AF5F0682B4894D4C403A494D2752ABB36B86D9', '2026-05-30 15:57:54.931058+00', 1, '2026-05-23 17:59:42.68062+00', '2026-05-23 15:57:54.939539+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058246508683333632, 3, '9DE80FFE0C0986CB67A803A1B92C9B424E61BF3FB02AE668A272A5990495B416', '2026-05-30 17:59:42.68062+00', 1, '2026-05-24 02:39:26.566454+00', '2026-05-23 17:59:42.686678+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058425438228844544, 2, 'A0221D8E53CC3A64A116BD606D5D8E8A9A044730065E4F4243407CE9887C5C96', '2026-05-31 05:50:42.789409+00', 1, '2026-05-24 05:51:04.900335+00', '2026-05-24 05:50:42.798049+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058377303326593024, 3, 'BFE6DC8D2EDA91540FBA8F886F53552ED894661F9928E633564B660C0118E157', '2026-05-31 02:39:26.566454+00', 1, '2026-05-24 05:59:38.177914+00', '2026-05-24 02:39:26.567858+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058427683699822592, 3, '0527B14432E85806ADF14A3CA725A588AC04315CECB7C85346515C5CF78A5E2B', '2026-05-31 05:59:38.158762+00', 1, '2026-05-24 08:04:49.660687+00', '2026-05-24 05:59:38.162372+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058459189130432512, 3, '00BC305661A975A44223F4BEA2FF95238AD95B09B4669C7219F4FBCA24D8A04E', '2026-05-31 08:04:49.660687+00', 1, '2026-05-24 14:04:42.740394+00', '2026-05-24 08:04:49.663225+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058549757248409600, 3, '42E824254A23947349F83041E039E43C67290C9692CBB935C5314E3B3CC8C252', '2026-05-31 14:04:42.740394+00', 1, '2026-05-25 01:29:33.137449+00', '2026-05-24 14:04:42.749045+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058425530818105344, 2, 'F40C3404A2799C4D018902B4F7E1D171B0D389FDCBAD1A7C09698C5255502B90', '2026-05-31 05:51:04.897668+00', 1, '2026-05-25 01:51:54.619774+00', '2026-05-24 05:51:04.897835+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058722102869102592, 3, '1AAD08A23CDCCC74F2D18F3469DE219D9F65FFDE99C811C0EEE41AF1D92D28FC', '2026-06-01 01:29:33.137449+00', 1, '2026-05-25 01:52:43.201619+00', '2026-05-25 01:29:33.147634+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058727729242705920, 2, 'ABB007B11B8B158C216663465718146AABF6AF43C97CE64801FF7FF0767BBE6C', '2026-06-01 01:51:54.618139+00', 1, '2026-05-25 01:55:07.711639+00', '2026-05-25 01:51:54.618278+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058727933010382848, 3, '545B8F0B0D24809BAC63B03F404DC6C46F94ED450C7897DE9D9427C22A0832DB', '2026-06-01 01:52:43.200176+00', 1, '2026-05-25 01:58:16.412053+00', '2026-05-25 01:52:43.200258+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058729330594418688, 3, 'E23FA1D31177F6342078AAA8CDD83C3929F6A303C59FBF114F84B4B134CE34AE', '2026-06-01 01:58:16.410768+00', 1, '2026-05-25 04:27:28.611341+00', '2026-05-25 01:58:16.410873+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058766878951739392, 3, 'A564E21120A59AB19431F54430A00898A56D638F9FC0EC80CA6F9FA970D3CB10', '2026-06-01 04:27:28.611341+00', 1, '2026-05-25 07:05:29.550667+00', '2026-05-25 04:27:28.618507+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058728539129253888, 2, '1CE90F5607624E60198694D49709EC1DF38C72D11AD582ABEBC27A926ED9B222', '2026-06-01 01:55:07.7102+00', 1, '2026-05-25 12:38:41.112465+00', '2026-05-25 01:55:07.710327+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058890495538630656, 2, 'F87E5703D6ABA6B7D3A3C107941DFD111A10AB01A3E343CE7F9BCEFEE4A81C83', '2026-06-01 12:38:41.07208+00', 0, NULL, '2026-05-25 12:38:41.083434+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058806644825001984, 3, '8A9BC36A019F62D3D53D076AFA9C92604D683556AE8E3B24FA942AE6B41EBA75', '2026-06-01 07:05:29.550667+00', 1, '2026-05-25 13:18:54.81284+00', '2026-05-25 07:05:29.555927+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058727553044189184, 1, '4015E22C649B320D2489A257422512645C9D211EDD313B6578C4F0599E14FD4F', '2026-06-01 01:51:12.578248+00', 1, '2026-05-27 13:46:34.788269+00', '2026-05-25 01:51:12.585091+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2059632357488594944, 1, 'F0052DB55903A5DA6E9E6498CF2DB4735CB348AE39EB564D1FEBF3240CB724D4', '2026-06-03 13:46:34.751539+00', 1, '2026-05-27 15:48:42.564453+00', '2026-05-27 13:46:34.764358+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2059663092408782848, 1, '312ED996F8B91B86737DC8E49E4AC8CC2DD7A016E66A4224A487247E8114F063', '2026-06-03 15:48:42.564453+00', 1, '2026-05-28 01:17:35.76381+00', '2026-05-27 15:48:42.570592+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2058900619263086592, 3, '1BA867C0652A4BCEF60ADB78289C32C6CA6B4D84B4F79D735DB692DA6F7662B2', '2026-06-01 13:18:54.810895+00', 1, '2026-05-29 06:44:41.557468+00', '2026-05-25 13:18:54.811056+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2060250961833758720, 3, '3D52888C41B9556896CA3ACDDAFA957408D3A49FB403489D53E5C1D59DFFA98C', '2026-06-05 06:44:41.520537+00', 0, NULL, '2026-05-29 06:44:41.532249+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2059806257639985152, 1, 'A8720113576D9C5E4D8854953D38D1F709FC9A32674ED28EE3B9705155C1A33C', '2026-06-04 01:17:35.76381+00', 1, '2026-05-29 09:20:25.583553+00', '2026-05-28 01:17:35.774638+00');
INSERT INTO "public"."sys_user_refresh_token" ("id", "user_id", "token_hash", "expires_at", "is_revoked", "revoked_at", "create_time") VALUES (2060290153536163840, 1, '3C127FFD7597A04478E0CBD192439132D53F549F7B3EE01F55D49454B4C68750', '2026-06-05 09:20:25.546793+00', 0, NULL, '2026-05-29 09:20:25.557982+00');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_role";
CREATE TABLE "public"."sys_user_role" (
  "id" int8 NOT NULL DEFAULT nextval('sys_user_role_id_seq'::regclass),
  "username" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "role" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
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
INSERT INTO "public"."sys_user_role" ("id", "username", "role", "create_time") VALUES (2, 'VisitorAdmin', 'ROLE_VISITOR', '2023-07-07 01:23:33');
INSERT INTO "public"."sys_user_role" ("id", "username", "role", "create_time") VALUES (1, 'SuperAdmin', 'ROLE_SUPER', '2023-07-07 01:21:15');
INSERT INTO "public"."sys_user_role" ("id", "username", "role", "create_time") VALUES (3, 'GenerallyAdmin', 'ROLE_ADMIN', '2026-04-19 00:03:25');
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
SELECT setval('"public"."blog_friend_id_seq"', 10, true);

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
-- Indexes structure for table sys_user
-- ----------------------------
CREATE UNIQUE INDEX "uk_username" ON "public"."sys_user" USING btree (
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

-- ----------------------------
-- Primary Key structure for table sys_user_role
-- ----------------------------
ALTER TABLE "public"."sys_user_role" ADD CONSTRAINT "sys_user_role_pkey" PRIMARY KEY ("id");








CREATE TABLE IF NOT EXISTS public.blog_gallery_category (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(500) NOT NULL DEFAULT '',
  sort INTEGER NOT NULL DEFAULT 0,
  enabled BOOLEAN NOT NULL DEFAULT TRUE,
  create_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  update_time TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.blog_gallery_category IS '博客画廊分类表';
COMMENT ON COLUMN public.blog_gallery_category.id IS '画廊分类主键ID';
COMMENT ON COLUMN public.blog_gallery_category.name IS '分类名称';
COMMENT ON COLUMN public.blog_gallery_category.description IS '分类描述';
COMMENT ON COLUMN public.blog_gallery_category.sort IS '排序值，数值越大越靠前';
COMMENT ON COLUMN public.blog_gallery_category.enabled IS '是否启用，true启用，false停用';
COMMENT ON COLUMN public.blog_gallery_category.create_time IS '创建时间';
COMMENT ON COLUMN public.blog_gallery_category.update_time IS '更新时间';

CREATE TABLE IF NOT EXISTS public.blog_gallery_image (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(160) NOT NULL,
  category_id BIGINT NOT NULL REFERENCES public.blog_gallery_category(id),
  resolution VARCHAR(50) NOT NULL DEFAULT '',
  ratio VARCHAR(50) NOT NULL DEFAULT '',
  image_time DATE NULL,
  url TEXT NOT NULL,
  source_type VARCHAR(20) NOT NULL DEFAULT 'local',
  bucket_name VARCHAR(120) NOT NULL DEFAULT '',
  object_name VARCHAR(500) NOT NULL DEFAULT '',
  file_name VARCHAR(260) NOT NULL DEFAULT '',
  size int4 NOT NULL DEFAULT 0 ,
  sort INTEGER NOT NULL DEFAULT 0,
  enabled BOOLEAN NOT NULL DEFAULT TRUE,
  create_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  update_time TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.blog_gallery_image IS '博客画廊图片表';
COMMENT ON COLUMN public.blog_gallery_image.id IS '画廊图片主键ID';
COMMENT ON COLUMN public.blog_gallery_image.name IS '图片名称';
COMMENT ON COLUMN public.blog_gallery_image.category_id IS '所属画廊分类ID，关联blog_gallery_category.id';
COMMENT ON COLUMN public.blog_gallery_image.resolution IS '图片分辨率，例如4K、1920x1080';
COMMENT ON COLUMN public.blog_gallery_image.ratio IS '图片比例，例如16:9、4:3、9:16';
COMMENT ON COLUMN public.blog_gallery_image.image_time IS '图片时间或拍摄/收集日期';
COMMENT ON COLUMN public.blog_gallery_image.url IS '图片访问链接，本地上传时由对象存储自动生成，外部引用时为第三方图片链接';
COMMENT ON COLUMN public.blog_gallery_image.source_type IS '图片来源类型，local表示本地上传，external表示外部引用';
COMMENT ON COLUMN public.blog_gallery_image.bucket_name IS '本地上传图片所在对象存储桶名称，外部引用时为空';
COMMENT ON COLUMN public.blog_gallery_image.object_name IS '本地上传图片在对象存储中的对象名称，外部引用时为空';
COMMENT ON COLUMN public.blog_gallery_image.file_name IS '原始文件名或显示文件名';
COMMENT ON COLUMN public.blog_gallery_image.size IS '图片大小，单位M，外部引用时为空';
COMMENT ON COLUMN public.blog_gallery_image.sort IS '排序值，数值越大越靠前';
COMMENT ON COLUMN public.blog_gallery_image.enabled IS '是否启用，true启用，false停用';
COMMENT ON COLUMN public.blog_gallery_image.create_time IS '创建时间';
COMMENT ON COLUMN public.blog_gallery_image.update_time IS '更新时间';

CREATE INDEX IF NOT EXISTS idx_blog_gallery_image_category_id ON public.blog_gallery_image(category_id);
CREATE INDEX IF NOT EXISTS idx_blog_gallery_category_sort ON public.blog_gallery_category(sort DESC, create_time DESC);
CREATE INDEX IF NOT EXISTS idx_blog_gallery_image_sort ON public.blog_gallery_image(sort DESC, create_time DESC);

