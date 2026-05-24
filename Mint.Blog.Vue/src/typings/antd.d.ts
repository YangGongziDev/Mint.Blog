declare namespace AntDesign {
  type TableColumnType<T> = import('ant-design-vue').TableColumnType<T>;
  type TableColumnGroupType<T> = import('ant-design-vue').TableColumnGroupType<T>;
  type TablePaginationConfig = import('ant-design-vue').TablePaginationConfig;
  type TableColumnCheck = import('@/hooks/table/use-hook-table').TableColumnCheck;
  type TableDataWithIndex<T> = import('@/hooks/table/use-hook-table').TableDataWithIndex<T>;
  type FlatResponseData<T> = { data: T | null; error: unknown | null };

  type TableData = Api.Common.CommonRecord<Record<string, unknown>>;

  /**
   * the custom column key
   *
   * if you want to add a custom column, you should add a key to this type
   */
  type CustomColumnKey = 'index' | 'operate';

  type SetTableColumnKey<C, T> = Omit<C, 'key'> & { key?: Extract<keyof T, string | number> | CustomColumnKey };

  type TableColumn<T> = SetTableColumnKey<TableColumnType<T>, T> | SetTableColumnKey<TableColumnGroupType<T>, T>;

  type TableApiFn<T = any, R = any> = (
    params: R
  ) => Promise<FlatResponseData<Api.Common.PaginatingQueryRecord<T>>>;

  /**
   * the type of table operation
   *
   * - add: add table item
   * - edit: edit table item
   */
  type TableOperateType = 'add' | 'edit';

  type GetTableData<A extends TableApiFn> = A extends TableApiFn<infer T> ? T : never;

  type AntDesignTableConfig<A extends TableApiFn> = Pick<
    import('@/hooks/table/use-hook-table').TableConfig<A, GetTableData<A>, TableColumn<TableDataWithIndex<GetTableData<A>>>>,
    'apiFn' | 'columns' | 'immediate'
  > & { apiParams: Parameters<A>[0] };
}
