let routeOptions = [
    {
        path: "/login", // 登录页
        component: () => import("@/views/Login.vue"),
        meta: {
            title: "登录",
        },
    },
    {
        path: "/:pathMatch(.*)*",
        name: "NotFound",
        component: () => import("@/views/404.vue"),
        meta: {
            title: "404",
        },
    },
    {
      path: "/resume",
      component: () => import("@/views/Resume.vue"),
      meta: {
        title: "个人简历",
      },
    },
    {   // admin和surfer的公共路由
        path: "/",
        component: () => import("@/views/Index.vue"),
        redirect: "/surfer",
        meta: {
            title: "杨工子",
        },
        children: [
            {
                path: "/admin",
                component: () => import("@/layouts/admin/Admin.vue"),
                redirect: "/admin/home",
                meta: {
                    title: "后台",
                },
                children: [
                    {
                        path: "/admin/home",
                        component: () => import("@/views/admin/Home.vue"),
                        meta: {
                            title: "仪表盘",
                        },
                    },
                    {
                        path: "/admin/article/list",
                        component: () => import("@/views/admin/ArticleList.vue"),
                        meta: {
                            title: "文章管理",
                        },
                    },
                    {
                        path: "/admin/article/create",
                        component: () => import("@/views/admin/ArticleCreate.vue"),
                        meta: {
                            title: "新建文章",
                        },
                    },
                    {
                        path: "/admin/article/edit/:id",
                        component: () => import("@/views/admin/ArticleEdit.vue"),
                        meta: {
                            title: "编辑文章",
                        },
                    },
                    {
                        path: "/admin/category/list",
                        component: () => import("@/views/admin/CategoryList.vue"),
                        meta: {
                            title: "分类管理",
                        },
                    },
                    {
                        path: "/admin/tag/list",
                        component: () => import("@/views/admin/TagList.vue"),
                        meta: {
                            title: "标签管理",
                        },
                    },
                    {
                        path: "/admin/blog/settings",
                        component: () => import("@/views/admin/BlogSettings.vue"),
                        meta: {
                            title: "博客设置",
                        },
                    },
                    {
                        path: "/admin/wiki/list",
                        component: () => import("@/views/admin/WikiList.vue"),
                        meta: {
                            title: "知识库管理",
                        },
                    },
                    {
                        path: "/admin/friend/list",
                        component: () => import("@/views/admin/FriendList.vue"),
                        meta: {
                            title: "友链管理",
                        },
                    },
                    {
                        path: "/admin/comment/list",
                        component: () => import("@/views/admin/CommentList.vue"),
                        meta: {
                            title: "评论管理",
                        },
                    },
                ],
            },
            {
                path: "/surfer",
                component: () => import("@/layouts/surfer/Surfer.vue"),
                redirect: "/surfer/home",
                meta: {
                    title: "前台",
                },
                children: [
                    {
                      path: "/surfer/example",
                      component: () => import("@/views/surfer/ThemeExample.vue"),
                      meta: {
                        title: "文章详情",
                      },
                    },
                    {
                      path: "/surfer/home",
                      component: () => import("@/views/surfer/Home.vue"),
                      meta: {
                        title: "首页",
                      },
                    },
                    {
                      path: "/surfer/archive/list",
                      component: () => import("@/views/surfer/ArchiveList.vue"),
                      meta: {
                        title: "归档",
                      },
                    },
                    {
                      path: "/surfer/category/list",
                      component: () => import("@/views/surfer/CategoryList.vue"),
                      meta: {
                        title: "分类列表",
                      },
                    },
                    {
                      path: "/surfer/category/article/list",
                      component: () => import("@/views/surfer/CategoryArticleList.vue"),
                      meta: {
                        title: "分类文章",
                      },
                    },
                    {
                      path: "/surfer/tag/list",
                      component: () => import("@/views/surfer/TagList.vue"),
                      meta: {
                        title: "标签列表",
                      },
                    },
                    {
                      path: "/surfer/tag/article/list",
                      component: () => import("@/views/surfer/TagArticleList.vue"),
                      meta: {
                        title: "标签文章",
                      },
                    },
                    {
                      path: "/surfer/article/:articleId",
                      component: () => import("@/views/surfer/ArticleDetail.vue"),
                      meta: {
                        title: "文章详情",
                      },
                    },
                    {
                      path: "/surfer/wiki/list",
                      component: () => import("@/views/surfer/WikiList.vue"),
                      meta: {
                        title: "知识库",
                      },
                    },
                    {
                      path: "/surfer/wiki/:wikiId",
                      component: () => import("@/views/surfer/WikiDetail.vue"),
                      meta: {
                        title: "知识库详情",
                      },
                    },
                    {
                      path: "/surfer/resource",
                      component: () => import("@/views/surfer/Resource.vue"),
                      meta: {
                        title: "资源导航",
                      },
                    },
                    {
                      path: "/surfer/tools",
                      component: () => import("@/views/surfer/Tools.vue"),
                      meta: {
                        title: "在线工具",
                      },
                    },
                    {
                      path: "/surfer/author",
                      component: () => import("@/views/surfer/Author.vue"),
                      meta: {
                        title: "关于作者",
                      },
                    },
                    {
                      path: "/surfer/friend",
                      component: () => import("@/views/surfer/Friend.vue"),
                      meta: {
                        title: "友情链接",
                      },
                    },
                    {
                      path: "/surfer/moments",
                      component: () => import("@/views/surfer/Moments.vue"),
                      meta: {
                        title: "生活说说",
                      },
                    },
                    {
                      path: "/surfer/equipment",
                      component: () => import("@/views/surfer/Equipment.vue"),
                      meta: {
                        title: "我的设备",
                      },
                    },
                    {
                      path: "/surfer/gallery",
                      component: () => import("@/views/surfer/Gallery.vue"),
                      meta: {
                        title: "照片墙纸",
                      },
                    },
                ]
            }
        ],
    },
];

export default routeOptions;
