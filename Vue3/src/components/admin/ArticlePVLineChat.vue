<template>
    <!-- PV 折线图容器 -->
    <div id="lineChat" class="chart-container"></div>
</template>

<script setup lang="ts">
import * as echarts from 'echarts'
import { watch, onMounted, onUnmounted, ref } from 'vue'
import type { ECharts } from 'echarts'

// 定义数据类型接口
interface ChartData {
    pvDates: string[]
    pvCounts: number[]
}

// 对外暴露的属性值
const props = defineProps<{
    value: ChartData | null
}>()

// 图表实例引用
const chartInstance = ref<ECharts | null>(null)

// 初始化折线图
function initLineChat(): void {
    const chartDom = document.getElementById('lineChat')
    if (!chartDom || !props.value) return
    
    // 如果已有实例，先销毁
    if (chartInstance.value) {
        chartInstance.value.dispose()
    }
    
    chartInstance.value = echarts.init(chartDom, null, { width: 600 })
    
    // 从 props.value 中获取日期集合和 pv 访问量集合
    const { pvDates, pvCounts } = props.value
    
    const option = {
        tooltip: {
            trigger: 'axis'
        },
        xAxis: {
            type: 'category',
            data: pvDates,
            axisLabel: {
                rotate: 45
            }
        },
        yAxis: {
            type: 'value',
            name: 'PV访问量'
        },
        series: [
            {
                name: 'PV',
                data: pvCounts,
                type: 'line',
                smooth: true,
                symbol: 'circle',
                symbolSize: 6,
                lineStyle: {
                    width: 2
                },
                itemStyle: {
                    color: '#1890ff'
                }
            }
        ]
    }
    
    chartInstance.value.setOption(option)
}

// 组件挂载时初始化
onMounted(() => {
    if (props.value) {
        initLineChat()
    }
})

// 组件卸载时销毁图表实例
onUnmounted(() => {
    if (chartInstance.value) {
        chartInstance.value.dispose()
        chartInstance.value = null
    }
})

// 侦听属性, 监听 props.value 的变化，一旦 props.value 发生变化，就调用 initLineChat 初始化折线图
watch(() => props.value, () => {
    if (props.value) {
        initLineChat()
    }
}, { deep: true })
</script>

<style lang="scss" scoped>
.chart-container {
    overflow-x: auto;
    width: 100%;
    height: 240px; // 原 15rem，统一改为 px
    min-height: 240px;
    
    // 响应式设计
    @media (max-width: 768px) {
        height: 192px; // 原 12rem，统一改为 px
    }
    
    // 图表加载状态
    &:empty {
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f5f5f5;
        
        &::before {
            content: '图表加载中...';
            color: #999;
            font-size: 14px;
        }
    }
}
</style>