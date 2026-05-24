import axios from "@/api/axios.ts";

// 获取标签分页数据
export function getTagPageList(data: any): Promise<any> {
    return axios.post("/admin/tag/list", data)
}

// 添加标签
export function addTag(data: any): Promise<any> {
    return axios.post("/admin/tag/add", data)
}

// 删除标签
export function deleteTag(id: any, deleteType?: number): Promise<any> {
    return axios.post("/admin/tag/delete", {id, deleteType})
}

// 更新标签
export function updateTag(data: String): Promise<any> {
    return axios.post("/admin/tag/update", data)
}

// 更新标签排序
export function updateTagSort(data: {id: number, sort: number}): Promise<any> {
    return axios.post("/admin/tag/update/sort", data)
}
// 更新标签排序到最前
export function updateTagSortFirst(id: number, sort: number): Promise<any> {
    return axios.post("/admin/tag/update/sort/first", {id, sort})
}
// 更新标签排序到最后
export function updateTagSortLast(id: number, sort: number): Promise<any> {
    return axios.post("/admin/tag/update/sort/last", {id, sort})
}

// 根据标签名模糊查询
export function searchTags(key: any): Promise<any> {
    return axios.post("/admin/tag/search", {key})
}

// 获取标签 select 列表数据
export function getTagSelectList(): Promise<any> {
    return axios.post("/admin/tag/select/list")
}
