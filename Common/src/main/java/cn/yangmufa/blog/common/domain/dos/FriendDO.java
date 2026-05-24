package cn.yangmufa.blog.common.domain.dos;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 友链
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@TableName("r_friend")
public class FriendDO {

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
     * 状态：pending-待审核, approved-已通过, rejected-已拒绝
     */
    private String status;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 分类：personal-个人, official-官方, tech-技术, etc.
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
