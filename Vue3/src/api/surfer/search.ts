import axios from "@/api/axios.ts";

// 文章搜索
export function getArticleSearchPageList(data: any): Promise<any> {
    return axios.post("/surfer/article/search", data)
}


