package cn.yangmufa.blog.admin.convert;

import cn.yangmufa.blog.admin.model.vo.wiki.FindWikiPageListRspVO;
import cn.yangmufa.blog.common.domain.dos.WikiDO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 知识库实体类转换
 **/
@Mapper
public interface WikiConvert {
    /**
     * 初始化 convert 实例
     */
    WikiConvert INSTANCE = Mappers.getMapper(WikiConvert.class);

    /**
     * WikiDO -> FindFriendPageListRspVO
     * @param bean
     * @return
     */
    @Mapping(target = "isTop", expression = "java(bean.getWeight() > 0)")
    @Mapping(source = "weight", target = "weight")
    FindWikiPageListRspVO convertDO2VO(WikiDO bean);

}
