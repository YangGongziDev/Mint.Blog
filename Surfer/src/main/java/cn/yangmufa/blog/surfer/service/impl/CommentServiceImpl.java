package cn.yangmufa.blog.surfer.service.impl;

import cn.yangmufa.blog.surfer.model.vo.comment.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import cn.yangmufa.blog.common.domain.dos.BlogSettingsDO;
import cn.yangmufa.blog.common.domain.dos.CommentDO;
import cn.yangmufa.blog.common.domain.mapper.BlogSettingsMapper;
import cn.yangmufa.blog.common.domain.mapper.CommentMapper;
import cn.yangmufa.blog.common.enums.CommentStatusEnum;
import cn.yangmufa.blog.common.enums.ResponseCodeEnum;
import cn.yangmufa.blog.common.exception.BizException;
import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.convert.CommentConvert;
import cn.yangmufa.blog.surfer.event.PublishCommentEvent;
import cn.yangmufa.blog.surfer.service.CommentService;
import cn.yangmufa.blog.surfer.utils.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.client.RestTemplate;
import toolgood.words.IllegalWordsSearch;
import toolgood.words.IllegalWordsSearchResult;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 知识库
 **/
@Service
@Slf4j
public class CommentServiceImpl implements CommentService {

    @Autowired
    private RestTemplate restTemplate;
    @Autowired
    private BlogSettingsMapper blogSettingsMapper;
    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private IllegalWordsSearch wordsSearch;
    @Autowired
    private ApplicationEventPublisher eventPublisher;

    @Override
    public Response findQQUserInfo(FindQQUserInfoReqVO findQQUserInfoReqVO) {
        String qq = findQQUserInfoReqVO.getQq();

        // 校验 QQ 号
        if (!StringUtil.isPureNumber(qq)) {
            log.warn("昵称输入的格式不是 QQ 号: {}", qq);
            throw new BizException(ResponseCodeEnum.NOT_QQ_NUMBER);
        }

        // 请求第三方接口
        String url = String.format("https://api.qjqq.cn/api/qqinfo?qq=%s", qq);
        String result = restTemplate.getForObject(url, String.class);

        log.info("通过 QQ 号获取用户信息: {}", result);

        // 解析响参
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            Map<String, Object> map = objectMapper.readValue(result, Map.class);
            if (Objects.equals(map.get("code"), HttpStatus.OK.value())) {
                // 获取用户头像、昵称、邮箱
                return Response.success(FindQQUserInfoRspVO.builder()
                                .avatar(String.valueOf(map.get("imgurl")))
                                .nickname(String.valueOf(map.get("name")))
                                .mail(String.valueOf(map.get("mail")))
                        .build());
            }

            return Response.fail();
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 发布评论
     *
     * @param publishCommentReqVO
     * @return
     */
    @Override
    public Response publishComment(PublishCommentReqVO publishCommentReqVO) {
        // 回复的评论 ID
        Long replyCommentId = publishCommentReqVO.getReplyCommentId();
        // 评论内容
        String content = publishCommentReqVO.getContent();
        // 昵称
        String nickname = publishCommentReqVO.getNickname();

        // 查询博客设置相关信息（约定的 ID 为 1）
        BlogSettingsDO blogSettingsDO = blogSettingsMapper.selectById(1L);
        // 是否开启了敏感词过滤
        boolean isCommentSensiWordOpen = blogSettingsDO.getIsCommentSensiWordOpen();
        // 是否开启了审核
        boolean isCommentExamineOpen = blogSettingsDO.getIsCommentExamineOpen();

        // 设置默认状态（正常）
        Integer status = CommentStatusEnum.NORMAL.getCode();
        // 审核不通过原因
        String reason = "";

        // 如果开启了审核, 设置状态为待审核，等待博主后台审核通过
        if (isCommentExamineOpen) {
            status = CommentStatusEnum.WAIT_EXAMINE.getCode();
        }

        // 评论内容是否包含敏感词
        boolean isContainSensitiveWord = false;
        // 是否开启了敏感词过滤
        if (isCommentSensiWordOpen) {
            // 校验评论中是否包含敏感词
            isContainSensitiveWord = wordsSearch.ContainsAny(content);

            if (isContainSensitiveWord) {
                // 若包含敏感词，设置状态为审核不通过
                status = CommentStatusEnum.EXAMINE_FAILED.getCode();
                // 匹配到的所有敏感词组
                List<IllegalWordsSearchResult> results = wordsSearch.FindAll(content);
                List<String> keywords = results.stream().map(result -> result.Keyword).collect(Collectors.toList());
                // 不同过的原因
                reason = String.format("系统自动拦截，包含敏感词：%s", keywords);
                log.warn("此评论内容中包含敏感词: {}, content: {}", keywords, content);
            }
        }

        CommentDO commentDO = CommentDO.builder()
                .avatar(publishCommentReqVO.getAvatar())
                .content(content)
                .mail(publishCommentReqVO.getMail())
                .createTime(LocalDateTime.now())
                .nickname(nickname)
                .routerUrl(publishCommentReqVO.getRouterUrl())
                .website(publishCommentReqVO.getWebsite())
                .replyCommentId(replyCommentId)
                .parentCommentId(publishCommentReqVO.getParentCommentId())
                .status(status)
                .reason(reason)
                .build();

        commentMapper.insert(commentDO);

        Long commentId = commentDO.getId();

        // 发送评论发布事件
        eventPublisher.publishEvent(new PublishCommentEvent(this, commentId));

        // 给予前端对应的提示信息
        if (isContainSensitiveWord)
            throw new BizException(ResponseCodeEnum.COMMENT_CONTAIN_SENSITIVE_WORD);

        if (Objects.equals(status, CommentStatusEnum.WAIT_EXAMINE.getCode()))
            throw new BizException(ResponseCodeEnum.COMMENT_WAIT_EXAMINE);

        return Response.success();
    }

    /**
     * 查询页面所有评论
     *
     * @param findCommentListReqVO
     * @return
     */
    @Override
    public Response findCommentList(FindCommentListReqVO findCommentListReqVO) {
        // 路由地址
        String routerUrl = findCommentListReqVO.getRouterUrl();

        // 根据该路由地址下所有评论（仅查询状态正常的）
        List<CommentDO> commentDOS = commentMapper.selectByRouterUrlAndStatus(routerUrl, CommentStatusEnum.NORMAL.getCode());
        // 总评论数
        Integer total = commentDOS.size();

        List<FindCommentItemRspVO> vos = null;
        // DO 转 VO
        if (!CollectionUtils.isEmpty(commentDOS)) {
            // 一级评论
            vos = commentDOS.stream()
                    .filter(commentDO -> Objects.isNull(commentDO.getParentCommentId())) // parentCommentId 父级 ID 为空，则表示为一级评论
                    .map(commentDO -> CommentConvert.INSTANCE.convertDO2VO(commentDO))
                    .collect(Collectors.toList());

            // 循环设置评论回复数据
            vos.forEach(vo -> {
                Long commentId = vo.getId();
                List<FindCommentItemRspVO> childComments = commentDOS.stream()
                        .filter(commentDO -> Objects.equals(commentDO.getParentCommentId(), commentId)) // 过滤出一级评论下所有子评论
                        .sorted(Comparator.comparing(CommentDO::getCreateTime)) // 按发布时间升序排列
                        .map(commentDO -> {
                            FindCommentItemRspVO findPageCommentRspVO = CommentConvert.INSTANCE.convertDO2VO(commentDO);
                            Long replyCommentId = commentDO.getReplyCommentId();
                            // 若二级评论的 replayCommentId 不等于一级评论 ID, 前端则需要展示【回复 @ xxx】，需要设置回复昵称
                            if (!Objects.equals(replyCommentId, commentId)) {
                                // 设置回复用户的昵称
                                Optional<CommentDO> optionalCommentDO = commentDOS.stream()
                                        .filter(commentDO1 -> Objects.equals(commentDO1.getId(), replyCommentId)).findFirst();
                                if (optionalCommentDO.isPresent()) {
                                    findPageCommentRspVO.setReplyNickname(optionalCommentDO.get().getNickname());
                                }
                            }
                            return findPageCommentRspVO;
                        }).collect(Collectors.toList());

                vo.setChildComments(childComments);
            });
        }

        return Response.success(FindCommentListRspVO.builder()
                .total(total)
                .comments(vos)
                .build());
    }

}
