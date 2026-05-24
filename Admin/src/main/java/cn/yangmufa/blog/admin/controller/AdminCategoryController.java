package cn.yangmufa.blog.admin.controller;

import cn.yangmufa.blog.admin.model.vo.category.*;
import cn.yangmufa.blog.admin.model.vo.tag.SearchTagsReqVO;
import cn.yangmufa.blog.admin.model.vo.tag.UpdateTagSortReqVO;
import cn.yangmufa.blog.admin.service.AdminCategoryService;
import cn.yangmufa.blog.common.aspect.ApiOperationLog;
import cn.yangmufa.blog.common.utils.PageResponse;
import cn.yangmufa.blog.common.utils.Response;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 分类
 **/
@RestController
@RequestMapping("/admin/category")
@Tag(name = "Admin 分类模块")
public class AdminCategoryController {

    @Autowired
    private AdminCategoryService categoryService;

    @PostMapping("/add")
    @Operation(summary = "添加分类")
    @ApiOperationLog(description = "添加分类")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response addCategory(@RequestBody @Validated AddCategoryReqVO addCategoryReqVO) {
        return categoryService.addCategory(addCategoryReqVO);
    }

    @PostMapping("/list")
    @Operation(summary = "分类分页数据获取")
    @ApiOperationLog(description = "分类分页数据获取")
    public PageResponse findCategoryPageList(@RequestBody @Validated FindCategoryPageListReqVO findCategoryPageListReqVO) {
        return categoryService.findCategoryPageList(findCategoryPageListReqVO);
    }

    @PostMapping("/delete")
    @Operation(summary = "删除分类")
    @ApiOperationLog(description = "删除分类")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response deleteCategory(@RequestBody @Validated DeleteCategoryReqVO deleteCategoryReqVO) {
        return categoryService.deleteCategory(deleteCategoryReqVO);
    }

    @PostMapping("/search")
    @Operation(summary = "分类模糊查询")
    @ApiOperationLog(description = "分类模糊查询")
    public Response searchTags(@RequestBody @Validated SearchCategorysReqVO searchCategorysReqVO) {
        return categoryService.searchCategorys(searchCategorysReqVO);
    }

    @PostMapping("/update")
    @Operation(summary = "修改分类")
    @ApiOperationLog(description = "修改分类")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateCategory(@RequestBody @Validated UpdateCategoryReqVO updateCategoryReqVO) {
        return categoryService.updateCategory(updateCategoryReqVO);
    }

    @PostMapping("/update/sort")
    @Operation(summary = "更新分类排序")
    @ApiOperationLog(description = "更新分类排序")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateCategorySort(@RequestBody  @Validated UpdateCategorySortReqVO updateTagSortReqVO) {
        return categoryService.updateCategorySort(updateTagSortReqVO);
    }
    @PostMapping("/update/sort/first")
    @Operation(summary = "更新分类排序到最前")
    @ApiOperationLog(description = "更新分类排序到最前")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateCategorySortFirst(@RequestBody  @Validated UpdateCategorySortReqVO updateTagSortReqVO) {
        return categoryService.updateCategorySortFirst(updateTagSortReqVO);
    }
    @PostMapping("/update/sort/last")
    @Operation(summary = "更新分类排序到最后")
    @ApiOperationLog(description = "更新分类排序到最后")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateCategorySortLast(@RequestBody  @Validated UpdateCategorySortReqVO updateTagSortReqVO) {
        return categoryService.updateCategorySortLast(updateTagSortReqVO);
    }

    @PostMapping("/select/list")
    @Operation(summary = "分类 Select 下拉列表数据获取")
    @ApiOperationLog(description = "分类 Select 下拉列表数据获取")
    public Response findCategorySelectList() {
        return categoryService.findCategorySelectList();
    }


}
