<script setup lang="ts">
import { computed, ref } from 'vue';

interface EmojiItem {
  emoji: string;
  name: string;
}

const emit = defineEmits<{
  select: [emoji: string];
}>();

const searchTerm = ref('');

const emojis: EmojiItem[] = [
  { emoji: '😀', name: '开心笑脸' },
  { emoji: '😃', name: '大笑脸' },
  { emoji: '😄', name: '眯眼笑脸' },
  { emoji: '😁', name: '露齿笑脸' },
  { emoji: '😆', name: '眯眼大笑' },
  { emoji: '😅', name: '流汗笑脸' },
  { emoji: '🤣', name: '滚地大笑' },
  { emoji: '😂', name: '笑哭' },
  { emoji: '🙂', name: '微笑' },
  { emoji: '🙃', name: '倒置笑脸' },
  { emoji: '😉', name: '眨眼' },
  { emoji: '😊', name: '害羞笑脸' },
  { emoji: '😇', name: '天使笑脸' },
  { emoji: '🥰', name: '爱心眼笑脸' },
  { emoji: '😍', name: '花痴脸' },
  { emoji: '🤩', name: '星星眼' },
  { emoji: '😘', name: '飞吻' },
  { emoji: '😋', name: '美味脸' },
  { emoji: '😛', name: '吐舌脸' },
  { emoji: '😜', name: '眨眼吐舌' },
  { emoji: '🤪', name: '疯狂脸' },
  { emoji: '😝', name: '眯眼吐舌' },
  { emoji: '🤑', name: '金钱眼' },
  { emoji: '🤗', name: '拥抱脸' },
  { emoji: '🤭', name: '捂嘴笑' },
  { emoji: '🤔', name: '思考脸' },
  { emoji: '😐', name: '面无表情' },
  { emoji: '😑', name: '无表情脸' },
  { emoji: '😏', name: '得意脸' },
  { emoji: '🙄', name: '翻白眼' },
  { emoji: '😴', name: '睡觉脸' },
  { emoji: '😷', name: '口罩脸' },
  { emoji: '🥵', name: '热脸' },
  { emoji: '🥶', name: '冷脸' },
  { emoji: '🥴', name: '眩晕脸' },
  { emoji: '😵', name: '晕倒脸' },
  { emoji: '🤯', name: '爆炸头' },
  { emoji: '🥳', name: '派对脸' },
  { emoji: '😎', name: '墨镜脸' },
  { emoji: '🥺', name: '恳求脸' },
  { emoji: '😢', name: '哭泣脸' },
  { emoji: '😭', name: '大哭脸' },
  { emoji: '😱', name: '尖叫脸' },
  { emoji: '😤', name: '愤怒脸' },
  { emoji: '😡', name: '生气脸' },
  { emoji: '💀', name: '骷髅' },
  { emoji: '💩', name: '便便' },
  { emoji: '🤡', name: '小丑脸' },
  { emoji: '👻', name: '幽灵' },
  { emoji: '👽', name: '外星人' },
  { emoji: '🤖', name: '机器人' },
  { emoji: '👍', name: '点赞' },
  { emoji: '👏', name: '鼓掌' },
  { emoji: '👋', name: '挥手' },
  { emoji: '👌', name: 'OK' },
  { emoji: '🙏', name: '感谢' },
  { emoji: '❤️', name: '红心' },
  { emoji: '💯', name: '满分' },
  { emoji: '💢', name: '怒气' },
  { emoji: '💣', name: '炸弹' },
  { emoji: '💡', name: '灯泡' },
  { emoji: '🔧', name: '扳手' },
  { emoji: '🔨', name: '锤子' },
  { emoji: '⚙️', name: '齿轮' },
  { emoji: '💻', name: '笔记本电脑' },
  { emoji: '📱', name: '手机' },
  { emoji: '⌨️', name: '键盘' },
  { emoji: '🖱️', name: '鼠标' },
  { emoji: '📷', name: '相机' },
  { emoji: '🎮', name: '游戏手柄' }
];

const filteredEmojis = computed(() => {
  const keyword = searchTerm.value.trim();
  if (!keyword) return emojis;
  return emojis.filter(item => item.emoji.includes(keyword) || item.name.includes(keyword));
});

function tooltipClass(index: number) {
  const col = index % 6;
  if (col === 0) return 'left-0 translate-x-0';
  if (col === 5) return 'right-0 translate-x-0';
  return 'left-1/2 -translate-x-1/2';
}
</script>

<template>
  <div class="emoji-bag">
    <div class="border-b border-gray-100 p-4 dark:border-[#334155]">
      <div class="relative">
        <span class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400">
          <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
            />
          </svg>
        </span>
        <input
          v-model="searchTerm"
          type="text"
          placeholder="搜索表情名称..."
          class="w-full rounded-lg border border-gray-200 bg-white py-2 pl-9 pr-4 text-sm text-gray-700 outline-none transition focus:border-[#3ecf9a] focus:ring-2 focus:ring-[#3ecf9a]/20 dark:border-[#334155] dark:bg-[#2c333e] dark:text-white dark:placeholder:text-gray-500"
        />
      </div>
    </div>

    <div class="p-4">
      <div v-if="filteredEmojis.length" class="grid max-h-64 grid-cols-6 gap-2 overflow-y-auto pr-1">
        <button
          v-for="(item, index) in filteredEmojis"
          :key="`${item.emoji}-${index}`"
          type="button"
          class="group relative flex h-10 w-10 items-center justify-center rounded-lg text-2xl transition hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-[#3ecf9a]/40 dark:hover:bg-[white/8]"
          :aria-label="item.name"
          @click="emit('select', item.emoji)"
        >
          {{ item.emoji }}
          <span
            class="pointer-events-none absolute z-10 whitespace-nowrap rounded bg-gray-800 px-2 py-1 text-xs text-white opacity-0 transition-opacity group-hover:opacity-100"
            :class="[index < 6 ? 'top-full mt-2' : 'bottom-full mb-2', tooltipClass(index)]"
          >
            {{ item.name }}
          </span>
        </button>
      </div>
      <div v-else class="py-8 text-center text-sm text-gray-500 dark:text-[#cbd5e1]">
        {{ searchTerm ? '未找到匹配的表情' : '暂无表情' }}
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.emoji-bag {
  width: min(24rem, calc(100vw - 32px));
}
</style>
