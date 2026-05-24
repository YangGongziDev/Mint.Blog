package cn.yangmufa.blog.surfer.model.vo.comment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 获取 QQ 号用户信息
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FindQQUserInfoRspVO {

    /**
     * 头像
     */
    private String avatar;

    /**
     * 昵称
     */
    private String nickname;

    /**
     * 邮箱
     */
    private String mail;

}
