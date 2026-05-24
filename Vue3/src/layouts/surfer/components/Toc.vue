<template>
    <!-- text-sm/[30px] 表示文字小号，行高为 30px -->
    <div v-if="titles && titles.length > 0" 
        :class="[currScrollY > 0 ? 'top-0' : 'top-[88px]']" 
        class="theme-bg-secondary theme-text-primary sticky top-[192px] text-sm/[30px] w-full p-5 mb-3 bg-white border border-gray-200 rounded-lg">
        <!-- 目录标题 -->
        <h2 class="theme-bg-secondary theme-text-primary flex items-center mb-2 font-bold">
            <!-- 目录图标 -->
            <UnorderedListOutlined class="w-3.5 h-3.5 me-2"/>
            文章目录
        </h2>
        <div class="toc-wrapper cursor-pointer ">
			<ul class="toc">
                <!-- 二级标题 -->
                <li v-for="(h2, index) in titles" :key="index">
                    <span @click="scrollToView(h2.offsetTop)" class="ps-5 hover:text-sky-600 " :class="[h2.index == activeHeadingIndex ? 'active py-1 text-sky-600 border-s-2 border-sky-600 font-bold' : 'text-gray-500 font-normal']">{{ h2.text }}</span>
                    <!-- 三级标题 -->
                    <ul v-if="h2.children && h2.children.length > 0">
                        <li v-for="(h3, index2) in h2.children" :key="index2">
                            <span @click="scrollToView(h3.offsetTop)" class="ps-10 hover:text-sky-600 " :class="[h3.index == activeHeadingIndex ? 'active py-1 text-sky-600 border-s-2 border-sky-600 font-bold' : 'text-gray-500 font-normal']">{{ h3.text }}</span>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { UnorderedListOutlined } from '@ant-design/icons-vue'

// 定义标题接口
interface TitleItem {
    index: number
    level: number
    text: string
    offsetTop: number
    children?: TitleItem[]
}

// 响应式的目录数据
const titles = ref<TitleItem[]>([])

// 滚动容器（布局内滚动容器）
const scrollContainer = ref<HTMLElement | null>(null)
let scrollBound = false

function getScroller(): HTMLElement | null {
    if (scrollContainer.value && scrollContainer.value.isConnected) return scrollContainer.value
    const el = document.querySelector('.surfer-layout-main') as HTMLElement | null
    if (el) scrollContainer.value = el
    return el
}

onMounted(() => {
    // 通过 .artilce-content 样式来获取父级 div
    const container = document.querySelector('.article-content')

    // 如果容器不存在，直接返回
    if (!container) {
        return
    }

    // 使用 MutationObserver 监视 DOM 的变化
    const observer = new MutationObserver(mutationsList => {
        for (let mutation of mutationsList) {
            if (mutation.type === 'childList') {
                // 先清空目录缓存数据
                titles.value = []
                // 计算目录数据
                initTocData(container)

                // 监听所有图片的加载事件
                const images = container.querySelectorAll('img');
                images.forEach(img => {
                    img.addEventListener('load', () => {
                        // 图片加载完成后重新计算标题的 offsetTop
                        initTocData(container)
                    })
                })

                // 添加滚动事件监听到正确的滚动容器
                const scroller = getScroller()
                if (scroller && !scrollBound) {
                    scroller.addEventListener('scroll', handleContentScroll)
                    scrollBound = true
                }
            }
        }
    })

    // 配置监视子节点的变化
    const config = { childList: true, subtree: true }
    // 开始观察正文 div 的内容变化
    observer.observe(container, config)
})

// 记录当前被选中的标题下标
const activeHeadingIndex = ref<number>(-1)
// 新增：当前 Y 轴滚动的偏移量（用于模板中的吸顶位置切换）
const currScrollY = ref<number>(0)
// 处理滚动事件
function handleContentScroll(): void {
    const scroller = getScroller()
    // 当前的滚动位置
    let scrollY = scroller ? scroller.scrollTop : window.scrollY
    // 维护 currScrollY，供模板使用
    currScrollY.value = scrollY
    // 循环目录
    titles.value.forEach(title => {
        // 获取每个标题的 offset
        let offsetTop = title.offsetTop
        // 如果当前位置大于等于标题位置，则标记选中，记录被选中标题的下标
        if (scrollY >= offsetTop) {
            activeHeadingIndex.value = title.index
        }

        // 处理3级标题, 同样的逻辑
        let children = title.children
        if (children && children.length > 0) {
            children.forEach(child => {
                let childOffsetTop = child.offsetTop
                if (scrollY >= childOffsetTop) {
                    activeHeadingIndex.value = child.index
                }
            })
        }
    })
}

// 移除滚动监听
onBeforeUnmount(() => {
    const scroller = getScroller()
    if (scroller && scrollBound) {
        scroller.removeEventListener('scroll', handleContentScroll)
        scrollBound = false
    }
})

// 滚动到指定的位置
function scrollToView(offsetTop: number): void {
    try {
        // 确保 offsetTop 是有效的数字
        if (typeof offsetTop !== 'number' || isNaN(offsetTop)) {
            console.warn('Invalid offsetTop value:', offsetTop);
            return;
        }

        // 使用 requestAnimationFrame 确保在下一帧执行滚动
        requestAnimationFrame(() => {
            const scroller = getScroller()
            if (scroller) {
                scroller.scrollTo({
                    top: Math.max(0, offsetTop),
                    behavior: 'smooth'
                })
            } else {
                window.scrollTo({ 
                    top: Math.max(0, offsetTop),
                    behavior: 'smooth'
                })
            }
        });
    } catch (error) {
        console.error('Error in scrollToView:', error);
        // 降级处理：使用简单的滚动
        const scroller = getScroller()
        if (scroller) {
            scroller.scrollTop = Math.max(0, offsetTop)
        } else {
            window.scrollTo(0, Math.max(0, offsetTop));
        }
    }
}

// 计算标题相对于滚动容器的偏移
function calcOffsetTopRelativeToScroller(htmlHeading: HTMLElement, headerOffset = 95): number {
    const scroller = getScroller()
    if (scroller) {
        const scrollerRect = scroller.getBoundingClientRect()
        const headingRect = htmlHeading.getBoundingClientRect()
        return headingRect.top - scrollerRect.top + scroller.scrollTop - headerOffset
    }
    // 退化为原来的 offsetTop 逻辑
    return htmlHeading.offsetTop - headerOffset
}

// 初始化标题数据
function initTocData(container: Element): void {
    // 只提取二级、三级标题
    let levels = ['h2', 'h3']
    let headings = container.querySelectorAll(levels.join(', '))

    // 存放组装后的目录标题数据
    let titlesArr: TitleItem[] = []

    // 下标
    let index: number = 1
    headings.forEach(heading => {
        const htmlHeading = heading as HTMLElement
        // 标题等级， h2 -> 级别 2 ； h3 -> 级别3
        let headingLevel = parseInt(htmlHeading.tagName.substring(1))
        // 标题文字
        let headingText = htmlHeading.innerText
        // 标题的位置（相对于滚动容器的距离）
        let offsetTop = calcOffsetTopRelativeToScroller(htmlHeading, 95)

        if (headingLevel === 2) { // 二级标题
            titlesArr.push({
                index,
                level: headingLevel,
                text: headingText,
                offsetTop,
                children: [] // 二级标题下的子标题
            })
        } else { // 三级标题
            // 父级标题
            let parentHeading = titlesArr[titlesArr.length - 1]
            // 确保父级标题存在且children属性已初始化
            if (parentHeading && parentHeading.children) {
                // 设置父级标题的 children
                parentHeading.children.push({
                    index,
                    level: headingLevel,
                    text: headingText,
                    offsetTop
                })
            }
        }
        // 下标 +1
        index++
    })

    // 设置数据
    titles.value = titlesArr
}
</script>

<style scoped lang="scss">
:deep(.toc-wrapper) {
    position: relative;
    overflow-x: hidden;
    overflow-y: auto;
    max-height: 75vh;
    text-overflow: ellipsis;
    white-space: nowrap;
    scroll-behavior: smooth;
}

:deep(.toc:before) {
    content: " ";
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    z-index: -1;
    width: 2px;
    background: #eaecef;
}

:deep(.dark) {
    .toc:before {
        content: " ";
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        z-index: -1;
        width: 2px;
        background: #30363d;
    }

    .toc li {
        span {
            color: #9e9e9e;

            &.active {
                color: rgb(2 132 199 / 1);
            }

            &:hover {
                color: rgb(2 132 199 / 1);
            }
        }
    }
}
</style>
