package cn.yangmufa.blog.admin.service;

import cn.yangmufa.blog.admin.model.vo.comment.DeleteCommentReqVO;
import cn.yangmufa.blog.admin.model.vo.comment.ExamineCommentReqVO;
import cn.yangmufa.blog.admin.model.vo.comment.FindCommentPageListReqVO;
import cn.yangmufa.blog.common.utils.Response;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 评论
 **/
public interface AdminCommentService {

    /**
     * 查询评论分页数据
     * @param findCommentPageListReqVO
     * @return
     */
    Response findCommentPageList(FindCommentPageListReqVO findCommentPageListReqVO);

    /**
     * 删除评论
     * @param deleteCommentReqVO
     * @return
     */
    Response deleteComment(DeleteCommentReqVO deleteCommentReqVO);

    /**
     * 评论审核
     * @param examineCommentReqVO
     * @return
     */
    Response examine(ExamineCommentReqVO examineCommentReqVO);

}
