import React from 'react';
import { AppState, AppStateStatus } from 'react-native';
import WebViewPreloadService from './WebViewPreloadService';

interface TabConfig {
  name: string;
  url: string;
  priority: number; // 1 = highest priority
  requiresAuth?: boolean;
}

class BackgroundLoadingManager {
  private static instance: BackgroundLoadingManager;
  private preloadService: WebViewPreloadService;
  private isLoading = false;
  private appStateListener: any;
  private currentAppState: AppStateStatus = 'active';

  // Tab configuraties met prioriteiten
  private readonly TAB_CONFIGS: TabConfig[] = [
    { name: 'Home', url: 'https://chili-market.com/', priority: 1 },
    {
      name: 'Marktplaats',
      url: 'https://chili-market.com/marktplaats/',
      priority: 2,
    },
    {
      name: 'NieuwsFeed',
      url: 'https://chili-market.com/nieuws-feed/',
      priority: 3,
    },
    {
      name: 'Profiel',
      url: 'https://chili-market.com/leden/',
      priority: 4,
      requiresAuth: true,
    },
  ];

  public static getInstance(): BackgroundLoadingManager {
    if (!BackgroundLoadingManager.instance) {
      BackgroundLoadingManager.instance = new BackgroundLoadingManager();
    }
    return BackgroundLoadingManager.instance;
  }

  constructor() {
    this.preloadService = WebViewPreloadService.getInstance();
    this.setupAppStateListener();
  }

  /**
   * Setup listener voor app state changes
   */
  private setupAppStateListener(): void {
    this.appStateListener = AppState.addEventListener(
      'change',
      this.handleAppStateChange,
    );
  }

  /**
   * Handle app state changes voor intelligente loading
   */
  private handleAppStateChange = (nextAppState: AppStateStatus): void => {
    console.log(
      '[BackgroundLoadingManager] App state changed:',
      this.currentAppState,
      '->',
      nextAppState,
    );

    if (
      this.currentAppState.match(/inactive|background/) &&
      nextAppState === 'active'
    ) {
      // App wordt weer actief - start background loading
      console.log(
        '[BackgroundLoadingManager] App became active, starting background loading',
      );
      this.startBackgroundLoading();
    } else if (nextAppState.match(/inactive|background/)) {
      // App gaat naar background - stop resource-intensive operations
      console.log(
        '[BackgroundLoadingManager] App went to background, pausing operations',
      );
      this.pauseBackgroundLoading();
    }

    this.currentAppState = nextAppState;
  };

  /**
   * Start background loading van alle tab URLs
   */
  public async startBackgroundLoading(): Promise<void> {
    if (this.isLoading) {
      console.log(
        '[BackgroundLoadingManager] Background loading already in progress',
      );
      return;
    }

    this.isLoading = true;
    console.log(
      '[BackgroundLoadingManager] Starting background loading for',
      this.TAB_CONFIGS.length,
      'tabs',
    );

    try {
      // Start met preload service
      await this.preloadService.startPreloading();

      // Sorteer tabs op prioriteit
      const sortedTabs = [...this.TAB_CONFIGS].sort(
        (a, b) => a.priority - b.priority,
      );

      // Load tabs in batches gebaseerd op prioriteit
      await this.loadTabsInBatches(sortedTabs);

      console.log('[BackgroundLoadingManager] Background loading completed');
    } catch (error) {
      console.error(
        '[BackgroundLoadingManager] Error during background loading:',
        error,
      );
    } finally {
      this.isLoading = false;
    }
  }

  /**
   * Load tabs in batches om system resources te sparen
   */
  private async loadTabsInBatches(tabs: TabConfig[]): Promise<void> {
    const batchSize = 2; // 2 tabs tegelijk laden

    for (let i = 0; i < tabs.length; i += batchSize) {
      const batch = tabs.slice(i, i + batchSize);
      console.log(
        '[BackgroundLoadingManager] Loading batch:',
        batch.map(t => t.name).join(', '),
      );

      // Load batch parallel
      const batchPromises = batch.map(tab => this.loadTab(tab));
      await Promise.allSettled(batchPromises);

      // Wacht tussen batches om system resources te sparen
      if (i + batchSize < tabs.length) {
        await new Promise(resolve => setTimeout(resolve, 1500));
      }
    }
  }

  /**
   * Load individuele tab
   */
  private async loadTab(tab: TabConfig): Promise<void> {
    try {
      console.log(
        `[BackgroundLoadingManager] Loading tab: ${tab.name} (${tab.url})`,
      );

      // Check of app nog actief is
      if (this.currentAppState !== 'active') {
        console.log(
          '[BackgroundLoadingManager] App not active, skipping tab load',
        );
        return;
      }

      // Pre-load de URL
      this.preloadService.preloadCustomUrl(tab.url);

      // Simuleer extra voorbereidingen voor verschillende tab types
      await this.prepareTabSpecificOptimizations(tab);
    } catch (error) {
      console.error(
        `[BackgroundLoadingManager] Error loading tab ${tab.name}:`,
        error,
      );
    }
  }

  /**
   * Tab-specifieke optimalisaties
   */
  private async prepareTabSpecificOptimizations(tab: TabConfig): Promise<void> {
    switch (tab.name) {
      case 'Home':
        // Pre-fetch homepage kritieke resources
        console.log('[BackgroundLoadingManager] Preparing Home optimizations');
        break;

      case 'Marktplaats':
        // Pre-fetch marktplaats data structures
        console.log(
          '[BackgroundLoadingManager] Preparing Marktplaats optimizations',
        );
        this.preloadService.preloadCustomUrl(
          'https://chili-market.com/marktplaats/recent/',
        );
        break;

      case 'NieuwsFeed':
        // Pre-fetch nieuws feed resources
        console.log(
          '[BackgroundLoadingManager] Preparing NieuwsFeed optimizations',
        );
        break;

      case 'Profiel':
        // Profile tab optimizations (alleen voor authenticated users)
        console.log(
          '[BackgroundLoadingManager] Preparing Profiel optimizations',
        );
        break;
    }

    // Wacht kort voor tab-specifieke operaties
    await new Promise(resolve => setTimeout(resolve, 500));
  }

  /**
   * Pause background loading (bijv. wanneer app naar background gaat)
   */
  public pauseBackgroundLoading(): void {
    if (this.isLoading) {
      console.log('[BackgroundLoadingManager] Pausing background loading');
      this.isLoading = false;
    }
  }

  /**
   * Pre-load een specifieke user profile URL
   */
  public preloadUserProfile(username: string): void {
    const profileUrl = `https://chili-market.com/leden/${username}/`;
    console.log(
      '[BackgroundLoadingManager] Pre-loading user profile:',
      profileUrl,
    );
    this.preloadService.preloadCustomUrl(profileUrl);
  }

  /**
   * Warm cache voor veel gebruikte pagina combinaties
   */
  public warmCommonFlows(): void {
    console.log('[BackgroundLoadingManager] Warming common user flows');

    // Veelgebruikte navigatie flows
    const commonFlows = [
      'https://chili-market.com/marktplaats/categorieen/',
      'https://chili-market.com/marktplaats/recent/',
      'https://chili-market.com/leden/zoeken/',
      'https://chili-market.com/help/',
    ];

    commonFlows.forEach(url => {
      this.preloadService.preloadCustomUrl(url);
    });
  }

  /**
   * Reset background loading state (bijv. bij auth state change)
   */
  public reset(): void {
    console.log(
      '[BackgroundLoadingManager] Resetting background loading state',
    );
    this.isLoading = false;
    this.preloadService.resetCache();

    // Herstart background loading na reset
    setTimeout(() => {
      this.startBackgroundLoading();
    }, 2000);
  }

  /**
   * Get loading status en statistieken
   */
  public getStatus(): {
    isLoading: boolean;
    appState: AppStateStatus;
    preloadStats: any;
  } {
    return {
      isLoading: this.isLoading,
      appState: this.currentAppState,
      preloadStats: this.preloadService.getStats(),
    };
  }

  /**
   * Cleanup bij app shutdown
   */
  public destroy(): void {
    if (this.appStateListener) {
      this.appStateListener.remove();
    }
    this.isLoading = false;
  }
}

export default BackgroundLoadingManager;
