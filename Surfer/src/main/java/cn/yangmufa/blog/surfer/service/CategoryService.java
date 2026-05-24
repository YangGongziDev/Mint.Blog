package cn.yangmufa.blog.surfer.service;

import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.model.vo.category.FindCategoryArticlePageListReqVO;
import cn.yangmufa.blog.surfer.model.vo.category.FindCategoryListReqVO;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 分类
 **/
public interface CategoryService {
    /**
     * 获取分类列表
     * @return
     */
    Response findCategoryList(FindCategoryListReqVO findCategoryListReqVO);

    /**
     * 获取分类下文章分页数据
     * @param findCategoryArticlePageListReqVO
     * @return
     */
    Response findCategoryArticlePageList(FindCategoryArticlePageListReqVO findCategoryArticlePageListReqVO);
}
