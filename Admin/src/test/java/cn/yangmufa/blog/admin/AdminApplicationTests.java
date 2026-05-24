package cn.yangmufa.blog.admin;

import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(classes = AdminApplicationTests.Application.class)
class AdminApplicationTests {
	// @Import({
	// 		DataSourceAutoConfiguration.class, // Spring DB 自动配置类
	// 		DataSourceTransactionManagerAutoConfiguration.class, // Spring 事务自动配置类
	// 		MybatisPlusAutoConfiguration.class, // MyBatis 的自动配置类
	// })
	public static class Application {
	}

}
