import axios from "@/api/axios.ts";

// 友链接口定义 - 根据后端返回数据结构
export interface Friend {
  id: number
  name: string
  description?: string
  url: string
  avatar?: string
  status: 'active' | 'inactive' | 'pending'
  createTime: string
  category: string
  isTop: boolean
  email?: string
  sort: number
  isDeleted: boolean
  updateTime: string
}

// 友链申请表单接口
export interface FriendApplicationForm {
  name: string
  avatar?: string
  category: string
  url: string
  description: string
  email: string
}

// API响应接口
export interface FriendListResponse {
  success: boolean
  data: Friend[]
  message?: string
}

// 友链申请响应接口
export interface FriendApplicationResponse {
  success: boolean
  message: string
}

// 提交友链申请
export function submitFriendApplication (data: FriendApplicationForm) {
  return axios.post<FriendApplicationResponse>('/surfer/friend/apply', data)
}

// 获取友链分页列表
export function getFriendPageList(data: any): Promise<any> {
    return axios.post("/surfer/friend/list", data)
}

// 获取友链详情
export function getFriendDetail(friendId: any): Promise<any> {
    return axios.post("/surfer/friend/detail", {friendId})
}