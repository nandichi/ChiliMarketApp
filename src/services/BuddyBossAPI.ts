const BUDDYBOSS_BASE_URL = 'https://chili-market.com/wp-json/buddyboss/v1';

export interface BuddyBossGroup {
  id: number;
  name: string;
  description: string;
  slug: string;
  status: string;
  date_created: string;
  creator_id: number;
  parent_id: number;
  total_member_count: number;
  cover_url?: string;
  avatar_urls?: {
    thumb: string;
    full: string;
  };
}

export interface BuddyBossActivity {
  id: number;
  user_id: number;
  component: string;
  type: string;
  action: string;
  content: string;
  date: string;
  user_avatar: string;
  user_name: string;
  can_comment?: boolean;
  can_favorite?: boolean;
  favorited?: boolean;
  comment_count?: number;
}

export interface BuddyBossMember {
  id: number;
  name: string;
  mention_name: string;
  link: string;
  user_login: string;
  avatar_urls: {
    thumb: string;
    full: string;
  };
  last_activity: string;
  latest_update?: string;
}

export interface BuddyBossMessage {
  id: number;
  thread_id: number;
  sender_id: number;
  subject: string;
  message: string;
  date_sent: string;
  is_starred?: boolean;
  sender_name: string;
  sender_avatar: string;
}

export interface BuddyBossNotification {
  id: number;
  user_id: number;
  item_id: number;
  secondary_item_id: number;
  component_name: string;
  component_action: string;
  date_notified: string;
  is_new: boolean;
  description: string;
}

class BuddyBossAPI {
  private baseURL: string;
  private token?: string;

  constructor(token?: string) {
    this.baseURL = BUDDYBOSS_BASE_URL;
    this.token = token;
  }

  setToken(token: string): void {
    this.token = token;
  }

  private getAuthHeaders(): Record<string, string> {
    if (!this.token) return {};
    return {
      Authorization: `Bearer ${this.token}`,
    };
  }

  private async makeRequest<T>(
    endpoint: string,
    options: RequestInit = {},
  ): Promise<T> {
    const url = `${this.baseURL}${endpoint}`;

    console.log(`BuddyBoss API Request: ${url}`);

    try {
      const response = await fetch(url, {
        ...options,
        headers: {
          'Content-Type': 'application/json',
          ...this.getAuthHeaders(),
          ...options.headers,
        },
      });

      if (!response.ok) {
        const errorText = await response.text();
        console.error(`BuddyBoss API Error: ${errorText}`);
        throw new Error(`BuddyBoss API Error ${response.status}: ${errorText}`);
      }

      return await response.json();
    } catch (error) {
      console.error('BuddyBoss API Error:', error);
      throw error;
    }
  }

  // Groups
  async getGroups(
    params: {
      per_page?: number;
      page?: number;
      type?: 'active' | 'newest' | 'alphabetical' | 'random' | 'popular';
      user_id?: number;
    } = {},
  ): Promise<BuddyBossGroup[]> {
    const searchParams = new URLSearchParams();
    searchParams.append('per_page', (params.per_page || 20).toString());
    searchParams.append('page', (params.page || 1).toString());
    if (params.type) searchParams.append('type', params.type);
    if (params.user_id)
      searchParams.append('user_id', params.user_id.toString());

    return this.makeRequest<BuddyBossGroup[]>(
      `/groups?${searchParams.toString()}`,
    );
  }

  async getGroup(id: number): Promise<BuddyBossGroup> {
    return this.makeRequest<BuddyBossGroup>(`/groups/${id}`);
  }

  async joinGroup(id: number): Promise<{ success: boolean }> {
    return this.makeRequest<{ success: boolean }>(`/groups/${id}/members`, {
      method: 'POST',
    });
  }

  async leaveGroup(id: number): Promise<{ success: boolean }> {
    return this.makeRequest<{ success: boolean }>(`/groups/${id}/members`, {
      method: 'DELETE',
    });
  }

  // Activity Stream
  async getActivity(
    params: {
      per_page?: number;
      page?: number;
      component?: string;
      type?: string;
      user_id?: number;
      group_id?: number;
    } = {},
  ): Promise<BuddyBossActivity[]> {
    const searchParams = new URLSearchParams();
    searchParams.append('per_page', (params.per_page || 20).toString());
    searchParams.append('page', (params.page || 1).toString());
    if (params.component) searchParams.append('component', params.component);
    if (params.type) searchParams.append('type', params.type);
    if (params.user_id)
      searchParams.append('user_id', params.user_id.toString());
    if (params.group_id)
      searchParams.append('group_id', params.group_id.toString());

    return this.makeRequest<BuddyBossActivity[]>(
      `/activity?${searchParams.toString()}`,
    );
  }

  async postActivity(data: {
    content: string;
    component?: string;
    type?: string;
    user_id?: number;
    group_id?: number;
  }): Promise<BuddyBossActivity> {
    return this.makeRequest<BuddyBossActivity>('/activity', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  }

  async favoriteActivity(id: number): Promise<{ success: boolean }> {
    return this.makeRequest<{ success: boolean }>(`/activity/${id}/favorite`, {
      method: 'POST',
    });
  }

  async unfavoriteActivity(id: number): Promise<{ success: boolean }> {
    return this.makeRequest<{ success: boolean }>(`/activity/${id}/favorite`, {
      method: 'DELETE',
    });
  }

  // Members
  async getMembers(
    params: {
      per_page?: number;
      page?: number;
      type?: 'newest' | 'active' | 'alphabetical' | 'random' | 'online';
      search?: string;
    } = {},
  ): Promise<BuddyBossMember[]> {
    const searchParams = new URLSearchParams();
    searchParams.append('per_page', (params.per_page || 20).toString());
    searchParams.append('page', (params.page || 1).toString());
    if (params.type) searchParams.append('type', params.type);
    if (params.search) searchParams.append('search', params.search);

    return this.makeRequest<BuddyBossMember[]>(
      `/members?${searchParams.toString()}`,
    );
  }

  async getMember(id: number): Promise<BuddyBossMember> {
    return this.makeRequest<BuddyBossMember>(`/members/${id}`);
  }

  // Messages
  async getMessages(
    params: {
      per_page?: number;
      page?: number;
      thread_id?: number;
    } = {},
  ): Promise<BuddyBossMessage[]> {
    const searchParams = new URLSearchParams();
    searchParams.append('per_page', (params.per_page || 20).toString());
    searchParams.append('page', (params.page || 1).toString());
    if (params.thread_id)
      searchParams.append('thread_id', params.thread_id.toString());

    return this.makeRequest<BuddyBossMessage[]>(
      `/messages?${searchParams.toString()}`,
    );
  }

  async sendMessage(data: {
    recipients: number[];
    subject: string;
    message: string;
    thread_id?: number;
  }): Promise<BuddyBossMessage> {
    return this.makeRequest<BuddyBossMessage>('/messages', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  }

  // Notifications
  async getNotifications(
    params: {
      per_page?: number;
      page?: number;
      is_new?: boolean;
    } = {},
  ): Promise<BuddyBossNotification[]> {
    const searchParams = new URLSearchParams();
    searchParams.append('per_page', (params.per_page || 20).toString());
    searchParams.append('page', (params.page || 1).toString());
    if (params.is_new !== undefined) {
      searchParams.append('is_new', params.is_new.toString());
    }

    return this.makeRequest<BuddyBossNotification[]>(
      `/notifications?${searchParams.toString()}`,
    );
  }

  async markNotificationAsRead(id: number): Promise<{ success: boolean }> {
    return this.makeRequest<{ success: boolean }>(`/notifications/${id}`, {
      method: 'PUT',
      body: JSON.stringify({ is_new: false }),
    });
  }

  // Test API verbinding
  async testConnection(): Promise<{ success: boolean; error?: string }> {
    try {
      await this.makeRequest('/groups?per_page=1');
      return { success: true };
    } catch (error) {
      return {
        success: false,
        error: error instanceof Error ? error.message : 'Onbekende fout',
      };
    }
  }
}

export default BuddyBossAPI;
