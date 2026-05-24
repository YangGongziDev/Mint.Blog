package cn.yangmufa.blog.jwt;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.NONE, classes = JwtApplicationTests.Application.class)
class JwtApplicationTests {

    public static class Application {
    }

    @Test
    void contextLoads() {
    }

}
