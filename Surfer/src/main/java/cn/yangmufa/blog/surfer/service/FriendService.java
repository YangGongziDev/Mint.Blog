package cn.yangmufa.blog.surfer.service;

import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.model.vo.article.FindFriendDetailReqVO;
import cn.yangmufa.blog.surfer.model.vo.article.FindIndexFriendPageListReqVO;
import cn.yangmufa.blog.surfer.model.vo.article.FriendAddReqVO;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 友链
 **/
public interface FriendService {

    /**
     * 获取首页文章分页数据
     * @param findIndexFriendPageListReqVO
     * @return
     */
    Response findFriendPageList(FindIndexFriendPageListReqVO findIndexFriendPageListReqVO);

    /**
     * 获取文章详情
     * @param findFriendDetailReqVO
     * @return
     */
    Response findFriendDetail(FindFriendDetailReqVO findFriendDetailReqVO);

    /**
     * 提交友链
     * @param findFriendDetailReqVO
     * @return
     */
    Response applyFriend(FriendAddReqVO findFriendDetailReqVO);
}