package cn.yangmufa.blog.surfer.service.impl;

import cn.yangmufa.blog.common.domain.dos.BlogSettingsDO;
import cn.yangmufa.blog.common.domain.mapper.BlogSettingsMapper;
import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.convert.BlogSettingsConvert;
import cn.yangmufa.blog.surfer.model.vo.blogsettings.FindBlogSettingsDetailRspVO;
import cn.yangmufa.blog.surfer.service.BlogSettingsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 博客设置
 **/
@Service
@Slf4j
public class BlogSettingsServiceImpl implements BlogSettingsService {

    @Autowired
    private BlogSettingsMapper blogSettingsMapper;

    /**
     * 获取博客设置信息
     *
     * @return
     */
    @Override
    public Response findDetail() {
        // 查询博客设置信息（约定的 ID 为 1）
        BlogSettingsDO blogSettingsDO = blogSettingsMapper.selectById(1L);
        // DO 转 VO
        FindBlogSettingsDetailRspVO vo = BlogSettingsConvert.INSTANCE.convertDO2VO(blogSettingsDO);

        return Response.success(vo);
    }
}
