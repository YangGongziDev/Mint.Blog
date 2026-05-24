package cn.yangmufa.blog.admin.model.vo.wiki;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 新增知识库
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "新增知识库 VO")
public class AddWikiReqVO {

    @NotBlank(message = "知识库标题不能为空")
    @Length(min = 1, max = 20, message = "知识库标题字数需大于 1 小于 20")
    private String title;

    @NotBlank(message = "知识库摘要不能为空")
    private String summary;

    @NotBlank(message = "知识库封面不能为空")
    private String cover;

}
