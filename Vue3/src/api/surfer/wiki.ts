import axios from "@/api/axios.ts";

// 获取知识库列表
export function getWikiList(): Promise<any> {
    return axios.post("/surfer/wiki/list")
}

// 获取知识库文章上一页
export function getWikiArticlePreNext(data: any): Promise<any> {
    return axios.post("/surfer/wiki/article/preNext", data)
}

// 获取知识库目录
export function getWikiCatalogs(id: any): Promise<any> {
    return axios.post("/surfer/wiki/catalog/list", {id})
}


