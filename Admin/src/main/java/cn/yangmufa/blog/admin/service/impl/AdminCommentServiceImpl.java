package cn.yangmufa.blog.admin.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import cn.yangmufa.blog.admin.convert.CommentConvert;
import cn.yangmufa.blog.admin.event.UpdateCommentEvent;
import cn.yangmufa.blog.admin.model.vo.comment.DeleteCommentReqVO;
import cn.yangmufa.blog.admin.model.vo.comment.ExamineCommentReqVO;
import cn.yangmufa.blog.admin.model.vo.comment.FindCommentPageListReqVO;
import cn.yangmufa.blog.admin.model.vo.comment.FindCommentPageListRspVO;
import cn.yangmufa.blog.admin.service.AdminCommentService;
import cn.yangmufa.blog.common.domain.dos.CommentDO;
import cn.yangmufa.blog.common.domain.mapper.CommentMapper;
import cn.yangmufa.blog.common.enums.ResponseCodeEnum;
import cn.yangmufa.blog.common.exception.BizException;
import cn.yangmufa.blog.common.utils.PageResponse;
import cn.yangmufa.blog.common.utils.Response;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 评论
 **/
@Service
@Slf4j
public class AdminCommentServiceImpl implements AdminCommentService {

    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private ApplicationEventPublisher eventPublisher;

    /**
     * 查询评论分页数据
     *
     * @param findCommentPageListReqVO
     * @return
     */
    @Override
    public Response findCommentPageList(FindCommentPageListReqVO findCommentPageListReqVO) {
        // 获取当前页、以及每页需要展示的数据数量
        Long current = findCommentPageListReqVO.getCurrent();
        Long size = findCommentPageListReqVO.getSize();
        LocalDate startDate = findCommentPageListReqVO.getStartDate();
        LocalDate endDate = findCommentPageListReqVO.getEndDate();
        String routerUrl = findCommentPageListReqVO.getRouterUrl();
        Integer status = findCommentPageListReqVO.getStatus();

        // 执行分页查询
        Page<CommentDO> commentDOPage = commentMapper.selectPageList(current, size, routerUrl, startDate, endDate, status);

        List<CommentDO> commentDOS = commentDOPage.getRecords();

        // DO 转 VO
        List<FindCommentPageListRspVO> vos = null;
        if (!CollectionUtils.isEmpty(commentDOS)) {
            vos = commentDOS.stream()
                    .map(commentDO -> CommentConvert.INSTANCE.convertDO2VO(commentDO))
                    .collect(Collectors.toList());
        }

        return PageResponse.success(commentDOPage, vos);
    }

    /**
     * 删除评论
     *
     * @param deleteCommentReqVO
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response deleteComment(DeleteCommentReqVO deleteCommentReqVO) {

        Long commentId = deleteCommentReqVO.getId();
        Long deleteType = deleteCommentReqVO.getDeleteType();

        if (deleteType == 1 || deleteType == 3){
            // 1. VO 转 CommentDO, 并更新
            CommentDO commentDO = CommentDO.builder()
                    .id(commentId)
                    .isDeleted(deleteType == 1 ? 1 : 0)
                    .build();
            int count = commentMapper.updateById(commentDO);
            // 根据更新是否成功，来判断该评论是否存在
            if (count == 0) {
                log.warn("==> 该文评论存在, commentId: {}", commentId);
                throw new BizException(ResponseCodeEnum.ARTICLE_NOT_FOUND);
            }
            return Response.success();
        }

        // 查询该评论是一级评论，还是二级评论
        CommentDO commentDO = commentMapper.selectById(commentId);

        // 判断评论是否存在
        if (Objects.isNull(commentDO)) {
            log.warn("该评论不存在, commentId: {}", commentId);
            throw new BizException(ResponseCodeEnum.COMMENT_NOT_FOUND);
        }

        // 删除评论
        commentMapper.deleteById(commentId);

        Long replayCommentId = commentDO.getReplyCommentId();

        // 一级评论
        if (Objects.isNull(replayCommentId)) {
            // 删除子评论
            commentMapper.deleteByParentCommentId(commentId);
        } else { // 二级评论
            // 删除此评论, 以及此评论下的所有回复
            deleteAllChildComment(commentId);
        }

        return Response.success();
    }

    /**
     * 递归删除所有子评论
     * @param commentId
     */
    private void deleteAllChildComment(Long commentId) {
        // 查询此评论的所有回复
        List<CommentDO> childCommentDOS = commentMapper.selectByReplyCommentId(commentId);

        if (CollectionUtils.isEmpty(childCommentDOS))
            return;

        // 循环递归删除
        childCommentDOS.forEach(childCommentDO -> {
            Long childCommentId = childCommentDO.getId();

            commentMapper.deleteById(childCommentId);
            // 递归调用
            deleteAllChildComment(childCommentId);
        });

    }

    /**
     * 评论审核
     *
     * @param examineCommentReqVO
     * @return
     */
    @Override
    public Response examine(ExamineCommentReqVO examineCommentReqVO) {
        Long commentId = examineCommentReqVO.getId();
        Integer status = examineCommentReqVO.getStatus();
        String reason = examineCommentReqVO.getReason();

        CommentDO commentDO = commentMapper.selectById(commentId);

        if (Objects.isNull(commentDO)) {
            log.warn("该评论不存在, commentId: {}", commentId);
            throw new BizException(ResponseCodeEnum.COMMENT_NOT_FOUND);
        }

        Integer currStatus = commentDO.getStatus();

        // 若未处于待审核状态
//        if (!Objects.equals(currStatus, CommentStatusEnum.WAIT_EXAMINE.getCode())) {
//            log.warn("该评论未处于待审核状态, commentId: {}", commentId);
//            throw new BizException(ResponseCodeEnum.COMMENT_STATUS_NOT_WAIT_EXAMINE);
//        }

        commentMapper.updateById(CommentDO.builder()
                .id(commentId)
                .status(status)
                .reason(reason)
                .updateTime(LocalDateTime.now())
                .build());

        // 发送文章发布事件
        eventPublisher.publishEvent(new UpdateCommentEvent(this, commentId));

        return Response.success();
    }

}
