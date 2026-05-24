package cn.yangmufa.blog.admin.service.impl;

import cn.yangmufa.blog.admin.model.vo.user.DeleteUserReqVO;
import cn.yangmufa.blog.admin.model.vo.user.FindUserInfoRspVO;
import cn.yangmufa.blog.admin.model.vo.user.UpdateAdminUserPasswordReqVO;
import cn.yangmufa.blog.admin.service.AdminUserService;
import cn.yangmufa.blog.common.domain.dos.UserDO;
import cn.yangmufa.blog.common.domain.mapper.UserMapper;
import cn.yangmufa.blog.common.enums.ResponseCodeEnum;
import cn.yangmufa.blog.common.exception.BizException;
import cn.yangmufa.blog.common.utils.Response;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: TODO
 **/
@Service
@Slf4j
public class AdminUserServiceImpl implements AdminUserService {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private PasswordEncoder passwordEncoder;

    /**
     * 修改密码
     * @param updateAdminUserPasswordReqVO
     * @return
     */
    @Override
    public Response updatePassword(UpdateAdminUserPasswordReqVO updateAdminUserPasswordReqVO) {

        // 拿到用户名、密码
        String username = updateAdminUserPasswordReqVO.getUsername();
        String password = updateAdminUserPasswordReqVO.getPassword();

        // 加密密码
        String encodePassword = passwordEncoder.encode(password);

        // 更新到数据库
        int count = userMapper.updatePasswordByUsername(username, encodePassword);

        return count == 1 ? Response.success() : Response.fail(ResponseCodeEnum.USERNAME_NOT_FOUND);
    }

    /**
     * 获取当前登录用户信息
     * @return
     */
    @Override
    public Response findUserInfo() {
        // 获取存储在 ThreadLocal 中的用户信息
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // 拿到用户名
        String username = authentication.getName();

        return Response.success(FindUserInfoRspVO.builder().username(username).build());
    }

    /**
     * 删除用户
     *
     * @param deleteUserReqVO
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response deleteUser(DeleteUserReqVO deleteUserReqVO) {

        Long userId = deleteUserReqVO.getId();
        Long deleteType = deleteUserReqVO.getDeleteType();

        if (deleteType == 1 || deleteType == 3){
            // 1. VO 转 UserDO, 并更新
            UserDO userDO = UserDO.builder()
                    .id(userId)
                    .isDeleted(deleteType == 1 ? 1 : 0)
                    .build();
            int count = userMapper.updateById(userDO);
            // 根据更新是否成功，来判断该评论是否存在
            if (count == 0) {
                log.warn("==> 该文用户不存在, userId: {}", userId);
                throw new BizException(ResponseCodeEnum.ARTICLE_NOT_FOUND);
            }
            return Response.success();
        }

        // 删除用户
        userMapper.deleteById(userId);

        return Response.success();
    }
}
