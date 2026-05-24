package cn.yangmufa.blog.admin.service;

import cn.yangmufa.blog.admin.model.vo.category.DeleteCategoryReqVO;
import cn.yangmufa.blog.admin.model.vo.user.DeleteUserReqVO;
import cn.yangmufa.blog.admin.model.vo.user.UpdateAdminUserPasswordReqVO;
import cn.yangmufa.blog.common.utils.Response;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: TODO
 **/
public interface AdminUserService {

    /**
     * 删除用户
     * @param deleteUserReqVO
     * @return
     */
    Response deleteUser(DeleteUserReqVO deleteUserReqVO);

    /**
     * 修改密码
     * @param updateAdminUserPasswordReqVO
     * @return
     */
    Response updatePassword(UpdateAdminUserPasswordReqVO updateAdminUserPasswordReqVO);

    /**
     * 获取当前登录用户信息
     * @return
     */
    Response findUserInfo();
}
