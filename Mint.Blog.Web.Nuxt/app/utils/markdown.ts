import MarkdownIt from 'markdown-it'
import sanitizeHtml from 'sanitize-html'
import hljs from 'highlight.js/lib/common'

export function renderArticleMarkdown(content: string) {
  const headings: { id: string; level: number; title: string }[] = []
  const md: InstanceType<typeof MarkdownIt> = new MarkdownIt({ html: false, linkify: true, highlight(code, language): string {
    const highlighted = language && hljs.getLanguage(language)
      ? hljs.highlight(code, { language, ignoreIllegals: true }).value
      : md.utils.escapeHtml(code)
    return `<pre><code class="hljs">${highlighted}</code></pre>`
  } })
  md.renderer.rules.fence = (tokens, index, options) => {
    const token = tokens[index]!
    const language = token.info.trim().split(/\s+/)[0] || ''
    return `<div class="code-block-wrapper"><div class="code-block-header"><div class="code-block-dots"><span></span><span></span><span></span></div><span class="code-lang-label">${md.utils.escapeHtml(language)}</span><button type="button" class="code-copy" aria-label="复制代码">⧉</button></div>${options.highlight!(token.content, language, '')}</div>\n`
  }
  md.renderer.rules.table_open = () => '<div class="markdown-table-wrapper"><table>\n'
  md.renderer.rules.table_close = () => '</table></div>\n'
  md.renderer.rules.heading_open = (tokens, index, options, env, renderer) => {
    const token = tokens[index]!
    const id = `article-heading-${headings.length}`
    token.attrSet('id', id)
    headings.push({ id, level: Number(token.tag.slice(1)), title: tokens[index + 1]?.children?.map(child => child.type === 'image' ? child.content : child.type === 'text' || child.type === 'code_inline' ? child.content : '').join('') || '' })
    return renderer.renderToken(tokens, index, options)
  }
  const tokens = md.parse(content, {})
  let level = 1
  let section = false
  let output = ''
  for (let index = 0; index < tokens.length; index++) {
    const token = tokens[index]!
    if (token.level === 0 && token.nesting !== -1) {
      if (section) output += '</div>'
      if (token.type === 'heading_open') level = Number(token.tag.slice(1))
      output += `<div class="markdown-section-content markdown-indent-${level - 1}">`
      section = true
    }
    output += md.renderer.render([token], md.options, {})
    // Heading titles need the following inline token, not a separately rendered array.
    if (token.type === 'heading_open') headings[headings.length - 1]!.title = tokens[index + 1]?.children?.map(child => child.content).join('') || ''
  }
  if (section) output += '</div>'
  const html = sanitizeHtml(output, {
    allowedTags: [...sanitizeHtml.defaults.allowedTags, 'img', 'button'],
    allowedAttributes: { ...sanitizeHtml.defaults.allowedAttributes, '*': ['class'], h1: ['id'], h2: ['id'], h3: ['id'], h4: ['id'], h5: ['id'], h6: ['id'], img: ['src', 'alt', 'title', 'width', 'height'], button: ['type', 'class', 'aria-label'] },
    allowedSchemes: ['http', 'https', 'mailto'],
    allowProtocolRelative: false
  })
  return { html, headings }
}
