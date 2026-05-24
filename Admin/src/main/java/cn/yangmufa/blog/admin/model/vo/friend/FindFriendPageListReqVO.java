package cn.yangmufa.blog.admin.model.vo.friend;

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
 * @description: 知识库分页
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(description = "查询友链分页数据入参 VO")
public class FindFriendPageListReqVO extends BasePageQuery {

    /**
     * 友链名称
     */
    private String name;

    /**
     * 发布的起始日期
     */
    private LocalDate startDate;

    /**
     * 发布的结束日期
     */
    private LocalDate endDate;

    /**
     * 排序
     */
    private Long sort;

}
