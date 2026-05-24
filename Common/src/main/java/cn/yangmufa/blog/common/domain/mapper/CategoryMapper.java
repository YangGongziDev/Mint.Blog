package cn.yangmufa.blog.common.domain.mapper;

import cn.yangmufa.blog.common.domain.dos.TagDO;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import cn.yangmufa.blog.common.domain.dos.CategoryDO;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: TODO
 **/
public interface CategoryMapper extends BaseMapper<CategoryDO> {

    /**
     * 查询分类分页数据
     * @return
     */
    default Page<CategoryDO> selectPageList(long current, long size, String name, LocalDate startDate, LocalDate endDate) {
        // 分页对象(查询第几页、每页多少数据)
        Page<CategoryDO> page = new Page<>(current, size);

        // 构建查询条件
        LambdaQueryWrapper<CategoryDO> wrapper = new LambdaQueryWrapper<>();

        wrapper
                .like(StringUtils.isNotBlank(name), CategoryDO::getName, name.trim()) // like 模块查询
                .ge(Objects.nonNull(startDate), CategoryDO::getCreateTime, startDate) // 大于等于 startDate
                .le(Objects.nonNull(endDate), CategoryDO::getCreateTime, endDate)  // 小于等于 endDate
                .orderByDesc(CategoryDO::getCreateTime); // 按创建时间倒叙

        return selectPage(page, wrapper);
    }

    /**
     * 根据分类模糊查询
     * @param key
     * @return
     */
    default List<CategoryDO> selectByKey(String key) {
        LambdaQueryWrapper<CategoryDO> wrapper = new LambdaQueryWrapper<>();

        // 构造模糊查询的条件
        wrapper.like(CategoryDO::getName, key).orderByDesc(CategoryDO::getCreateTime);

        return selectList(wrapper);
    }

    /**
     * 根据用户名查询
     * @param categoryName
     * @return
     */
    default CategoryDO selectByName(String categoryName) {
        // 构建查询条件
        LambdaQueryWrapper<CategoryDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CategoryDO::getName, categoryName);

        // 执行查询
        return selectOne(wrapper);
    }

    /**
     * 查询时指定数量
     * @param limit
     * @return
     */
    default List<CategoryDO> selectByLimit(Long limit) {
        return selectList(Wrappers.<CategoryDO>lambdaQuery()
                .orderByDesc(CategoryDO::getArticlesTotal) // 根据文章总数降序
                .last(String.format("LIMIT %d", limit))); // 查询指定数量
    }

    /**
     * 查询文章分类排序值最大的一条分类数据
     * @return
     */
    default CategoryDO selectMaxSortCategory() {
        return selectOne(Wrappers.<CategoryDO>lambdaQuery()
                .orderByDesc(CategoryDO::getSort) // 根据排序值降序
                .last("LIMIT 1"));
    }

    /**
     * 查询文章分类排序值最小的一条分类数据
     * @return
     */
    default CategoryDO selectMinSortCategory() {
        return selectOne(Wrappers.<CategoryDO>lambdaQuery()
                .orderByAsc(CategoryDO::getSort) // 根据排序值升序
                .last("LIMIT 1"));
    }
}
