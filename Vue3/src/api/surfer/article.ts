import axios from "@/api/axios.ts";

// 获取文章列表
export function getArticlePageList(data: any): Promise<any> {
    return axios.post("/surfer/article/list", data)
}

// 获取文章详情
export function getArticleDetail(articleId: any): Promise<any> {
    return axios.post("/surfer/article/detail", {articleId})
}



