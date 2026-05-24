package cn.yangmufa.blog.admin.service;

import cn.yangmufa.blog.admin.model.vo.friend.*;
import cn.yangmufa.blog.common.utils.Response;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 友链
 **/
public interface AdminFriendService {

    /**
     * 新增友链
     * @param addFriendReqVO
     * @return
     */
    Response addFriend(AddFriendReqVO addFriendReqVO);

    /**
     * 删除友链
     * @param deleteFriendReqVO
     * @return
     */
    Response deleteFriend(DeleteFriendReqVO deleteFriendReqVO);

    /**
     * 友链分页查询
     * @param findFriendPageListReqVO
     * @return
     */
    Response findFriendPageList(FindFriendPageListReqVO findFriendPageListReqVO);

    /**
     * 更新友链置顶状态
     * @param updateFriendIsTopReqVO
     * @return
     */
    Response updateFriendIsTop(UpdateFriendIsTopReqVO updateFriendIsTopReqVO);

    /**
     * 设置标签类排序 设置最前
     * @return
     */
    Response updateFriendSortFirst(UpdateFriendSortReqVO updateFriendSortReqVO);

    /**
     * 设置友链排序 设置最后
     * @return
     */
    Response updateFriendSortLast(UpdateFriendSortReqVO updateFriendSortReqVO);

    /**
     * 更新友链审核状态
     * @param updateFriendIsPublishReqVO
     * @return
     */
    Response updateFriendStatus(UpdateFriendIsPublishReqVO updateFriendIsPublishReqVO);

    /**
     * 更新友链
     * @param updateFriendReqVO
     * @return
     */
    Response updateFriend(UpdateFriendReqVO updateFriendReqVO);

    /**
     * 新增友链目录
     * @param updateFriendSortReqVO
     * @return
     */
    Response updateFriendSort(UpdateFriendSortReqVO updateFriendSortReqVO);

}
