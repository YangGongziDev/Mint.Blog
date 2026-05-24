package cn.yangmufa.blog.admin.service;

import cn.yangmufa.blog.admin.model.vo.tag.UpdateTagSortReqVO;
import cn.yangmufa.blog.admin.model.vo.wiki.*;
import cn.yangmufa.blog.common.utils.Response;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 知识库
 **/
public interface AdminWikiService {

    /**
     * 新增知识库
     * @param addWikiReqVO
     * @return
     */
    Response addWiki(AddWikiReqVO addWikiReqVO);

    /**
     * 删除知识库
     * @param deleteWikiReqVO
     * @return
     */
    Response deleteWiki(DeleteWikiReqVO deleteWikiReqVO);

    /**
     * 知识库分页查询
     * @param findWikiPageListReqVO
     * @return
     */
    Response findWikiPageList(FindWikiPageListReqVO findWikiPageListReqVO);

    /**
     * 更新知识库置顶状态
     * @param updateWikiIsTopReqVO
     * @return
     */
    Response updateWikiIsTop(UpdateWikiIsTopReqVO updateWikiIsTopReqVO);

    /**
     * 设置标签类排序 设置最前
     * @return
     */
    Response updateWikiSortFirst(UpdateWikiSortReqVO updateWikiSortReqVO);

    /**
     * 设置知识库排序 设置最后
     * @return
     */
    Response updateWikiSortLast(UpdateWikiSortReqVO updateWikiSortReqVO);

    /**
     * 更新知识库发布状态
     * @param updateWikiIsPublishReqVO
     * @return
     */
    Response updateWikiIsPublish(UpdateWikiIsPublishReqVO updateWikiIsPublishReqVO);

    /**
     * 更新知识库
     * @param updateWikiReqVO
     * @return
     */
    Response updateWiki(UpdateWikiReqVO updateWikiReqVO);

    /**
     * 新增知识库目录
     * @param updateWikiSortReqVO
     * @return
     */
    Response updateWikiSort(UpdateWikiSortReqVO updateWikiSortReqVO);

    /**
     * 查询知识库目录
     * @param findWikiCatalogListReqVO
     * @return
     */
    Response findWikiCatalogList(FindWikiCatalogListReqVO findWikiCatalogListReqVO);

    /**
     * 更新知识库目录
     * @param updateWikiCatalogReqVO
     * @return
     */
    Response updateWikiCatalogs(UpdateWikiCatalogReqVO updateWikiCatalogReqVO);
}
