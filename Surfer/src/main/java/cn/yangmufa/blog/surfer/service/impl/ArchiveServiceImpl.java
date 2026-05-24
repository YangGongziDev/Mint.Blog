package cn.yangmufa.blog.surfer.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.google.common.collect.Lists;
import cn.yangmufa.blog.common.domain.dos.ArticleDO;
import cn.yangmufa.blog.common.domain.mapper.ArticleMapper;
import cn.yangmufa.blog.common.utils.PageResponse;
import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.convert.ArticleConvert;
import cn.yangmufa.blog.surfer.model.vo.archive.FindArchiveArticlePageListReqVO;
import cn.yangmufa.blog.surfer.model.vo.archive.FindArchiveArticlePageListRspVO;
import cn.yangmufa.blog.surfer.model.vo.archive.FindArchiveArticleRspVO;
import cn.yangmufa.blog.surfer.service.ArchiveService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 文章归档
 **/
@Service
@Slf4j
public class ArchiveServiceImpl implements ArchiveService {

    @Autowired
    private ArticleMapper articleMapper;

    /**
     * 获取文章归档分页数据
     *
     * @param findArchiveArticlePageListReqVO
     * @return
     */
    @Override
    public Response findArchivePageList(FindArchiveArticlePageListReqVO findArchiveArticlePageListReqVO) {
        Long current = findArchiveArticlePageListReqVO.getCurrent();
        Long size = findArchiveArticlePageListReqVO.getSize();

        // 分页查询
        IPage<ArticleDO> page = articleMapper.selectPageList(current, size, null, null, null, null);
        List<ArticleDO> articleDOS = page.getRecords();

        List<FindArchiveArticlePageListRspVO> vos = Lists.newArrayList();
        if (!CollectionUtils.isEmpty(articleDOS)) {
            // DO 转 VO
            List<FindArchiveArticleRspVO> archiveArticleRspVOS =  articleDOS.stream()
                    .map(articleDO -> ArticleConvert.INSTANCE.convertDO2ArchiveArticleVO(articleDO))
                    .collect(Collectors.toList());

            // 按创建的月份进行分组
            Map<YearMonth, List<FindArchiveArticleRspVO>> map = archiveArticleRspVOS.stream().collect(Collectors.groupingBy(FindArchiveArticleRspVO::getCreateMonth));
            // 使用 TreeMap 按月份倒序排列
            Map<YearMonth, List<FindArchiveArticleRspVO>> sortedMap = new TreeMap<>(Collections.reverseOrder());
            sortedMap.putAll(map);

            // 遍历排序后的 Map，将其转换为归档 VO
            sortedMap.forEach((k, v) -> vos.add(FindArchiveArticlePageListRspVO.builder().month(k).articles(v).build()));
        }

        return PageResponse.success(page, vos);
    }

    /**
     * 获取文章归档某年的数据
     * @param year 年份
     * @return
     */
    @Override
    public Response findArchiveYearList(String year) {

        // 查询指定年份的文章数据
        LocalDate startDate = LocalDate.of(Integer.parseInt(year), 1, 1);
        LocalDate endDate = LocalDate.of(Integer.parseInt(year), 12, 31);

        // 查询该年份的所有文章
        List<ArticleDO> articleDOS = articleMapper.selectPageList(1L, 1000L, null, startDate, endDate, null).getRecords();

        List<FindArchiveArticlePageListRspVO> vos = Lists.newArrayList();
        if (!CollectionUtils.isEmpty(articleDOS)) {
            // DO 转 VO
            List<FindArchiveArticleRspVO> archiveArticleRspVOS = articleDOS.stream()
                    .map(articleDO -> ArticleConvert.INSTANCE.convertDO2ArchiveArticleVO(articleDO))
                    .collect(Collectors.toList());

            // 按创建的月份进行分组
            Map<YearMonth, List<FindArchiveArticleRspVO>> map = archiveArticleRspVOS.stream().collect(Collectors.groupingBy(FindArchiveArticleRspVO::getCreateMonth));
            // 使用 TreeMap 按月份倒序排列
            Map<YearMonth, List<FindArchiveArticleRspVO>> sortedMap = new TreeMap<>(Collections.reverseOrder());
            sortedMap.putAll(map);

            // 遍历排序后的 Map，将其转换为归档 VO
            sortedMap.forEach((k, v) -> vos.add(FindArchiveArticlePageListRspVO.builder().month(k).articles(v).build()));
        }

        return Response.success(vos);
    }
    
    /**
     * 获取文章所有的年份
     * @return
     */
    @Override
    public Response findArchiveYears() {
        // 查询所有文章
        List<ArticleDO> articleDOS = articleMapper.selectPageList(1L, Long.MAX_VALUE, null, null, null, null).getRecords();
        
        // 提取所有文章的年份并去重
        Set<Integer> years = articleDOS.stream()
                .map(articleDO -> articleDO.getCreateTime().getYear())
                .collect(Collectors.toCollection(TreeSet::new));
        
        // 倒序排列
        List<Integer> sortedYears = new ArrayList<>(years);
        Collections.reverse(sortedYears);
        
        return Response.success(sortedYears);
    }
}
