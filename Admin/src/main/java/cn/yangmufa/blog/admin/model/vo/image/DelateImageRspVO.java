package cn.yangmufa.blog.admin.model.vo.image;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 上传文件
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DelateImageRspVO {

    /**
     * 图片名称
     */
    public String name;

}
