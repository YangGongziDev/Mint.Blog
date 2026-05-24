package cn.yangmufa.blog.surfer.config;

import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ResourceLoader;
import toolgood.words.IllegalWordsSearch;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: ToolGood 敏感词过滤配置
 **/
@Configuration
@Slf4j
public class ToolGoodConfig {

    @Bean
    public IllegalWordsSearch illegalWordsSearch(ResourceLoader resourceLoader) throws IOException {
        log.info("==> 开始初初始化敏感词工具类 ...");
        IllegalWordsSearch illegalWordsSearch = new IllegalWordsSearch();

        log.info("==> 加载敏感词 txt 文件 ...");
        // 读取 /resource 目录下的敏感词 txt 文件
        List<String> sensitiveWords = Lists.newArrayList();
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(resourceLoader.getResource("classpath:word/sensi_words.txt").getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (StringUtils.isNotBlank(line.trim())) {
                    sensitiveWords.add(line.trim());
                }
            }
        }

        // 设置敏感词
        illegalWordsSearch.SetKeywords(sensitiveWords);
        log.info("==> 初始化敏感词工具类成功 ...");
        return illegalWordsSearch;
    }

}
