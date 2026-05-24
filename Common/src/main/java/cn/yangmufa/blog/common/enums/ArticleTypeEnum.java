package cn.yangmufa.blog.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 文章类型
 **/
@Getter
@AllArgsConstructor
public enum ArticleTypeEnum {

    NORMAL(1, "普通"),
    WIKI(2, "收录于知识库");

    private Integer value;
    private String description;

}
