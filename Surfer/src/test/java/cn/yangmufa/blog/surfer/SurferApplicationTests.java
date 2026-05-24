package cn.yangmufa.blog.surfer;

import cn.yangmufa.blog.admin.config.MinioProperties;
import cn.yangmufa.blog.common.domain.dos.UserDO;
import cn.yangmufa.blog.common.domain.mapper.UserMapper;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import io.minio.errors.*;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.util.UUID;

@SpringBootTest
@Slf4j
class SurferApplicationTests {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private MinioProperties minioProperties;

    @Autowired
    private MinioClient minioClient;


    @Test
    void testLog() {
        log.info("这是一行 Info 级别日志");
        log.warn("这是一行 Warn 级别日志");
        log.error("这是一行 Error 级别日志");

        // 占位符
        String author = "杨工子";
        log.info("这是一行带有占位符日志，作者：{}", author);
    }

    @Test
    void insertTest() {
        // 构建数据库实体类
        UserDO userDO = UserDO.builder()
                .username("杨工子")
                .password("123456")
                .createTime(LocalDateTime.now())
                .updateTime(LocalDateTime.now())
                .isDeleted(0)
                .build();

        userMapper.insert(userDO);
    }

    @Test
    void uploadFile2MinioTest() throws IOException, ServerException, InsufficientDataException, ErrorResponseException, NoSuchAlgorithmException, InvalidKeyException, InvalidResponseException, XmlParserException, InternalException {
        File file = new File("D:\\Backup\\Documents\\My Pictures\\111.jpg");
        String originalFileName = file.getName();
        String contentType = "image/jpeg";

        String key = UUID.randomUUID().toString().replace("-", "");
        String suffix = originalFileName.substring(originalFileName.lastIndexOf("."));

        String objectName = String.format("%s%s", key, suffix);

        log.info("==> 开始上传文件至 Minio, ObjectName: {}", objectName);
        minioClient.putObject(PutObjectArgs.builder()
                .bucket(minioProperties.getBucketName())
                .object(objectName)
                .stream(new FileInputStream(file), file.length(), -1)
                .contentType(contentType)
                .build());

        String url = String.format("%s/%s/%s", minioProperties.getEndpoint(), minioProperties.getBucketName(), objectName);
        log.info("==> 上传文件至 Minio 成功，访问路径: {}", url);
    }

}
