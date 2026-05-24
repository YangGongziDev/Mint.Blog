package cn.yangmufa.blog.admin.service;

import cn.yangmufa.blog.common.utils.Response;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: TODO
 **/
public interface AdminFileService {
    /**
     * 上传文件
     * @param newFile
     * @return
     */
    Response uploadFile(MultipartFile newFile, String newFileOriginalName,String oldFileName);
}
