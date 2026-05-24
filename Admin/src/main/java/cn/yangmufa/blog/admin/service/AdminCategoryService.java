package cn.yangmufa.blog.admin.service;

import cn.yangmufa.blog.admin.model.vo.category.*;
import cn.yangmufa.blog.admin.model.vo.tag.SearchTagsReqVO;
import cn.yangmufa.blog.common.utils.PageResponse;
import cn.yangmufa.blog.common.utils.Response;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: TODO
 **/
public interface AdminCategoryService {
    /**
     * 添加分类
     * @param addCategoryReqVO
     * @return
     */
    Response addCategory(AddCategoryReqVO addCategoryReqVO);

    /**
     * 分类分页数据查询
     * @param findCategoryPageListReqVO
     * @return
     */
    PageResponse findCategoryPageList(FindCategoryPageListReqVO findCategoryPageListReqVO);

    /**
     * 删除分类
     * @param deleteCategoryReqVO
     * @return
     */
    Response deleteCategory(DeleteCategoryReqVO deleteCategoryReqVO);

    /**
     * 根据分类关键词模糊查询
     * @param searchCategorysReqVO
     * @return
     */
    Response searchCategorys(SearchCategorysReqVO searchCategorysReqVO);

    /**
     * 修改分类
     * @param updateCategoryReqVO
     * @return
     */
    Response updateCategory(UpdateCategoryReqVO updateCategoryReqVO);

    /**
     * 修改分类排序
     * @param updateCategorySortReqVO
     * @return
     */
    Response updateCategorySort(UpdateCategorySortReqVO updateCategorySortReqVO);

    /**
     * 设置文章分类排序 设置最前
     * @return
     */
    Response updateCategorySortFirst(UpdateCategorySortReqVO updateCategorySortReqVO);

    /**
     * 设置文章分类排序 设置最后
     * @return
     */
    Response updateCategorySortLast(UpdateCategorySortReqVO updateCategorySortReqVO);

    /**
     * 获取文章分类的 Select 列表数据
     * @return
     */
    Response findCategorySelectList();

}
