package cn.yangmufa.blog.surfer.model.vo.category;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 分类列表
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FindCategoryListReqVO {

    /**
     * 展示数量
     */
    private Long size;

}
