// 在首屏绘制前同步执行，避免客户端挂载前出现主题闪烁。
export const themeInitScript = String.raw`(function () {
  var match = document.cookie.match(/(?:^|;\s*)mint-theme=([^;]*)/);
  var theme = 'system';
  if (match) {
    try { theme = decodeURIComponent(match[1]); } catch (_) {}
    try { theme = JSON.parse(theme); } catch (_) {}
  }
  var dark = theme === 'dark' || (theme !== 'light' && window.matchMedia('(prefers-color-scheme: dark)').matches);
  document.documentElement.dataset.theme = dark ? 'dark' : 'light';
})();`
