package cn.yangmufa.blog.admin.model.vo.friend;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

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
public class UpdateFriendReqVO {

    @NotNull(message = "ID 不能为空")
    private Long id;

    @NotBlank(message = "友链名称不能为空")
    private String name;

    @NotBlank(message = "友链描述不能为空")
    private String description;

    @NotBlank(message = "友链URL不能为空")
    private String url;

    @NotBlank(message = "友链头像Logo不能为空")
    private String avatar;

    @NotBlank(message = "友链分类不能为空")
    private String category;

    private String email;

}
