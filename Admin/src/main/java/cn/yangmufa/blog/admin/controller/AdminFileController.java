package cn.yangmufa.blog.admin.controller;

import cn.yangmufa.blog.admin.service.AdminFileService;
import cn.yangmufa.blog.common.aspect.ApiOperationLog;
import cn.yangmufa.blog.common.utils.Response;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 文件模块
 **/
@RestController
@RequestMapping("/admin")
@Tag(name = "Admin 文件模块")
public class AdminFileController {

    @Autowired
    private AdminFileService fileService;

    @PostMapping("/file/upload")
    @Operation(summary = "文件上传")
    @ApiOperationLog(description = "文件上传")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response uploadImage(@RequestParam MultipartFile newFile,@RequestParam String newFileOriginalName,@RequestParam String oldFileName) {
        return fileService.uploadFile(newFile,newFileOriginalName,oldFileName);
    }

}
