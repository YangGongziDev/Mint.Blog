package cn.yangmufa.blog.admin.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import cn.yangmufa.blog.admin.model.vo.dashboard.FindDashboardPVStatisticsInfoRspVO;
import cn.yangmufa.blog.admin.model.vo.dashboard.FindDashboardStatisticsInfoRspVO;
import cn.yangmufa.blog.admin.service.AdminDashboardService;
import cn.yangmufa.blog.common.constant.Constants;
import cn.yangmufa.blog.common.domain.dos.ArticleDO;
import cn.yangmufa.blog.common.domain.dos.ArticlePublishCountDO;
import cn.yangmufa.blog.common.domain.dos.StatisticsArticlePVDO;
import cn.yangmufa.blog.common.domain.mapper.ArticleMapper;
import cn.yangmufa.blog.common.domain.mapper.CategoryMapper;
import cn.yangmufa.blog.common.domain.mapper.StatisticsArticlePVMapper;
import cn.yangmufa.blog.common.domain.mapper.TagMapper;
import cn.yangmufa.blog.common.utils.Response;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 仪表盘
 **/
@Service
@Slf4j
public class AdminDashboardServiceImpl implements AdminDashboardService {

    @Autowired
    private ArticleMapper articleMapper;
    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private TagMapper tagMapper;
    @Autowired
    private StatisticsArticlePVMapper articlePVMapper;

    /**
     * 获取仪表盘基础统计信息
     *
     * @return
     */
    @Override
    public Response findDashboardStatistics() {
        // 查询文章总数
        Long articleTotalCount = articleMapper.selectCount(Wrappers.emptyWrapper());

        // 查询分类总数
        Long categoryTotalCount = categoryMapper.selectCount(Wrappers.emptyWrapper());

        // 查询标签总数
        Long tagTotalCount = tagMapper.selectCount(Wrappers.emptyWrapper());

        // 总浏览量
        List<ArticleDO> articleDOS = articleMapper.selectAllReadNum();
        Long pvTotalCount = 0L;

        if (!CollectionUtils.isEmpty(articleDOS)) {
            // 所有 read_num 相加
            pvTotalCount = articleDOS.stream().mapToLong(ArticleDO::getReadNum).sum();
        }

        // 组装 VO 类
        FindDashboardStatisticsInfoRspVO vo = FindDashboardStatisticsInfoRspVO.builder()
                .articleTotalCount(articleTotalCount)
                .categoryTotalCount(categoryTotalCount)
                .tagTotalCount(tagTotalCount)
                .pvTotalCount(pvTotalCount)
                .build();

        return Response.success(vo);
    }

    /**
     * 获取文章发布热点统计信息
     *
     * @return
     */
    @Override
    public Response findDashboardPublishArticleStatistics() {
        // 当前日期
        LocalDate currDate = LocalDate.now();

        // 当前日期倒退一年的日期
        LocalDate startDate = currDate.minusYears(1);

        // 查找这一年内，每日发布的文章数量
        List<ArticlePublishCountDO> articlePublishCountDOS = articleMapper.selectDateArticlePublishCount(startDate, currDate.plusDays(1));

        Map<LocalDate, Long> map = null;
        if (!CollectionUtils.isEmpty(articlePublishCountDOS)) {
            // DO 转 Map
            Map<LocalDate, Long> dateArticleCountMap = articlePublishCountDOS.stream()
                    .collect(Collectors.toMap(ArticlePublishCountDO::getDate, ArticlePublishCountDO::getCount));

            // 有序 Map, 返回的日期文章数需要以升序排列
            map = Maps.newLinkedHashMap();
            // 从上一年的今天循环到今天
            for (; startDate.isBefore(currDate) || startDate.isEqual(currDate); startDate = startDate.plusDays(1)) {
                // 以日期作为 key 从 dateArticleCountMap 中取文章发布总量
                Long count = dateArticleCountMap.get(startDate);
                // 设置到返参 Map
                map.put(startDate, Objects.isNull(count) ? 0 : count);
            }
        }

        return Response.success(map);
    }

    /**
     * 获取文章最近一周 PV 访问量统计信息
     *
     * @return
     */
    @Override
    public Response findDashboardPVStatistics() {
        // 查询最近一周的 PV 访问量记录
        List<StatisticsArticlePVDO> articlePVDOS = articlePVMapper.selectLatestWeekRecords();

        FindDashboardPVStatisticsInfoRspVO vo = null;
        if (!CollectionUtils.isEmpty(articlePVDOS)) {
            // 转 Map, 方便后续通过日期获取 PV 访问量
            Map<LocalDate, Long> pvDateCountMap = articlePVDOS.stream()
                    .collect(Collectors.toMap(StatisticsArticlePVDO::getPvDate, StatisticsArticlePVDO::getPvCount));

            // 日期集合
            List<String> pvDates = Lists.newArrayList();
            // PV 集合
            List<Long> pvCounts = Lists.newArrayList();

            // 当前日期
            LocalDate currDate = LocalDate.now();
            // 一周前
            LocalDate tmpDate = currDate.minusWeeks(1);
            // 从一周前开始循环
            for (; tmpDate.isBefore(currDate) || tmpDate.isEqual(currDate); tmpDate = tmpDate.plusDays(1)) {
                // 设置对应日期的 PV 访问量
                pvDates.add(tmpDate.format(Constants.MONTH_DAY_FORMATTER));
                Long pvCount = pvDateCountMap.get(tmpDate);
                pvCounts.add(Objects.isNull(pvCount) ? 0 : pvCount);
            }

            vo = FindDashboardPVStatisticsInfoRspVO.builder()
                    .pvDates(pvDates)
                    .pvCounts(pvCounts)
                    .build();
        }

        return Response.success(vo);
    }
}
