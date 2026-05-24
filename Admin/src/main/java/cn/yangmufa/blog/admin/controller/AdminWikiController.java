package cn.yangmufa.blog.admin.controller;

import cn.yangmufa.blog.admin.model.vo.wiki.*;
import cn.yangmufa.blog.admin.service.AdminWikiService;
import cn.yangmufa.blog.common.aspect.ApiOperationLog;
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

import javax.validation.Valid;
import java.util.List;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 知识库模块
 **/
@RestController
@RequestMapping("/admin/wiki")
@Tag(name = "Admin 知识库模块")
public class AdminWikiController {

    @Autowired
    private AdminWikiService wikiService;

    @PostMapping("/add")
    @Operation(summary = "新增知识库")
    @ApiOperationLog(description = "新增知识库")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response addWiki(@RequestBody @Validated AddWikiReqVO addWikiReqVO) {
        return wikiService.addWiki(addWikiReqVO);
    }

    @PostMapping("/delete")
    @Operation(summary = "知识库删除")
    @ApiOperationLog(description = "知识库删除")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response deleteWiki(@RequestBody @Validated DeleteWikiReqVO deleteWikiReqVO) {
        return wikiService.deleteWiki(deleteWikiReqVO);
    }

    @PostMapping("/list")
    @Operation(summary = "查询知识库分页数据")
    @ApiOperationLog(description = "查询知识库分页数据")
    public Response findWikiPageList(@RequestBody @Validated FindWikiPageListReqVO findWikiPageListReqVO) {
        return wikiService.findWikiPageList(findWikiPageListReqVO);
    }

    @PostMapping("/isTop/update")
    @Operation(summary = "更新知识库置顶状态")
    @ApiOperationLog(description = "更新知识库置顶状态")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateWikiIsTop(@RequestBody @Validated UpdateWikiIsTopReqVO updateWikiIsTopReqVO) {
        return wikiService.updateWikiIsTop(updateWikiIsTopReqVO);
    }

    @PostMapping("/isPublish/update")
    @Operation(summary = "更新知识库发布状态")
    @ApiOperationLog(description = "更新知识库发布状态")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateWikiIsPublish(@RequestBody @Validated UpdateWikiIsPublishReqVO updateWikiIsPublishReqVO) {
        return wikiService.updateWikiIsPublish(updateWikiIsPublishReqVO);
    }

    @PostMapping("/update")
    @Operation(summary = "更新知识库")
    @ApiOperationLog(description = "更新知识库")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateWiki(@RequestBody @Validated UpdateWikiReqVO updateWikiReqVO) {
        return wikiService.updateWiki(updateWikiReqVO);
    }

    @PostMapping("/update/sort")
    @Operation(summary = "更新知识库排序")
    @ApiOperationLog(description = "更新知识库排序")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateWiki(@RequestBody  @Validated UpdateWikiSortReqVO updateWikiSortReqVO) {
        return wikiService.updateWikiSort(updateWikiSortReqVO);
    }
    @PostMapping("/update/sort/first")
    @Operation(summary = "更新知识库排序到最前")
    @ApiOperationLog(description = "更新知识库排序到最前")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateWikiSortFirst(@RequestBody  @Validated UpdateWikiSortReqVO updateWikiSortReqVO) {
        return wikiService.updateWikiSortFirst(updateWikiSortReqVO);
    }

    @PostMapping("/update/sort/last")
    @Operation(summary = "更新知识库排序到最后")
    @ApiOperationLog(description = "更新知识库排序到最后")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateWikiSortLast(@RequestBody  @Validated UpdateWikiSortReqVO updateWikiSortReqVO) {
        return wikiService.updateWikiSortLast(updateWikiSortReqVO);
    }

    @PostMapping("/catalog/list")
    @Operation(summary = "查询知识库目录数据")
    @ApiOperationLog(description = "查询知识库目录数据")
    public Response findWikiCatalogList(@RequestBody @Validated FindWikiCatalogListReqVO findWikiCatalogListReqVO) {
        return wikiService.findWikiCatalogList(findWikiCatalogListReqVO);
    }

    @PostMapping("/catalog/update")
    @Operation(summary = "更新知识库目录")
    @ApiOperationLog(description = "更新知识库目录")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateWikiCatalogs(@RequestBody @Valid UpdateWikiCatalogReqVO updateWikiCatalogsReqVO) {
        return wikiService.updateWikiCatalogs(updateWikiCatalogsReqVO);
    }

}
