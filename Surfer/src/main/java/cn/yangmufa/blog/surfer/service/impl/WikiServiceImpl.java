package cn.yangmufa.blog.surfer.service.impl;

import cn.yangmufa.blog.surfer.model.vo.wiki.*;
import com.google.common.collect.Lists;
import cn.yangmufa.blog.common.domain.dos.WikiCatalogDO;
import cn.yangmufa.blog.common.domain.dos.WikiDO;
import cn.yangmufa.blog.common.domain.mapper.WikiCatalogMapper;
import cn.yangmufa.blog.common.domain.mapper.WikiMapper;
import cn.yangmufa.blog.common.enums.WikiCatalogLevelEnum;
import cn.yangmufa.blog.common.utils.Response;
import cn.yangmufa.blog.surfer.model.vo.article.FindPreNextArticleRspVO;
import cn.yangmufa.blog.surfer.service.WikiService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 知识库
 **/
@Service
@Slf4j
public class WikiServiceImpl implements WikiService {

    @Autowired
    private WikiMapper wikiMapper;
    @Autowired
    private WikiCatalogMapper wikiCatalogMapper;

    /**
     * 获取知识库
     *
     * @return
     */
    @Override
    public Response findWikiList() {

        // 查询已发布的知识库
        List<WikiDO> wikiDOS = wikiMapper.selectPublished();

        // 查询每个知识库的文章数量
        List<FindWikiListRspVO> vos = null;
        if (!CollectionUtils.isEmpty(wikiDOS)) {
            vos = wikiDOS.stream()
                    .map(wikiDO -> {
                        // 统计该知识库下的文章数量
                        Long wikiId = wikiDO.getId();
                        int articlesTotal = wikiCatalogMapper.selectByWikiId(wikiId).stream()
                                .filter(catalog -> Objects.nonNull(catalog.getArticleId()))
                                .collect(Collectors.toList())
                                .size();
                        
                        return FindWikiListRspVO.builder()
                                .id(wikiDO.getId())
                                .title(wikiDO.getTitle())
                                .articlesTotal(articlesTotal)
                                .cover(wikiDO.getCover())
                                .summary(wikiDO.getSummary())
                                .sort(wikiDO.getSort())
                                .weight(wikiDO.getWeight())
                                .isTop(wikiDO.getWeight() > 0)
                                .build();
                    }).collect(Collectors.toList());

            // 设置每个知识库的第一篇文章 ID，方便前端跳转
            vos.forEach(vo -> {
                Long wikiId = vo.getId();
                WikiCatalogDO wikiCatalogDO = wikiCatalogMapper.selectFirstArticleId(wikiId);
                vo.setFirstArticleId(Objects.nonNull(wikiCatalogDO) ? wikiCatalogDO.getArticleId() : null);
            });
        }

        return Response.success(vos);
    }

    /**
     * 获取知识库目录
     *
     * @param findWikiCatalogListReqVO
     * @return
     */
    @Override
    public Response findWikiCatalogList(FindWikiCatalogListReqVO findWikiCatalogListReqVO) {
        Long wikiId = findWikiCatalogListReqVO.getId();

        // 获取该知识库下所有目录数据
        List<WikiCatalogDO> catalogDOS = wikiCatalogMapper.selectByWikiId(wikiId);

        // DO 转 VO
        List<FindWikiCatalogListRspVO> vos = null;
        if (!CollectionUtils.isEmpty(catalogDOS)) {
            vos = Lists.newArrayList();

            // 过滤出一级目录，并按 sort 值升序排列
            List<WikiCatalogDO> level1Catalogs = catalogDOS.stream()
                    .filter(catalogDO -> Objects.equals(catalogDO.getLevel(), WikiCatalogLevelEnum.ONE.getValue()))
                    .sorted(Comparator.comparing(WikiCatalogDO::getSort))
                    .collect(Collectors.toList());

            // 构造 VO 对象, 并添加到 vos 集合中
            for (WikiCatalogDO level1Catalog : level1Catalogs) {
                vos.add(FindWikiCatalogListRspVO.builder()
                        .id(level1Catalog.getId())
                        .articleId(level1Catalog.getArticleId())
                        .title(level1Catalog.getTitle())
                        .level(level1Catalog.getLevel())
                        .build());
            }

            // 循环 vos 集合，开始构造二级目录数据
            vos.forEach(level1Catalog -> {
                // 一级目录的 ID
                Long parentId = level1Catalog.getId();

                // 过滤出当前一级目录下的子目录，并按照 sort 值升序排列
                List<WikiCatalogDO> level2CatalogDOS = catalogDOS.stream()
                        .filter(catalogDO -> Objects.equals(catalogDO.getParentId(), parentId)
                                && Objects.equals(catalogDO.getLevel(), WikiCatalogLevelEnum.TWO.getValue()))
                        .sorted(Comparator.comparing(WikiCatalogDO::getSort))
                        .collect(Collectors.toList());

                // 设置子目录数据到 children 字段中
                List<FindWikiCatalogListRspVO> level2Catalogs = level2CatalogDOS.stream()
                        .map(catalogDO -> FindWikiCatalogListRspVO.builder()
                                .id(catalogDO.getId())
                                .articleId(catalogDO.getArticleId())
                                .title(catalogDO.getTitle())
                                .level(catalogDO.getLevel())
                                .build())
                        .collect(Collectors.toList());
                level1Catalog.setChildren(level2Catalogs);
            });
        }

        return Response.success(vos);
    }

    /**
     * 获取上下页
     *
     * @param findWikiArticlePreNextReqVO
     * @return
     */
    @Override
    public Response findArticlePreNext(FindWikiArticlePreNextReqVO findWikiArticlePreNextReqVO) {
        // 知识库 ID
        Long wikiId = findWikiArticlePreNextReqVO.getId();
        // 文章 ID
        Long articleId = findWikiArticlePreNextReqVO.getArticleId();

        FindWikiArticlePreNextRspVO vo = new FindWikiArticlePreNextRspVO();
        // 获取当前文章所属知识库的目录
        WikiCatalogDO wikiCatalogDO = wikiCatalogMapper.selectByWikiIdAndArticleId(wikiId, articleId);

        // 构建上一篇文章 VO
        WikiCatalogDO preArticleDO = wikiCatalogMapper.selectPreArticle(wikiId, wikiCatalogDO.getId());
        if (Objects.nonNull(preArticleDO)) {
            FindPreNextArticleRspVO preArticleVO = FindPreNextArticleRspVO.builder()
                    .articleId(preArticleDO.getArticleId())
                    .articleTitle(preArticleDO.getTitle())
                    .build();
            vo.setPreArticle(preArticleVO);
        }

        // 构建下一篇文章 VO
        WikiCatalogDO nextArticleDO = wikiCatalogMapper.selectNextArticle(wikiId, wikiCatalogDO.getId());
        if (Objects.nonNull(nextArticleDO)) {
            FindPreNextArticleRspVO nextArticleVO = FindPreNextArticleRspVO.builder()
                    .articleId(nextArticleDO.getArticleId())
                    .articleTitle(nextArticleDO.getTitle())
                    .build();
            vo.setNextArticle(nextArticleVO);
        }

        return Response.success(vo);
    }

}
