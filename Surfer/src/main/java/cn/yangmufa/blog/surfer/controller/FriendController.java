package cn.yangmufa.blog.surfer.controller;

import cn.yangmufa.blog.common.aspect.ApiOperationLog;
import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.model.vo.article.FindFriendDetailReqVO;
import cn.yangmufa.blog.surfer.model.vo.article.FindIndexFriendPageListReqVO;
import cn.yangmufa.blog.surfer.model.vo.article.FriendAddReqVO;
import cn.yangmufa.blog.surfer.service.FriendService;
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
 * @description: 统计信息
 **/
@RestController
@RequestMapping("/surfer/friend")
@Tag(name = "友链")
public class FriendController {

    @Autowired
    private FriendService friendService;

    @PostMapping("/list")
    @Operation(summary = "获取友链分页数据")
    @ApiOperationLog(description = "获取友链分页数据")
    public Response findFriendPageList(@RequestBody FindIndexFriendPageListReqVO findIndexFriendPageListReqVO) {
        return friendService.findFriendPageList(findIndexFriendPageListReqVO);
    }


    @PostMapping("/detail")
    @Operation(summary = "获取友链详情")
    @ApiOperationLog(description = "获取友链详情")
    public Response findFriendDetail(@RequestBody FindFriendDetailReqVO findFriendDetailReqVO) {
        return friendService.findFriendDetail(findFriendDetailReqVO);
    }

    @PostMapping("/apply")
    @Operation(summary = "申请友链")
    @ApiOperationLog(description = "申请友链")
    public Response applyFriend(@RequestBody FriendAddReqVO friendAddReqVO) {
        return friendService.applyFriend(friendAddReqVO);
    }


}
