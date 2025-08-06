import React, { useState, useEffect, useRef, useCallback } from 'react';
import {
  View,
  StyleSheet,
  SafeAreaView,
  StatusBar,
  useColorScheme,
  ActivityIndicator,
  Text,
  TouchableOpacity,
} from 'react-native';
import { WebView, WebViewMessageEvent } from 'react-native-webview';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import { useAuth } from '../context/AuthContext';
import { useNavigation } from '@react-navigation/native';

const CHILI_MARKET_URL = 'https://chili-market.com';

interface WebViewScreenProps {
  url?: string;
}

export default function WebViewScreen({ url = CHILI_MARKET_URL }: WebViewScreenProps) {
  const isDarkMode = useColorScheme() === 'dark';
  const { user, isAuthenticated, isGuest, justLoggedOut, clearLogoutFlag, api } = useAuth();
  const navigation = useNavigation();
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);
  const [_scriptInjected, _setScriptInjected] = useState(false);
  const [pageFullyLoaded, setPageFullyLoaded] = useState(false);
  const token = api.getAuthToken();
  const loadingRef = useRef(true);
  
  // Create a stable key based on auth state to force WebView reload on auth changes
  const webViewKey = React.useMemo(() => {
    return `webview-${isAuthenticated ? 'auth' : isGuest ? 'guest' : 'none'}`;
  }, [isAuthenticated, isGuest]);

  // Function to determine which tab should be active based on URL
  const getTabForUrl = (currentUrl: string) => {
    if (!currentUrl) return null;
    
    const urlLower = currentUrl.toLowerCase();
    
    // Check for home page (root, main page, or home-related paths)
    if (urlLower === 'https://chili-market.com/' || 
        urlLower === 'https://chili-market.com' ||
        urlLower.includes('/home')) {
      return 'Home';
    }
    
    // Check for marketplace related URLs
    if (urlLower.includes('/marktplaats') || 
        urlLower.includes('/marketplace') ||
        urlLower.includes('/winkel') ||
        urlLower.includes('/shop')) {
      return 'Marktplaats';
    }
    
    // Check for profile related URLs (only for authenticated users)
    if (isAuthenticated && 
        (urlLower.includes('/leden/') || 
         urlLower.includes('/profile') ||
         urlLower.includes('/profiel'))) {
      return 'Profiel';
    }
    
    // Check for news feed related URLs
    if (urlLower.includes('/nieuws') || 
        urlLower.includes('/news') ||
        urlLower.includes('/feed') ||
        urlLower.includes('/blog')) {
      return 'NieuwsFeed';
    }
    
    // Default to current tab if no match
    return null;
  };

  // Definieer handleLoadEnd functie eerst
  const handleLoadEnd = useCallback(() => {
    console.log('[WebView] Website loaded successfully');
    setError(false);
    setLoading(false);
    loadingRef.current = false;
  }, []);

  // SUPER AGGRESSIVE TIMEOUT - 8 seconden maximum
  useEffect(() => {
    const absoluteTimeout = setTimeout(() => {
      if (!pageFullyLoaded) {
        console.log('[WebView] SUPER AGGRESSIVE TIMEOUT: Force complete after 8 seconds');
        setPageFullyLoaded(true);
        setLoading(false);
        loadingRef.current = false;
        handleLoadEnd(); // Force load end
      }
    }, 8000); // 8 seconden maximum - website moet maar accepteren dat het klaar is

    return () => clearTimeout(absoluteTimeout);
  }, [pageFullyLoaded, handleLoadEnd]);

  // Clear logout flag after cleanup script has been applied
  useEffect(() => {
    if (justLoggedOut) {
      console.log('[WebView] Logout flag detected, will clear after cleanup');
      const timer = setTimeout(() => {
        clearLogoutFlag();
        console.log('[WebView] Logout flag cleared');
      }, 2000); // Give cleanup script time to run
      
      return () => clearTimeout(timer);
    }
  }, [justLoggedOut]); // Removed clearLogoutFlag from dependencies to prevent loops

  



  // Debug logging in render (reduced to prevent spam)
  if (process.env.NODE_ENV === 'development') {
    console.log('[WebViewScreen] Auth state:', { isAuthenticated, isGuest, justLoggedOut });
    console.log('[WebViewScreen] WebView key:', webViewKey);
  }

  // Alleen authenticatie scherm tonen als gebruiker niet ingelogd EN niet als gast doorgaat
  if (!isAuthenticated && !isGuest) {
    return (
      <SafeAreaView style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <ActivityIndicator size="large" color={Colors.primary} />
        <Text style={{ marginTop: 16 }}>Bezig met authenticatie...</Text>
        <Text style={{ marginTop: 8, color: 'gray', fontSize: 12 }}>isAuthenticated: {String(isAuthenticated)}</Text>
        <Text style={{ marginTop: 2, color: 'gray', fontSize: 12 }}>isGuest: {String(isGuest)}</Text>
        <Text style={{ marginTop: 2, color: 'gray', fontSize: 12 }}>token: {String(token)}</Text>
      </SafeAreaView>
    );
  }

  const handleError = (syntheticEvent: any) => {
    const { nativeEvent } = syntheticEvent;
    console.log('[WebView] Error:', nativeEvent);
    setError(true);
    setLoading(false);
  };

  const handleLoadStart = () => {
    console.log('[WebView] Loading website...');
    setError(false);
    setLoading(true);
    loadingRef.current = true;
  };

  const handleMessage = (event: WebViewMessageEvent) => {
    console.log('WebView message:', event.nativeEvent.data);
  };

  const handleNavigationStateChange = (navState: any) => {
    console.log('[WebView] Navigation state changed:', {
      url: navState.url,
      loading: navState.loading,
      canGoBack: navState.canGoBack,
      canGoForward: navState.canGoForward,
    });
    
    // Reset pageFullyLoaded als we naar een nieuwe URL navigeren
    if (navState.url !== url) {
      console.log('[WebView] URL changed, resetting pageFullyLoaded state');
      setPageFullyLoaded(false);
      
      // TEMPORARILY DISABLED: Tab synchronization to fix render loop
      // TODO: Re-implement with better loop prevention
      /* 
      const targetTab = getTabForUrl(navState.url);
      if (targetTab) {
        console.log('[WebView] URL suggests switching to tab:', targetTab);
        setTimeout(() => {
          try {
            navigation.navigate(targetTab as never);
            console.log('[WebView] Successfully navigated to tab:', targetTab);
          } catch (error) {
            console.log('[WebView] Failed to navigate to tab:', targetTab, error);
          }
        }, 500);
      }
      */
    }
  };

  const handleShouldStartLoadWithRequest = (request: any) => {
    console.log('[WebView] Should start load with request:', request.url);
    
    // BLOKKEER trage third-party resources, maar sta reCAPTCHA toe voor formulieren
    if (request.url.includes('googlesyndication.com') ||
        request.url.includes('facebook.com/tr') ||
        request.url.includes('google-analytics.com') ||
        request.url.includes('googletagmanager.com') ||
        request.url.includes('doubleclick.net') ||
        request.url.includes('youtube.com/embed') ||
        request.url.includes('twitter.com/widgets') ||
        request.url.includes('instagram.com/embed')) {
      console.log('[WebView] BLOCKED slow third-party:', request.url);
      return false;
    }
    
    // Sta reCAPTCHA toe voor formulieren
    if (request.url.includes('google.com/recaptcha') || 
        request.url.includes('gstatic.com')) {
      console.log('[WebView] ALLOWED reCAPTCHA:', request.url);
      return true;
    }
    
    return true;
  };

  const handleLoadProgress = (event: any) => {
    console.log('[WebView] Load progress:', event.nativeEvent.progress);
    
    // SUPER AGRESSIEF: Forceer bij 80%
    if (event.nativeEvent.progress >= 0.80 && !pageFullyLoaded) {
      console.log('[WebView] 80% reached - FORCE COMPLETE NOW');
      setPageFullyLoaded(true);
      
      // DIRECT forceren - geen wachttijd
      setTimeout(() => {
        console.log('[WebView] FORCED load end - website is good enough');
        setLoading(false);
        loadingRef.current = false;
        handleLoadEnd(); // Direct call handleLoadEnd
      }, 1000);
    }
  };

  const handleContentProcessDidTerminate = () => {
    console.log('[WebView] Content process terminated, reloading...');
    // Optionally reload the WebView
  };

  const handleRetry = () => {
    setError(false);
    setLoading(true);
  };

  const getWebViewProps = () => {
    const baseProps = {
      source: { uri: url },
      style: styles.webView,
      onError: handleError,
      onLoadStart: handleLoadStart,
      onLoadEnd: handleLoadEnd,
      onMessage: handleMessage,
      onNavigationStateChange: handleNavigationStateChange,
      onShouldStartLoadWithRequest: handleShouldStartLoadWithRequest,
      onLoadProgress: handleLoadProgress,
      onContentProcessDidTerminate: handleContentProcessDidTerminate,
      startInLoadingState: false, // Uitschakelen - we gebruiken onze eigen loading indicator
      renderLoading: () => <View />, // Geen WebView loading component
      scalesPageToFit: true,
      bounces: false,
      scrollEnabled: true,
      domStorageEnabled: true,
      javaScriptEnabled: true,
      mixedContentMode: 'compatibility' as const,
      allowsBackForwardNavigationGestures: true,
      userAgent: `ChiliMarketApp/1.0 (Mobile; ${isAuthenticated ? 'Authenticated' : isGuest ? 'Guest' : 'NotAuthenticated'})`,
      cacheEnabled: true,
      thirdPartyCookiesEnabled: true,
      sharedCookiesEnabled: true,
      allowsInlineMediaPlayback: true,
      mediaPlaybackRequiresUserAction: false,
      allowsFullscreenVideo: true,
    };

    // Reset session storage en cookies ALLEEN als gebruiker daadwerkelijk is uitgelogd
    if (!isAuthenticated && justLoggedOut) {
      const cleanupScript = `
        (function() {
          try {
            console.log('[ChiliMarket] Starting authentication cleanup...');
            
            // Clear session storage
            sessionStorage.removeItem('chili_jwt_session_done');
            localStorage.removeItem('chili_jwt_session_done');
            console.log('[ChiliMarket] Session storage cleared');
            
            // Get all current cookies for debugging
            console.log('[ChiliMarket] Current cookies:', document.cookie);
            
            // More aggressive cookie clearing
            const allCookies = document.cookie.split(';');
            allCookies.forEach(cookie => {
              const name = cookie.trim().split('=')[0];
              if (name && (
                name.includes('wordpress') || 
                name.includes('wp') || 
                name.includes('auth') ||
                name.includes('login') ||
                name.includes('session')
              )) {
                // Clear with multiple domain/path combinations
                document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/; domain=.chili-market.com;';
                document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/; domain=chili-market.com;';
                document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
                console.log('[ChiliMarket] Cleared cookie: ' + name);
              }
            });
            
            // Note: WordPress logout URL navigation removed to prevent loops
            // Cookies and storage cleanup should be sufficient for logout
            
            console.log('[ChiliMarket] Authentication cleanup completed');
          } catch (e) {
            console.log('[ChiliMarket] Could not clear authentication data: ' + e);
          }
        })();
        true;
      `;
      
      // Return early with cleanup script voor zowel niet-ingelogde als guest gebruikers
      return {
        ...baseProps,
        injectedJavaScript: cleanupScript,
      };
    }

    // MINIMALE LOGIN: Alleen simpele JWT sessie zonder complexe logica
    if (isAuthenticated && user && token) {
      console.log('[WebView] Auto-login enabled for authenticated user on URL:', url);
      // Gebruik de expliciete token uit de context
      // Script om JWT sessie te activeren in WordPress met bridge logging en alleen Authorization header
      const _autoSessionScript = `
        (function() {
          function bridgeLog(msg) {
            console.log(msg);
            if (window.ReactNativeWebView) {
              window.ReactNativeWebView.postMessage(msg);
            }
          }
          bridgeLog('[ChiliMarket] Start JWT sessie script (forced injection)');
          bridgeLog('[ChiliMarket] JWT token naar sessie-endpoint: ' + String(${JSON.stringify(token)}));
          // Controleer of we al een WordPress sessie hebben
          const hasWordPressCookie = document.cookie.includes('wordpress_logged_in');
          const sessionDone = sessionStorage.getItem('chili_jwt_session_done') === 'true';
          
          if (hasWordPressCookie) {
            bridgeLog('[ChiliMarket] WordPress cookie al aanwezig - skip JWT sessie');
            bridgeLog('[ChiliMarket] WordPress sessie actief!');
            return;
          }
          
          if (sessionDone) {
            bridgeLog('[ChiliMarket] JWT sessie al uitgevoerd deze sessie - skip');
            bridgeLog('[ChiliMarket] WordPress sessie actief!');
            return;
          }
          
          if (${JSON.stringify(token)}) {
            sessionStorage.setItem('chili_jwt_session_done', 'true');
            bridgeLog('[ChiliMarket] JWT sessie request wordt verstuurd...');
            fetch('https://chili-market.com/wp-json/custom-jwt/v1/session', {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + String(${JSON.stringify(token)})
              }
            })
            .then(function(res) {
              bridgeLog('[ChiliMarket] JWT sessie response status: ' + res.status);
              bridgeLog('[ChiliMarket] JWT sessie response headers: ' + JSON.stringify(Array.from(res.headers.entries())));
              
              // Check voor Set-Cookie header
              const setCookieHeader = res.headers.get('set-cookie');
              if (setCookieHeader) {
                bridgeLog('[ChiliMarket] Set-Cookie header gevonden: ' + setCookieHeader);
              } else {
                bridgeLog('[ChiliMarket] GEEN Set-Cookie header gevonden in response');
              }
              
              return res.text().then(function(text) {
                bridgeLog('[ChiliMarket] JWT sessie response body: ' + text);
                try { return JSON.parse(text); } catch (e) { return text; }
              });
            })
            .then(function(data) {
              bridgeLog('[ChiliMarket] JWT sessie parsed data: ' + JSON.stringify(data));
              try {
                bridgeLog('[ChiliMarket] Cookies na sessie: ' + document.cookie);
              } catch (e) {
                bridgeLog('[ChiliMarket] Kan cookies niet lezen: ' + e);
              }
              
              if (data && data.success) {
                bridgeLog('[ChiliMarket] Sessie succesvol, controleer WordPress login status...');
                
                // Simpele check zonder delays
                try {
                  const bodyClasses = document.body.className;
                  const isLoggedIn = bodyClasses.includes('logged-in') || 
                                    document.querySelector('.wp-admin-bar') ||
                                    document.querySelector('[href*="wp-admin"]') ||
                                    document.querySelector('.user-logged-in');
                  
                  bridgeLog('[ChiliMarket] WordPress login status: ' + (isLoggedIn ? 'INGELOGD' : 'NIET INGELOGD'));
                  bridgeLog('[ChiliMarket] Body classes: ' + bodyClasses);
                  
                  if (isLoggedIn) {
                      bridgeLog('[ChiliMarket] WordPress sessie actief!');
                    }
                  } else {
                    bridgeLog('[ChiliMarket] WordPress sessie nog niet actief - dit is normaal');
                  }
                } catch (e) {
                  bridgeLog('[ChiliMarket] Fout bij controleren login status: ' + e);
                }
              }
            })
            .catch(function(e) { bridgeLog('[ChiliMarket] JWT sessie error: ' + e); });
          } else {
            bridgeLog('[ChiliMarket] Sessie script niet gestart (geen token)');
          }
        })();
        true;
      `;

      const _autoLoginScript = `
        (function() {
          function bridgeLog(msg) {
            console.log(msg);
            if (window.ReactNativeWebView) {
              window.ReactNativeWebView.postMessage(msg);
            }
          }
          bridgeLog('[ChiliMarket] Start auto-login script (forced injection)');
          try {
            bridgeLog('[ChiliMarket] Cookies bij start auto-login: ' + document.cookie);
          } catch (e) {
            bridgeLog('[ChiliMarket] Kan cookies niet lezen bij auto-login: ' + e);
          }
        })();
        true;
      `;

      return {
        ...baseProps,
        // ULTRA-LICHT: Direct uitvoeren na inject
        injectedJavaScript: `
          (function() {
            console.log('[ChiliMarket] Script injected');
            window.ReactNativeWebView && window.ReactNativeWebView.postMessage('[ChiliMarket] Script injected');
            
            // Direct uitvoeren
            const token = '${token}';
            console.log('[ChiliMarket] Token check:', token ? 'PRESENT' : 'MISSING');
            window.ReactNativeWebView && window.ReactNativeWebView.postMessage('[ChiliMarket] Token: ' + (token ? 'PRESENT' : 'MISSING'));
            
            if (!token || token === 'undefined' || token === 'null') {
              window.ReactNativeWebView && window.ReactNativeWebView.postMessage('[ChiliMarket] No token - skip');
              return;
            }
            
            // Check cookies
            if (document.cookie.includes('wordpress_logged_in')) {
              window.ReactNativeWebView && window.ReactNativeWebView.postMessage('[ChiliMarket] Already logged in');
              return;
            }
            
            // Delayed JWT call (na page rendering)
            setTimeout(() => {
              window.ReactNativeWebView && window.ReactNativeWebView.postMessage('[ChiliMarket] Starting JWT call');
              
              fetch('https://chili-market.com/wp-json/custom-jwt/v1/session', {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer ' + token
                }
              }).then(res => res.json()).then(data => {
                const result = data.success ? 'SUCCESS' : 'FAILED';
                window.ReactNativeWebView && window.ReactNativeWebView.postMessage('[ChiliMarket] JWT result: ' + result);
              }).catch(e => {
                window.ReactNativeWebView && window.ReactNativeWebView.postMessage('[ChiliMarket] JWT error: ' + e.message);
              });
              
            }, 1000); // 1 seconde na script inject
            
          })();
          true;
        `,
      };
    }
    return baseProps;
  };

  if (error) {
    return (
      <SafeAreaView style={styles.container}>
        <StatusBar
          barStyle={isDarkMode ? 'light-content' : 'dark-content'}
          backgroundColor={Colors.primary}
        />
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
      </SafeAreaView>
    );
  }

  console.log('[WebViewScreen] Rendering WebView - loading:', loading);

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={Colors.primary}
      />

      {/* Loading Indicator */}
      {loading && (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={Colors.primary} />
          <Text style={styles.loadingText}>Website laden...</Text>
        </View>
      )}

      <View style={styles.webViewContainer}>
        <WebView key={webViewKey} {...getWebViewProps()} />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
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
