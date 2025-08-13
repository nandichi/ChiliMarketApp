import React, {
  useState,
  useEffect,
  useRef,
  useCallback,
  useMemo,
} from 'react';
import {
  View,
  StyleSheet,
  ActivityIndicator,
  Text,
  TouchableOpacity,
  Dimensions,
} from 'react-native';
import { WebView, WebViewProps } from 'react-native-webview';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import { useAuth } from '../context/AuthContext';
import WebViewPreloadService from '../services/WebViewPreloadService';

const { width: screenWidth } = Dimensions.get('window');

interface EnhancedWebViewProps extends Omit<WebViewProps, 'source'> {
  url: string;
  preloadEnabled?: boolean;
  showLoadingProgress?: boolean;
  enableAdvancedCaching?: boolean;
  blockAds?: boolean;
  enableResourceOptimization?: boolean;
}

// Uitgebreide lijst van te blokkeren resources voor betere performance
const BLOCKED_DOMAINS = [
  // Analytics & Tracking
  'google-analytics.com',
  'googletagmanager.com',
  'googlesyndication.com',
  'googleadservices.com',
  'doubleclick.net',
  'facebook.com/tr',
  'fbcdn.net/tr',
  'hotjar.com',
  'mixpanel.com',
  'segment.com',
  'amplitude.com',

  // Social Media Widgets
  'youtube.com/embed',
  'twitter.com/widgets',
  'instagram.com/embed',
  'linkedin.com/embed',
  'tiktok.com/embed',

  // Ad Networks
  'adsystem.com',
  'amazon-adsystem.com',
  'googlesyndication.com',
  'amazon.com/gp/ads',
  'media.net',
  'outbrain.com',
  'taboola.com',
  'criteo.com',

  // Chat Widgets
  'intercom.io',
  'zendesk.com',
  'livechatinc.com',
  'freshchat.com',

  // Unnecessary JS Libraries
  'cdnjs.cloudflare.com/ajax/libs/jquery',
  'code.jquery.com',
  'unpkg.com',
  'jsdelivr.net',
];

export default function EnhancedWebView({
  url,
  preloadEnabled = true,
  showLoadingProgress = true,
  enableAdvancedCaching = true,
  blockAds = true,
  enableResourceOptimization = true,
  onLoadStart,
  onLoadEnd,
  onError,
  onShouldStartLoadWithRequest,
  injectedJavaScript,
  ...props
}: EnhancedWebViewProps) {
  const { user, isAuthenticated, isGuest, api } = useAuth();
  const [loading, setLoading] = useState(true);
  const [loadingProgress, setLoadingProgress] = useState(0);
  const [error, setError] = useState(false);
  const [retryCount, setRetryCount] = useState(0);
  const webViewRef = useRef<WebView>(null);
  const preloadService = WebViewPreloadService.getInstance();
  const token = api.getAuthToken();

  // Performance optimalisatie: stabiele key voor WebView
  const webViewKey = useMemo(() => {
    return `enhanced-webview-${url}-${
      isAuthenticated ? 'auth' : isGuest ? 'guest' : 'none'
    }-${retryCount}`;
  }, [url, isAuthenticated, isGuest, retryCount]);

  // Check voor pre-loaded view
  const preloadedView = useMemo(() => {
    if (preloadEnabled) {
      return preloadService.getPreloadedView(url);
    }
    return null;
  }, [url, preloadEnabled]);

  // Enhanced resource blocking
  const shouldStartLoadWithRequest = useCallback(
    (request: any) => {
      const requestUrl = request.url.toLowerCase();

      // Custom handler eerst
      if (onShouldStartLoadWithRequest) {
        const customResult = onShouldStartLoadWithRequest(request);
        if (!customResult) return false;
      }

      // Blokkeer ads en tracking als enabled
      if (blockAds || enableResourceOptimization) {
        const isBlocked = BLOCKED_DOMAINS.some(domain =>
          requestUrl.includes(domain),
        );

        if (isBlocked) {
          console.log(
            '[EnhancedWebView] BLOCKED resource:',
            requestUrl.substring(0, 100),
          );
          return false;
        }
      }

      // Blokkeer zeer grote images voor snelheid
      if (enableResourceOptimization) {
        const isLargeImage = request.url.match(
          /\.(jpg|jpeg|png|gif|webp)\?.*w=([0-9]+)/,
        );
        if (isLargeImage) {
          const width = parseInt(isLargeImage[2]);
          if (width > screenWidth * 2) {
            console.log('[EnhancedWebView] BLOCKED large image:', width, 'px');
            return false;
          }
        }
      }

      return true;
    },
    [blockAds, enableResourceOptimization, onShouldStartLoadWithRequest],
  );

  // Enhanced load handlers
  const handleLoadStart = useCallback(
    (syntheticEvent: any) => {
      console.log('[EnhancedWebView] Load started for:', url);
      setError(false);
      setLoading(true);
      setLoadingProgress(0);

      // Markeer als actief in preload service
      preloadService.markAsActive(url);

      if (onLoadStart) {
        onLoadStart(syntheticEvent);
      }
    },
    [url, onLoadStart],
  );

  const handleLoadProgress = useCallback(
    (syntheticEvent: any) => {
      const progress = syntheticEvent.nativeEvent.progress;
      setLoadingProgress(progress);

      // Als bijna geladen, start cache warming voor gerelateerde pagina's
      if (progress > 0.8) {
        preloadService.warmRelatedCache(url);
      }
    },
    [url],
  );

  const handleLoadEnd = useCallback(
    (syntheticEvent: any) => {
      console.log('[EnhancedWebView] Load completed for:', url);
      setError(false);
      setLoading(false);
      setLoadingProgress(1);

      if (onLoadEnd) {
        onLoadEnd(syntheticEvent);
      }
    },
    [url, onLoadEnd],
  );

  const handleError = useCallback(
    (syntheticEvent: any) => {
      console.error(
        '[EnhancedWebView] Load error for:',
        url,
        syntheticEvent.nativeEvent,
      );
      setError(true);
      setLoading(false);

      if (onError) {
        onError(syntheticEvent);
      }
    },
    [url, onError],
  );

  const handleRetry = useCallback(() => {
    setError(false);
    setLoading(true);
    setRetryCount(prev => prev + 1);
  }, []);

  // Enhanced injected JavaScript met performance optimalisaties
  const enhancedInjectedJS = useMemo(() => {
    let jsCode = `
      (function() {
        console.log('[EnhancedWebView] Enhanced script injected for ${url}');
        
        // Performance optimalisaties
        ${
          enableResourceOptimization
            ? `
        // Lazy load images
        document.addEventListener('DOMContentLoaded', function() {
          const images = document.querySelectorAll('img[data-src]');
          if ('IntersectionObserver' in window) {
            const imageObserver = new IntersectionObserver((entries, observer) => {
              entries.forEach(entry => {
                if (entry.isIntersecting) {
                  const img = entry.target;
                  img.src = img.dataset.src;
                  img.removeAttribute('data-src');
                  imageObserver.unobserve(img);
                }
              });
            });
            images.forEach(img => imageObserver.observe(img));
          }
        });
        
        // Remove heavy widgets
        setTimeout(() => {
          const selectors = [
            'iframe[src*="youtube"]',
            'iframe[src*="facebook"]',
            'iframe[src*="twitter"]',
            '.fb-like',
            '.twitter-tweet',
            '[class*="disqus"]'
          ];
          selectors.forEach(selector => {
            document.querySelectorAll(selector).forEach(el => el.remove());
          });
        }, 1000);
        `
            : ''
        }
        
        // Authentication logic
        ${
          isAuthenticated && user && token
            ? `
        const token = '${token}';
        if (token && token !== 'undefined' && token !== 'null') {
          if (!document.cookie.includes('wordpress_logged_in')) {
            setTimeout(() => {
              fetch('https://chili-market.com/wp-json/custom-jwt/v1/session', {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer ' + token
                }
              }).then(res => res.json()).then(data => {
                console.log('[EnhancedWebView] JWT result:', data.success ? 'SUCCESS' : 'FAILED');
                if (data.success) {
                  window.ReactNativeWebView?.postMessage('auth_success');
                }
              }).catch(e => {
                console.log('[EnhancedWebView] JWT error:', e.message);
              });
            }, 500);
          }
        }
        `
            : ''
        }
        
        // Custom injected code
        ${injectedJavaScript || ''}
        
        true;
      })();
    `;

    return jsCode;
  }, [
    url,
    isAuthenticated,
    user,
    token,
    injectedJavaScript,
    enableResourceOptimization,
  ]);

  // Enhanced WebView props
  const webViewProps = useMemo(
    () => ({
      source: { uri: url },
      style: styles.webView,
      onLoadStart: handleLoadStart,
      onLoadProgress: showLoadingProgress ? handleLoadProgress : undefined,
      onLoadEnd: handleLoadEnd,
      onError: handleError,
      onShouldStartLoadWithRequest: shouldStartLoadWithRequest,
      injectedJavaScript: enhancedInjectedJS,

      // Performance optimalisaties
      startInLoadingState: false,
      renderLoading: () => <View />,
      scalesPageToFit: true,
      bounces: false,
      scrollEnabled: true,
      showsHorizontalScrollIndicator: false,
      showsVerticalScrollIndicator: true,

      // Caching optimalisaties
      domStorageEnabled: enableAdvancedCaching,
      javaScriptEnabled: true,
      cacheEnabled: enableAdvancedCaching,
      cacheMode: enableAdvancedCaching
        ? 'LOAD_CACHE_ELSE_NETWORK'
        : 'LOAD_DEFAULT',

      // Media optimalisaties
      allowsInlineMediaPlayback: true,
      mediaPlaybackRequiresUserAction: false,
      allowsFullscreenVideo: true,

      // Security & compatibility
      mixedContentMode: 'compatibility' as const,
      thirdPartyCookiesEnabled: true,
      sharedCookiesEnabled: true,
      allowsBackForwardNavigationGestures: true,

      // Custom User Agent
      userAgent: `ChiliMarketApp/1.0 Enhanced (Mobile; ${
        isAuthenticated
          ? 'Authenticated'
          : isGuest
          ? 'Guest'
          : 'NotAuthenticated'
      })`,

      ...props,
    }),
    [
      url,
      handleLoadStart,
      handleLoadEnd,
      handleError,
      shouldStartLoadWithRequest,
      enhancedInjectedJS,
      showLoadingProgress,
      handleLoadProgress,
      enableAdvancedCaching,
      isAuthenticated,
      isGuest,
      props,
    ],
  );

  if (error) {
    return (
      <View style={styles.errorContainer}>
        <Icon name="wifi-off" size={64} color={Colors.gray400} />
        <Text style={styles.errorTitle}>Verbindingsfout</Text>
        <Text style={styles.errorMessage}>
          Kan de website niet laden.{'\n'}
          Controleer je internetverbinding en probeer opnieuw.
        </Text>
        <TouchableOpacity style={styles.retryButton} onPress={handleRetry}>
          <Icon name="refresh" size={20} color={Colors.white} />
          <Text style={styles.retryButtonText}>Opnieuw proberen</Text>
        </TouchableOpacity>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      {/* Enhanced Loading Indicator with Progress */}
      {loading && (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={Colors.primary} />
          <Text style={styles.loadingText}>Website laden...</Text>
          {showLoadingProgress && loadingProgress > 0 && (
            <View style={styles.progressContainer}>
              <View style={styles.progressBar}>
                <View
                  style={[
                    styles.progressFill,
                    { width: `${loadingProgress * 100}%` },
                  ]}
                />
              </View>
              <Text style={styles.progressText}>
                {Math.round(loadingProgress * 100)}%
              </Text>
            </View>
          )}
          {preloadedView && (
            <Text style={styles.preloadText}>Pre-loaded content gebruikt</Text>
          )}
        </View>
      )}

      <View style={styles.webViewContainer}>
        <WebView ref={webViewRef} key={webViewKey} {...webViewProps} />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  webViewContainer: {
    flex: 1,
  },
  webView: {
    flex: 1,
  },
  loadingContainer: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: Colors.background,
    zIndex: 1000,
  },
  loadingText: {
    marginTop: 16,
    fontSize: 16,
    color: Colors.textSecondary,
    fontWeight: '500',
  },
  preloadText: {
    marginTop: 8,
    fontSize: 12,
    color: Colors.primary,
    fontStyle: 'italic',
  },
  progressContainer: {
    marginTop: 20,
    alignItems: 'center',
    width: 200,
  },
  progressBar: {
    height: 4,
    width: '100%',
    backgroundColor: Colors.gray200,
    borderRadius: 2,
    overflow: 'hidden',
  },
  progressFill: {
    height: '100%',
    backgroundColor: Colors.primary,
    borderRadius: 2,
  },
  progressText: {
    marginTop: 8,
    fontSize: 12,
    color: Colors.textSecondary,
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: 32,
  },
  errorTitle: {
    fontSize: 20,
    fontWeight: '600',
    color: Colors.text,
    marginTop: 16,
    marginBottom: 8,
  },
  errorMessage: {
    fontSize: 16,
    color: Colors.textSecondary,
    textAlign: 'center',
    lineHeight: 24,
    marginBottom: 32,
  },
  retryButton: {
    backgroundColor: Colors.primary,
    borderRadius: 12,
    paddingVertical: 12,
    paddingHorizontal: 24,
    flexDirection: 'row',
    alignItems: 'center',
    shadowColor: Colors.primary,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 4,
  },
  retryButtonText: {
    color: Colors.white,
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 8,
  },
});
