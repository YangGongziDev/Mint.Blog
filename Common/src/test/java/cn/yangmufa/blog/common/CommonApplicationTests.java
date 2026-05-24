package cn.yangmufa.blog.common;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.NONE, classes = CommonApplicationTests.Application.class)
@Slf4j
class CommonApplicationTests {

    public static class Application {
    }

    @Test
    public void test() {
    }

}
