package cn.yangmufa.blog.surfer.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springdoc.core.GroupedOpenApi;
import org.springdoc.core.customizers.GlobalOpenApiCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

// 只在 dev/prod 环境中开启
@Profile("dev")
@Configuration
public class Knife4jSurferConfig {

    /**
     * 根据@Tag 上的排序，写入x-order
     * @return the global open api customizer
     */
    @Bean
    public GlobalOpenApiCustomizer surferOrderGlobalOpenApiCustomizer() {
        Random random = new Random();
        return openApi -> {
            if (openApi.getTags()!=null){
                openApi.getTags().forEach(tag -> {
                    Map<String,Object> map=new HashMap<>();
                    map.put("x-order", random.nextInt(100));
                    tag.setExtensions(map);
                });
            }
            if(openApi.getPaths()!=null){
                openApi.addExtension("x-test123","333");
                openApi.getPaths().addExtension("x-abb",random.nextInt(100) + 1);
            }
        };
    }

    @Bean
    public GroupedOpenApi surferDefaultApi() {
        return GroupedOpenApi.builder()
                // 分组名称
                .group("Surfer 前台接口")
                // 这里指定 Controller 扫描包路径
                .packagesToScan("cn.yangmufa.blog.surfer.controller")
                .build();
    }

    @Bean
    @Primary // 告诉Spring在有多个候选注入时优先考虑该bean。
    public OpenAPI surferCustomOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("MintBlog Surfer 前台接口文档") // 标题
                        .version("0.0.1-SNAPSHOT") // 版本号
                        .contact(new Contact()
                                .name("杨工子") // 设置作者名称
                                .url("https://www.yangmufa.cn") // 设置作者网址
                                .email("YangMufa@163.com")) // 设置作者邮箱
                        .description("智慧博客专业版是一款<br/>" +
                                "后端由：JDK25 + SpringBoot4 + MybatisPlus4 + PostgreSQL18，<br/>" +
                                "前端由：TypeScript5 + Vite7 + Vue4 + AntDesign5 + Tailwindcss4 + SCSS2 <br/>" +
                                "开发的前后端分离项目。")
                        .termsOfService("https://api.ibp.yangmufa.cn/terms")
                        .license(new License().name("Apache 2.0")
                                .url("http://license.ibp.yangmufa.cn")));
    }
}
