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
 * @description: 更新友链排序
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "更新友链排序 VO")
public class UpdateFriendSortReqVO {

    @NotNull(message = "友链ID不能为空")
    private Long id;

    @NotNull(message = "友链排序号不能为空")
    private Integer sort;
}
