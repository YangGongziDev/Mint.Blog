package cn.yangmufa.blog.surfer.service;

import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.model.vo.comment.FindCommentListReqVO;
import cn.yangmufa.blog.surfer.model.vo.comment.FindQQUserInfoReqVO;
import cn.yangmufa.blog.surfer.model.vo.comment.PublishCommentReqVO;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 评论
 **/
public interface CommentService {

    /**
     * 根据 QQ 号获取用户信息
     * @param findQQUserInfoReqVO
     * @return
     */
    Response findQQUserInfo(FindQQUserInfoReqVO findQQUserInfoReqVO);

    /**
     * 发布评论
     * @param publishCommentReqVO
     * @return
     */
    Response publishComment(PublishCommentReqVO publishCommentReqVO);

    /**
     * 查询页面所有评论
     * @param findCommentListReqVO
     * @return
     */
    Response findCommentList(FindCommentListReqVO findCommentListReqVO);
}
