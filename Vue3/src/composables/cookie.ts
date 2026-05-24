import { useCookies } from '@vueuse/integrations/useCookies'

const cookie = useCookies()

// ============================== Token 令牌 ==============================

// 存储在 Cookie 中的 Token 的 key
const TOKEN_KEY = 'Authorization'

// 获取 Token 值
export function getToken() {
    return cookie.get(TOKEN_KEY)
}

// 设置 Token 到 Cookie 中
export function setToken(token:any) {
    return cookie.set(TOKEN_KEY, token)
}

// 删除 Token
export function removeToken() {
    console.log('删除 Token');
    // 尝试多种方式删除Cookie
    cookie.remove(TOKEN_KEY);
    cookie.remove(TOKEN_KEY, { path: '/' });
    cookie.remove(TOKEN_KEY, { path: '/', domain: window.location.hostname });
    // 手动设置过期时间删除
    document.cookie = `${TOKEN_KEY}=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;`;
    console.log('Token删除完成');
}

// ============================== 标签页 ==============================

// 存储在 Cookie 中的标签页数据的 key
const TAB_LIST_KEY = 'tabList'

// 获取 TabList
export function getTabList() {
    return cookie.get(TAB_LIST_KEY)
}

// 存储 TabList 到 Cookie 中
export function setTabList(tabList:any) {
    return cookie.set(TAB_LIST_KEY, tabList)
}