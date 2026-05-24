package cn.yangmufa.blog.admin.controller;

import cn.yangmufa.blog.admin.service.AdminImageService;
import cn.yangmufa.blog.common.aspect.ApiOperationLog;
import cn.yangmufa.blog.common.utils.Response;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 文件模块
 **/
@RestController
@RequestMapping("/admin")
@Tag(name = "Admin 文件模块")
public class AdminImageController {

    @Autowired
    private AdminImageService imageService;

    @PostMapping("/image/upload")
    @Operation(summary = "图片上传")
    @ApiOperationLog(description = "图片上传")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response uploadImage(@RequestParam MultipartFile newImageFile,@RequestParam String newImageOriginalName,@RequestParam String oldImageName) {
        return imageService.uploadImage(newImageFile,newImageOriginalName,oldImageName);
    }


    @PostMapping("/image/delete")
    @Operation(summary = "图片删除")
    @ApiOperationLog(description = "图片删除")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response deleteImage(@RequestBody String oldImageName) {
        return imageService.delateImage(oldImageName);
    }
    
    @PostMapping("/image/deletes")
    @Operation(summary = "批量图片删除")
    @ApiOperationLog(description = "批量图片删除")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response deleteImages(@RequestBody List<String> oldImageNames) {
        return imageService.delateImages(oldImageNames);
    }

}
