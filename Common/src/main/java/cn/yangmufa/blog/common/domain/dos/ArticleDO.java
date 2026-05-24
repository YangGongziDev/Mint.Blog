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
 * @description: 文章
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@TableName("r_article")
public class ArticleDO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String title;

    private String cover;

    private String summary;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    private Integer isDeleted;

    private Long readNum;

    private Integer weight = 0;

    private Integer type;
}
