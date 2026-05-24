package cn.yangmufa.blog.admin.model.vo.tag;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 标签修改请求参数
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "添加标签 VO")
public class UpdateTagReqVO {

    @NotNull(message = "标签 ID 不能为空")
    private Long id;

    @NotEmpty(message = "标签名称不能为空")
    private String name;

}
