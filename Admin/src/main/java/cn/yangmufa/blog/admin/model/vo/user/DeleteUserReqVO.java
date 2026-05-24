package cn.yangmufa.blog.admin.model.vo.user;

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
 * @description: 删除用户
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "删除用户 VO")
public class DeleteUserReqVO {

    @NotNull(message = "分类 ID 不能为空")
    private Long id;

    /**
     * 删除类型
     * 1: 逻辑删除
     * 2: 物理删除
     * 3: 取消删除
     */
    @NotNull(message = "删除类型不能为空")
    private Long deleteType;

}
