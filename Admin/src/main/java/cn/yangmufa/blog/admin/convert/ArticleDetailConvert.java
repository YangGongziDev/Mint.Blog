package cn.yangmufa.blog.admin.convert;

import cn.yangmufa.blog.admin.model.vo.article.FindArticleDetailRspVO;
import cn.yangmufa.blog.common.domain.dos.ArticleDO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 文章详情转换
 **/
@Mapper
public interface ArticleDetailConvert {
    /**
     * 初始化 convert 实例
     */
    ArticleDetailConvert INSTANCE = Mappers.getMapper(ArticleDetailConvert.class);

    /**
     * 将 DO 转化为 VO
     * @param bean
     * @return
     */
    @Mapping(source = "isDeleted", target = "isDeleted")
    FindArticleDetailRspVO convertDO2VO(ArticleDO bean);

}