package cn.yangmufa.blog.surfer.service;

import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.model.vo.tag.FindTagArticlePageListReqVO;
import cn.yangmufa.blog.surfer.model.vo.tag.FindTagListReqVO;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 分类
 **/
public interface TagService {
    /**
     * 获取标签列表
     * @return
     */
    Response findTagList(FindTagListReqVO findTagListReqVO);

    /**
     * 获取标签下文章分页列表
     * @param findTagArticlePageListReqVO
     * @return
     */
    Response findTagPageList(FindTagArticlePageListReqVO findTagArticlePageListReqVO);
}
