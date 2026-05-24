import axios from "@/api/axios.ts";

// 获取 QQ 用户信息
export function getUserInfoByQQ(qq: any): Promise<any> {
    return axios.post("/surfer/comment/qq/userInfo", {qq})
}

// 发布评论
export function publishComment(data: any): Promise<any> {
    return axios.post("/surfer/comment/publish", data)
}

// 获取所有评论
export function getComments(routerUrl: any): Promise<any> {
    return axios.post("/surfer/comment/list", {routerUrl})
}



