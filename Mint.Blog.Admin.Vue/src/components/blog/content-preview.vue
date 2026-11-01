<template>
  <article>
    <h1>{{ title }}</h1>
    <MdPreview :model-value="content" :sanitize="sanitize" :no-mermaid="true" :no-katex="true" />
  </article>
</template>

<script setup lang="ts">
import { MdPreview } from 'md-editor-v3';
import 'md-editor-v3/lib/preview.css';
defineProps<{ title: string; content: string }>();
const tags = new Set('p br h1 h2 h3 h4 h5 h6 blockquote ul ol li pre code strong em del s a img table thead tbody tr th td hr div span sup sub input'.split(' '));
function sanitize(html: string) {
  const document = new DOMParser().parseFromString(html, 'text/html');
  for (const element of Array.from(document.body.querySelectorAll('*'))) {
    if (!tags.has(element.tagName.toLowerCase())) { element.remove(); continue; }
    for (const attribute of Array.from(element.attributes)) {
      const name = attribute.name.toLowerCase();
      const value = attribute.value.trim();
      const link = element.tagName === 'A' && name === 'href';
      const image = element.tagName === 'IMG' && name === 'src';
      const safeUrl = !value.includes('\\')
        && Array.from(value).every(char => char.charCodeAt(0) > 32 && char.charCodeAt(0) !== 127)
        && /^(https?:\/\/|\/[^/]|#)/i.test(value);
      if (!((link || image) && safeUrl) && !['alt', 'title', 'class'].includes(name)) element.removeAttribute(attribute.name);
    }
  }
  return document.body.innerHTML;
}
</script>
