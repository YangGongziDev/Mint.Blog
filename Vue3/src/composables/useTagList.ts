import { ref } from 'vue'
import { useMenuStore } from '@/stores/menu.ts'
import {useRoute, useRouter, onBeforeRouteUpdate} from 'vue-router'
import { setTabList, getTabList } from '@/composables/cookie.ts'

export function useTabList() {
    const menuStore = useMenuStore()
    const route = useRoute()
    const router = useRouter()

    // 当前被选中的 tab
    const activeTab = ref(route.path)
    // 导航栏 tab 数组
    const tabList = ref([
        {
            title: '仪表盘',
            path: "/admin/home"
        },
    ])

    // 添加 Tab 标签页
    function addTab(tab:any) {
        // 标签是否不存在
        let isTabNotExisted = tabList.value.findIndex(item => item.path == tab.path) == -1
        // 如果不存在
        if (isTabNotExisted) {
            // 添加标签
            tabList.value.push(tab)
        }
        // 存储 tabList 到 cookie 中
        setTabList(tabList.value)
    }

    function initTabList() {
        // 从 cookie 中获取缓存起来的标签导航栏数据
        let tabs = getTabList()
        // 若不为空，则赋值
        if (tabs) {
            tabList.value = tabs
        }
    }
    // 初始化标签导航栏
    initTabList()

    // 在路由切换前被调用
    onBeforeRouteUpdate((to, from) => {
        if (from){}
        // 设置被激活的 Tab 标签
        activeTab.value = to.path
        // 添加 Tab 标签页
        addTab({
            title: to.meta.title,
            path: to.path
        })
    })

    // 标签页切换事件
    const tabChange = (path:any) => {
        console.log('切回了path',path)
        // 设置被激活的 Tab 标签
        activeTab.value = path
        // 路由跳转
        router.push(path)
    }

    // 删除 Tab 标签
    const removeTab = (path:any) => {
        let tabs = tabList.value
        // 当前被选中的 tab 标签
        let actTab = activeTab.value

        // 如果要删除的是当前被选中的标签页，则需要判断其被删除后，需要激活哪个 tab 标签页
        if (actTab == path) {
            // 循环 tabList
            tabs.forEach((tab, index) => {
                // 获取被选中的 tab 元素
                if (tab.path == path) {
                    // 拿到被选中的标签页下标，如果它后面还有标签页，则取下一个标签页，否则取上一个
                    let nextTab = tabs[index + 1] || tabs[index - 1]
                    if (nextTab) {
                        actTab = nextTab.path
                    }
                }
            })
        }

        // 需要被激活的标签页
        activeTab.value = actTab

        // 过滤掉被删除的标签页, 重新设置回去
        tabList.value = tabList.value.filter((tab) => tab.path != path)

        // 存储到 cookie 中
        setTabList(tabList.value)
        
        // 切换标签页
        tabChange(activeTab.value)
    }

    // 处理关闭标签菜单事件
    const handleCloseTab = (command:any) => {
        // 首页路由
        let indexPath = '/admin/home'
        // 处理关闭其他
        if (command == 'closeOthers') {
            // 仅过滤出首页和当前页
            tabList.value = tabList.value.filter((tab) => tab.path == indexPath || tab.path == activeTab.value)
        } else if (command == 'closeAll') { // 处理关闭全部
            // 切换回首页
            activeTab.value = indexPath
            // 只保留首页
            tabList.value = tabList.value.filter((tab) => tab.path == indexPath)
            // 切换标签页
            tabChange(activeTab.value)
        }

        // 设置到 cookie 中
        setTabList(tabList.value)
    }

    return {
        menuStore,
        activeTab,
        tabList,
        tabChange,
        removeTab,
        handleCloseTab
    }
}