package cn.yangmufa.blog.common.domain.mapper;

import cn.yangmufa.blog.common.domain.dos.FriendDO;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 友链
 **/
public interface FriendMapper extends BaseMapper<FriendDO> {

    /**
     * 分页查询
     * @param current
     * @param size
     * @param name
     * @param startDate
     * @param endDate
     * @param isPublish
     * @return
     */
    default Page<FriendDO> selectPageList(Long current, Long size, String name, LocalDate startDate, LocalDate endDate, Boolean isPublish) {
        // 分页对象(查询第几页、每页多少数据)
        Page<FriendDO> page = new Page<>(current, size);

        // 构建查询条件
        LambdaQueryWrapper<FriendDO> wrapper = Wrappers.<FriendDO>lambdaQuery()
                .like(StringUtils.isNotBlank(name), FriendDO::getName, name) // like 模块查询
                .ge(Objects.nonNull(startDate), FriendDO::getCreateTime, startDate) // 大于等于 startDate
                .le(Objects.nonNull(endDate), FriendDO::getCreateTime, endDate)  // 小于等于 endDate
                .eq(Objects.nonNull(isPublish), FriendDO::getStatus, "active") // 发布状态
                .orderByDesc(FriendDO::getSort) // 按排序值倒序
                .orderByDesc(FriendDO::getCreateTime); // 按创建时间倒叙

        return selectPage(page, wrapper);
    }

    /**
     * 查询已审核的友链
     * @return
     */
    default List<FriendDO> selecStatusActive() {
        return selectList(Wrappers.<FriendDO>lambdaQuery()
                .eq(FriendDO::getStatus, "active") // 查询已审核的
                .orderByDesc(FriendDO::getSort) // 按权重降序
                .orderByDesc(FriendDO::getCreateTime) // 按发布时间降序
        );
    }

    /**
     * 查询知识库标签排序值最大的一条分类数据
     * @return
     */
    default FriendDO selectMaxSortFriend() {
        return selectOne(Wrappers.<FriendDO>lambdaQuery()
                .orderByDesc(FriendDO::getSort) // 根据排序值降序
                .last("LIMIT 1"));
    }

    /**
     * 查询知识库标签排序值最小的一条分类数据
     * @return
     */
    default FriendDO selectMinSortFriend() {
        return selectOne(Wrappers.<FriendDO>lambdaQuery()
                .orderByAsc(FriendDO::getSort) // 根据排序值升序
                .last("LIMIT 1"));
    }

}