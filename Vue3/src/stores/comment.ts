import { defineStore } from 'pinia'
import { ref } from 'vue'

// 用户信息接口
interface UserInfo {
  avatar: string
  nickname: string
  mail: string
  website: string
}

export const useCommentStore = defineStore('comment', () => {
  // 评论用户信息
  const userInfo = ref<UserInfo>({
    avatar: '',
    nickname: '',
    mail: '',
    website: ''
  })

  return { userInfo }
},
{
  // 开启持久化
  persist: true,
}
)