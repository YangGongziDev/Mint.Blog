import axios from "@/api/axios.ts";

// 获取文章归档分页数据
export function getArchivePageList(data: any): Promise<any> {
    return axios.post("/surfer/archive/list", data)
}

// 获取文章归档所有年份
export function getArchiveYears(): Promise<any> {
    return axios.post("/surfer/archive/years")
}

// 获取文章归档某年数据
export function getArchiveYearList(year: string): Promise<any> {
    if(!year) {
        return Promise.resolve()
    }
    // 后端使用 @RequestBody String year，直接发送字符串
    return axios.post("/surfer/archive/year", year, {
        headers: { 'Content-Type': 'text/plain' }
    })
}


