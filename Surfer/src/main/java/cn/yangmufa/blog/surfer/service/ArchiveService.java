package cn.yangmufa.blog.surfer.service;

import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.model.vo.archive.FindArchiveArticlePageListReqVO;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 归档文章
 **/
public interface ArchiveService {
    /**
     * 获取文章归档分页数据
     * @param findArchiveArticlePageListReqVO
     * @return
     */
    Response findArchivePageList(FindArchiveArticlePageListReqVO findArchiveArticlePageListReqVO);

    /**
     * 获取文章归档某年的数据
     * @param year
     * @return
     */
    Response findArchiveYearList(String year);

    /**
     * 获取文章所有的年份
     * @return
     */
    Response findArchiveYears();
}
