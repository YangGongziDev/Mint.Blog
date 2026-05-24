package cn.yangmufa.blog.common.exception;

/**
 * @author: 杨工子
 * @url: www.yangmufa.cn
 * @date: 2024-12
 * @description: 通用异常接口
 **/
public interface BaseExceptionInterface {
    String getErrorCode();

    String getErrorMessage();
}
