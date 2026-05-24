package cn.yangmufa.blog.surfer.convert;

import cn.yangmufa.blog.common.domain.dos.FriendDO;
import cn.yangmufa.blog.surfer.model.vo.article.FindIndexFriendPageListRspVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 友链转换
 **/
@Mapper
public interface FriendConvert {
    /**
     * 初始化 convert 实例
     */
    FriendConvert INSTANCE = Mappers.getMapper(FriendConvert.class);

    /**
     * FriendDO -> FindIndexFriendPageListRspVO
     * @param bean
     * @return
     */
    FindIndexFriendPageListRspVO convertDO2VO(FriendDO bean);
}