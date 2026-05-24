package cn.yangmufa.blog.admin.model.vo.tag;

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
 * @description: 更新标签库排序
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "更新标签排序 VO")
public class UpdateTagSortReqVO {

    @NotNull(message = "标签ID不能为空")
    private Long id;

    @NotNull(message = "标签排序号不能为空")
    private Integer sort;
}
