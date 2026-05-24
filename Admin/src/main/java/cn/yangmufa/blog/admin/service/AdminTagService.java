package cn.yangmufa.blog.admin.service;

import cn.yangmufa.blog.admin.model.vo.category.UpdateCategorySortReqVO;
import cn.yangmufa.blog.admin.model.vo.tag.*;
import cn.yangmufa.blog.common.utils.PageResponse;
import cn.yangmufa.blog.common.utils.Response;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: TODO
 **/
public interface AdminTagService {

    /**
     * 添加标签集合
     * @param addTagReqVO
     * @return
     */
    Response addTags(AddTagReqVO addTagReqVO);

    /**
     * 查询标签分页
     * @param findTagPageListReqVO
     * @return
     */
    PageResponse findTagPageList(FindTagPageListReqVO findTagPageListReqVO);

    /**
     * 删除标签
     * @param deleteTagReqVO
     * @return
     */
    Response deleteTag(DeleteTagReqVO deleteTagReqVO);

    /**
     * 修改标签
     * @param updateTagReqVO
     * @return
     */
    Response updateTag(UpdateTagReqVO updateTagReqVO);

    /**
     * 修改标签排序
     * @param updateTagSortReqVO
     * @return
     */
    Response updateTagSort(UpdateTagSortReqVO updateTagSortReqVO);

    /**
     * 设置标签类排序 设置最前
     * @return
     */
    Response updateTagSortFirst(UpdateTagSortReqVO updateTagSortReqVO);

    /**
     * 设置文标签类排序 设置最后
     * @return
     */
    Response updateTagSortLast(UpdateTagSortReqVO updateTagSortReqVO);

    /**
     * 根据标签关键词模糊查询
     * @param searchTagsReqVO
     * @return
     */
    Response searchTags(SearchTagsReqVO searchTagsReqVO);

    /**
     * 查询标签 Select 列表数据
     * @return
     */
    Response findTagSelectList();
}
