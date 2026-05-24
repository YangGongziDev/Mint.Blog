package cn.yangmufa.blog.admin.service.impl;

import cn.yangmufa.blog.admin.model.vo.tag.*;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.yangmufa.blog.admin.service.AdminTagService;
import cn.yangmufa.blog.common.domain.dos.ArticleTagRelDO;
import cn.yangmufa.blog.common.domain.dos.TagDO;
import cn.yangmufa.blog.common.domain.mapper.ArticleTagRelMapper;
import cn.yangmufa.blog.common.domain.mapper.TagMapper;
import cn.yangmufa.blog.common.enums.ResponseCodeEnum;
import cn.yangmufa.blog.common.exception.BizException;
import cn.yangmufa.blog.common.model.vo.SelectRspVO;
import cn.yangmufa.blog.common.utils.PageResponse;
import cn.yangmufa.blog.common.utils.Response;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: TODO
 **/
@Service
@Slf4j
public class AdminTagServiceImpl extends ServiceImpl<TagMapper, TagDO> implements AdminTagService {

    @Autowired
    private TagMapper tagMapper;
    @Autowired
    private ArticleTagRelMapper articleTagRelMapper;

    /**
     * 添加标签集合
     *
     * @param addTagReqVO
     * @return
     */
    @Override
    public Response addTags(AddTagReqVO addTagReqVO) {

        List<String> tagNames = addTagReqVO.getTags().stream()
                .map(String::trim)
                .collect(Collectors.toList());

        // 检查标签是否已存在
        List<TagDO> existingTags = tagMapper.selectList(new LambdaQueryWrapper<TagDO>()
                .in(TagDO::getName, tagNames));

        if (!CollectionUtils.isEmpty(existingTags)) {
            List<String> existingTagNames = existingTags.stream()
                    .map(TagDO::getName)
                    .collect(Collectors.toList());
            log.warn("新增标签名称： {}, 已存在", existingTagNames);
            return Response.fail(String.format("标签 %s 已存在", existingTagNames));
        }

        // vo 转 do
        List<TagDO> tagDOS = tagNames.stream()
                .map(tagName -> TagDO.builder()
                        .name(tagName) // 去掉前后空格
                        .createTime(LocalDateTime.now())
                        .isDeleted(0)
                        .sort(0)
                        .articlesTotal(0)
                        .build())
                .collect(Collectors.toList());

        // 批量插入
        try {
            saveBatch(tagDOS);
        } catch (Exception e) {
            log.warn("添加标签失败", e);
            return Response.fail("添加标签失败");
        }

        return Response.success();
    }

    /**
     * 修改标签
     */
    @Override
    public Response updateTag(UpdateTagReqVO updateTagReqVO) {
        Long tagId = updateTagReqVO.getId();
        String tagName = updateTagReqVO.getName();

        // 检查是否与其他标签名称冲突
        TagDO existingTag = tagMapper.selectOne(new LambdaQueryWrapper<TagDO>()
                .eq(TagDO::getName, tagName));
        if (Objects.nonNull(existingTag) && !existingTag.getId().equals(tagId)) {
            log.warn("更新标签名称： {}, 已存在", tagName);
            throw new BizException(ResponseCodeEnum.TAG_CANT_DUPLICATE);
        }

        TagDO tagDO = TagDO.builder()
                .id(tagId)
                .name(tagName)
                .updateTime(LocalDateTime.now())
                .build();

        return tagMapper.updateById(tagDO) == 1 ? Response.success() : Response.fail(ResponseCodeEnum.TAG_NOT_EXISTED);
    }

    /**
     * 更新标签排序
     * @param updateTagSortReqVO
     *
     * @return
     */
    @Override
    public Response updateTagSort(UpdateTagSortReqVO updateTagSortReqVO) {
        Long TagId = updateTagSortReqVO.getId();
        Integer sort = updateTagSortReqVO.getSort();
        tagMapper.updateById(TagDO.builder().id(TagId).sort(sort).build());
        return Response.success();
    }

    /**
     * 设置文章分类排序设置最前
     *
     * @return
     */
    @Override
    public Response updateTagSortFirst(UpdateTagSortReqVO updateTagSortReqVO) {
        // 查找出最大排序值
        TagDO maxSort = tagMapper.selectMaxSorTag();
        // 更新分类排序
        tagMapper.updateById(TagDO.builder().id(updateTagSortReqVO.getId()).sort(maxSort.getSort() + 1).build());
        return Response.success();
    }

    /**
     * 设置文章分类排序设置最后
     *
     * @return
     */
    @Override
    public Response updateTagSortLast(UpdateTagSortReqVO updateTagSortReqVO) {
        // 查找出最小排序值
        TagDO minSort = tagMapper.selectMinSortTag();
        if (minSort.getSort() > 0){
            // 更新分类排序
            tagMapper.updateById(TagDO.builder().id(updateTagSortReqVO.getId()).sort(minSort.getSort() - 1).build());
            return Response.success();
        } else {
            tagMapper.updateById(TagDO.builder().id(updateTagSortReqVO.getId()).sort(0).build());
            return Response.success();
        }
    }

    /**
     * 查询标签分页
     *
     * @param findTagPageListReqVO
     * @return
     */
    @Override
    public PageResponse findTagPageList(FindTagPageListReqVO findTagPageListReqVO) {
        // 分页参数、条件参数
        Long current = findTagPageListReqVO.getCurrent();
        Long size = findTagPageListReqVO.getSize();
        String name = findTagPageListReqVO.getName();
        LocalDate startDate = findTagPageListReqVO.getStartDate();
        LocalDate endDate = findTagPageListReqVO.getEndDate();

        // 分页查询
        Page<TagDO> page = tagMapper.selectPageList(current, size, name, startDate, endDate);

        List<TagDO> records = page.getRecords();

        // do 转 vo
        List<FindTagPageListRspVO> vos = null;
        if (!CollectionUtils.isEmpty(records)) {
            vos = records.stream().map(tagDO -> FindTagPageListRspVO.builder()
                    .id(tagDO.getId())
                    .name(tagDO.getName())
                    .createTime(tagDO.getCreateTime())
                    .articlesTotal(tagDO.getArticlesTotal())
                    .sort(tagDO.getSort())
                    .isDeleted(tagDO.getIsDeleted())
                    .build()).collect(Collectors.toList());
        }

        return PageResponse.success(page, vos);
    }

    /**
     * 删除标签
     *
     * @param deleteTagReqVO
     * @return
     */
    @Override
    public Response deleteTag(DeleteTagReqVO deleteTagReqVO) {
        // 标签 ID
        Long tagId = deleteTagReqVO.getId();
        Long deleteType = deleteTagReqVO.getDeleteType();

        if (deleteType == 1 || deleteType == 3){
            // 1. VO 转 TagDO, 并更新
            TagDO tagDO = TagDO.builder()
                    .id(tagId)
                    .isDeleted(deleteType == 1 ? 1 : 0)
                    .build();
            int count = tagMapper.updateById(tagDO);
            // 根据更新是否成功，来判断该标签是否存在
            if (count == 0) {
                log.warn("==> 该文标签不存在, tagId: {}", tagId);
                throw new BizException(ResponseCodeEnum.ARTICLE_NOT_FOUND);
            }
            return Response.success();
        }

        // 校验该标签下是否有关联的文章，若有，则不允许删除，提示用户需要先删除标签下的文章
        ArticleTagRelDO articleTagRelDO = articleTagRelMapper.selectOneByTagId(tagId);

        if (Objects.nonNull(articleTagRelDO)) {
            log.warn("==> 此标签下包含文章，无法删除，tagId: {}", tagId);
            throw new BizException(ResponseCodeEnum.TAG_CAN_NOT_DELETE);
        }

        // 根据标签 ID 删除
        int count = tagMapper.deleteById(tagId);

        return count == 1 ? Response.success() : Response.fail(ResponseCodeEnum.TAG_NOT_EXISTED);
    }

    /**
     * 根据标签关键词模糊查询
     *
     * @param searchTagsReqVO
     * @return
     */
    @Override
    public Response searchTags(SearchTagsReqVO searchTagsReqVO) {
        String key = searchTagsReqVO.getKey();

        // 执行模糊查询
        List<TagDO> tagDOS = tagMapper.selectByKey(key);

        // do 转 vo
        List<SelectRspVO> vos = null;
        if (!CollectionUtils.isEmpty(tagDOS)) {
            vos = tagDOS.stream()
                    .map(tagDO -> SelectRspVO.builder()
                            .value(tagDO.getId())
                            .label(tagDO.getName())
                            .sort(tagDO.getSort())
                            .build())
                    .collect(Collectors.toList());
        }

        return Response.success(vos);
    }

    /**
     * 查询标签 Select 列表数据
     *
     * @return
     */
    @Override
    public Response findTagSelectList() {
        // 查询所有标签
        List<TagDO> tagDOS = tagMapper.selectList(Wrappers.emptyWrapper());

        // DO 转 VO
        List<SelectRspVO> vos = null;
        if (!CollectionUtils.isEmpty(tagDOS)) {
            vos = tagDOS.stream()
                    .map(tagDO -> SelectRspVO.builder()
                            .label(tagDO.getName())
                            .sort(tagDO.getSort())
                            .value(tagDO.getId())
                            .build())
                    .collect(Collectors.toList());
        }

        return Response.success(vos);
    }
}
