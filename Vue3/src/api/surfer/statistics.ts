import axios from "@/api/axios.ts";

// 获取统计信息（文章总数、分类总数、标签总数、总访问量）
export function getStatisticsInfo(): Promise<any> {
    return axios.post("/surfer/statistics/info")
}



