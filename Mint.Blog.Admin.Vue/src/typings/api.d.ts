/** Backend API types. */
declare namespace Api {
  namespace Common {
    interface PaginatingCommonParams {
      current: number;
      size: number;
      total: number;
    }

    interface PaginatingQueryRecord<T = any> extends PaginatingCommonParams {
      records: T[];
    }

    type CommonSearchParams = Pick<Common.PaginatingCommonParams, 'current' | 'size'>;
    type EnableStatus = '1' | '2';

    type CommonRecord<T = any> = {
      id: number;
      createBy: string;
      createTime: string;
      updateBy: string;
      updateTime: string;
      status: EnableStatus;
    } & T;
  }

  namespace Auth {
    interface LoginToken {
      accessToken: string;
      refreshToken: string;
      expiresAt: string;
      refreshTokenExpiresAt: string;
      userName: string;
      displayName: string;
    }

    interface UserInfo {
      userId: string;
      userName: string;
      displayName: string;
      roles: string[];
      buttons: string[];
    }
  }

  namespace Route {
    type ElegantConstRoute = import('@/router/types').AppRouteRecord;

    interface MenuRoute extends ElegantConstRoute {
      id: string;
    }

    interface UserRoute {
      routes: MenuRoute[];
      home: import('@/router/types').RouteKey;
    }
  }

  namespace SystemManage {
    type UserGender = '1' | '2';
    type MenuType = '1' | '2';
    type MenuButton = {
      code: string;
      desc: string;
    };
    type IconType = '1' | '2';
    type MenuPropsOfRoute = Pick<
      import('vue-router').RouteMeta,
      | 'i18nKey'
      | 'keepAlive'
      | 'constant'
      | 'order'
      | 'href'
      | 'hideInMenu'
      | 'activeMenu'
      | 'multiTab'
      | 'fixedIndexInTab'
      | 'query'
    >;

    type Menu = Common.CommonRecord<{
      parentId: number;
      menuType: MenuType;
      menuName: string;
      routeName: string;
      routePath: string;
      component?: string;
      icon: string;
      iconType: IconType;
      buttons?: MenuButton[] | null;
      children?: Menu[];
    }> & MenuPropsOfRoute;

    type MenuList = Common.PaginatingQueryRecord<Menu>;
    type MenuTree = {
      id: number;
      label: string;
      pId: number;
      children?: MenuTree[];
    };
  }
}
