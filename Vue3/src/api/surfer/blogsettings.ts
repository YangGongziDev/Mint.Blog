import axios from "@/api/axios.ts";

// 获取博客设置详情
// export function getSurferBlogSettingsDetail(): Promise<any> {
export function getBlogSettingsDetail(): Promise<any> {
    return axios.post("/surfer/blog/settings/detail")
}


