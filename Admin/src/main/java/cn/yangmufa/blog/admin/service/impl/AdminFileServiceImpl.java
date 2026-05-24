package cn.yangmufa.blog.admin.service.impl;

import cn.yangmufa.blog.admin.model.vo.file.UploadFileRspVO;
import cn.yangmufa.blog.admin.service.AdminFileService;
import cn.yangmufa.blog.admin.utils.FileUpland;
import cn.yangmufa.blog.common.enums.ResponseCodeEnum;
import cn.yangmufa.blog.common.exception.BizException;
import cn.yangmufa.blog.common.utils.Response;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 文件上传
 **/
@Service
@Slf4j
public class AdminFileServiceImpl implements AdminFileService {

    @Autowired
    private FileUpland fileUtil;

    /**
     * 上传文件
     *
     * @param
     * @return
     */
    @Override
    public Response uploadFile(MultipartFile newFile, String newFileOriginalName,String oldFileName) {
        try {
            // 上传文件
            String url = fileUtil.uploadFile(newFile,newFileOriginalName,oldFileName);

            // 构建成功返参，将图片的访问链接返回
            return Response.success(UploadFileRspVO.builder().url(url).build());
        } catch (Exception e) {
            log.error("==> 上传文件至 Minio 错误: ", e);
            // 手动抛出业务异常，提示 “文件上传失败”
            throw new BizException(ResponseCodeEnum.FILE_UPLOAD_FAILED);
        }
    }
}
