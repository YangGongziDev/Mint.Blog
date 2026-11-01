const sourcePaths: Record<string, string> = {
  home: '/',
  dashboard: '/dashboard',
  category: '/categories',
  tag: '/tags',
  archive: '/archives',
  column: '/columns',
  friend: '/friends',
  message: '/messages',
  about: '/about',
  author: '/author',
  equipment: '/equipment',
  gallery: '/gallery'
};

function hasUnsafeCharacters(value: string) {
  return [...value].some(char => char === '\\' || char.charCodeAt(0) <= 32 || char.charCodeAt(0) === 127);
}

export function getBlogWebUrl(type: 'article' | 'column', id: string) {
  const { VITE_BLOG_WEB_URL, VITE_BLOG_ARTICLE_PATH, VITE_BLOG_COLUMN_PATH } = import.meta.env;
  if (!VITE_BLOG_WEB_URL || !id || id === '.' || id === '..' || id.includes('/') || hasUnsafeCharacters(id)) {
    return undefined;
  }
  const template = type === 'article'
    ? VITE_BLOG_ARTICLE_PATH || '/articles/:id'
    : VITE_BLOG_COLUMN_PATH || '/columns/:id';
  if (!template.startsWith('/') || template.startsWith('//') || hasUnsafeCharacters(template)) return undefined;
  return joinSourceBase(VITE_BLOG_WEB_URL, template.replace(/:id/g, () => encodeURIComponent(id)));
}

export function getBlogWebHomeUrl() {
  const base = import.meta.env.VITE_BLOG_WEB_URL;
  return base ? joinSourceBase(base, '/') : undefined;
}

function parseHttpUrl(value: string) {
  if (hasUnsafeCharacters(value) || !/^https?:\/\//i.test(value)) return undefined;
  try {
    const url = new URL(value);
    return url.username || url.password ? undefined : url;
  } catch {
    return undefined;
  }
}

export function resolveBlogSourceHref(path: string, _resolveLocal?: (path: string) => string) {
  if (!path || hasUnsafeCharacters(path)) return undefined;
  if (/^https?:\/\//i.test(path)) return parseHttpUrl(path) ? path : undefined;
  if (!/^\/(?!\/)/.test(path)) return undefined;

  const base = import.meta.env.VITE_BLOG_WEB_URL;
  if (!base) return undefined;
  const match = path.match(/^\/blog\/surfer\/([^/?#]+)(?:\/([^/?#]+))?\/?([?#].*)?$/);
  if (!match) {
    const current = path.match(/^(\/(?:articles|columns)(?:\/([^/?#]+))?\/?|\/(?:dashboard|categories|tags|archives|friends|messages|about|author|equipment|gallery)\/?|\/)([?#].*)?$/);
    if (!current) return undefined;
    if (current[2] && !isSafeSourceId(current[2])) return undefined;
    return joinSourceBase(base, path);
  }
  const [, page, id, suffix = ''] = match;
  let target = Object.hasOwn(sourcePaths, page) ? sourcePaths[page] : undefined;
  if (id) {
    if (page !== 'article' && page !== 'column') return undefined;
    if (!isSafeSourceId(id)) return undefined;
    target = `/${page === 'article' ? 'articles' : 'columns'}/${id}`;
  }
  if (!target) return undefined;

  return joinSourceBase(base, target + suffix);
}

function isSafeSourceId(id: string) {
  try {
    const decoded = decodeURIComponent(id);
    return decoded !== '.' && decoded !== '..' && !decoded.includes('/') && !hasUnsafeCharacters(decoded);
  } catch {
    return false;
  }
}

function joinSourceBase(base: string, path: string) {
  const url = parseHttpUrl(base);
  if (!url || url.search || url.hash) return undefined;
  return `${url.href.replace(/\/+$/, '')}${path}`;
}
