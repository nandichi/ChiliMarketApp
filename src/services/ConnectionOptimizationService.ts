import { Platform } from 'react-native';

interface ConnectionConfig {
  enablePreconnect: boolean;
  enableDnsPrefetch: boolean;
  enableHttp2Push: boolean;
  connectionPoolSize: number;
  keepAliveTimeout: number;
}

interface DomainMetrics {
  domain: string;
  connectTime: number;
  lastUsed: number;
  connectionCount: number;
  success: boolean;
}

class ConnectionOptimizationService {
  private static instance: ConnectionOptimizationService;
  private domainMetrics: Map<string, DomainMetrics> = new Map();
  private preconnectedDomains: Set<string> = new Set();
  private connectionPool: Map<string, any> = new Map();

  private readonly config: ConnectionConfig = {
    enablePreconnect: true,
    enableDnsPrefetch: true,
    enableHttp2Push: true,
    connectionPoolSize: 6, // HTTP/1.1 browser limit
    keepAliveTimeout: 60000, // 60 seconds
  };

  // Kritieke domains voor Chili Market
  private readonly CRITICAL_DOMAINS = [
    'chili-market.com',
    'www.chili-market.com',
    'api.chili-market.com',
    'cdn.chili-market.com',
  ];

  // Externe services die gebruikt worden
  private readonly EXTERNAL_DOMAINS = [
    'fonts.googleapis.com',
    'fonts.gstatic.com',
    'cdnjs.cloudflare.com',
  ];

  public static getInstance(): ConnectionOptimizationService {
    if (!ConnectionOptimizationService.instance) {
      ConnectionOptimizationService.instance =
        new ConnectionOptimizationService();
    }
    return ConnectionOptimizationService.instance;
  }

  constructor() {
    this.initializeConnectionOptimizations();
    this.startConnectionMetricsCollection();
  }

  /**
   * Initialiseer connection optimalisaties
   */
  private async initializeConnectionOptimizations(): Promise<void> {
    console.log(
      '[ConnectionOptimizationService] Initializing connection optimizations',
    );

    // Pre-connect naar kritieke domains
    await this.preconnectToCriticalDomains();

    // DNS prefetch voor externe domains
    this.prefetchExternalDomains();

    // Setup connection pooling
    this.setupConnectionPooling();
  }

  /**
   * Pre-connect naar kritieke domains
   */
  private async preconnectToCriticalDomains(): Promise<void> {
    if (!this.config.enablePreconnect) return;

    console.log(
      '[ConnectionOptimizationService] Pre-connecting to critical domains',
    );

    for (const domain of this.CRITICAL_DOMAINS) {
      try {
        await this.preconnectToDomain(domain);
      } catch (error) {
        console.error(
          `[ConnectionOptimizationService] Error pre-connecting to ${domain}:`,
          error,
        );
      }
    }
  }

  /**
   * Pre-connect naar specifiek domain
   */
  private async preconnectToDomain(domain: string): Promise<void> {
    if (this.preconnectedDomains.has(domain)) {
      console.log(
        `[ConnectionOptimizationService] Already pre-connected to ${domain}`,
      );
      return;
    }

    const startTime = Date.now();

    try {
      // Simuleer DNS lookup en TCP handshake
      await this.performDnsLookup(domain);
      await this.establishTcpConnection(domain);

      const connectTime = Date.now() - startTime;

      this.preconnectedDomains.add(domain);
      this.updateDomainMetrics(domain, connectTime, true);

      console.log(
        `[ConnectionOptimizationService] Pre-connected to ${domain} in ${connectTime}ms`,
      );

      // Cleanup na timeout
      setTimeout(() => {
        this.preconnectedDomains.delete(domain);
      }, this.config.keepAliveTimeout);
    } catch (error) {
      const connectTime = Date.now() - startTime;
      this.updateDomainMetrics(domain, connectTime, false);
      throw error;
    }
  }

  /**
   * DNS prefetch voor externe domains
   */
  private prefetchExternalDomains(): void {
    if (!this.config.enableDnsPrefetch) return;

    console.log(
      '[ConnectionOptimizationService] DNS prefetching external domains',
    );

    this.EXTERNAL_DOMAINS.forEach(domain => {
      this.performDnsLookup(domain).catch(error => {
        console.error(
          `[ConnectionOptimizationService] DNS prefetch failed for ${domain}:`,
          error,
        );
      });
    });
  }

  /**
   * Voer DNS lookup uit
   */
  private async performDnsLookup(domain: string): Promise<void> {
    // In een echte implementatie zou dit native DNS lookup zijn
    return new Promise((resolve, reject) => {
      const timeout = setTimeout(() => {
        reject(new Error(`DNS lookup timeout for ${domain}`));
      }, 5000);

      // Simuleer DNS lookup tijd
      const dnsTime = 50 + Math.random() * 200; // 50-250ms

      setTimeout(() => {
        clearTimeout(timeout);
        console.log(
          `[ConnectionOptimizationService] DNS lookup for ${domain} completed in ${dnsTime.toFixed(
            1,
          )}ms`,
        );
        resolve();
      }, dnsTime);
    });
  }

  /**
   * Etableer TCP verbinding
   */
  private async establishTcpConnection(domain: string): Promise<void> {
    return new Promise((resolve, reject) => {
      const timeout = setTimeout(() => {
        reject(new Error(`TCP connection timeout for ${domain}`));
      }, 10000);

      // Simuleer TCP handshake tijd
      const tcpTime = 100 + Math.random() * 300; // 100-400ms

      setTimeout(() => {
        clearTimeout(timeout);
        console.log(
          `[ConnectionOptimizationService] TCP connection to ${domain} established in ${tcpTime.toFixed(
            1,
          )}ms`,
        );
        resolve();
      }, tcpTime);
    });
  }

  /**
   * Setup connection pooling
   */
  private setupConnectionPooling(): void {
    console.log(
      '[ConnectionOptimizationService] Setting up connection pooling',
    );

    // Voor elke kritieke domain een connection pool
    this.CRITICAL_DOMAINS.forEach(domain => {
      this.connectionPool.set(domain, {
        connections: [],
        maxConnections: this.config.connectionPoolSize,
        activeConnections: 0,
        lastCleanup: Date.now(),
      });
    });

    // Periodieke cleanup van connection pools
    setInterval(() => {
      this.cleanupConnectionPools();
    }, 30000); // Elke 30 seconden
  }

  /**
   * Cleanup connection pools
   */
  private cleanupConnectionPools(): void {
    const now = Date.now();

    for (const [domain, pool] of this.connectionPool) {
      // Cleanup old connections
      if (now - pool.lastCleanup > this.config.keepAliveTimeout) {
        pool.connections = [];
        pool.activeConnections = 0;
        pool.lastCleanup = now;
        console.log(
          `[ConnectionOptimizationService] Cleaned up connection pool for ${domain}`,
        );
      }
    }
  }

  /**
   * Update domain metrics
   */
  private updateDomainMetrics(
    domain: string,
    connectTime: number,
    success: boolean,
  ): void {
    const existing = this.domainMetrics.get(domain);

    const metrics: DomainMetrics = {
      domain,
      connectTime: existing
        ? (existing.connectTime + connectTime) / 2
        : connectTime, // Rolling average
      lastUsed: Date.now(),
      connectionCount: existing ? existing.connectionCount + 1 : 1,
      success,
    };

    this.domainMetrics.set(domain, metrics);
  }

  /**
   * Start metrics collectie
   */
  private startConnectionMetricsCollection(): void {
    console.log(
      '[ConnectionOptimizationService] Starting connection metrics collection',
    );

    // Log metrics elke 5 minuten
    setInterval(() => {
      this.logConnectionMetrics();
    }, 5 * 60 * 1000);
  }

  /**
   * Log connection metrics
   */
  private logConnectionMetrics(): void {
    console.log('[ConnectionOptimizationService] Connection Metrics:');

    for (const [domain, metrics] of this.domainMetrics) {
      console.log(
        `  ${domain}: ${metrics.connectTime.toFixed(1)}ms avg, ${
          metrics.connectionCount
        } connections, success: ${metrics.success}`,
      );
    }

    console.log(`  Pre-connected domains: ${this.preconnectedDomains.size}`);
    console.log(`  Connection pools: ${this.connectionPool.size}`);
  }

  /**
   * Optimaliseer verbinding voor specifieke URL
   */
  public async optimizeConnectionForUrl(url: string): Promise<void> {
    const domain = this.extractDomain(url);

    if (!domain) {
      console.warn(
        '[ConnectionOptimizationService] Could not extract domain from URL:',
        url,
      );
      return;
    }

    // Pre-connect als nog niet gedaan
    if (
      !this.preconnectedDomains.has(domain) &&
      this.CRITICAL_DOMAINS.includes(domain)
    ) {
      await this.preconnectToDomain(domain);
    }

    // DNS prefetch voor externe domains
    if (this.EXTERNAL_DOMAINS.includes(domain)) {
      this.performDnsLookup(domain).catch(console.error);
    }
  }

  /**
   * Extract domain van URL
   */
  private extractDomain(url: string): string | null {
    try {
      const urlObj = new URL(url);
      return urlObj.hostname;
    } catch {
      // Fallback voor relative URLs of invalid URLs
      const match = url.match(/^https?:\/\/([^\/]+)/);
      return match ? match[1] : null;
    }
  }

  /**
   * Warm connections voor user flow
   */
  public async warmConnectionsForUserFlow(urls: string[]): Promise<void> {
    console.log(
      '[ConnectionOptimizationService] Warming connections for user flow',
    );

    const domains = urls
      .map(url => this.extractDomain(url))
      .filter((domain): domain is string => domain !== null)
      .filter((domain, index, arr) => arr.indexOf(domain) === index); // Unique domains

    // Pre-connect parallel voor alle domains
    const preconnectPromises = domains.map(domain =>
      this.preconnectToDomain(domain).catch(error =>
        console.error(
          `[ConnectionOptimizationService] Failed to preconnect to ${domain}:`,
          error,
        ),
      ),
    );

    await Promise.allSettled(preconnectPromises);
  }

  /**
   * Krijg beste verbinding voor domain
   */
  public getBestConnectionForDomain(domain: string): any | null {
    const pool = this.connectionPool.get(domain);

    if (!pool || pool.connections.length === 0) {
      return null;
    }

    // Return minst recent gebruikte verbinding
    return pool.connections.shift();
  }

  /**
   * Return verbinding naar pool
   */
  public returnConnectionToPool(domain: string, connection: any): void {
    const pool = this.connectionPool.get(domain);

    if (pool && pool.connections.length < pool.maxConnections) {
      pool.connections.push(connection);
    }
  }

  /**
   * Get connection statistieken
   */
  public getConnectionStats(): {
    preconnectedDomains: number;
    totalConnections: number;
    averageConnectTime: number;
    successRate: number;
  } {
    const metrics = Array.from(this.domainMetrics.values());
    const totalConnections = metrics.reduce(
      (sum, m) => sum + m.connectionCount,
      0,
    );
    const successfulConnections = metrics.filter(m => m.success).length;
    const averageConnectTime =
      metrics.length > 0
        ? metrics.reduce((sum, m) => sum + m.connectTime, 0) / metrics.length
        : 0;

    return {
      preconnectedDomains: this.preconnectedDomains.size,
      totalConnections,
      averageConnectTime,
      successRate:
        metrics.length > 0 ? (successfulConnections / metrics.length) * 100 : 0,
    };
  }

  /**
   * Reset alle verbindingen en metrics
   */
  public reset(): void {
    console.log(
      '[ConnectionOptimizationService] Resetting all connections and metrics',
    );

    this.preconnectedDomains.clear();
    this.domainMetrics.clear();
    this.connectionPool.clear();

    // Herinitialiseer
    this.initializeConnectionOptimizations();
  }

  /**
   * Cleanup bij app shutdown
   */
  public destroy(): void {
    this.preconnectedDomains.clear();
    this.domainMetrics.clear();
    this.connectionPool.clear();
  }
}

export default ConnectionOptimizationService;
