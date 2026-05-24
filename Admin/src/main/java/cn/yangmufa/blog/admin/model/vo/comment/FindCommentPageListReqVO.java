package cn.yangmufa.blog.admin.model.vo.comment;

import cn.yangmufa.blog.common.model.BasePageQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 评论分页
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "查询评论分页数据入参 VO")
public class FindCommentPageListReqVO extends BasePageQuery {

    /**
     * 路由地址
     */
    private String routerUrl;

    /**
     * 发布的起始日期
     */
    private LocalDate startDate;

    /**
     * 发布的结束日期
     */
    private LocalDate endDate;

    /**
     * 状态
     */
    private Integer status;
}
