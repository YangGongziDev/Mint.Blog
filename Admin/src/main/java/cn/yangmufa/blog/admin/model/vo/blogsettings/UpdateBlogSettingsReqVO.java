package cn.yangmufa.blog.admin.model.vo.blogsettings;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 博客基础信息修改
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = " 博客基础信息修改 VO")
public class UpdateBlogSettingsReqVO {

    @NotBlank(message = "博客 LOGO 不能为空")
    private String logo;

    @NotBlank(message = "博客名称不能为空")
    private String name;

    @NotBlank(message = "博客作者不能为空")
    private String author;

    @NotBlank(message = "博客介绍语不能为空")
    private String introduction;

    private String copyrightDeclaration;

    @NotBlank(message = "博客头像不能为空")
    private String avatar;

    private String githubHomepage;

    private String csdnHomepage;

    private String giteeHomepage;

    private String zhihuHomepage;

    @Email(message = "邮箱格式不正确")
    private String mail;

    @NotNull(message = "请设置评论敏感词过滤是否开启")
    private Boolean isCommentSensiWordOpen;

    @NotNull(message = "请设置评论审核是否开启")
    private Boolean isCommentExamineOpen;

    private Boolean isAutoTheme;
}