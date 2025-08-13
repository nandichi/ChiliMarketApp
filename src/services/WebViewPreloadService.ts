import React from 'react';
import { WebView } from 'react-native-webview';
import { Dimensions } from 'react-native';

interface PreloadedWebView {
  url: string;
  webViewRef: React.RefObject<WebView<any>>;
  isLoaded: boolean;
  lastAccessed: Date;
}

class WebViewPreloadService {
  private static instance: WebViewPreloadService;
  private preloadedViews: Map<string, PreloadedWebView> = new Map();
  private maxPreloadedViews = 4;
  private preloadTimeout = 10000; // 10 seconden timeout voor pre-loading

  // URLs die standaard worden pre-loaded
  private readonly PRELOAD_URLS = [
    'https://chili-market.com/',
    'https://chili-market.com/marktplaats/',
    'https://chili-market.com/nieuws-feed/',
    'https://chili-market.com/leden/',
  ];

  public static getInstance(): WebViewPreloadService {
    if (!WebViewPreloadService.instance) {
      WebViewPreloadService.instance = new WebViewPreloadService();
    }
    return WebViewPreloadService.instance;
  }

  /**
   * Start pre-loading van alle belangrijke URLs bij app start
   */
  public async startPreloading(): Promise<void> {
    console.log(
      '[WebViewPreloadService] Starting preload of',
      this.PRELOAD_URLS.length,
      'URLs',
    );

    // Wacht kort om app startup niet te vertragen
    await new Promise(resolve => setTimeout(resolve, 2000));

    // Pre-load alle URLs parallel
    const preloadPromises = this.PRELOAD_URLS.map(url => this.preloadUrl(url));

    try {
      await Promise.allSettled(preloadPromises);
      console.log('[WebViewPreloadService] All URLs preload initiated');
    } catch (error) {
      console.error('[WebViewPreloadService] Error during preloading:', error);
    }
  }

  /**
   * Pre-load specifieke URL
   */
  private async preloadUrl(url: string): Promise<void> {
    return new Promise((resolve, reject) => {
      console.log('[WebViewPreloadService] Pre-loading:', url);

      const webViewRef = React.createRef<WebView<any>>();
      const startTime = Date.now();

      // Cleanup oude pre-loaded views als er te veel zijn
      this.cleanupOldViews();

      const preloadedView: PreloadedWebView = {
        url,
        webViewRef: webViewRef as React.RefObject<WebView<any>>,
        isLoaded: false,
        lastAccessed: new Date(),
      };

      this.preloadedViews.set(url, preloadedView);

      // Timeout voor pre-loading
      const timeoutId = setTimeout(() => {
        console.log('[WebViewPreloadService] Timeout voor:', url);
        reject(new Error(`Preload timeout voor ${url}`));
      }, this.preloadTimeout);

      // Simuleer WebView load (in echte implementatie zou dit een hidden WebView zijn)
      setTimeout(() => {
        clearTimeout(timeoutId);
        preloadedView.isLoaded = true;
        const loadTime = Date.now() - startTime;
        console.log(
          `[WebViewPreloadService] Pre-loaded ${url} in ${loadTime}ms`,
        );
        resolve();
      }, Math.random() * 3000 + 1000); // Simuleer 1-4 seconden load tijd
    });
  }

  /**
   * Haal een pre-loaded WebView op voor een URL
   */
  public getPreloadedView(url: string): PreloadedWebView | null {
    const preloadedView = this.preloadedViews.get(url);

    if (preloadedView && preloadedView.isLoaded) {
      preloadedView.lastAccessed = new Date();
      console.log(
        '[WebViewPreloadService] Returning pre-loaded view for:',
        url,
      );
      return preloadedView;
    }

    // Als niet pre-loaded, start background preload voor volgende keer
    if (!preloadedView) {
      this.preloadUrl(url).catch(console.error);
    }

    return null;
  }

  /**
   * Markeer URL als actief gebruikt (verhoogt prioriteit)
   */
  public markAsActive(url: string): void {
    const preloadedView = this.preloadedViews.get(url);
    if (preloadedView) {
      preloadedView.lastAccessed = new Date();
    }
  }

  /**
   * Pre-load een custom URL (bijv. gebruiker profiel)
   */
  public preloadCustomUrl(url: string): void {
    if (!this.preloadedViews.has(url)) {
      this.preloadUrl(url).catch(console.error);
    }
  }

  /**
   * Cleanup oude pre-loaded views om geheugen te besparen
   */
  private cleanupOldViews(): void {
    if (this.preloadedViews.size <= this.maxPreloadedViews) {
      return;
    }

    // Sorteer op last accessed tijd (oudste eerst)
    const sortedViews = Array.from(this.preloadedViews.entries()).sort(
      ([, a], [, b]) => a.lastAccessed.getTime() - b.lastAccessed.getTime(),
    );

    // Verwijder oudste views
    const toRemove = sortedViews.slice(
      0,
      sortedViews.length - this.maxPreloadedViews,
    );

    toRemove.forEach(([url]) => {
      console.log('[WebViewPreloadService] Removing old preloaded view:', url);
      this.preloadedViews.delete(url);
    });
  }

  /**
   * Cache warming voor verwante pagina's
   */
  public warmRelatedCache(currentUrl: string): void {
    // Pre-load verwante pagina's gebaseerd op huidige pagina
    if (currentUrl.includes('/leden/')) {
      this.preloadCustomUrl('https://chili-market.com/marktplaats/');
      this.preloadCustomUrl('https://chili-market.com/nieuws-feed/');
    } else if (currentUrl.includes('/marktplaats/')) {
      this.preloadCustomUrl('https://chili-market.com/leden/');
    }
  }

  /**
   * Reset alle pre-loaded views (bijv. bij auth state change)
   */
  public resetCache(): void {
    console.log('[WebViewPreloadService] Resetting all preloaded views');
    this.preloadedViews.clear();
    // Herstart preloading na kort interval
    setTimeout(() => this.startPreloading(), 1000);
  }

  /**
   * Krijg statistieken over pre-loaded views
   */
  public getStats(): { total: number; loaded: number; urls: string[] } {
    const loaded = Array.from(this.preloadedViews.values()).filter(
      v => v.isLoaded,
    ).length;
    const urls = Array.from(this.preloadedViews.keys());

    return {
      total: this.preloadedViews.size,
      loaded,
      urls,
    };
  }
}

export default WebViewPreloadService;
