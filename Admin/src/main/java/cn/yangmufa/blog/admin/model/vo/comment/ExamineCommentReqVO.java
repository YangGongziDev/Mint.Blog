package cn.yangmufa.blog.admin.model.vo.comment;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 评论审核
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "评论审核 VO")
public class ExamineCommentReqVO {

    @NotNull(message = "评论 ID 不能为空")
    private Long id;

    @NotNull(message = "评论状态不能为空")
    private Integer status;

    /**
     * 原因
     */
    private String reason;
}
