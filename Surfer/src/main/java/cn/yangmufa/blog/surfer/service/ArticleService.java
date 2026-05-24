package cn.yangmufa.blog.surfer.service;

import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.model.vo.article.FindArticleDetailReqVO;
import cn.yangmufa.blog.surfer.model.vo.article.FindIndexArticlePageListReqVO;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 文章
 **/
public interface ArticleService {
    /**
     * 获取首页文章分页数据
     * @param findIndexArticlePageListReqVO
     * @return
     */
    Response findArticlePageList(FindIndexArticlePageListReqVO findIndexArticlePageListReqVO);

    /**
     * 获取文章详情
     * @param findArticleDetailReqVO
     * @return
     */
    Response findArticleDetail(FindArticleDetailReqVO findArticleDetailReqVO);

}
