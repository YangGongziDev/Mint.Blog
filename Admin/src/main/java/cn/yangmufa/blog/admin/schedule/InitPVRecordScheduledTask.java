package cn.yangmufa.blog.admin.schedule;

import cn.yangmufa.blog.common.domain.dos.StatisticsArticlePVDO;
import cn.yangmufa.blog.common.domain.mapper.StatisticsArticlePVMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 初始化 PV 访问量定时任务
 **/
@Component
@Slf4j
public class InitPVRecordScheduledTask {

    @Autowired
    private StatisticsArticlePVMapper articlePVMapper;

    @Scheduled(cron = "0 0 23 * * ?") // 每天晚间 23 点执行
    // @Scheduled(cron = "0 * * * * ?") // 每一分钟执行一次
    public void execute() {
        // 定时任务执行的业务逻辑
        log.info("==> 开始执行初始化明日 PV 访问量记录定时任务");

        // 当日日期
        LocalDate currDate = LocalDate.now();

        // 明日
        LocalDate tomorrowDate = currDate.plusDays(1);

        // 组装插入的记录
        StatisticsArticlePVDO articlePVDO = StatisticsArticlePVDO.builder()
                .pvDate(tomorrowDate) // 明日的文章 pv 访问量
                .pvCount(0L) // 默认阅读量为 0
                .createTime(LocalDateTime.now())
                .updateTime(LocalDateTime.now())
                .build();

        articlePVMapper.insert(articlePVDO);
        log.info("==> 结束执行初始化明日 PV 访问量记录定时任务");
    }
}
