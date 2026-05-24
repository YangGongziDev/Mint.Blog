import axios from "@/api/axios.ts";

// 上传图片
export function uploadImage(newImageFile: File, newImageOriginalName: string, oldImageName: string): Promise<any> {
    const formData = new FormData()
    formData.append('newImageFile', newImageFile)
    formData.append('newImageOriginalName', newImageOriginalName)
    formData.append('oldImageName', oldImageName)
    return axios.post("/admin/image/upload", formData)
}

// 单个删除图片
export function deleteImage(oldImageName: string): Promise<any> {
    if(!oldImageName) {
        return Promise.resolve()
    }
    // 后端使用 @RequestBody String oldImageName，直接发送字符串
    return axios.post("/admin/image/delete", oldImageName, {
        headers: { 'Content-Type': 'text/plain' }
    })
}

// 批量删除图片
export function deleteImages(oldImageNames: Array<string>): Promise<any> {
    if (!oldImageNames || oldImageNames.length === 0) {
        return Promise.resolve()
    }
    // 后端使用 @RequestBody List<String>，直接发送 JSON 数组
    return axios.post("/admin/image/deletes", oldImageNames)
}

