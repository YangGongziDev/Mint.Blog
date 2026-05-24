import axios from '../../axios';

export interface Friend {
  id: number;
  name: string;
  description?: string;
  url: string;
  avatar?: string;
  status: 'active' | 'inactive' | 'pending';
  createTime: string;
  category: string;
  isTop: boolean;
  email?: string;
  sort: number;
  isDeleted: boolean;
  updateTime: string;
}

export interface FriendApplicationForm {
  name: string;
  avatar?: string;
  category: string;
  url: string;
  description: string;
  email: string;
}

type BlogFriendListItem = {
  id: number;
  name: string;
  description?: string;
  url: string;
  avatar?: string;
  status?: string;
  createdAt?: string;
  createTime?: string;
  category?: string;
  isTop?: boolean;
  email?: string;
  sort?: number;
  updatedAt?: string;
  updateTime?: string;
};

type BlogPagedResult<T> = {
  items?: T[];
  pageNumber?: number;
  pageSize?: number;
  totalCount?: number;
};

type BlogApiResponse<T> = {
  success: boolean;
  data: T;
  message?: string;
};

type SurferFriendPageRequest = {
  current?: number;
  size?: number;
};

type SurferFriendPageResponse = {
  success: boolean;
  data: Friend[];
  current: number;
  size: number;
  total: number;
  pages: number;
};

function normalizeFriend(item: BlogFriendListItem): Friend {
  const createTime = item.createTime || item.createdAt || '';
  const updateTime = item.updateTime || item.updatedAt || createTime;

  return {
    id: item.id,
    name: item.name,
    description: item.description,
    url: item.url,
    avatar: item.avatar,
    status: (item.status as Friend['status']) || 'active',
    createTime,
    category: item.category || '',
    isTop: item.isTop || false,
    email: item.email,
    sort: item.sort || 0,
    isDeleted: false,
    updateTime
  };
}

export async function getFriendPageList(data: SurferFriendPageRequest): Promise<SurferFriendPageResponse> {
  const current = data.current || 1;
  const size = data.size || 10;
  const result = (await axios.get<BlogApiResponse<BlogPagedResult<BlogFriendListItem>>>('/blog/surfer/friend', {
    params: {
      pageNumber: current,
      pageSize: size
    }
  })) as unknown as BlogApiResponse<BlogPagedResult<BlogFriendListItem>>;
  const pageData = result.data || {};
  const items = pageData.items || [];
  const total = pageData.totalCount || items.length;

  return {
    success: result.success,
    data: items.map(normalizeFriend),
    current: pageData.pageNumber || current,
    size: pageData.pageSize || size,
    total,
    pages: Math.ceil(total / (pageData.pageSize || size || 1))
  };
}

export function submitFriendApplication<T = unknown>(data: FriendApplicationForm): Promise<T> {
  return axios.post('/blog/surfer/friend', data) as Promise<T>;
}
