import dayjs from 'dayjs';

export const DATE_TIME_FORMAT = 'YYYY-MM-DD HH:mm:ss';

export function formatDateTime(value?: string | number | Date | null) {
  if (!value) return '-';

  const date = dayjs(value);
  return date.isValid() ? date.format(DATE_TIME_FORMAT) : String(value);
}

export function getDateTimeValue(value?: string | number | Date | null) {
  if (!value) return 0;

  const timestamp = dayjs(value).valueOf();
  return Number.isNaN(timestamp) ? 0 : timestamp;
}

export function compareDateTime(current?: string | number | Date | null, next?: string | number | Date | null) {
  return getDateTimeValue(current) - getDateTimeValue(next);
}

export type TimeSortOrder = 'timeAsc' | 'timeDesc';

export function resolveTimeSortOrder(order?: string | null, currentSortOrder?: TimeSortOrder): TimeSortOrder {
  if (order === 'ascend') return 'timeAsc';
  if (order === 'descend') return 'timeDesc';

  return currentSortOrder === 'timeDesc' ? 'timeAsc' : 'timeDesc';
}

export function compareDateTimeDesc(current?: string | number | Date | null, next?: string | number | Date | null) {
  return compareDateTime(next, current);
}

export function isTableSortChange(extra?: { action?: string }) {
  return extra?.action === 'sort';
}

export function getTableSortOrder(sorter: unknown) {
  if (!sorter || Array.isArray(sorter) || typeof sorter !== 'object') return undefined;

  return (sorter as { order?: string | null }).order;
}

export function getAntdTimeSortOrder(sortOrder: TimeSortOrder) {
  return sortOrder === 'timeAsc' ? 'ascend' : 'descend';
}


