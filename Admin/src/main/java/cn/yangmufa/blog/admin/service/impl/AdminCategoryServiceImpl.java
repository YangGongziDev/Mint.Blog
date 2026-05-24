package cn.yangmufa.blog.admin.service.impl;

import cn.yangmufa.blog.admin.model.vo.category.*;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import cn.yangmufa.blog.admin.service.AdminCategoryService;
import cn.yangmufa.blog.common.domain.dos.ArticleCategoryRelDO;
import cn.yangmufa.blog.common.domain.dos.CategoryDO;
import cn.yangmufa.blog.common.domain.mapper.ArticleCategoryRelMapper;
import cn.yangmufa.blog.common.domain.mapper.CategoryMapper;
import cn.yangmufa.blog.common.enums.ResponseCodeEnum;
import cn.yangmufa.blog.common.exception.BizException;
import cn.yangmufa.blog.common.model.vo.SelectRspVO;
import cn.yangmufa.blog.common.utils.PageResponse;
import cn.yangmufa.blog.common.utils.Response;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: TODO
 **/
@Service
@Slf4j
public class AdminCategoryServiceImpl implements AdminCategoryService {

    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private ArticleCategoryRelMapper articleCategoryRelMapper;

    /**
     * 添加分类
     *
     * @param addCategoryReqVO
     * @return
     */
    @Override
    public Response addCategory(AddCategoryReqVO addCategoryReqVO) {

        String categoryName = addCategoryReqVO.getName();

        // 先判断该分类是否已经存在
        CategoryDO categoryDO = categoryMapper.selectByName(categoryName);

        if (Objects.nonNull(categoryDO)) {
            log.warn("新增分类名称： {}, 已存在", categoryName);
            throw new BizException(ResponseCodeEnum.CATEGORY_NAME_IS_EXISTED);
        }

        // 构建 DO 类
        CategoryDO insertCategoryDO = CategoryDO.builder()
                .name(addCategoryReqVO.getName().trim())
                .createTime(LocalDateTime.now())
                .isDeleted(0)
                .sort(0)
                .updateTime(LocalDateTime.now())
                .articlesTotal(0)
                .build();

        // 执行 insert
        categoryMapper.insert(insertCategoryDO);

        return Response.success();
    }

    /**
     * 分类分页数据查询
     *
     * @param findCategoryPageListReqVO
     * @return
     */
    @Override
    public PageResponse findCategoryPageList(FindCategoryPageListReqVO findCategoryPageListReqVO) {
        // 获取当前页、以及每页需要展示的数据数量
        Long current = findCategoryPageListReqVO.getCurrent();
        Long size = findCategoryPageListReqVO.getSize();
        String name = findCategoryPageListReqVO.getName();
        LocalDate startDate = findCategoryPageListReqVO.getStartDate();
        LocalDate endDate = findCategoryPageListReqVO.getEndDate();

        // 执行分页查询
        Page<CategoryDO> categoryDOPage = categoryMapper.selectPageList(current, size, name, startDate, endDate);

        List<CategoryDO> categoryDOS = categoryDOPage.getRecords();

        // DO 转 VO
        List<FindCategoryPageListRspVO> vos = null;
        if (!CollectionUtils.isEmpty(categoryDOS)) {
            vos = categoryDOS.stream()
                    .map(categoryDO -> FindCategoryPageListRspVO.builder()
                            .id(categoryDO.getId())
                            .name(categoryDO.getName())
                            .createTime(categoryDO.getCreateTime())
                            .articlesTotal(categoryDO.getArticlesTotal())
                            .sort(categoryDO.getSort())
                            .isDeleted(categoryDO.getIsDeleted())
                            .build())
                    .collect(Collectors.toList());
        }

        return PageResponse.success(categoryDOPage, vos);
    }

    /**
     * 删除分类
     *
     * @param deleteCategoryReqVO
     * @return
     */
    @Override
    public Response deleteCategory(DeleteCategoryReqVO deleteCategoryReqVO) {

        // 分类 ID
        Long categoryId = deleteCategoryReqVO.getId();
        Long deleteType = deleteCategoryReqVO.getDeleteType();

        if (deleteType == 1 || deleteType == 3){
            // 1. VO 转 CategoryDO, 并更新
            CategoryDO categoryDO = CategoryDO.builder()
                    .id(categoryId)
                    .isDeleted(deleteType == 1 ? 1 : 0)
                    .build();
            int count = categoryMapper.updateById(categoryDO);
            // 根据更新是否成功，来判断该分类是否存在
            if (count == 0) {
                log.warn("==> 该文分类不存在, category: {}", categoryId);
                throw new BizException(ResponseCodeEnum.ARTICLE_NOT_FOUND);
            }
            return Response.success();
        }

        // 校验该分类下是否已经有文章，若有，则提示需要先删除分类下所有文章，才能删除
        ArticleCategoryRelDO articleCategoryRelDO = articleCategoryRelMapper.selectOneByCategoryId(categoryId);

        if (Objects.nonNull(articleCategoryRelDO)) {
            log.warn("==> 此分类下包含文章，无法删除，categoryId: {}", categoryId);
            throw new BizException(ResponseCodeEnum.CATEGORY_CAN_NOT_DELETE);
        }

        // 删除分类
        categoryMapper.deleteById(categoryId);

        return Response.success();
    }

    /**
     * 根据标签关键词模糊查询
     *
     * @param searchCategorysReqVO
     * @return
     */
    @Override
    public Response searchCategorys(SearchCategorysReqVO searchCategorysReqVO) {
        String key = searchCategorysReqVO.getKey();

        // 执行模糊查询
        List<CategoryDO> categoryDOS = categoryMapper.selectByKey(key);

        // do 转 vo
        List<SelectRspVO> vos = null;
        if (!CollectionUtils.isEmpty(categoryDOS)) {
            vos = categoryDOS.stream()
                    .map(categoryDO -> SelectRspVO.builder()
                            .value(categoryDO.getId())
                            .label(categoryDO.getName())
                            .sort(categoryDO.getSort())
                            .build())
                    .collect(Collectors.toList());
        }

        return Response.success(vos);
    }

    /**
     * 修改分类
     * @param updateCategoryReqVO
     * @return
     */
    @Override
    public Response updateCategory(UpdateCategoryReqVO updateCategoryReqVO) {
        Long categoryId = updateCategoryReqVO.getId();
        String categoryName = updateCategoryReqVO.getName();

        // 检查是否与其他分类名称冲突
        CategoryDO existingCategory = categoryMapper.selectByName(categoryName);
        if (Objects.nonNull(existingCategory) && !existingCategory.getId().equals(categoryId)) {
            log.warn("更新分类名称： {}, 已存在", categoryName);
            throw new BizException(ResponseCodeEnum.CATEGORY_NAME_IS_EXISTED);
        }

        CategoryDO categoryDO = CategoryDO.builder()
                .id(categoryId)
                .name(categoryName)
                .updateTime(LocalDateTime.now())
                .build();
        return categoryMapper.updateById(categoryDO) == 1 ? Response.success() : Response.fail(ResponseCodeEnum.CATEGORY_NOT_EXISTED);
    }

    /**
     * 更新分类排序
     * @param updateTagSortReqVO
     *
     * @return
     */
    @Override
    public Response updateCategorySort(UpdateCategorySortReqVO updateTagSortReqVO) {
        Long categoryId = updateTagSortReqVO.getId();
        Integer sort = updateTagSortReqVO.getSort();
        categoryMapper.updateById(CategoryDO.builder().id(categoryId).sort(sort).build());
        return Response.success();
    }
    /**
     * 设置文章分类排序设置最前
     *
     * @return
     */
    @Override
    public Response updateCategorySortFirst(UpdateCategorySortReqVO updateCategorySortReqVO) {
        // 查找出最大排序值
        CategoryDO maxSort = categoryMapper.selectMaxSortCategory();
        // 更新分类排序
        categoryMapper.updateById(CategoryDO.builder().id(updateCategorySortReqVO.getId()).sort(maxSort.getSort() + 1).build());
        return Response.success();
    }
    /**
     * 设置文章分类排序设置最后
     *
     * @return
     */
    @Override
    public Response updateCategorySortLast(UpdateCategorySortReqVO updateCategorySortReqVO) {
        // 查找出最小排序值
        CategoryDO minSort = categoryMapper.selectMinSortCategory();
        if (minSort.getSort() > 0){
            // 更新分类排序
            categoryMapper.updateById(CategoryDO.builder().id(updateCategorySortReqVO.getId()).sort(minSort.getSort() - 1).build());
            return Response.success();
        } else {
            // return Response.fail(ResponseCodeEnum.SORT_OPERATION_FAILURE_LESS_THAN_ONE);
            categoryMapper.updateById(CategoryDO.builder().id(updateCategorySortReqVO.getId()).sort(0).build());
            return Response.success();
        }
    }

    /**
     * 获取文章分类的 Select 列表数据
     *
     * @return
     */
    @Override
    public Response findCategorySelectList() {
        // 查询所有分类
        List<CategoryDO> categoryDOS = categoryMapper.selectList(null);

        // DO 转 VO
        List<SelectRspVO> selectRspVOS = null;
        // 如果分类数据不为空
        if (!CollectionUtils.isEmpty(categoryDOS)) {
            // 将分类 ID 作为 Value 值，将分类名称作为 label 展示
            selectRspVOS = categoryDOS.stream()
                    .map(categoryDO -> SelectRspVO.builder()
                            .label(categoryDO.getName())
                            .sort(categoryDO.getSort())
                            .value(categoryDO.getId())
                            .build())
                    .collect(Collectors.toList());
        }

        return Response.success(selectRspVOS);
    }

}
