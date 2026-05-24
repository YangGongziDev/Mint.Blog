import { defineStore } from "pinia";
import { ref } from "vue";
import { getUserInfo } from "@/api/admin/user.ts";
import { removeToken } from "@/composables/cookie.ts";

// 用户信息接口
interface UserInfo {
  username?: string;
  email?: string;
  avatar?: string;
  id?: number;
  [key: string]: any;
}

export const useUserStore = defineStore(
  "user",
  () => {
    // 用户信息
    const userInfo = ref<UserInfo>({});

    // 设置用户信息
    function setUserInfo() {
      // 调用后台获取用户信息接口
      getUserInfo().then((res) => {
        let result: any = res;
        if (result.success == true) {
          userInfo.value = res.data;
        }
      });
    }

    // 退出登录
    function logout() {
      // 删除 cookie 中的 token 令牌
      removeToken();
      // 删除登录用户信息
      userInfo.value = {};
    }

    return { userInfo, setUserInfo, logout };
  },
  {
    // 开启持久化
    persist: true,
  }
  // {
  //     persist: {
  //         key: 'user_storage',
  //         storage: localStorage,
  //         // 指定需要持久化的状态
  //         pick: ['token', 'user', 'role', 'permission']
  //     }
  // }
);
