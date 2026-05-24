package cn.yangmufa.blog.admin.model.vo.friend;

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
 * @description: 友链审核状态
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "更新友链审核状态 VO")
public class UpdateFriendIsPublishReqVO {

    @NotNull(message = "友链 ID 不能为空")
    private Long id;

    @NotNull(message = "友链状态不能为空")
    private String status;
}
