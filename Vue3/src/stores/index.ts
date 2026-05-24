// 引入全局状态管理 Pinia
import { createPinia } from 'pinia'
// 默认导入 ，导入的是插件的默认配置版本
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'

// // - 命名导入 ，导入的是工厂函数 ,允许在安装插件时传入全局配置选项,可以自定义默认的存储方式、序列化器、调试模式等
// import { createPersistedState } from 'pinia-plugin-persistedstate'
// // 需要全局自定义配置
// pinia.use(createPersistedState({
//   storage: sessionStorage,  // 使用sessionStorage而不是localStorage
//   key: id => `__persisted__${id}`,  // 为所有store键添加前缀
//   debug: true  // 开启调试模式
// }))

const pinia = createPinia()
// 持久化插件
pinia.use(piniaPluginPersistedstate)

// 暴露出去
export default pinia