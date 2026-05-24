package cn.yangmufa.blog.admin.service.impl;

import cn.yangmufa.blog.admin.model.vo.image.UploadImageRspVO;
import cn.yangmufa.blog.admin.service.AdminImageService;
import cn.yangmufa.blog.admin.utils.ImageUpland;
import cn.yangmufa.blog.common.enums.ResponseCodeEnum;
import cn.yangmufa.blog.common.exception.BizException;
import cn.yangmufa.blog.common.utils.Response;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 文件上传
 **/
@Service
@Slf4j
public class AdminImageServiceImpl implements AdminImageService {

    @Autowired
    private ImageUpland imageUtil;

    /**
     * 上传文件
     *
     * @param newImageFile
     * @return
     */
    @Override
    public Response uploadImage(MultipartFile newImageFile, String newImageOriginalName,String oldImageName) {
        try {
            // 上传文件
            String url = imageUtil.uploadImage(newImageFile,newImageOriginalName,oldImageName);
            // 构建成功返参，将图片的访问链接返回
            return Response.success(UploadImageRspVO.builder().url(url).build());
        } catch (Exception e) {
            log.error("==> 上传文件至 Minio 错误: ", e);
            // 手动抛出业务异常，提示 “文件上传失败”
            throw new BizException(ResponseCodeEnum.FILE_UPLOAD_FAILED);
        }
    }

    @Override
    public Response delateImage(String oldImageName) {
        try {
            return imageUtil.deleteImage(oldImageName) ? Response.success() : Response.fail();
        } catch (Exception e) {
            log.error("==> 删除文件失败: ", e);
            return Response.fail();
        }
    }
    @Override
    public Response delateImages(List<String> oldImageNames) {
        try {
            return imageUtil.deleteImages(oldImageNames) ? Response.success() : Response.fail();
        } catch (Exception e) {
            log.error("==> 删除文件失败: ", e);
            return Response.fail();
        }
    }
}
