import type { DictData } from '@/types/dict';

import { useDictStore } from '@/stores/dict';

class DictUtil {
  private getStore() {
    return useDictStore();
  }

  getByType(typeCode: string): DictData[] {
    return this.getStore().getDictByType(typeCode);
  }

  getLabel(typeCode: string, value: string): string {
    return this.getStore().getDictLabel(typeCode, value);
  }

  getValue(typeCode: string, label: string): string {
    return this.getStore().getDictValue(typeCode, label);
  }

  getOptions(typeCode: string) {
    return this.getStore().getDictOptions(typeCode);
  }

  getLabels(typeCode: string, values: string[]): string[] {
    return values.map((value) => this.getLabel(typeCode, value));
  }

  getValues(typeCode: string, labels: string[]): string[] {
    return labels.map((label) => this.getValue(typeCode, label));
  }

  hasValue(typeCode: string, value: string): boolean {
    const dict = this.getByType(typeCode);
    return dict.some((item) => item.value === value);
  }

  hasLabel(typeCode: string, label: string): boolean {
    const dict = this.getByType(typeCode);
    return dict.some((item) => item.label === label);
  }

  getMap(typeCode: string): Record<string, DictData> {
    const dict = this.getByType(typeCode);
    const map: Record<string, DictData> = {};
    dict.forEach((item) => {
      map[item.value] = item;
    });
    return map;
  }

  refresh() {
    return this.getStore().refreshDictData();
  }
}

export const dict = new DictUtil();

export default DictUtil;
