import NProgress from 'nprogress';
import { message, Modal } from 'ant-design-vue';

// 类型定义
export type MessageType = 'success' | 'warning' | 'info' | 'error';

export interface MessageOptions {
    type?: MessageType;
    message?: string;
    duration?: number;
    className?: string;
}

export interface ModalOptions {
    content?: string;
    type?: MessageType;
    title?: string;
    okText?: string;
    cancelText?: string;
}

// 消息提示
export function showMessage(
    messageText: string = '提示内容', 
    type: MessageType = 'success', 
    duration: number = 3
): void {
    const close = message[type]({
        content: messageText,
        duration: duration,
    });

    if (typeof close === 'function' && duration > 0) {
        window.setTimeout(() => close(), duration * 1000);
    }
}

// 确认对话框
export function showModel(
    content: string = '提示内容', 
    type: MessageType = 'warning', 
    title: string = '确认'
): Promise<void> {
    if(type){}
    return new Promise((resolve, reject) => {
        Modal.confirm({
            title: title,
            content: content,
            class: 'wiki-confirm-modal',
            okText: '确定',
            cancelText: '取消',
            onOk: () => resolve(),
            onCancel: () => reject(new Error('用户取消操作')),
        });
    });
}

// 显示页面加载 Loading
export function showPageLoading() {
    NProgress.start()
}

// 隐藏页面加载 Loading
export function hidePageLoading() {
    NProgress.done()
}

/**
 * 从 Markdown 内容中提取所有图片链接
 * @param content Markdown 内容
 * @returns 图片链接数组
 */
export function extractImagesFromMarkdown(content: string): string[] {
    const images: string[] = [];
    // 匹配 Markdown 图片语法 ![alt](url)
    const regex = /!\[.*?\]\((.*?)\)/g;
    let match;
    while ((match = regex.exec(content)) !== null) {
        if (match[1]) {
            images.push(match[1]);
        }
    }
    // 匹配 HTML img 标签 <img src="url" ... />
    const htmlRegex = /<img[^>]+src="([^">]+)"/g;
    while ((match = htmlRegex.exec(content)) !== null) {
        if (match[1]) {
            images.push(match[1]);
        }
    }
    return images;
}
