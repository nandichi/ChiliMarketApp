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
   * DISABLED: Dit veroorzaakte problemen met accounts en inloggen
   */
  private handleAppStateChange = (nextAppState: AppStateStatus): void => {
    console.log(
      '[BackgroundLoadingManager] App state changed:',
      this.currentAppState,
      '->',
      nextAppState,
      '(background loading disabled)',
    );

    // Niet meer automatisch background loading starten/stoppen om account/login problemen te voorkomen
    this.currentAppState = nextAppState;
  };

  /**
   * Start background loading van alle tab URLs
   * DISABLED: Dit veroorzaakte problemen met accounts en inloggen
   */
  public async startBackgroundLoading(): Promise<void> {
    console.log('[BackgroundLoadingManager] Background loading is disabled');
    // Niet meer automatisch background loading starten om account/login problemen te voorkomen
    return;
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
   * DISABLED: Dit veroorzaakte problemen met accounts en inloggen
   */
  public preloadUserProfile(username: string): void {
    console.log(
      '[BackgroundLoadingManager] User profile preloading is disabled',
    );
    // Niet meer automatisch user profiles preloaden om account/login problemen te voorkomen
  }

  /**
   * Warm cache voor veel gebruikte pagina combinaties
   * DISABLED: Dit veroorzaakte problemen met accounts en inloggen
   */
  public warmCommonFlows(): void {
    console.log('[BackgroundLoadingManager] Cache warming is disabled');
    // Niet meer automatisch cache warmen om account/login problemen te voorkomen
  }

  /**
   * Reset background loading state (bijv. bij auth state change)
   * DISABLED: Dit veroorzaakte problemen met accounts en inloggen
   */
  public reset(): void {
    console.log(
      '[BackgroundLoadingManager] Background loading reset is disabled',
    );
    this.isLoading = false;
    // Niet meer automatisch cache resetten en herstarten om account/login problemen te voorkomen
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
