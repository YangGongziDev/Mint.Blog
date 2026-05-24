import axios from "@/api/axios.ts";

// 获取评论分页数据
export function getCommentPageList(data: any): Promise<any> {
    return axios.post("/admin/comment/list", data)
}

// 删除评论
export function deleteComment(id: any, deleteType: number): Promise<any> {
    return axios.post("/admin/comment/delete", {id, deleteType})
}

// 审核评论
export function examineComment(data: any): Promise<any> {
    return axios.post("/admin/comment/examine", data)
}

