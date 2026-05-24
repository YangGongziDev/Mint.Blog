package cn.yangmufa.blog.surfer.service;

import cn.yangmufa.blog.common.utils.Response;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 博客设置
 **/
public interface BlogSettingsService {
    /**
     * 获取博客设置信息
     * @return
     */
    Response findDetail();
}
