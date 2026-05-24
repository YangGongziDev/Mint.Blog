package cn.yangmufa.blog.admin.service;

import cn.yangmufa.blog.common.utils.Response;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: TODO
 **/
public interface AdminImageService {
    /**
     * 上传图片
     * @param newImageFile
     * @return
     */
    Response uploadImage(MultipartFile newImageFile,String newImageOriginalName,String oldImageName);


    /**
     * 单个删除图片
     * @param oldImageName
     * @return
     */
    Response delateImage(String oldImageName);
    /**
     * 批量删除图片
     * @param oldImageNames
     * @return
     */
    Response delateImages(List<String> oldImageNames);
}
