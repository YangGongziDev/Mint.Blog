package cn.yangmufa.blog.surfer.model.vo.article;

import cn.yangmufa.blog.common.model.BasePageQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 友链分页
 **/
@Data
@Builder
@Schema(description = "查询友链分页 VO")
public class FindIndexFriendPageListReqVO extends BasePageQuery {
}
