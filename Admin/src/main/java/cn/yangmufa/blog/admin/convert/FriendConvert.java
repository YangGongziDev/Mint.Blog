package cn.yangmufa.blog.admin.convert;

import cn.yangmufa.blog.admin.model.vo.friend.FindFriendPageListRspVO;
import cn.yangmufa.blog.common.domain.dos.FriendDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 友链实体类转换
 **/
@Mapper
public interface FriendConvert {
    /**
     * 初始化 convert 实例
     */
    FriendConvert INSTANCE = Mappers.getMapper(FriendConvert.class);

    /**
     * WikiDO -> FindFriendPageListRspVO
     * @param bean
     * @return
     */
    FindFriendPageListRspVO convertDO2VO(FriendDO bean);

}
