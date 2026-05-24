package cn.yangmufa.blog.surfer.model.vo.archive;

import cn.yangmufa.blog.common.model.BasePageQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 文章归档
 **/
@Data
@Builder
@Schema(description = "文章归档分页 VO")
public class FindArchiveArticlePageListReqVO extends BasePageQuery {
}
