package cn.yangmufa.blog.common.domain.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import cn.yangmufa.blog.common.domain.dos.StatisticsArticlePVDO;

import java.time.LocalDate;
import java.util.List;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 每日文章 PV 访问量统计
 **/
public interface StatisticsArticlePVMapper extends BaseMapper<StatisticsArticlePVDO> {

    /**
     * 对指定日期的文章 PV 访问量进行 +1
     * @param date
     * @return
     */
    default int increasePVCount(LocalDate date) {
        return update(null, Wrappers.<StatisticsArticlePVDO>lambdaUpdate()
                .setSql("pv_count = pv_count + 1")
                .eq(StatisticsArticlePVDO::getPvDate, date));
    }

    /**
     * 查询最近一周的文章 PV 访问量记录
     * @return
     */
    default List<StatisticsArticlePVDO> selectLatestWeekRecords() {
        return selectList(Wrappers.<StatisticsArticlePVDO>lambdaQuery()
                .le(StatisticsArticlePVDO::getPvDate, LocalDate.now()) // 小于等于当前日期
                .last("limit 7")); // 仅查询七条
    }
}
