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
  Share,
  Alert,
} from 'react-native';
import { WebView, WebViewProps } from 'react-native-webview';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import { useAuth } from '../context/AuthContext';
import WebViewPreloadService from '../services/WebViewPreloadService';
import HapticFeedbackService from '../services/HapticFeedbackService';

const { width: screenWidth } = Dimensions.get('window');

interface EnhancedWebViewProps extends Omit<WebViewProps, 'source'> {
  url: string;
  preloadEnabled?: boolean;
  showLoadingProgress?: boolean;
  enableAdvancedCaching?: boolean;
  blockAds?: boolean;
  enableResourceOptimization?: boolean;
  showShareButton?: boolean;
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
  preloadEnabled = false,
  showLoadingProgress = true,
  enableAdvancedCaching = true,
  blockAds = true,
  enableResourceOptimization = true,
  showShareButton = true,
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
  const [currentUrl, setCurrentUrl] = useState(url);
  const [pageTitle, setPageTitle] = useState('');
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

      // Update currentUrl als we nog geen betere hebben
      if (!currentUrl || currentUrl === url) {
        const eventUrl = syntheticEvent?.nativeEvent?.url;
        if (eventUrl) {
          setCurrentUrl(eventUrl);
          console.log(
            '[EnhancedWebView] Updated currentUrl from load event:',
            eventUrl,
          );
        }
      }

      if (onLoadEnd) {
        onLoadEnd(syntheticEvent);
      }
    },
    [url, onLoadEnd, currentUrl],
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

  const handleRetry = useCallback(async () => {
    await HapticFeedbackService.triggerForAction('refresh');
    setError(false);
    setLoading(true);
    setRetryCount(prev => prev + 1);
  }, []);

  // Handle navigation state changes (meer betrouwbaar voor URL tracking)
  const handleNavigationStateChange = useCallback(
    (navState: any) => {
      const { url: newUrl, title } = navState;
      if (newUrl && newUrl !== currentUrl) {
        setCurrentUrl(newUrl);
        console.log('[EnhancedWebView] Navigation state changed:', {
          newUrl,
          title,
          canGoBack: navState.canGoBack,
          canGoForward: navState.canGoForward,
        });
      }
      if (title && title !== pageTitle) {
        setPageTitle(title);
      }
    },
    [currentUrl, pageTitle],
  );

  // Share handler
  const handleShare = useCallback(async () => {
    try {
      await HapticFeedbackService.triggerForAction('button_press');

      // Probeer de huidige URL direct van de WebView op te halen
      let shareUrl = currentUrl || url;
      let shareTitle = pageTitle || 'Chili Market';

      // Als we geen goede currentUrl hebben, probeer direct van webview
      if (!currentUrl || currentUrl === url) {
        try {
          // Inject JavaScript om direct de huidige URL en titel op te halen
          const urlScript = `
            (function() {
              const info = {
                url: window.location.href,
                title: document.title || 'Chili Market'
              };
              window.ReactNativeWebView?.postMessage('share_info:' + JSON.stringify(info));
              return JSON.stringify(info);
            })();
          `;

          if (webViewRef.current) {
            webViewRef.current.injectJavaScript(urlScript);
            // Korte vertraging om te wachten op de response
            await new Promise(resolve => setTimeout(resolve, 200));
          }
        } catch (e) {
          console.log('[EnhancedWebView] Direct URL fetch failed:', e);
        }
      }

      console.log('[EnhancedWebView] Sharing:', {
        title: shareTitle,
        url: shareUrl,
        currentUrl,
        originalUrl: url,
      });

      const result = await Share.share({
        message: `${shareTitle}\n${shareUrl}`,
        url: shareUrl,
        title: shareTitle,
      });

      if (result.action === Share.sharedAction) {
        console.log('[EnhancedWebView] Content shared successfully');
      }
    } catch (error) {
      console.error('[EnhancedWebView] Share error:', error);
      Alert.alert(
        'Delen mislukt',
        'Er is een probleem opgetreden bij het delen van deze pagina.',
      );
    }
  }, [pageTitle, currentUrl, url]);

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
        
        // Authentication logic - versterkt en verbeterd
        ${
          isAuthenticated && user && token
            ? `
        const token = '${token}';
        console.log('[EnhancedWebView] Auth Status - Authenticated:', ${isAuthenticated}, 'Token present:', !!token);
        
        function performAuthentication() {
          if (token && token !== 'undefined' && token !== 'null') {
            // Check eerst of gebruiker al ingelogd is door WordPress cookies te controleren
            const isAlreadyLoggedIn = document.cookie.includes('wordpress_logged_in') || 
                                    document.cookie.includes('wordpress_sec') ||
                                    document.querySelector('.logged-in') !== null ||
                                    document.querySelector('[href*="wp-admin"]') !== null;
            
            if (isAlreadyLoggedIn) {
              console.log('[EnhancedWebView] User appears to be already logged in, skipping authentication');
              window.ReactNativeWebView?.postMessage('auth_already_logged_in');
              return;
            }
            
            console.log('[EnhancedWebView] User not logged in, attempting JWT authentication...');
            
            fetch('https://chili-market.com/wp-json/custom-jwt/v1/session', {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + token
              },
              credentials: 'include'
            }).then(res => {
              console.log('[EnhancedWebView] JWT Response status:', res.status);
              return res.json();
            }).then(data => {
              console.log('[EnhancedWebView] JWT result:', data.success ? 'SUCCESS' : 'FAILED', data);
              if (data.success) {
                window.ReactNativeWebView?.postMessage('auth_success');
                console.log('[EnhancedWebView] Authentication successful, reloading page once...');
                // Markeer dat we een reload hebben gedaan om loops te voorkomen
                sessionStorage.setItem('chili_app_auth_reloaded', 'true');
                setTimeout(() => {
                  window.location.reload();
                }, 100);
              } else {
                console.log('[EnhancedWebView] Authentication failed:', data.message || 'Unknown error');
                window.ReactNativeWebView?.postMessage('auth_failed');
              }
            }).catch(e => {
              console.log('[EnhancedWebView] JWT error:', e.message);
              window.ReactNativeWebView?.postMessage('auth_error');
            });
          } else {
            console.log('[EnhancedWebView] No valid token available for authentication');
          }
        }
        
        // Voer authenticatie alleen uit als we nog niet hebben geprobeerd voor deze pagina
        function tryAuthentication() {
          // Check of we al een reload hebben gedaan voor deze sessie
          if (sessionStorage.getItem('chili_app_auth_reloaded') === 'true') {
            console.log('[EnhancedWebView] Already reloaded this session, skipping authentication');
            return;
          }
          
          // Check of authenticatie al is uitgevoerd voor deze URL
          const currentUrl = window.location.href;
          const authKey = 'chili_app_auth_done_' + btoa(currentUrl).substring(0, 20);
          if (sessionStorage.getItem(authKey) === 'true') {
            console.log('[EnhancedWebView] Authentication already attempted for this URL, skipping');
            return;
          }
          
          // Markeer dat we authenticatie proberen voor deze URL
          sessionStorage.setItem(authKey, 'true');
          performAuthentication();
        }
        
        // Voer authenticatie uit na een korte vertraging om te zorgen dat de pagina klaar is
        if (document.readyState === 'complete') {
          setTimeout(tryAuthentication, 1000);
        } else {
          window.addEventListener('load', () => {
            setTimeout(tryAuthentication, 1000);
          });
        }
        `
            : `
        console.log('[EnhancedWebView] No authentication - User not authenticated or no token');
        `
        }
        
        // URL en titel tracking voor share functionaliteit
        function sendPageInfo() {
          const currentUrl = window.location.href;
          const pageTitle = document.title || '';
          
          const pageInfo = {
            type: 'page_info',
            url: currentUrl,
            title: pageTitle
          };
          
          console.log('[WebView] Sending page info:', pageInfo);
          window.ReactNativeWebView?.postMessage(JSON.stringify(pageInfo));
        }
        
        // Verstuur pagina info meerdere keren om zeker te zijn
        function ensurePageInfoSent() {
          sendPageInfo();
          setTimeout(sendPageInfo, 1000);
          setTimeout(sendPageInfo, 2000);
        }
        
        // Verstuur pagina info wanneer de pagina klaar is
        if (document.readyState === 'complete') {
          setTimeout(ensurePageInfoSent, 500);
        } else {
          window.addEventListener('load', () => {
            setTimeout(ensurePageInfoSent, 500);
          });
        }
        
        // Track URL changes voor single-page applications
        let lastUrl = window.location.href;
        const observer = new MutationObserver(() => {
          const currentUrl = window.location.href;
          if (currentUrl !== lastUrl) {
            lastUrl = currentUrl;
            console.log('[WebView] URL changed to:', currentUrl);
            setTimeout(sendPageInfo, 300);
          }
        });
        
        observer.observe(document, { 
          childList: true, 
          subtree: true 
        });
        
        // Ook luisteren naar popstate voor browser navigatie
        window.addEventListener('popstate', () => {
          setTimeout(sendPageInfo, 100);
        });
        
        // En pushstate/replacestate overriden voor SPA navigatie
        const originalPushState = history.pushState;
        const originalReplaceState = history.replaceState;
        
        history.pushState = function() {
          originalPushState.apply(history, arguments);
          setTimeout(sendPageInfo, 100);
        };
        
        history.replaceState = function() {
          originalReplaceState.apply(history, arguments);
          setTimeout(sendPageInfo, 100);
        };
        
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

  // Handle WebView messages (vooral voor auth status en page info)
  const handleMessage = useCallback((event: any) => {
    const message = event.nativeEvent.data;
    console.log('[EnhancedWebView] Received message:', message);

    // Check voor share_info berichten
    if (message.startsWith('share_info:')) {
      try {
        const infoData = message.replace('share_info:', '');
        const parsedInfo = JSON.parse(infoData);
        setCurrentUrl(parsedInfo.url);
        setPageTitle(parsedInfo.title);
        console.log('[EnhancedWebView] Share info updated:', parsedInfo);
        return;
      } catch (e) {
        console.log('[EnhancedWebView] Failed to parse share info:', e);
      }
    }

    // Probeer JSON te parsen voor gestructureerde berichten
    try {
      const parsedMessage = JSON.parse(message);
      if (parsedMessage.type === 'page_info') {
        setCurrentUrl(parsedMessage.url);
        setPageTitle(parsedMessage.title);
        console.log('[EnhancedWebView] Page info updated:', {
          url: parsedMessage.url,
          title: parsedMessage.title,
        });
        return;
      }
    } catch (e) {
      // Niet een JSON bericht, behandel als string
    }

    switch (message) {
      case 'auth_success':
        console.log('[EnhancedWebView] WebView authentication successful');
        break;
      case 'auth_failed':
        console.log('[EnhancedWebView] WebView authentication failed');
        break;
      case 'auth_error':
        console.log('[EnhancedWebView] WebView authentication error');
        break;
      case 'auth_already_logged_in':
        console.log(
          '[EnhancedWebView] User already logged in, no authentication needed',
        );
        break;
      default:
        console.log('[EnhancedWebView] Unknown message:', message);
    }
  }, []);

  // Enhanced WebView props
  const webViewProps = useMemo(
    () => ({
      source: { uri: url },
      style: styles.webView,
      onLoadStart: handleLoadStart,
      onLoadProgress: showLoadingProgress ? handleLoadProgress : undefined,
      onLoadEnd: handleLoadEnd,
      onError: handleError,
      onMessage: handleMessage,
      onShouldStartLoadWithRequest: shouldStartLoadWithRequest,
      onNavigationStateChange: handleNavigationStateChange,
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
        ? ('LOAD_CACHE_ELSE_NETWORK' as const)
        : ('LOAD_DEFAULT' as const),

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
      handleMessage,
      shouldStartLoadWithRequest,
      handleNavigationStateChange,
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

      {/* Share Button */}
      {showShareButton && !loading && !error && (
        <TouchableOpacity
          style={styles.shareButton}
          onPress={handleShare}
          activeOpacity={0.8}
        >
          <Icon name="share" size={24} color={Colors.white} />
        </TouchableOpacity>
      )}
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
  shareButton: {
    position: 'absolute',
    bottom: 70,
    right: 20,
    width: 56,
    height: 56,
    backgroundColor: Colors.primary,
    borderRadius: 28,
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: Colors.primary,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 6,
    zIndex: 1000,
  },
});
