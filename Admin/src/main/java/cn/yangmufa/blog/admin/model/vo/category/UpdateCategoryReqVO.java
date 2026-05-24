package cn.yangmufa.blog.admin.model.vo.category;

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
 * @description: 删除分类
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "删除分类 VO")
public class UpdateCategoryReqVO {

    @NotNull(message = "分类 ID 不能为空")
    private Long id;

    @NotNull(message = "分类名称不能为空")
    private String name;

}
