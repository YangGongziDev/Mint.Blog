package cn.yangmufa.blog.common.domain.dos;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 每日文章 PV 访问量统计
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@TableName("r_statistics_article_pv")
public class StatisticsArticlePVDO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private LocalDate pvDate;

    private Long pvCount;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
