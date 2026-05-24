import axios from "@/api/axios.ts";

// 获取标签列表
export function getTagList(data: any): Promise<any> {
    return axios.post("/surfer/tag/list", data)
}

// 获取标签下文章列表
export function getTagArticlePageList(data: any): Promise<any> {
    return axios.post("/surfer/tag/article/list", data)
}


