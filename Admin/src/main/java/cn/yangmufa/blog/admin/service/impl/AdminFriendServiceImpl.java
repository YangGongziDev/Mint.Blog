package cn.yangmufa.blog.admin.service.impl;

import cn.yangmufa.blog.admin.convert.FriendConvert;
import cn.yangmufa.blog.admin.model.vo.friend.*;
import cn.yangmufa.blog.admin.model.vo.wiki.*;
import cn.yangmufa.blog.admin.service.AdminFriendService;
import cn.yangmufa.blog.common.domain.dos.FriendDO;
import cn.yangmufa.blog.common.domain.mapper.FriendMapper;
import cn.yangmufa.blog.common.enums.ResponseCodeEnum;
import cn.yangmufa.blog.common.exception.BizException;
import cn.yangmufa.blog.common.utils.PageResponse;
import cn.yangmufa.blog.common.utils.Response;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 友链
 **/
@Service
@Slf4j
public class AdminFriendServiceImpl implements AdminFriendService {


    @Autowired
    private FriendMapper friendMapper;

    /**
     * 新增友链
     *
     * @param addFriendReqVO
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response addFriend(AddFriendReqVO addFriendReqVO) {
        // VO 转 DO
        FriendDO friendDO = FriendDO.builder()
                .name(addFriendReqVO.getName())
                .avatar(addFriendReqVO.getAvatar())
                .category(addFriendReqVO.getCategory())
                .url(addFriendReqVO.getUrl())
                .description(addFriendReqVO.getDescription())
                .email(addFriendReqVO.getEmail())
                .sort(0)
                .isDeleted(0)
                .isTop(false)
                .status("active") // 管理员添加的友链默认已审核通过
                .createTime(LocalDateTime.now())
                .updateTime(LocalDateTime.now())
                .build();
        friendMapper.insert(friendDO);
        return Response.success();
    }

    /**
     * 删除友链
     *
     * @param deleteFriendReqVO
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response deleteFriend(DeleteFriendReqVO deleteFriendReqVO) {

        Long friendId = deleteFriendReqVO.getId();
        Long deleteType = deleteFriendReqVO.getDeleteType();

        if (deleteType == 1 || deleteType == 3){
            // 1. VO 转 FriendDO, 并更新
            FriendDO friendDO = FriendDO.builder()
                    .id(friendId)
                    .isDeleted(deleteType == 1 ? 1 : 0)
                    .build();
            int count = friendMapper.updateById(friendDO);
            // 根据更新是否成功，来判断该友链是否存在
            if (count == 0) {
                log.warn("==> 该友链不存在, friendId: {}", friendId);
                throw new BizException(ResponseCodeEnum.ARTICLE_NOT_FOUND);
            }
            return Response.success();
        }

        // 删除友链
        int count = friendMapper.deleteById(friendId);
        // 若友链不存在
        if (count == 0) {
            log.warn("该友链不存在, FriendId: {}", friendId);
            throw new BizException(ResponseCodeEnum.RESOURCE_NOT_FOUND);
        }
        return Response.success();
    }

    /**
     * 友链分页查询
     * @param findFriendPageListReqVO
     * @return
     */
    @Override
    public Response findFriendPageList(FindFriendPageListReqVO findFriendPageListReqVO) {

        // 获取当前页、以及每页需要展示的数据数量
        Long current = findFriendPageListReqVO.getCurrent();
        Long size = findFriendPageListReqVO.getSize();
        // 查询条件
        String name = findFriendPageListReqVO.getName();
        LocalDate startDate = findFriendPageListReqVO.getStartDate();
        LocalDate endDate = findFriendPageListReqVO.getEndDate();

        // 执行分页查询
        Page<FriendDO> friendDOPage = friendMapper.selectPageList(current, size, name, startDate, endDate, null);

        // 获取查询记录
        List<FriendDO> friendDOS = friendDOPage.getRecords();

        // DO 转 VO
        List<FindFriendPageListRspVO> vos = null;
        if (!CollectionUtils.isEmpty(friendDOS)) {
            vos = friendDOS.stream()
                    .map(friendDO -> FriendConvert.INSTANCE.convertDO2VO(friendDO))
                    .collect(Collectors.toList());
        }

        return PageResponse.success(friendDOPage, vos);
    }

    /**
     * 更新友链置顶状态
     *
     * @param updateFriendIsTopReqVO
     * @return
     */
    @Override
    public Response updateFriendIsTop(UpdateFriendIsTopReqVO updateFriendIsTopReqVO) {

        Long friendId = updateFriendIsTopReqVO.getId();
        Boolean isTop = updateFriendIsTopReqVO.getIsTop();

        // 更新该友链的权重值
        friendMapper.updateById(FriendDO.builder().id(friendId).isTop(isTop).build());
        return Response.success();
    }

    /**
     * 设置文章分类排序设置最前
     *
     * @return
     */
    @Override
    public Response updateFriendSortFirst(UpdateFriendSortReqVO updateFriendSortReqVO) {

        // 查找出最大排序值
        FriendDO maxSort = friendMapper.selectMaxSortFriend();
        // 更新分类排序
        friendMapper.updateById(FriendDO.builder().id(updateFriendSortReqVO.getId()).sort(maxSort.getSort() + 1).build());
        return Response.success();
    }

    /**
     * 设置文章分类排序设置最后
     *
     * @return
     */
    @Override
    public Response updateFriendSortLast(UpdateFriendSortReqVO updateFriendSortReqVO) {
        // 查找出最小排序值
        FriendDO minSort = friendMapper.selectMinSortFriend();
        if (minSort.getSort() > 0){
            // 更新分类排序
            friendMapper.updateById(FriendDO.builder().id(updateFriendSortReqVO.getId()).sort(minSort.getSort() - 1).build());
            return Response.success();
        } else {
            friendMapper.updateById(FriendDO.builder().id(updateFriendSortReqVO.getId()).sort(0).build());
            return Response.success();
        }
    }

    /**
     * 更新友链审核状态
     *
     * @param updateFriendIsPublishReqVO
     * @return
     */
    @Override
    public Response updateFriendStatus(UpdateFriendIsPublishReqVO updateFriendIsPublishReqVO) {
        Long friendId = updateFriendIsPublishReqVO.getId();
        String status = updateFriendIsPublishReqVO.getStatus();
        // 更新发布状态
        friendMapper.updateById(FriendDO.builder().id(friendId).status(status).build());
        return Response.success();
    }

    /**
     * 更新友链
     *
     * @param updateFriendReqVO
     * @return
     */
    @Override
    public Response updateFriend(UpdateFriendReqVO updateFriendReqVO) {
        // VO 转 DO
        FriendDO friendDO = FriendDO.builder()
                .id(updateFriendReqVO.getId())
                .name(updateFriendReqVO.getName())
                .avatar(updateFriendReqVO.getAvatar())
                .category(updateFriendReqVO.getCategory())
                .url(updateFriendReqVO.getUrl())
                .description(updateFriendReqVO.getDescription())
                .email(updateFriendReqVO.getEmail())
                .updateTime(LocalDateTime.now())
                .build();

        // 根据 ID 更新友链
        friendMapper.updateById(friendDO);
        return Response.success();
    }

    /**
     * 更新友链排序
     * @param updateFriendSortReqVO
     *
     * @return
     */
    @Override
    public Response updateFriendSort(UpdateFriendSortReqVO updateFriendSortReqVO) {
        Long friendId = updateFriendSortReqVO.getId();
        Integer sort = updateFriendSortReqVO.getSort();
        friendMapper.updateById(FriendDO.builder().id(friendId).sort(sort).build());
        return Response.success();
    }

}
