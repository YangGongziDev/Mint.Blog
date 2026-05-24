package cn.yangmufa.blog.admin.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Maps;
import cn.yangmufa.blog.admin.service.AdminStatisticsService;
import cn.yangmufa.blog.common.domain.dos.ArticleCategoryRelDO;
import cn.yangmufa.blog.common.domain.dos.ArticleTagRelDO;
import cn.yangmufa.blog.common.domain.dos.CategoryDO;
import cn.yangmufa.blog.common.domain.dos.TagDO;
import cn.yangmufa.blog.common.domain.mapper.ArticleCategoryRelMapper;
import cn.yangmufa.blog.common.domain.mapper.ArticleTagRelMapper;
import cn.yangmufa.blog.common.domain.mapper.CategoryMapper;
import cn.yangmufa.blog.common.domain.mapper.TagMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 统计
 **/
@Service
@Slf4j
public class AdminStatisticsServiceImpl implements AdminStatisticsService {

    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private ArticleCategoryRelMapper articleCategoryRelMapper;
    @Autowired
    private TagMapper tagMapper;
    @Autowired
    private ArticleTagRelMapper articleTagRelMapper;

    @Override
    public void statisticsCategoryArticleTotal() {
        // 查询所有分类
        List<CategoryDO> categoryDOS = categoryMapper.selectList(Wrappers.emptyWrapper());

        // 查询所有文章-分类映射记录
        List<ArticleCategoryRelDO> articleCategoryRelDOS = articleCategoryRelMapper.selectList(Wrappers.emptyWrapper());

        // 按所属分类 ID 进行分组
        Map<Long, List<ArticleCategoryRelDO>> categoryIdAndArticleCategoryRelDOMap = Maps.newHashMap();
        // 如果不为空
        if (!CollectionUtils.isEmpty(articleCategoryRelDOS)) {
            categoryIdAndArticleCategoryRelDOMap = articleCategoryRelDOS.stream()
                    .collect(Collectors.groupingBy(ArticleCategoryRelDO::getCategoryId));
        }

        if (!CollectionUtils.isEmpty(categoryDOS)) {
            // 循环统计各分类下的文章总数
            for (CategoryDO categoryDO : categoryDOS) {
                Long categoryId = categoryDO.getId();
                // 获取此分类下所有映射记录
                List<ArticleCategoryRelDO> articleCategoryRelDOList = categoryIdAndArticleCategoryRelDOMap.get(categoryId);

                // 获取文章总数
                int articlesTotal = CollectionUtils.isEmpty(articleCategoryRelDOList) ? 0 : articleCategoryRelDOList.size();

                // 更新该分类的文章总数
                CategoryDO categoryDO1 = CategoryDO.builder()
                        .id(categoryId)
                        .articlesTotal(articlesTotal)
                        .build();
                categoryMapper.updateById(categoryDO1);
            }
        }
    }

    /**
     * 统计各标签下文章总数
     */
    @Override
    public void statisticsTagArticleTotal() {
        // 查询所有标签
        List<TagDO> tagDOS = tagMapper.selectList(Wrappers.emptyWrapper());

        // 查询所有文章-标签映射记录
        List<ArticleTagRelDO> articleTagRelDOS = articleTagRelMapper.selectList(Wrappers.emptyWrapper());

        // 按所属标签 ID 进行分组
        Map<Long, List<ArticleTagRelDO>> tagIdAndArticleTagRelDOMap = Maps.newHashMap();
        // 如果不为空
        if (!CollectionUtils.isEmpty(articleTagRelDOS)) {
            tagIdAndArticleTagRelDOMap = articleTagRelDOS.stream()
                    .collect(Collectors.groupingBy(ArticleTagRelDO::getTagId));
        }

        if (!CollectionUtils.isEmpty(tagDOS)) {
            // 循环统计各标签下的文章总数
            for (TagDO tagDO : tagDOS) {
                Long tagId = tagDO.getId();

                // 获取此标签下所有映射记录
                List<ArticleTagRelDO> articleTagRelDOList = tagIdAndArticleTagRelDOMap.get(tagId);

                // 获取文章总数
                int articlesTotal = CollectionUtils.isEmpty(articleTagRelDOList) ? 0 : articleTagRelDOList.size();

                // 更新该标签的文章总数
                TagDO tagDO1 = TagDO.builder()
                        .id(tagId)
                        .articlesTotal(articlesTotal)
                        .build();
                tagMapper.updateById(tagDO1);
            }
        }
    }
}
