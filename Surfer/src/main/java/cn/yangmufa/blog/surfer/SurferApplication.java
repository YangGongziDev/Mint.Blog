package cn.yangmufa.blog.surfer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
// 多模块项目中，必需手动指定扫描 cn.yangmufa.blog 包下面的所有类
@ComponentScan({"cn.yangmufa.blog"})
@EnableScheduling // 启用定时任务
public class SurferApplication {
    public static void main(String[] args) {
        SpringApplication.run(SurferApplication.class, args);
    }

}
