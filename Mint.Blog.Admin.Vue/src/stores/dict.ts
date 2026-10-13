import type { DictData, DictGroup, DictType } from '@/types/dict';

import { defineStore } from 'pinia';
import { ref, computed } from 'vue';

export const useDictStore = defineStore('dict', () => {
  const dictTypes = ref<DictType[]>([]);
  const allDictData = ref<DictData[]>([]);
  const dictData = computed(() => allDictData.value.filter((item) => item.status === 'enabled'));
  const loaded = ref(false);
  const loading = ref(false);
  let pendingLoad: Promise<void> | undefined;
  let generation = 0;

  const dictGroup = computed<DictGroup>(() => {
    const group: DictGroup = {};
    dictData.value.forEach((item) => {
      (group[item.typeCode] ||= []).push(item);
    });
    Object.values(group).forEach((items) => items.sort((a, b) => a.sort - b.sort));
    return group;
  });

  const loadDictData = (force = false): Promise<void> => {
    if (pendingLoad) return pendingLoad;
    if (loaded.value) {
      if (force) allDictData.value = [...allDictData.value];
      return Promise.resolve();
    }
    loading.value = true;
    const currentGeneration = generation;
    pendingLoad = (async () => {
      try {
        if (!loaded.value) {
          const { initialDictTypes, initialDictData } =
            await import('@/views/system/dict/index.vue');
          if (currentGeneration !== generation) return;
          const response = {
            code: 200,
            data: {
              types: initialDictTypes.map((item) => ({ ...item })),
              list: initialDictData.map((item) => ({ ...item })),
            },
          };
          dictTypes.value = response.data.types;
          allDictData.value = response.data.list;
          loaded.value = true;
        }
      } finally {
        if (currentGeneration === generation) {
          loading.value = false;
          pendingLoad = undefined;
        }
      }
    })();
    return pendingLoad;
  };

  const getDictByType = (typeCode: string): DictData[] => dictGroup.value[typeCode] || [];
  const getDictLabel = (typeCode: string, value: string): string =>
    getDictByType(typeCode).find((item) => item.value === value)?.label || value;
  const getDictValue = (typeCode: string, label: string): string =>
    getDictByType(typeCode).find((item) => item.label === label)?.value || label;
  const getDictOptions = (typeCode: string) =>
    getDictByType(typeCode).map((item) => ({ label: item.label, value: item.value }));
  const refreshDictData = () => loadDictData(true);
  const clearDictData = () => {
    generation += 1;
    pendingLoad = undefined;
    dictTypes.value = [];
    allDictData.value = [];
    loaded.value = false;
    loading.value = false;
  };

  return {
    dictTypes,
    allDictData,
    dictData,
    dictGroup,
    loaded,
    loading,
    loadDictData,
    getDictByType,
    getDictLabel,
    getDictValue,
    getDictOptions,
    refreshDictData,
    clearDictData,
  };
});
