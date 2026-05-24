package cn.yangmufa.blog.admin.controller;

import cn.yangmufa.blog.admin.model.vo.friend.*;
import cn.yangmufa.blog.admin.model.vo.wiki.*;
import cn.yangmufa.blog.admin.service.AdminFriendService;
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

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 友链模块
 **/
@RestController
@RequestMapping("/admin/friend")
@Tag(name = "Admin 友链模块")
public class AdminFriendController {

    @Autowired
    private AdminFriendService friendService;

    @PostMapping("/add")
    @Operation(summary = "新增友链")
    @ApiOperationLog(description = "新增友链")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response addFriend(@RequestBody @Validated AddFriendReqVO addFriendReqVO) {
        return friendService.addFriend(addFriendReqVO);
    }

    @PostMapping("/delete")
    @Operation(summary = "友链删除")
    @ApiOperationLog(description = "友链删除")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response deleteFriend(@RequestBody @Validated DeleteFriendReqVO deleteFriendReqVO) {
        return friendService.deleteFriend(deleteFriendReqVO);
    }

    @PostMapping("/list")
    @Operation(summary = "查询友链分页数据")
    @ApiOperationLog(description = "查询友链分页数据")
    public Response findFriendPageList(@RequestBody @Validated FindFriendPageListReqVO findFriendPageListReqVO) {
        return friendService.findFriendPageList(findFriendPageListReqVO);
    }

    @PostMapping("/isTop/update")
    @Operation(summary = "更新友链置顶状态")
    @ApiOperationLog(description = "更新友链置顶状态")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateFriendIsTop(@RequestBody @Validated UpdateFriendIsTopReqVO updateFriendIsTopReqVO) {
        return friendService.updateFriendIsTop(updateFriendIsTopReqVO);
    }

    @PostMapping("/status/update")
    @Operation(summary = "更新友链审核状态")
    @ApiOperationLog(description = "更新友链审核状态")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateFriendIsPublish(@RequestBody @Validated UpdateFriendIsPublishReqVO updateFriendIsPublishReqVO) {
        return friendService.updateFriendStatus(updateFriendIsPublishReqVO);
    }

    @PostMapping("/update")
    @Operation(summary = "更新友链")
    @ApiOperationLog(description = "更新友链")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateFriend(@RequestBody @Validated UpdateFriendReqVO updateFriendReqVO) {
        return friendService.updateFriend(updateFriendReqVO);
    }

    @PostMapping("/update/sort")
    @Operation(summary = "更新友链排序")
    @ApiOperationLog(description = "更新友链排序")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateFriend(@RequestBody  @Validated UpdateFriendSortReqVO updateFriendSortReqVO) {
        return friendService.updateFriendSort(updateFriendSortReqVO);
    }
    @PostMapping("/update/sort/first")
    @Operation(summary = "更新友链排序到最前")
    @ApiOperationLog(description = "更新友链排序到最前")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateFriendSortFirst(@RequestBody  @Validated UpdateFriendSortReqVO updateFriendSortReqVO) {
        return friendService.updateFriendSortFirst(updateFriendSortReqVO);
    }

    @PostMapping("/update/sort/last")
    @Operation(summary = "更新友链排序到最后")
    @ApiOperationLog(description = "更新友链排序到最后")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateFriendSortLast(@RequestBody  @Validated UpdateFriendSortReqVO updateFriendSortReqVO) {
        return friendService.updateFriendSortLast(updateFriendSortReqVO);
    }

}
