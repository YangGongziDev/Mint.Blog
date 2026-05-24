package cn.yangmufa.blog.surfer.controller;

import cn.yangmufa.blog.common.aspect.ApiOperationLog;
import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.model.vo.article.FindArticleDetailReqVO;
import cn.yangmufa.blog.surfer.model.vo.article.FindIndexArticlePageListReqVO;
import cn.yangmufa.blog.surfer.service.ArticleService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 文章
 **/
@RestController
@RequestMapping("/surfer/article")
@Tag(name = "文章")
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @PostMapping("/list")
    @Operation(summary = "获取首页文章分页数据")
    @ApiOperationLog(description = "获取首页文章分页数据")
    public Response findArticlePageList(@RequestBody FindIndexArticlePageListReqVO findIndexArticlePageListReqVO) {
        return articleService.findArticlePageList(findIndexArticlePageListReqVO);
    }


    @PostMapping("/detail")
    @Operation(summary = "获取文章详情")
    @ApiOperationLog(description = "获取文章详情")
    public Response findArticleDetail(@RequestBody FindArticleDetailReqVO findArticleDetailReqVO) {
        return articleService.findArticleDetail(findArticleDetailReqVO);
    }

}
