package cn.yangmufa.blog.surfer.utils;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 字符串工具类
 **/
public class StringUtil {

    /**
     * 判断字符串是否是纯数字
     * @param str
     * @return
     */
    public static boolean isPureNumber(String str) {
        return str.matches("\\d+");
    }

}
