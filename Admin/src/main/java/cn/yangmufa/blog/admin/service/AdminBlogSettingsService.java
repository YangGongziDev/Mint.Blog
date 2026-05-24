package cn.yangmufa.blog.admin.service;

import cn.yangmufa.blog.admin.model.vo.blogsettings.UpdateBlogSettingsReqVO;
import cn.yangmufa.blog.common.utils.Response;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: TODO
 **/
public interface AdminBlogSettingsService {
    /**
     * 更新博客设置信息
     * @param updateBlogSettingsReqVO
     * @return
     */
    Response updateBlogSettings(UpdateBlogSettingsReqVO updateBlogSettingsReqVO);

    /**
     * 获取博客设置详情
     * @return
     */
    Response findDetail();
}
