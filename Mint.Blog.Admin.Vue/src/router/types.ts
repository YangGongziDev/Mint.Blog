import type { RouteRecordNameGeneric, RouteRecordRaw } from 'vue-router';

export type RouteKey = string;

export type AppRouteRecord = RouteRecordRaw & {
  name?: RouteRecordNameGeneric;
  path: string;
  children?: AppRouteRecord[];
};
