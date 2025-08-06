const WORDPRESS_BASE_URL = 'https://chili-market.com/wp-json/wp/v2';
const JWT_AUTH_URL = 'https://chili-market.com/wp-json/custom-jwt/v1/login';
const WORDPRESS_REST_URL = 'https://chili-market.com/wp-json/wp/v2';

export interface WordPressPost {
  id: number;
  title: {
    rendered: string;
  };
  content: {
    rendered: string;
  };
  excerpt: {
    rendered: string;
  };
  featured_media: number;
  categories: number[];
  tags: number[];
  date: string;
  link: string;
  slug: string;
  status: string;
  _embedded?: {
    'wp:featuredmedia'?: Array<{
      source_url: string;
      alt_text: string;
    }>;
    'wp:term'?: Array<
      Array<{
        id: number;
        name: string;
        slug: string;
      }>
    >;
  };
}

export interface WordPressUser {
  id: number;
  name: string;
  email: string;
  username: string;
  roles: string[];
  avatar_urls: {
    [key: string]: string;
  };
  meta: Record<string, any>;
}

export interface WordPressCategory {
  id: number;
  name: string;
  slug: string;
  description: string;
  count: number;
  parent: number;
}

export interface WordPressMedia {
  id: number;
  source_url: string;
  alt_text: string;
  caption: {
    rendered: string;
  };
  media_details: {
    width: number;
    height: number;
    sizes: Record<
      string,
      {
        source_url: string;
        width: number;
        height: number;
      }
    >;
  };
}

export interface APIResponse<T> {
  data: T;
  total?: number;
  totalPages?: number;
}

class WordPressAPI {
  private baseURL: string;
  private jwtAuthURL: string;
  private restURL: string;
  private token?: string;
  private credentials?: {
    username: string;
    password: string;
  };
  private useJWT: boolean = false;

  constructor() {
    this.baseURL = WORDPRESS_BASE_URL;
    this.jwtAuthURL = JWT_AUTH_URL;
    this.restURL = WORDPRESS_REST_URL;
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
  ): Promise<{ data: T; headers: Headers }> {
    const url = `${this.baseURL}${endpoint}`;

    console.log(`WordPress API Request: ${url}`);

    try {
      // Voeg timeout toe aan alle requests
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 10000); // 10 seconden timeout

      const response = await fetch(url, {
        ...options,
        headers: {
          'Content-Type': 'application/json',
          ...this.getAuthHeaders(),
          ...options.headers,
        },
        signal: controller.signal,
      });

      clearTimeout(timeoutId);

      if (!response.ok) {
        const errorText = await response.text();
        console.error(`API Error Response: ${errorText}`);

        // Verbeterde error handling voor WordPress specifieke errors
        if (response.status === 401) {
          // Token is mogelijk verlopen, probeer te vernieuwen
          if (this.credentials && this.token) {
            console.log(
              'Token mogelijk verlopen, probeer opnieuw in te loggen...',
            );
            await this.refreshToken();
            // Probeer request opnieuw met nieuwe token
            return this.makeRequest(endpoint, options);
          }
          throw new Error(
            'Authenticatie mislukt. Controleer gebruikersnaam en wachtwoord.',
          );
        } else if (response.status === 403) {
          throw new Error('Geen toegang. Controleer gebruikerspermissies.');
        } else if (response.status === 404) {
          throw new Error(
            'API endpoint niet gevonden. Controleer WordPress configuratie.',
          );
        } else if (response.status >= 500) {
          throw new Error('Server fout. Probeer het later opnieuw.');
        }

        throw new Error(`API Error ${response.status}: ${errorText}`);
      }

      const data = await response.json();
      return { data, headers: response.headers };
    } catch (error) {
      console.error('WordPress API Error:', error);
      
      // Specifieke error handling voor timeout
      if (error instanceof Error && error.name === 'AbortError') {
        throw new Error('API request timeout. Controleer je internetverbinding en probeer opnieuw.');
      }
      
      throw error;
    }
  }

  // Verbeterde test connection methode
  async testConnection(): Promise<{ success: boolean; error?: string }> {
    try {
      console.log('Testing WordPress connection...');

      // Test basis WordPress site met timeout
      const siteController = new AbortController();
      const siteTimeoutId = setTimeout(() => siteController.abort(), 5000);
      
      const siteResponse = await fetch('https://chili-market.com/wp-json/', {
        signal: siteController.signal,
      });
      clearTimeout(siteTimeoutId);
      
      if (!siteResponse.ok) {
        return {
          success: false,
          error: `Website niet bereikbaar (${siteResponse.status})`,
        };
      }

      // Test REST API beschikbaarheid met timeout
      const apiController = new AbortController();
      const apiTimeoutId = setTimeout(() => apiController.abort(), 5000);
      
      const apiResponse = await fetch(this.baseURL, {
        signal: apiController.signal,
      });
      clearTimeout(apiTimeoutId);
      
      if (!apiResponse.ok) {
        return {
          success: false,
          error: `WordPress REST API niet beschikbaar (${apiResponse.status})`,
        };
      }

      // Test custom JWT Auth endpoint met timeout
      console.log('Testing custom JWT Auth endpoint...');
      const jwtController = new AbortController();
      const jwtTimeoutId = setTimeout(() => jwtController.abort(), 10000);
      
      const jwtResponse = await fetch(this.jwtAuthURL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username: 'test',
          password: 'test',
        }),
        signal: jwtController.signal,
      });
      clearTimeout(jwtTimeoutId);

      console.log('JWT Auth test response status:', jwtResponse.status);
      console.log(
        'JWT Auth test content-type:',
        jwtResponse.headers.get('content-type'),
      );

      // Controleer of JWT Auth endpoint JSON retourneert
      const jwtContentType = jwtResponse.headers.get('content-type');
      const isJwtJsonResponse =
        jwtContentType && jwtContentType.includes('application/json');

      if (jwtResponse.status === 404) {
        return {
          success: false,
          error:
            'Custom JWT Auth endpoint niet gevonden. Controleer thema configuratie.',
        };
      } else if (!isJwtJsonResponse) {
        // Als JWT endpoint geen JSON retourneert, is er waarschijnlijk een probleem
        const responseText = await jwtResponse.text();
        console.log(
          'JWT Auth endpoint returns non-JSON:',
          responseText.substring(0, 200),
        );

        if (
          responseText.includes('<html') ||
          responseText.includes('<!DOCTYPE')
        ) {
          return {
            success: false,
            error:
              'Custom JWT Auth endpoint retourneert HTML. Thema mogelijk niet correct geconfigureerd.',
          };
        }

        return {
          success: false,
          error:
            'Custom JWT Auth endpoint retourneert onverwacht formaat. Controleer thema configuratie.',
        };
      } else if (jwtResponse.status === 403) {
        // 403 met JSON response betekent dat het plugin werkt maar credentials fout zijn
        try {
          const jwtErrorData = await jwtResponse.json();
          console.log(
            'Custom JWT Auth endpoint is actief (verwachte 403 voor test credentials)',
          );
          console.log('JWT Auth error response:', jwtErrorData);
        } catch (error) {
          console.error('JWT Auth 403 response is geen geldige JSON');
          return {
            success: false,
            error: 'Custom JWT Auth endpoint retourneert ongeldige JSON response.',
          };
        }
      }

      const apiData = await apiResponse.json();
      console.log('WordPress API info:', apiData);

      return { success: true };
    } catch (error) {
      console.error('Connection test failed:', error);
      
      // Specifieke error handling voor timeout
      if (error instanceof Error && error.name === 'AbortError') {
        return {
          success: false,
          error: 'Verbindingsfout: timeout. Controleer je internetverbinding.',
        };
      }
      
      return {
        success: false,
        error:
          error instanceof Error ? error.message : 'Onbekende verbindingsfout',
      };
    }
  }

  // Tijdelijke authenticatie methode zonder JWT
  async loginWithoutJWT(username: string, password: string): Promise<WordPressUser> {
    console.log('Attempting login without JWT for user:', username);

    try {
      // Voor tijdelijke authenticatie, accepteer de login zonder verificatie
      // omdat we geen directe authenticatie hebben zonder JWT
      console.log('Login succesvol (tijdelijke methode):', {
        user: username,
      });

      // Bewaar credentials voor later gebruik
      this.credentials = {
        username: username.trim(),
        password: password.trim(),
      };

      // Maak een tijdelijke token voor authenticatie
      this.token = `temp_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
      this.useJWT = false;

      // Maak een tijdelijke gebruiker object
      return {
        id: Date.now(), // Tijdelijke ID
        name: username,
        email: `${username}@temporary.com`,
        username: username,
        roles: ['subscriber'],
        avatar_urls: {},
        meta: {},
      };
    } catch (error) {
      console.error('Login without JWT error:', error);
      throw error;
    }
  }

  async login(username: string, password: string): Promise<WordPressUser> {
    console.log('Attempting JWT login for user:', username);
    console.log('JWT Auth URL:', this.jwtAuthURL);

    try {
      console.log('Requesting JWT token from custom endpoint...');
      console.log('Request body:', JSON.stringify({
        username: username.trim(),
        password: '***' // Verberg wachtwoord in logs
      }));

      // Voeg timeout toe aan de fetch request
      const controller = new AbortController();
      const timeoutId = setTimeout(() => {
        console.log('[JWT Login] Timeout reached after 30 seconds');
        controller.abort();
      }, 30000); // 30 seconden timeout

      const response = await fetch(this.jwtAuthURL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username: username.trim(),
          password: password.trim(),
        }),
        signal: controller.signal,
      });

      clearTimeout(timeoutId);
      console.log('[JWT Login] Response received, timeout cleared');

      console.log('JWT login response status:', response.status);
      console.log(
        'JWT login response content-type:',
        response.headers.get('content-type'),
      );

      // Controleer eerst of de response JSON bevat
      const contentType = response.headers.get('content-type');
      const isJsonResponse =
        contentType && contentType.includes('application/json');

      if (!response.ok) {
        let errorMessage = `HTTP ${response.status}`;

        if (isJsonResponse) {
          try {
            const errorData = await response.json();
            console.error('JWT login error response:', errorData);
            console.error('JWT login error details:', JSON.stringify(errorData, null, 2));
            errorMessage = errorData.message || errorData.error || errorMessage;
          } catch (jsonError) {
            console.error('Failed to parse error response as JSON:', jsonError);
          }
        } else {
          // Als het geen JSON is, lees de response als tekst voor debugging
          const errorText = await response.text();
          console.error(
            'JWT login error response (not JSON):',
            errorText.substring(0, 200),
          );

          if (errorText.includes('<html') || errorText.includes('<!DOCTYPE')) {
            errorMessage =
              'Server retourneert HTML in plaats van JSON. Controleer JWT Auth plugin installatie.';
          }
        }

        if (response.status === 401 || response.status === 403) {
          throw new Error('Ongeldige gebruikersnaam of wachtwoord.');
        } else if (response.status === 404) {
          throw new Error(
            'Custom JWT Auth endpoint niet gevonden. Controleer thema configuratie.',
          );
        } else if (response.status >= 500) {
          throw new Error('Server error. Controleer WordPress configuratie.');
        }

        throw new Error(`Login fout: ${errorMessage}`);
      }

      // Voor succesvolle response, controleer ook of het JSON is
      if (!isJsonResponse) {
        const responseText = await response.text();
        console.error(
          'Success response is not JSON:',
          responseText.substring(0, 200),
        );
        throw new Error(
          'Server retourneert onverwacht response formaat. Controleer custom JWT Auth endpoint configuratie.',
        );
      }

      const tokenData = await response.json();
      console.log('JWT token response volledig:', tokenData);
      console.log('JWT token ontvangen:', {
        user: tokenData.user?.display_name,
        email: tokenData.user?.user_email,
        token: tokenData.token ? 'Aanwezig' : 'Ontbreekt',
      });

      // Controleer of we een geldige token hebben
      if (!tokenData.token) {
        console.error('JWT response bevat geen token:', tokenData);
        throw new Error('Server retourneert geen geldige JWT token. Controleer custom JWT Auth endpoint configuratie.');
      }

      // Bewaar token en credentials
      this.token = tokenData.token;
      this.credentials = {
        username: username.trim(),
        password: password.trim(),
      };
      this.useJWT = true;

      // Als de JWT response geen gebruikersdetails bevat, haal ze op via de API
      if (!tokenData.user?.display_name || !tokenData.user?.user_email) {
        console.log('JWT response bevat geen gebruikersdetails, haal op via API...');
        try {
          const userDetails = await this.getCurrentUser();
          console.log('Gebruikersdetails opgehaald via API:', userDetails);
          return userDetails;
        } catch (apiError) {
          console.error('Fout bij ophalen gebruikersdetails via API:', apiError);
          // Fallback: maak een gebruiker object met beschikbare data
          return {
            id: tokenData.user?.ID || Date.now(),
            name: tokenData.user?.display_name || username,
            email: tokenData.user?.user_email || `${username}@chili-market.com`,
            username: tokenData.user?.user_login || username,
            roles: ['subscriber'],
            avatar_urls: {},
            meta: {},
          };
        }
      }

      // Als we wel gebruikersdetails hebben, maak een gebruiker object
      const user: WordPressUser = {
        id: tokenData.user?.ID || Date.now(),
        name: tokenData.user?.display_name || username,
        email: tokenData.user?.user_email || `${username}@chili-market.com`,
        username: tokenData.user?.user_login || username,
        roles: ['subscriber'],
        avatar_urls: {},
        meta: {},
      };

      console.log('Login succesvol met gebruiker:', user);
      return user;
    } catch (error) {
      console.error('JWT login error:', error);
      
      // Specifieke error handling voor timeout
      if (error instanceof Error && error.name === 'AbortError') {
        throw new Error('Login timeout. Controleer je internetverbinding en probeer opnieuw.');
      }
      
      throw error;
    }
  }

  // Token vernieuwen
  private async refreshToken(): Promise<void> {
    if (!this.credentials) {
      throw new Error('Geen opgeslagen credentials voor token refresh');
    }

    // Voor tijdelijke authenticatie, maak nieuwe tijdelijke token
    if (!this.useJWT) {
      this.token = `temp_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
      console.log('Tijdelijke token vernieuwd');
      return;
    }

    console.log('Refreshing JWT token...');

    const response = await fetch(this.jwtAuthURL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(this.credentials),
    });

    if (!response.ok) {
      // Als refresh faalt, clear credentials
      this.token = undefined;
      this.credentials = undefined;
      throw new Error('Token refresh mislukt. Log opnieuw in.');
    }

    const tokenData = await response.json();
    this.token = tokenData.token;
    console.log('JWT token vernieuwd');
  }

  // Token valideren
  async validateToken(): Promise<boolean> {
    if (!this.token) return false;

    // Voor tijdelijke tokens, altijd geldig
    if (!this.useJWT) {
      return true;
    }

    try {
      // Voor custom JWT endpoint, valideer door een test request te doen
      const response = await fetch(`${WORDPRESS_BASE_URL}/users/me`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${this.token}`,
        },
      });

      const isValid = response.ok;
      console.log('Token validation result:', isValid);
      return isValid;
    } catch (error) {
      console.error('Token validation error:', error);
      return false;
    }
  }

  // Logout
  logout(): void {
    this.token = undefined;
    this.credentials = undefined;
    this.useJWT = false;
    console.log('Logout: token cleared');
  }

  // Check authenticatie status
  isAuthenticated(): boolean {
    return !!this.token;
  }

  // Get JWT token for WebView authentication
  getAuthToken(): string | undefined {
    return this.token;
  }

  // Get user credentials for WebView authentication
  getCredentials(): { username: string; password: string } | undefined {
    return this.credentials;
  }

  // Huidige gebruiker ophalen
  async getCurrentUser(): Promise<WordPressUser> {
    if (!this.token) {
      throw new Error('Niet ingelogd - geen token');
    }

    // Voor tijdelijke authenticatie, gebruik opgeslagen credentials
    if (!this.useJWT && this.credentials) {
      return {
        id: Date.now(), // Tijdelijke ID
        name: this.credentials.username,
        email: `${this.credentials.username}@temporary.com`,
        username: this.credentials.username,
        roles: ['subscriber'],
        avatar_urls: {},
        meta: {},
      };
    }

    // Voor JWT authenticatie met timeout
    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 8000); // 8 seconden timeout

      const response = await fetch(`${this.baseURL}/users/me`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${this.token}`,
        },
        signal: controller.signal,
      });

      clearTimeout(timeoutId);

      if (!response.ok) {
        console.error('getCurrentUser API error:', response.status, response.statusText);
        throw new Error(`Fout bij ophalen gebruikersgegevens: ${response.status}`);
      }

      const data = await response.json();
      console.log('getCurrentUser response:', data);
      return data;
    } catch (error) {
      console.error('getCurrentUser error:', error);
      
      if (error instanceof Error && error.name === 'AbortError') {
        throw new Error('Timeout bij ophalen gebruikersgegevens. Probeer opnieuw.');
      }
      
      throw error;
    }
  }

  // Verbeterde debugging methode voor API status
  async debugAPI(): Promise<void> {
    console.log('=== WordPress API Debug Info ===');

    try {
      // Test basis site
      const siteResponse = await fetch('https://chili-market.com/');
      console.log('Site reachable:', siteResponse.ok, siteResponse.status);

      // Test WordPress JSON endpoint
      const wpJsonResponse = await fetch('https://chili-market.com/wp-json/');
      if (wpJsonResponse.ok) {
        const wpJsonData = await wpJsonResponse.json();
        console.log('WordPress info:', {
          name: wpJsonData.name,
          description: wpJsonData.description,
          url: wpJsonData.url,
          home: wpJsonData.home,
          namespaces: wpJsonData.namespaces,
        });
      }

      // Test REST API v2
      const apiResponse = await fetch(this.baseURL);
      if (apiResponse.ok) {
        const apiData = await apiResponse.json();
        console.log('REST API v2 info:', apiData);
      }

      // Test custom JWT Auth endpoint
      console.log('Testing custom JWT Auth endpoint...');
      const jwtTestResponse = await fetch(this.jwtAuthURL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username: 'testuser',
          password: 'testpass',
        }),
      });

      console.log('JWT Auth endpoint status:', jwtTestResponse.status);
      if (jwtTestResponse.status === 403) {
        console.log(
          '✅ Custom JWT Auth endpoint is actief (verwachte 403 voor foute credentials)',
        );
      } else if (jwtTestResponse.status === 404) {
        console.log('❌ Custom JWT Auth endpoint niet gevonden');
      } else {
        console.log('JWT Auth response:', jwtTestResponse.status);
      }

      // Test users endpoint (public)
      const usersResponse = await fetch(`${this.baseURL}/users`);
      console.log('Users endpoint status:', usersResponse.status);
      if (usersResponse.ok) {
        const users = await usersResponse.json();
        console.log(
          'Available users:',
          users.map((u: any) => ({
            id: u.id,
            name: u.name,
            slug: u.slug,
            roles: u.roles || 'unknown',
          })),
        );
      }

      // Test posts endpoint
      const postsResponse = await fetch(`${this.baseURL}/posts?per_page=1`);
      console.log('Posts endpoint status:', postsResponse.status);
    } catch (error) {
      console.error('Debug API error:', error);
    }

    console.log('=== End Debug Info ===');
  }

  // Specifieke JWT Auth debugging
  async debugJWTAuth(): Promise<{
    isAvailable: boolean;
    returnsJson: boolean;
    errorDetails?: string;
    responsePreview?: string;
    fullResponse?: any;
  }> {
    console.log('=== JWT Auth Debug ===');

    try {
      const testResponse = await fetch(this.jwtAuthURL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username: 'debug_test',
          password: 'debug_test',
        }),
      });

      console.log('JWT Auth Status:', testResponse.status);
      console.log(
        'JWT Auth Headers:',
        Object.fromEntries(testResponse.headers.entries()),
      );

      const contentType = testResponse.headers.get('content-type') || '';
      const isJson = contentType.includes('application/json');

      // Lees response als tekst eerst
      const responseText = await testResponse.text();
      const responsePreview = responseText.substring(0, 300);

      console.log('Content-Type:', contentType);
      console.log('Is JSON:', isJson);
      console.log('Response preview:', responsePreview);

      let result: {
        isAvailable: boolean;
        returnsJson: boolean;
        errorDetails?: string;
        responsePreview?: string;
        fullResponse?: any;
      } = {
        isAvailable: testResponse.status !== 404,
        returnsJson: isJson,
        responsePreview: responsePreview,
      };

      if (testResponse.status === 404) {
        result.errorDetails =
          'Custom JWT Auth endpoint niet gevonden - thema niet geconfigureerd';
      } else if (!isJson) {
        if (
          responseText.includes('<html') ||
          responseText.includes('<!DOCTYPE')
        ) {
          result.errorDetails =
            'Endpoint retourneert HTML - mogelijk WordPress error of thema niet actief';
        } else {
          result.errorDetails = 'Endpoint retourneert onbekend formaat';
        }
      } else if (testResponse.status === 403) {
        try {
          const jsonData = JSON.parse(responseText);
          console.log(
            'Custom JWT Auth werkt correct - 403 met JSON response:',
            jsonData,
          );
          result.errorDetails =
            'Custom endpoint werkt correct (verwachte 403 voor test credentials)';
          result.fullResponse = jsonData;
        } catch (e) {
          result.errorDetails =
            'Response heeft JSON content-type maar is geen geldige JSON';
        }
      } else if (testResponse.status === 200) {
        try {
          const jsonData = JSON.parse(responseText);
          console.log('Custom JWT Auth succesvol response:', jsonData);
          result.fullResponse = jsonData;
          result.errorDetails = 'Custom endpoint werkt en retourneert succesvolle response';
        } catch (e) {
          result.errorDetails = 'Response is 200 maar geen geldige JSON';
        }
      }

      console.log('Debug resultaat:', result);
      console.log('=== End JWT Auth Debug ===');

      return result;
    } catch (error) {
      console.error('JWT Auth debug error:', error);
      return {
        isAvailable: false,
        returnsJson: false,
        errorDetails: `Network error: ${
          error instanceof Error ? error.message : 'Unknown error'
        }`,
      };
    }
  }

  // Posts ophalen (voor producten/content)
  async getPosts(
    params: {
      per_page?: number;
      page?: number;
      categories?: number[];
      search?: string;
      _embed?: boolean;
      status?: string;
    } = {},
  ): Promise<APIResponse<WordPressPost[]>> {
    const searchParams = new URLSearchParams();

    // Default parameters
    searchParams.append('per_page', (params.per_page || 10).toString());
    searchParams.append('page', (params.page || 1).toString());
    searchParams.append('_embed', (params._embed !== false).toString());

    if (params.categories && params.categories.length > 0) {
      searchParams.append('categories', params.categories.join(','));
    }
    if (params.search) {
      searchParams.append('search', params.search);
    }
    if (params.status) {
      searchParams.append('status', params.status);
    }

    const endpoint = `/posts?${searchParams.toString()}`;
    const { data, headers } = await this.makeRequest<WordPressPost[]>(endpoint);

    return {
      data,
      total: parseInt(headers.get('X-WP-Total') || '0'),
      totalPages: parseInt(headers.get('X-WP-TotalPages') || '0'),
    };
  }

  // Specifieke post ophalen
  async getPost(id: number): Promise<WordPressPost> {
    const { data } = await this.makeRequest<WordPressPost>(
      `/posts/${id}?_embed=true`,
    );
    return data;
  }

  // Categorieën ophalen
  async getCategories(
    params: {
      per_page?: number;
      hide_empty?: boolean;
    } = {},
  ): Promise<WordPressCategory[]> {
    const searchParams = new URLSearchParams();
    searchParams.append('per_page', (params.per_page || 100).toString());
    searchParams.append('hide_empty', (params.hide_empty !== false).toString());

    const endpoint = `/categories?${searchParams.toString()}`;
    const { data } = await this.makeRequest<WordPressCategory[]>(endpoint);
    return data;
  }

  // Media ophalen
  async getMedia(id: number): Promise<WordPressMedia> {
    const { data } = await this.makeRequest<WordPressMedia>(`/media/${id}`);
    return data;
  }

  // Zoeken in content
  async search(
    query: string,
    params: {
      type?: 'posts' | 'pages';
      per_page?: number;
    } = {},
  ): Promise<WordPressPost[]> {
    const searchParams = new URLSearchParams();
    searchParams.append('search', query);
    searchParams.append('per_page', (params.per_page || 20).toString());
    searchParams.append('_embed', 'true');

    const type = params.type || 'posts';
    const endpoint = `/${type}?${searchParams.toString()}`;
    const { data } = await this.makeRequest<WordPressPost[]>(endpoint);
    return data;
  }

  // Producten ophalen (als custom post type bestaat)
  async getProducts(
    params: {
      per_page?: number;
      page?: number;
      category?: string;
    } = {},
  ): Promise<WordPressPost[]> {
    try {
      // Probeer eerst als custom post type
      const searchParams = new URLSearchParams();
      searchParams.append('per_page', (params.per_page || 10).toString());
      searchParams.append('page', (params.page || 1).toString());
      searchParams.append('_embed', 'true');

      if (params.category) {
        searchParams.append('categories', params.category);
      }

      const endpoint = `/products?${searchParams.toString()}`;
      const { data } = await this.makeRequest<WordPressPost[]>(endpoint);
      return data;
    } catch (error) {
      // Fallback: zoek in gewone posts met product-gerelateerde categorieën
      console.log('Products endpoint not found, falling back to posts');
      const categories = await this.getCategories();
      const productCategories = categories
        .filter(
          cat =>
            cat.name.toLowerCase().includes('product') ||
            cat.slug.includes('product') ||
            cat.name.toLowerCase().includes('groenten') ||
            cat.name.toLowerCase().includes('fruit'),
        )
        .map(cat => cat.id);

      const { data } = await this.getPosts({
        categories: productCategories,
        per_page: params.per_page,
        page: params.page,
      });

      return data;
    }
  }
}

export default WordPressAPI;
