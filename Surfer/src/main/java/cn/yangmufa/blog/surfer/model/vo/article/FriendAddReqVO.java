package cn.yangmufa.blog.surfer.model.vo.article;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 更新知识库
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "更新友链 VO")
public class FriendAddReqVO {

    @NotBlank(message = "友链名称不能为空")
    @Length(min = 1, max = 20, message = "友链标题字数需大于 1 小于 20")
    private String name;

    @NotBlank(message = "友链头像logo不能为空")
    private String avatar;

    @NotBlank(message = "友链分类不能为空")
    private String category;

    @NotBlank(message = "友链URL不能为空")
    private String url;

    @NotBlank(message = "友链描述不能为空")
    private String description;

    private String email;

}
