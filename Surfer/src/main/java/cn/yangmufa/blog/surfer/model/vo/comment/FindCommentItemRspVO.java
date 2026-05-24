package cn.yangmufa.blog.surfer.model.vo.comment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 查询评论
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FindCommentItemRspVO {

    /**
     * 主键
     */
    private Long id;

    /**
     * 头像
     */
    private String avatar;

    /**
     * 昵称
     */
    private String nickname;

    /**
     * 网址
     */
    private String website;

    /**
     * 评论内容
     */
    private String content;

    /**
     * 发布时间
     */
    private LocalDateTime createTime;

    /**
     * 回复用户的昵称
     */
    private String replyNickname;

    /**
     * 子评论集合
     */
    private List<FindCommentItemRspVO> childComments;

    /**
     * 是否展示回复表单（默认 false）
     */
    private Boolean isShowReplyForm;

}
