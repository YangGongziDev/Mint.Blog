import { beforeEach, describe, expect, it, vi } from 'vitest';
import { createPinia, setActivePinia } from 'pinia';
import { useAuthStore } from '../../src/stores/auth';
import { useDictStore } from '../../src/stores/dict';
import type { DictData, DictType } from '../../src/types/dict';

const dictFixtures = vi.hoisted(() => {
  const timestamps = { createTime: '2026-01-01 10:00:00', updateTime: '2026-01-01 10:00:00' };
  return {
    initialDictTypes: [
      { id: '1', code: 'status', name: '状态', status: 'enabled', ...timestamps },
    ] satisfies DictType[],
    initialDictData: [
      { id: '1', typeCode: 'status', value: '1', label: '启用', status: 'enabled', sort: 2, ...timestamps },
      { id: '2', typeCode: 'status', value: '0', label: '禁用', status: 'disabled', sort: 3, ...timestamps },
      { id: '3', typeCode: 'status', value: '2', label: '待启用', status: 'enabled', sort: 1, ...timestamps },
    ] satisfies DictData[],
  };
});
vi.mock('@/views/system/dict/index.vue', () => dictFixtures);

const mocks = vi.hoisted(() => ({
  info: vi.fn(), refresh: vi.fn(), rebuild: vi.fn(), replace: vi.fn(), get: vi.fn(),
}));
vi.mock('@/api/auth', () => ({ getUserInfo: mocks.info, refreshToken: mocks.refresh, logout: vi.fn() }));
vi.mock('@/router', () => ({
  default: { currentRoute: { value: { meta: {}, name: 'Users', fullPath: '/system/user' } }, hasRoute: () => false, replace: mocks.replace },
  rebuildDynamicRoutes: mocks.rebuild,
}));
vi.mock('@/utils/session', () => ({ clearSessionState: () => useAuthStore().setToken(null, null) }));
vi.mock('@/utils/request', () => ({ request: { get: mocks.get } }));

beforeEach(() => {
  vi.clearAllMocks();
  const values = new Map<string, string>();
  vi.stubGlobal('localStorage', {
    getItem: (key: string) => values.get(key) ?? null,
    setItem: (key: string, value: string) => values.set(key, value),
    removeItem: (key: string) => values.delete(key),
  });
  setActivePinia(createPinia());
  mocks.info.mockResolvedValue({ data: { id: '1', avatar: '', roles: [], permissions: [] } });
  mocks.refresh.mockResolvedValue({ data: { token: 'new', refreshToken: 'next', expiresIn: 300 } });
});

describe('server identity synchronization', () => {
  it('ignores cached wildcard permissions on session restore and coalesces initialization', async () => {
    localStorage.setItem('user_info', JSON.stringify({ permissions: [{ code: '*' }] }));
    const auth = useAuthStore();
    auth.setToken('old', 'refresh');
    await Promise.all([auth.initAuth(), auth.initAuth()]);
    expect(mocks.info).toHaveBeenCalledTimes(1);
    expect(auth.hasPermission('system.user.edit')).toBe(false);
  });
  it('refreshes identity without permitting another refresh, rebuilds routes and exits revoked pages', async () => {
    const auth = useAuthStore();
    auth.setToken('old', 'refresh');
    await expect(auth.refreshToken()).resolves.toBe('new');
    expect(mocks.info).toHaveBeenCalledWith(true);
    expect(mocks.rebuild).toHaveBeenCalledTimes(1);
    expect(mocks.replace).toHaveBeenCalledWith('/403');
  });
  it('fails closed when identity fails after refresh', async () => {
    const auth = useAuthStore();
    auth.setToken('old', 'refresh');
    mocks.info.mockRejectedValueOnce(new Error('401'));
    await expect(auth.refreshToken()).rejects.toThrow('401');
    expect(mocks.refresh).toHaveBeenCalledTimes(1);
    expect(mocks.info).toHaveBeenCalledTimes(1);
    expect(auth.token).toBeNull();
  });
});

describe('static dictionary state', () => {
  it('initializes from static fixtures and filters and sorts enabled options without a request', async () => {
    const dict = useDictStore();
    expect(dict.loaded).toBe(false);
    expect(dict.dictTypes).toEqual([]);
    expect(dict.allDictData).toEqual([]);

    await dict.loadDictData();

    expect(mocks.get).not.toHaveBeenCalled();
    expect(dict.loaded).toBe(true);
    expect(dict.loading).toBe(false);
    expect(dict.dictTypes).toEqual(dictFixtures.initialDictTypes);
    expect(dict.allDictData).toEqual(dictFixtures.initialDictData);
    expect(dict.dictData).toEqual([dictFixtures.initialDictData[0], dictFixtures.initialDictData[2]]);
    expect(dict.getDictOptions('status')).toEqual([
      { value: '2', label: '待启用' },
      { value: '1', label: '启用' },
    ]);
  });

  it('shares edits between consumers and preserves them when loading or refreshing', async () => {
    const dict = useDictStore();
    await dict.loadDictData();
    const consumer = useDictStore();
    dict.dictTypes[0]!.name = '修改后的状态';
    dict.allDictData[0]!.label = '已启用';
    dict.allDictData[1]!.status = 'enabled';

    expect(consumer.dictTypes[0]!.name).toBe('修改后的状态');
    expect(consumer.getDictLabel('status', '1')).toBe('已启用');
    expect(consumer.getDictOptions('status')).toEqual([
      { value: '2', label: '待启用' },
      { value: '1', label: '已启用' },
      { value: '0', label: '禁用' },
    ]);
    await consumer.loadDictData();
    await consumer.refreshDictData();
    expect(consumer.getDictLabel('status', '1')).toBe('已启用');
    expect(consumer.dictTypes[0]!.name).toBe('修改后的状态');
    expect(dictFixtures.initialDictTypes[0]!.name).toBe('状态');
    expect(dictFixtures.initialDictData[0]!.label).toBe('启用');
    expect(dictFixtures.initialDictData[1]!.status).toBe('disabled');
  });

  it('clears shared state and reloads fresh static data', async () => {
    const dict = useDictStore();
    await dict.loadDictData();
    dict.dictTypes[0]!.name = '修改后的状态';
    dict.allDictData[0]!.label = '已启用';
    const consumer = useDictStore();

    dict.clearDictData();

    expect(consumer.loaded).toBe(false);
    expect(consumer.loading).toBe(false);
    expect(consumer.dictTypes).toEqual([]);
    expect(consumer.allDictData).toEqual([]);
    expect(consumer.dictData).toEqual([]);
    expect(consumer.getDictOptions('status')).toEqual([]);
    await consumer.loadDictData();
    expect(dict.loaded).toBe(true);
    expect(dict.loading).toBe(false);
    expect(dict.dictTypes).toEqual(dictFixtures.initialDictTypes);
    expect(dict.allDictData).toEqual(dictFixtures.initialDictData);
    expect(dict.getDictLabel('status', '1')).toBe('启用');
    expect(mocks.get).not.toHaveBeenCalled();
  });
});
