package cn.yangmufa.blog.admin.model.vo.category;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 标签模糊查询
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "标签模糊查询 VO")
public class SearchCategorysReqVO {

    @NotBlank(message = "分类查询关键词不能为空")
    private String key;

}
