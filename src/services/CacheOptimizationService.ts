import AsyncStorage from '@react-native-async-storage/async-storage';

interface CacheEntry {
  data: any;
  timestamp: number;
  expiresAt: number;
  url: string;
  size: number;
}

interface CacheStats {
  totalEntries: number;
  totalSize: number;
  hitRate: number;
  missRate: number;
}

class CacheOptimizationService {
  private static instance: CacheOptimizationService;
  private cache: Map<string, CacheEntry> = new Map();
  private maxCacheSize = 50 * 1024 * 1024; // 50MB max cache
  private maxEntries = 500;
  private cacheHits = 0;
  private cacheMisses = 0;

  // Cache expiry times voor verschillende content types
  private readonly CACHE_EXPIRY = {
    html: 5 * 60 * 1000, // 5 minuten voor HTML pages
    css: 24 * 60 * 60 * 1000, // 24 uur voor CSS
    js: 24 * 60 * 60 * 1000, // 24 uur voor JavaScript
    images: 7 * 24 * 60 * 60 * 1000, // 7 dagen voor images
    api: 2 * 60 * 1000, // 2 minuten voor API calls
    default: 10 * 60 * 1000, // 10 minuten default
  };

  public static getInstance(): CacheOptimizationService {
    if (!CacheOptimizationService.instance) {
      CacheOptimizationService.instance = new CacheOptimizationService();
    }
    return CacheOptimizationService.instance;
  }

  constructor() {
    this.loadCacheFromStorage();
    this.startCacheCleanupSchedule();
  }

  /**
   * Cache een URL response
   */
  public async cacheResponse(
    url: string,
    data: any,
    contentType?: string,
  ): Promise<void> {
    try {
      const now = Date.now();
      const size = this.calculateDataSize(data);
      const expiry = this.getExpiryTime(url, contentType);

      const cacheEntry: CacheEntry = {
        data,
        timestamp: now,
        expiresAt: now + expiry,
        url,
        size,
      };

      // Check cache size limits
      await this.ensureCacheSpace(size);

      this.cache.set(url, cacheEntry);

      // Persist kritieke cache entries
      if (this.isCriticalUrl(url)) {
        await this.persistCacheEntry(url, cacheEntry);
      }

      console.log(
        `[CacheOptimizationService] Cached ${url} (${this.formatSize(size)})`,
      );
    } catch (error) {
      console.error(
        '[CacheOptimizationService] Error caching response:',
        error,
      );
    }
  }

  /**
   * Haal cached response op
   */
  public getCachedResponse(url: string): any | null {
    const entry = this.cache.get(url);

    if (!entry) {
      this.cacheMisses++;
      return null;
    }

    // Check expiry
    if (Date.now() > entry.expiresAt) {
      this.cache.delete(url);
      this.cacheMisses++;
      return null;
    }

    this.cacheHits++;
    console.log(`[CacheOptimizationService] Cache hit for ${url}`);
    return entry.data;
  }

  /**
   * Pre-cache kritieke resources
   */
  public async precacheResources(urls: string[]): Promise<void> {
    console.log(
      '[CacheOptimizationService] Pre-caching',
      urls.length,
      'resources',
    );

    const promises = urls.map(async url => {
      try {
        // Simuleer resource fetch (in echte implementatie zou dit fetch() zijn)
        const response = await this.simulateFetch(url);
        await this.cacheResponse(url, response);
      } catch (error) {
        console.error(
          `[CacheOptimizationService] Error pre-caching ${url}:`,
          error,
        );
      }
    });

    await Promise.allSettled(promises);
  }

  /**
   * Intelligente cache warming gebaseerd op gebruikerspatronen
   */
  public async warmCache(userPreferences?: any): Promise<void> {
    console.log(
      '[CacheOptimizationService] Warming cache based on user patterns',
    );

    // Basis URLs die altijd gecached worden
    const criticalUrls = [
      'https://chili-market.com/',
      'https://chili-market.com/marktplaats/',
      'https://chili-market.com/nieuws-feed/',
    ];

    // Voeg user-specifieke URLs toe
    if (userPreferences?.username) {
      criticalUrls.push(
        `https://chili-market.com/leden/${userPreferences.username}/`,
      );
    }

    // Voeg populaire categorieen toe
    const popularCategories = [
      'https://chili-market.com/marktplaats/categorieen/',
      'https://chili-market.com/marktplaats/recent/',
    ];

    await this.precacheResources([...criticalUrls, ...popularCategories]);
  }

  /**
   * Cleanup expired cache entries
   */
  public cleanupExpiredEntries(): void {
    const now = Date.now();
    let cleanedCount = 0;

    for (const [url, entry] of this.cache) {
      if (now > entry.expiresAt) {
        this.cache.delete(url);
        cleanedCount++;
      }
    }

    if (cleanedCount > 0) {
      console.log(
        `[CacheOptimizationService] Cleaned up ${cleanedCount} expired entries`,
      );
    }
  }

  /**
   * Cache size management
   */
  private async ensureCacheSpace(requiredSize: number): Promise<void> {
    const currentSize = this.getCurrentCacheSize();

    if (
      currentSize + requiredSize > this.maxCacheSize ||
      this.cache.size >= this.maxEntries
    ) {
      await this.evictLeastRecentlyUsed(requiredSize);
    }
  }

  /**
   * LRU eviction policy
   */
  private async evictLeastRecentlyUsed(requiredSize: number): Promise<void> {
    const entries = Array.from(this.cache.entries()).sort(
      ([, a], [, b]) => a.timestamp - b.timestamp,
    );

    let freedSize = 0;
    let evictedCount = 0;

    for (const [url, entry] of entries) {
      if (freedSize >= requiredSize && this.cache.size < this.maxEntries) {
        break;
      }

      // Bescherm kritieke cache entries
      if (this.isCriticalUrl(url)) {
        continue;
      }

      this.cache.delete(url);
      freedSize += entry.size;
      evictedCount++;
    }

    console.log(
      `[CacheOptimizationService] Evicted ${evictedCount} entries, freed ${this.formatSize(
        freedSize,
      )}`,
    );
  }

  /**
   * Bepaal of URL kritiek is voor app functionaliteit
   */
  private isCriticalUrl(url: string): boolean {
    const criticalPatterns = [
      'chili-market.com/$',
      'chili-market.com/marktplaats/$',
      'chili-market.com/nieuws-feed/$',
    ];

    return criticalPatterns.some(pattern => new RegExp(pattern).test(url));
  }

  /**
   * Bereken expiry tijd gebaseerd op content type
   */
  private getExpiryTime(url: string, contentType?: string): number {
    if (contentType) {
      if (contentType.includes('text/html')) return this.CACHE_EXPIRY.html;
      if (contentType.includes('text/css')) return this.CACHE_EXPIRY.css;
      if (contentType.includes('javascript')) return this.CACHE_EXPIRY.js;
      if (contentType.includes('image/')) return this.CACHE_EXPIRY.images;
    }

    // Bepaal op basis van URL extensie
    if (url.match(/\.(css)$/i)) return this.CACHE_EXPIRY.css;
    if (url.match(/\.(js)$/i)) return this.CACHE_EXPIRY.js;
    if (url.match(/\.(jpg|jpeg|png|gif|webp|svg)$/i))
      return this.CACHE_EXPIRY.images;
    if (url.includes('/api/')) return this.CACHE_EXPIRY.api;

    return this.CACHE_EXPIRY.default;
  }

  /**
   * Bereken data size voor cache management
   */
  private calculateDataSize(data: any): number {
    try {
      return JSON.stringify(data).length * 2; // Rough estimate (UTF-16)
    } catch {
      return 1024; // Default fallback
    }
  }

  /**
   * Get huidige cache size
   */
  private getCurrentCacheSize(): number {
    return Array.from(this.cache.values()).reduce(
      (total, entry) => total + entry.size,
      0,
    );
  }

  /**
   * Format size voor logging
   */
  private formatSize(bytes: number): string {
    if (bytes < 1024) return `${bytes}B`;
    if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)}KB`;
    return `${(bytes / (1024 * 1024)).toFixed(1)}MB`;
  }

  /**
   * Simuleer fetch voor pre-caching (in echte implementatie zou dit fetch() zijn)
   */
  private async simulateFetch(url: string): Promise<any> {
    // Simuleer network delay
    await new Promise(resolve =>
      setTimeout(resolve, 100 + Math.random() * 500),
    );

    return {
      url,
      content: `Cached content for ${url}`,
      timestamp: Date.now(),
    };
  }

  /**
   * Persist kritieke cache entries naar AsyncStorage
   */
  private async persistCacheEntry(
    url: string,
    entry: CacheEntry,
  ): Promise<void> {
    try {
      const key = `cache_${btoa(url).replace(/[^a-zA-Z0-9]/g, '')}`;
      await AsyncStorage.setItem(key, JSON.stringify(entry));
    } catch (error) {
      console.error(
        '[CacheOptimizationService] Error persisting cache entry:',
        error,
      );
    }
  }

  /**
   * Load persisted cache van AsyncStorage
   */
  private async loadCacheFromStorage(): Promise<void> {
    try {
      const keys = await AsyncStorage.getAllKeys();
      const cacheKeys = keys.filter(key => key.startsWith('cache_'));

      for (const key of cacheKeys) {
        try {
          const entryJson = await AsyncStorage.getItem(key);
          if (entryJson) {
            const entry: CacheEntry = JSON.parse(entryJson);

            // Check if entry is still valid
            if (Date.now() < entry.expiresAt) {
              this.cache.set(entry.url, entry);
            } else {
              await AsyncStorage.removeItem(key);
            }
          }
        } catch (error) {
          console.error(
            `[CacheOptimizationService] Error loading cache entry ${key}:`,
            error,
          );
          await AsyncStorage.removeItem(key);
        }
      }

      console.log(
        `[CacheOptimizationService] Loaded ${this.cache.size} cache entries from storage`,
      );
    } catch (error) {
      console.error(
        '[CacheOptimizationService] Error loading cache from storage:',
        error,
      );
    }
  }

  /**
   * Start periodieke cache cleanup
   */
  private startCacheCleanupSchedule(): void {
    // Cleanup elke 5 minuten
    setInterval(() => {
      this.cleanupExpiredEntries();
    }, 5 * 60 * 1000);
  }

  /**
   * Get cache statistieken
   */
  public getStats(): CacheStats {
    const totalRequests = this.cacheHits + this.cacheMisses;

    return {
      totalEntries: this.cache.size,
      totalSize: this.getCurrentCacheSize(),
      hitRate: totalRequests > 0 ? (this.cacheHits / totalRequests) * 100 : 0,
      missRate:
        totalRequests > 0 ? (this.cacheMisses / totalRequests) * 100 : 0,
    };
  }

  /**
   * Reset alle cache statistics
   */
  public resetStats(): void {
    this.cacheHits = 0;
    this.cacheMisses = 0;
  }

  /**
   * Clear complete cache
   */
  public async clearCache(): Promise<void> {
    this.cache.clear();

    // Clear persisted cache
    try {
      const keys = await AsyncStorage.getAllKeys();
      const cacheKeys = keys.filter(key => key.startsWith('cache_'));
      await AsyncStorage.multiRemove(cacheKeys);
    } catch (error) {
      console.error(
        '[CacheOptimizationService] Error clearing persisted cache:',
        error,
      );
    }

    console.log('[CacheOptimizationService] Cache cleared');
  }
}

export default CacheOptimizationService;
