import axios from "@/api/axios.ts";

// 获取分类分页数据
export function getCategoryPageList(data: any): Promise<any> {
    return axios.post("/admin/category/list", data)
}

// 添加分类
export function addCategory(data: any): Promise<any> {
    return axios.post("/admin/category/add", data)
}

// 删除分类
export function deleteCategory(id: any, deleteType: number): Promise<any> {
    return axios.post("/admin/category/delete", {id, deleteType})
}

// 更新分类
export function updateCategory(data: any): Promise<any> {
    return axios.post("/admin/category/update", data)
}
// 搜索分类
export function searchCategories(key: string): Promise<any> {
    return axios.post("/admin/category/search", {key})
}

// 更新分类排序
export function updateCategorySort(id: number, sort: number): Promise<any> {
    return axios.post("/admin/category/update/sort", {id, sort})
}
// 更新分类排序到最前
export function updateCategorySortFirst(id: number, sort: number): Promise<any> {
    return axios.post("/admin/category/update/sort/first", {id, sort})
}
// 更新分类排序到最后
export function updateCategorySortLast(id: number, sort: number): Promise<any> {
    return axios.post("/admin/category/update/sort/last", {id, sort})
}

// 获取分类 select 数据
export function getCategorySelectList(): Promise<any> {
    return axios.post("/admin/category/select/list")
}

