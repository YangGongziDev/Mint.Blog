package cn.yangmufa.blog.surfer.model.vo.article;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 首页-文章分页
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FindIndexFriendPageListRspVO {

    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 友链名称
     */
    private String name;

    /**
     * 描述
     */
    private String description;

    /**
     * 友链URL
     */
    private String url;

    /**
     * 头像URL
     */
    private String avatar;

    /**
     * 状态：pending-待审核, active-已通过, rejected-已拒绝
     */
    private String status;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 分类：tech技术类 tools工具类 avigation导航类 news新闻类 aggregate聚合类 life生活类 MintBlog优秀站点
     */
    private String category;

    /**
     * 是否置顶
     */
    private Boolean isTop;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 排序字段
     */
    private Integer sort;

    /**
     * 是否删除
     */
    private Integer isDeleted;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;
}
