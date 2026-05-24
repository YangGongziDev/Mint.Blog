import axios from "@/api/axios.ts";

// 获取友链数据
export function getFriendPageList(data: any): Promise<any> {
    return axios.post("/admin/friend/list", data)
}

// 新增友链
export function addFriend(data: any): Promise<any> {
    return axios.post("/admin/friend/add", data)
}

// 更新友链置顶状态
export function updateFriendIsTop(data: any): Promise<any> {
    return axios.post("/admin/friend/isTop/update", data)
}

// 更新友链审核状态
export function updateFriendStatus(data: { id: number; status: string }): Promise<any> {
    return axios.post("/admin/friend/status/update", data)
}

// 删除友链
export function deleteFriend(id: any, deleteType: number): Promise<any> {
    return axios.post("/admin/friend/delete", {id, deleteType})
}

// 更新友链
export function updateFriend(data: any): Promise<any> {
    return axios.post("/admin/friend/update", data)
}

// 更新友链排序
export function updateFriendSort(id: number, sort: number): Promise<any> {
    return axios.post("/admin/friend/update/sort", {id, sort})
}
// 更新友链排序到最前
export function updateFriendSortFirst(id: number, sort: number): Promise<any> {
    return axios.post("/admin/friend/update/sort/first", {id, sort})
}
// 更新友链排序到最后
export function updateFriendSortLast(id: number, sort: number): Promise<any> {
    return axios.post("/admin/friend/update/sort/last", {id, sort})
}

// 获取友链目录
export function getFriendCatalogs(id: any): Promise<any> {
    return axios.post("/admin/friend/catalog/list", {id})
}

// 更新友链目录
export function updateFriendCatalogs(data: any): Promise<any> {
    return axios.post("/admin/friend/catalog/update", data)
}