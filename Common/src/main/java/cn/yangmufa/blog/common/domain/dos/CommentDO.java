package cn.yangmufa.blog.common.domain.dos;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 评论
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@TableName("r_comment")
public class CommentDO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String content;

    private String avatar;

    private String nickname;

    private String mail;

    private String website;

    private String routerUrl;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    private Integer isDeleted;

    private Long replyCommentId;

    private Long parentCommentId;

    private Integer status;

    private String reason;
}
