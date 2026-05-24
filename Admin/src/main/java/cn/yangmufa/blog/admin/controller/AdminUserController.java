package cn.yangmufa.blog.admin.controller;

import cn.yangmufa.blog.admin.model.vo.category.DeleteCategoryReqVO;
import cn.yangmufa.blog.admin.model.vo.user.DeleteUserReqVO;
import cn.yangmufa.blog.admin.model.vo.user.UpdateAdminUserPasswordReqVO;
import cn.yangmufa.blog.admin.service.AdminUserService;
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
 * @description: 用户
 **/
@RestController
@RequestMapping("/admin")
@Tag(name = "Admin 用户模块")
public class AdminUserController {

    @Autowired
    private AdminUserService userService;

    @PostMapping("/delete")
    @Operation(summary = "删除用户")
    @ApiOperationLog(description = "删除用户")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response deleteCategory(@RequestBody @Validated DeleteUserReqVO deleteUserReqVO) {
        return userService.deleteUser(deleteUserReqVO);
    }

    @PostMapping("/password/update")
    @Operation(summary = "修改用户密码")
    @ApiOperationLog(description = "修改用户密码")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updatePassword(@RequestBody @Validated UpdateAdminUserPasswordReqVO updateAdminUserPasswordReqVO) {
        return userService.updatePassword(updateAdminUserPasswordReqVO);
    }

    @PostMapping("/user/info")
    @Operation(summary = "获取用户信息")
    @ApiOperationLog(description = "获取用户信息")
    public Response findUserInfo() {
        return userService.findUserInfo();
    }

}
