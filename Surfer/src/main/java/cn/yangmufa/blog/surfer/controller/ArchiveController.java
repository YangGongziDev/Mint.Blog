package cn.yangmufa.blog.surfer.controller;

import cn.yangmufa.blog.common.aspect.ApiOperationLog;
import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.model.vo.archive.FindArchiveArticlePageListReqVO;
import cn.yangmufa.blog.surfer.service.ArchiveService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 文章归档
 **/
@RestController
@RequestMapping("/surfer")
@Tag(name = "文章归档")
public class ArchiveController {

    @Autowired
    private ArchiveService archiveService;

    @PostMapping("/archive/list")
    @Operation(summary = "获取文章归档分页数据")
    @ApiOperationLog(description = "获取文章归档分页数据")
    public Response findArchivePageList(@RequestBody @Validated FindArchiveArticlePageListReqVO findArchiveArticlePageListReqVO) {
        return archiveService.findArchivePageList(findArchiveArticlePageListReqVO);
    }

    @PostMapping("/archive/year")
    @Operation(summary = "获取文章归档一年数据")
    @ApiOperationLog(description = "获取文章归档一年数据")
    public Response findArchiveYearList(@RequestBody String year) {
        return archiveService.findArchiveYearList(year);
    }

    @PostMapping("/archive/years")
    @Operation(summary = "获取文章所有所有年份")
    @ApiOperationLog(description = "获取文章所有所有年份")
    public Response findArchiveYearsList() {
        return archiveService.findArchiveYears();
    }

}
