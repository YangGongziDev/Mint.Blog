<template>
  <section class="comment-emoji" aria-label="表情选择">
    <input v-model="keyword" placeholder="搜索表情" aria-label="搜索表情">
    <div><button v-for="[emoji, name] in filtered" :key="emoji" type="button" :title="name" :aria-label="name" @click="emit('select', emoji)">{{ emoji }}</button></div>
    <p v-if="!filtered.length">没有匹配的表情</p>
  </section>
</template>

<script setup lang="ts">
const emit = defineEmits<{ select: [emoji: string] }>()
const keyword = ref('')
const emojis = [
  ['😀','开心笑脸'],['😃','大笑脸'],['😄','眯眼笑脸'],['😁','露齿笑脸'],['😆','眯眼大笑'],['😅','流汗笑脸'],['🤣','滚地大笑'],['😂','笑哭'],['🙂','微笑'],['🙃','倒置笑脸'],['😉','眨眼'],['😊','害羞笑脸'],['😇','天使笑脸'],['🥰','爱心眼笑脸'],['😍','花痴脸'],['🤩','星星眼'],['😘','飞吻'],['😋','美味脸'],['😛','吐舌脸'],['😜','眨眼吐舌'],['🤪','疯狂脸'],['😝','眯眼吐舌'],['🤑','金钱眼'],['🤗','拥抱脸'],['🤭','捂嘴笑'],['🤔','思考脸'],['😐','面无表情'],['😑','无表情脸'],['😏','得意脸'],['🙄','翻白眼'],['😴','睡觉脸'],['😷','口罩脸'],['🥵','热脸'],['🥶','冷脸'],['🥴','眩晕脸'],['😵','晕倒脸'],['🤯','爆炸头'],['🥳','派对脸'],['😎','墨镜脸'],['🥺','恳求脸'],['😢','哭泣脸'],['😭','大哭脸'],['😱','尖叫脸'],['😤','愤怒脸'],['😡','生气脸'],['💀','骷髅'],['💩','便便'],['🤡','小丑脸'],['👻','幽灵'],['👽','外星人'],['🤖','机器人'],['👍','点赞'],['👏','鼓掌'],['👋','挥手'],['👌','OK'],['🙏','感谢'],['❤️','红心'],['💯','满分'],['💢','怒气'],['💣','炸弹'],['💡','灯泡'],['🔧','扳手'],['🔨','锤子'],['⚙️','齿轮'],['💻','笔记本电脑'],['📱','手机'],['⌨️','键盘'],['🖱️','鼠标'],['📷','相机'],['🎮','游戏手柄']
] as const
const filtered = computed(() => emojis.filter(item => item.some(value => value.includes(keyword.value.trim()))))
</script>

<style scoped>
.comment-emoji{width:min(320px,100%);padding:12px;border:1px solid var(--border);border-radius:8px;margin:10px 0;background:var(--surface)}input{width:100%;margin-bottom:10px}.comment-emoji>div{display:grid;grid-template-columns:repeat(6,1fr);max-height:220px;overflow:auto}button{border:0;font-size:22px;padding:5px}button:hover{background:var(--bg)}
</style>
