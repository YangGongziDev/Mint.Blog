import { createWebHistory, createRouter } from 'vue-router'
import routeOptions from "@/router/routeOptions.ts";


const router = createRouter({
    history: createWebHistory(),
    routes: routeOptions,
    // 每次切换路后，页面滚动到顶部
    scrollBehavior() {
        return { top: 0 }
    }
});

export default router;