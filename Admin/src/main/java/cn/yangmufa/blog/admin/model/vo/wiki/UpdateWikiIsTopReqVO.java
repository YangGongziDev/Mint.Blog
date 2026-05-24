package cn.yangmufa.blog.admin.model.vo.wiki;

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
 * @description: 更新知识库置顶状态
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "更新知识库置顶状态 VO")
public class UpdateWikiIsTopReqVO {

    @NotNull(message = "知识库 ID 不能为空")
    private Long id;

    @NotNull(message = "知识库置顶状态不能为空")
    private Boolean isTop;
}
