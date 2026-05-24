/*
 Navicat Premium Dump SQL

 Source Server         : AliCloud_Docker-YangMufa666
 Source Server Type    : PostgreSQL
 Source Server Version : 170002 (170002)
 Source Host           : 47.116.10.106:5432
 Source Catalog        : Mint.Blog
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 170002 (170002)
 File Encoding         : 65001

 Date: 24/05/2026 18:15:11
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
  "type" int2 NOT NULL DEFAULT 1
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
COMMENT ON COLUMN "public"."blog_article"."type" IS '文章类型1：普通文章，2：收录于知识库';
COMMENT ON TABLE "public"."blog_article" IS '文章表';

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
  "update_time" timestamp(6) NOT NULL
)
;
ALTER TABLE "public"."blog_article_draft" OWNER TO "postgres";

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
-- Table structure for blog_column
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_column";
CREATE TABLE "public"."blog_column" (
  "id" int8 NOT NULL DEFAULT nextval('blog_wiki_id_seq'::regclass),
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
-- Table structure for blog_settings
-- ----------------------------
DROP TABLE IF EXISTS "public"."blog_settings";
CREATE TABLE "public"."blog_settings" (
  "id" int8 NOT NULL DEFAULT nextval('blog_settings_id_seq'::regclass),
  "name" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "logo" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "author" varchar(20) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "avatar" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "introduction" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "copyright_declaration" varchar(255) COLLATE "pg_catalog"."default",
  "github_homepage" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "csdn_homepage" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "gitee_homepage" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "zhihu_homepage" varchar(60) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "douyin_homepage" varchar(120) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "mail" varchar(60) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
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
