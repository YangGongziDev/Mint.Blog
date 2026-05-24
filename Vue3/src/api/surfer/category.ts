import axios from "@/api/axios.ts";

// 获取分类列表
export function getCategoryList(data: any): Promise<any> {
    return axios.post("/surfer/category/list", data)
}

// 获取分类-文章列表
export function getCategoryArticlePageList(data: any): Promise<any> {
    return axios.post("/surfer/category/article/list", data)
}


