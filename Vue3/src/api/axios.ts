import axios from "axios";
import { getToken } from "@/composables/cookie.ts";
import { showMessage } from "@/composables/util.ts";
import { useUserStore } from "@/stores/user.ts";

// 创建 Axios 实例
const instance = axios.create({
// API 基础 URL - 统一使用相对路径，通过Nginx代理
  baseURL: "/api",
  timeout: 30000, // 请求超时时间（30秒，适应图片上传等耗时操作）
});

// 添加请求拦截器
instance.interceptors.request.use(
  function (config) {
    // 在发送请求之前做些什么
    const token = getToken();
    console.log("统一添加请求头中的 Token:" + token);

    // 当 token 不为空时
    if (token) {
      // 添加请求头, key 为 Authorization，value 值的前缀为 'Bearer '
      config.headers["Authorization"] = "Bearer " + token;
    }

    // 动态设置 Content-Type
    if (config.data instanceof FormData) {
      // 如果是 FormData（文件上传），不设置 Content-Type，让浏览器自动设置
      // 浏览器会自动设置为 multipart/form-data 并包含正确的 boundary
      delete config.headers["Content-Type"];
    } else if (!config.headers["Content-Type"]) {
      // 如果不是 FormData 且没有手动设置 Content-Type，则设置为 application/json
      config.headers["Content-Type"] = "application/json";
    }

    return config;
  },
  function (error) {
    // 对请求错误做些什么
    return Promise.reject(error);
  }
);

// 添加响应拦截器
instance.interceptors.response.use(
  function (response) {
    // 2xx 范围内的状态码都会触发该函数。
    // 对响应数据做点什么
    return response.data;
  },
  function (error) {
    // 超出 2xx 范围的状态码都会触发该函数。
    // 对响应错误做点什么
    console.error('请求错误:', error);
    
    // 检查是否有响应对象
    if (error.response) {
      // 服务器返回了错误状态码
      let status = error.response.status;

      // 状态码 401
      if (status == 401) {
        // 退出登录
        let userStore = useUserStore();
        userStore.logout();
        // 跳转到登录页面而不是刷新页面，避免无限循环
        window.location.href = '/login';
        return Promise.reject(error);
      }

      // 若后台有错误提示就用提示文字，默认提示为 '请求失败'
      let errorMsg = error.response.data?.message || '请求失败';
      // 弹错误提示
      showMessage(errorMsg, 'error');
    } else if (error.request) {
      // 请求已发出但没有收到响应（网络错误、服务器未启动等）
      console.error('网络请求失败:', error.request);
      showMessage('网络连接失败，请检查网络或后端服务是否启动', 'error');
    } else {
      // 其他错误
      console.error('请求配置错误:', error.message);
      showMessage('请求配置错误: ' + error.message, 'error');
    }

    return Promise.reject(error);
  }
);

// 暴露出去
export default instance;
