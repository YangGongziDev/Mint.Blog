package cn.yangmufa.blog.admin.controller;

import cn.yangmufa.blog.admin.model.vo.tag.*;
import cn.yangmufa.blog.admin.service.AdminTagService;
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
 * @description: 标签模块
 **/
@RestController
@RequestMapping("/admin/tag")
@Tag(name = "Admin 标签模块")
public class AdminTagController {

    @Autowired
    private AdminTagService tagService;

    @PostMapping("/add")
    @Operation(summary = "添加标签")
    @ApiOperationLog(description = "添加标签")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response addTags(@RequestBody @Validated AddTagReqVO addTagReqVO) {
        return tagService.addTags(addTagReqVO);
    }

    @PostMapping("/update")
    @Operation(summary = "修改标签")
    @ApiOperationLog(description = "修改标签")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateTag(@RequestBody @Validated UpdateTagReqVO updateTagReqVO) {
        return tagService.updateTag(updateTagReqVO);
    }

    @PostMapping("/update/sort")
    @Operation(summary = "更新标签排序")
    @ApiOperationLog(description = "更新标签排序")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateTagSort(@RequestBody  @Validated UpdateTagSortReqVO updateTagSortReqVO) {
        return tagService.updateTagSort(updateTagSortReqVO);
    }
    @PostMapping("/update/sort/first")
    @Operation(summary = "更新标签排序到最前")
    @ApiOperationLog(description = "更新标签排序到最前")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateTagSortFirst(@RequestBody  @Validated UpdateTagSortReqVO updateTagSortReqVO) {
        return tagService.updateTagSortFirst(updateTagSortReqVO);
    }
    @PostMapping("/update/sort/last")
    @Operation(summary = "更新标签排序到最后")
    @ApiOperationLog(description = "更新分标签序到最后")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateTagSortLast(@RequestBody  @Validated UpdateTagSortReqVO updateTagSortReqVO) {
        return tagService.updateTagSortLast(updateTagSortReqVO);
    }

    @PostMapping("/list")
    @Operation(summary = "标签分页数据获取")
    @ApiOperationLog(description = "标签分页数据获取")
    public PageResponse findTagPageList(@RequestBody @Validated FindTagPageListReqVO findTagPageListReqVO) {
        return tagService.findTagPageList(findTagPageListReqVO);
    }

    @PostMapping("/delete")
    @Operation(summary = "删除标签")
    @ApiOperationLog(description = "删除标签")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response deleteTag(@RequestBody @Validated DeleteTagReqVO deleteTagReqVO) {
        return tagService.deleteTag(deleteTagReqVO);
    }

    @PostMapping("/search")
    @Operation(summary = "标签模糊查询")
    @ApiOperationLog(description = "标签模糊查询")
    public Response searchTags(@RequestBody @Validated SearchTagsReqVO searchTagsReqVO) {
        return tagService.searchTags(searchTagsReqVO);
    }

    @PostMapping("/select/list")
    @Operation(summary = "查询标签 Select 列表数据")
    @ApiOperationLog(description = "查询标签 Select 列表数据")
    public Response findTagSelectList() {
        return tagService.findTagSelectList();
    }

}
