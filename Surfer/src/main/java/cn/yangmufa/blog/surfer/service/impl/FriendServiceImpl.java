package cn.yangmufa.blog.surfer.service.impl;

import cn.yangmufa.blog.common.domain.dos.*;
import cn.yangmufa.blog.common.domain.mapper.*;
import cn.yangmufa.blog.common.enums.ResponseCodeEnum;
import cn.yangmufa.blog.common.exception.BizException;
import cn.yangmufa.blog.common.utils.PageResponse;
import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.convert.FriendConvert;
import cn.yangmufa.blog.surfer.model.vo.article.*;
import cn.yangmufa.blog.surfer.service.FriendService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 友链
 **/
@Service
@Slf4j
public class FriendServiceImpl implements FriendService {

    @Autowired
    private FriendMapper friendMapper;

    /**
     * 获取首页文章分页数据
     *
     * @param findIndexFriendPageListReqVO
     * @return
     */
    @Override
    public Response findFriendPageList(FindIndexFriendPageListReqVO findIndexFriendPageListReqVO) {

        Long current = findIndexFriendPageListReqVO.getCurrent();
        Long size = findIndexFriendPageListReqVO.getSize();

        // 第一步：分页查询友链记录
        Page<FriendDO> friendDOPage = friendMapper.selectPageList(current, size, null, null, null, null);

        // 返回的分页数据
        List<FriendDO> friendDOS = friendDOPage.getRecords();

        List<FindIndexFriendPageListRspVO> vos = Lists.newArrayList();

        if (!CollectionUtils.isEmpty(friendDOS)) {
            // 友链 DO 转 VO
            vos = friendDOS.stream()
                    .map(FriendConvert.INSTANCE::convertDO2VO)
                    .collect(Collectors.toList());
        }

        return PageResponse.success(friendDOPage, vos);
    }

    /**
     * 获取友链详情
     *
     * @param findFriendDetailReqVO
     * @return
     */
    @Override
    public Response findFriendDetail(FindFriendDetailReqVO findFriendDetailReqVO) {

        Long friendId = findFriendDetailReqVO.getFriendId();

        FriendDO friendDO = friendMapper.selectById(friendId);

        // 判断友链是否存在
        if (Objects.isNull(friendDO)) {
            log.warn("==> 该友链不存在, friendId: {}", friendId);
            throw new BizException(ResponseCodeEnum.RESOURCE_NOT_FOUND);
        }

        // DO 转 VO
        FindIndexFriendPageListRspVO vo = FriendConvert.INSTANCE.convertDO2VO(friendDO);

        return Response.success(vo);
    }

    /**
     * 提交友链
     *
     * @param friendAddReqVO
     * @return
     */
    @Override
    public Response applyFriend(FriendAddReqVO friendAddReqVO) {

        // VO 转 DO
        FriendDO friendDO = FriendDO.builder()
                .name(friendAddReqVO.getName())
                .avatar(friendAddReqVO.getAvatar())
                .category(friendAddReqVO.getCategory())
                .url(friendAddReqVO.getUrl())
                .description(friendAddReqVO.getDescription())
                .email(friendAddReqVO.getEmail())
                .sort(0)
                .isDeleted(0)
                .isTop(false)
                .status("pending") // 添加状态，默认为待审核
                .createTime(LocalDateTime.now())
                .updateTime(LocalDateTime.now())
                .build();
        friendMapper.insert(friendDO);
        return Response.success();
    }
}
