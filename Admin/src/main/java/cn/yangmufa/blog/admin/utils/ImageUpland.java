package cn.yangmufa.blog.admin.utils;

import cn.yangmufa.blog.admin.config.MinioProperties;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import io.minio.RemoveObjectArgs;
import io.minio.StatObjectArgs;
import io.minio.errors.ErrorResponseException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: TODO
 **/
@Component
@Slf4j
public class ImageUpland {

    @Autowired
    private MinioProperties minioProperties;

    @Autowired
    private MinioClient minioClient;

    /**
     * 上传文件
     * @param newImageFile
     * @return
     * @throws Exception
     */
    public String uploadImage(MultipartFile newImageFile,String newImageOriginalName,String oldImageName) throws Exception {

        log.info("==> 发现同名图片，准备删除: {}", oldImageName);
        deleteImage(oldImageName);
        log.info("==> 同名图片删除成功: {}", oldImageName);

        // 文件的原始名称
        String originalFileName = newImageFile.getOriginalFilename();
        // 文件的 Content-Type
        String contentType = newImageFile.getContentType();

        // 生成存储对象的名称（将 UUID 字符串中的 - 替换成空字符串）
        String key = UUID.randomUUID().toString().replace("-", "");
        // 获取文件的后缀，如 .jpg
        String suffix = originalFileName.substring(originalFileName.lastIndexOf("."));

        // 拼接上文件后缀，即为要存储的文件名
        String objectName = String.format("%s%s", key, suffix);

        log.info("==> 开始上传文件至 Minio, ObjectName: {}", objectName);

        // 上传文件至 Minio
        minioClient.putObject(PutObjectArgs.builder()
                .bucket(minioProperties.getBucketName())
                .object(objectName)
                .stream(newImageFile.getInputStream(), newImageFile.getSize(), -1)
                .contentType(contentType)
                .build());

        // 返回文件的访问链接
        String url = String.format("%s/%s/%s", minioProperties.getEndpoint(), minioProperties.getBucketName(), objectName);
        log.info("==> 上传文件至 Minio 成功，访问路径: {}", url);
        return url;
    }

    /**
     * 删除文件
     * @param oldImageName 文件对象名称
     */
    public boolean deleteImage(String oldImageName) {
        try {
            // 检查minio是否存在同名图片，如果存在则先删除
            if (oldImageName != null && !oldImageName.trim().isEmpty() && isFileExists(oldImageName)) {
                log.info("==> 开始删除 Minio 文件, ObjectName: {}", oldImageName);
                // 删除 Minio 中的文件
                minioClient.removeObject(
                        RemoveObjectArgs.builder()
                                .bucket(minioProperties.getBucketName())
                                .object(oldImageName)
                                .build()
                );
            }
            log.info("==> 删除 Minio 文件成功, ObjectName: {}", oldImageName);
            return true;
        } catch (Exception e) {
            log.error("==> 删除 Minio 文件失败, ObjectName: {}, 错误信息: ", oldImageName, e);
            throw new RuntimeException("删除文件失败: " + e.getMessage());
        }
    }

    public boolean deleteImages(List<String> oldImageNames) {
        if (!oldImageNames.isEmpty()) {
            for (String oldImageName : oldImageNames) {
               try {
                   deleteImage(oldImageName);
               } catch (Exception e) {
                   log.error("==> 删除文件失败: {}", oldImageName, e);
               }
            }
        } else {
            return false;
        }
        return true;
    }


    /**
     * 检查文件是否存在
     * @param objectName 文件对象名称
     * @return true-存在，false-不存在
     */
    public boolean isFileExists(String objectName) {
        try {
            minioClient.statObject(
                    StatObjectArgs.builder()
                            .bucket(minioProperties.getBucketName())
                            .object(objectName)
                            .build()
            );
            return true;
        } catch (ErrorResponseException e) {
            // 文件不存在时会抛出 ErrorResponseException
            if (e.errorResponse().code().equals("NoSuchKey")) {
                return false;
            }
            log.error("==> 检查文件是否存在时发生错误, ObjectName: {}, 错误信息: ", objectName, e);
            return false;
        } catch (Exception e) {
            log.error("==> 检查文件是否存在时发生错误, ObjectName: {}, 错误信息: ", objectName, e);
            return false;
        }
    }

}
