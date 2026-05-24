package cn.yangmufa.blog.surfer.event.subscriber;

import cn.yangmufa.blog.common.domain.dos.BlogSettingsDO;
import cn.yangmufa.blog.common.domain.dos.CommentDO;
import cn.yangmufa.blog.common.domain.mapper.BlogSettingsMapper;
import cn.yangmufa.blog.common.domain.mapper.CommentMapper;
import cn.yangmufa.blog.common.enums.CommentStatusEnum;
import cn.yangmufa.blog.common.mail.MailHelper;
import cn.yangmufa.blog.surfer.event.PublishCommentEvent;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.util.Objects;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: TODO
 **/
@Component
@Slf4j
public class PublishCommentSubscriber implements ApplicationListener<PublishCommentEvent> {

    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private BlogSettingsMapper blogSettingsMapper;
    @Autowired
    private MailHelper mailHelper;

    @Override
    @Async("threadPoolTaskExecutor")
    public void onApplicationEvent(PublishCommentEvent event) {
        // 在这里处理收到的事件，可以是任何逻辑操作
        Long commentId = event.getCommentId();

        // 获取当前线程名称
        String threadName = Thread.currentThread().getName();

        log.info("==> threadName: {}", threadName);
        log.info("==> 评论发布事件消费成功，commentId: {}", commentId);

        CommentDO commentDO = commentMapper.selectById(commentId);
        Long replyCommentId = commentDO.getReplyCommentId();
        String nickname = commentDO.getNickname();
        String content = commentDO.getContent();
        Integer status = commentDO.getStatus();

        // 获取博客设置相关信息
        BlogSettingsDO blogSettingsDO = blogSettingsMapper.selectById(1L);
        // 博客名称
        String blogName = blogSettingsDO.getName();
        // 博主邮箱
        String authorMail = blogSettingsDO.getMail();
        // 是否需要审核
        boolean isCommentExamineOpen = blogSettingsDO.getIsCommentExamineOpen();
        // 是否开启了敏感词过滤
        boolean isSensiWordOpen = blogSettingsDO.getIsCommentSensiWordOpen();
        // 博客访问地址
        String domain = "http://116.62.199.48/#";

        // 二级评论，并且状态为 “正常”, 邮件通知被评论的用户
        if (Objects.nonNull(replyCommentId)
                && Objects.equals(status, CommentStatusEnum.NORMAL.getCode())) {
            CommentDO replyCommentDO = commentMapper.selectById(replyCommentId);

            String to = replyCommentDO.getMail();

            String routerUrl = replyCommentDO.getRouterUrl();
            String title = String.format("你在%s的评论收到了回复", blogName);

            // 构建 HTML
            String html = String.format("<html><body>" +
                            "<h2>你的评论:</h2><p>%s</p>" +
                            "<h2>%s 回复了你:</h2><p>%s</p>" +
                            "<p><a href='%s%s' target='_blank'>查看详情</a></p>" +
                            "</body></html>",
                    replyCommentDO.getContent(), nickname, content, domain, routerUrl);
            // 发送邮件
            mailHelper.sendHtml(to, title, html);
        } else if (Objects.isNull(replyCommentId)
                && StringUtils.isNotBlank(authorMail)) { // 一级评论, 需要通知到博主
            String routerUrl = commentDO.getRouterUrl();
            String title = String.format("%s收到了评论", blogName);

            // 如果开启了评论审核，并且当前评论状态为 "待审核"，标题后缀添加【待审核】标识
            if (isCommentExamineOpen && Objects.equals(status, CommentStatusEnum.WAIT_EXAMINE.getCode())) {
                title = title + "【待审核】";
            }

            // 如果开启了敏感词过滤，并且当前评论状态为 "审核不通过"，标题后缀添加【系统已拦截】标识
            if (isSensiWordOpen && Objects.equals(status, CommentStatusEnum.EXAMINE_FAILED.getCode())) {
                title = title + "【系统已拦截】";
            }

            // 构建 HTML
            String html = String.format("<html><body>" +
                            "<h2>路由:</h2><p>%s</p>" +
                            "<h2>%s 评论了你:</h2><p>%s</p>" +
                            "<p><a href='%s%s' target='_blank'>查看详情</a></p>" +
                            "</body></html>",
                    routerUrl, nickname, commentDO.getContent(), domain, routerUrl);
            // 发送邮件
            mailHelper.sendHtml(authorMail, title, html);
        }

    }
}