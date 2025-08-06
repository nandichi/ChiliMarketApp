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

const CHILI_MARKET_URL = 'https://chili-market.com';

interface WebViewScreenProps {
  url?: string;
}

export default function WebViewScreen({ url = CHILI_MARKET_URL }: WebViewScreenProps) {
  // ALLE HOOKS MOETEN BOVENAAN STAAN - GEEN CONDITIONALE RETURNS TUSSEN HOOKS
  const isDarkMode = useColorScheme() === 'dark';
  const { user, isAuthenticated, isGuest, api } = useAuth();
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);
  const token = api.getAuthToken();
  
  // Create a stable key based on auth state to force WebView reload on auth changes
  const webViewKey = React.useMemo(() => {
    return `webview-${isAuthenticated ? 'auth' : isGuest ? 'guest' : 'none'}`;
  }, [isAuthenticated, isGuest]);

  const handleLoadEnd = useCallback(() => {
    console.log('[WebView] Website loaded successfully');
    setError(false);
    setLoading(false);
  }, []);

  const handleError = useCallback((syntheticEvent: any) => {
    const { nativeEvent } = syntheticEvent;
    console.log('[WebView] Error:', nativeEvent);
    setError(true);
    setLoading(false);
  }, []);

  const handleLoadStart = useCallback(() => {
    console.log('[WebView] Loading website...');
    setError(false);
    setLoading(true);
  }, []);

  const handleMessage = useCallback((event: WebViewMessageEvent) => {
    console.log('WebView message:', event.nativeEvent.data);
  }, []);

  const handleNavigationStateChange = useCallback((navState: any) => {
    console.log('[WebView] Navigation state changed:', {
      url: navState.url,
      loading: navState.loading,
    });
  }, []);

  const handleShouldStartLoadWithRequest = useCallback((request: any) => {
    console.log('[WebView] Should start load with request:', request.url);
    
    // BLOKKEER trage third-party resources
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
    
    return true;
  }, []);

  const handleContentProcessDidTerminate = useCallback(() => {
    console.log('[WebView] Content process terminated, reloading...');
  }, []);

  const handleRetry = useCallback(() => {
    setError(false);
    setLoading(true);
  }, []);

  const getWebViewProps = useCallback(() => {
    const baseProps = {
      source: { uri: url },
      style: styles.webView,
      onError: handleError,
      onLoadStart: handleLoadStart,
      onLoadEnd: handleLoadEnd,
      onMessage: handleMessage,
      onNavigationStateChange: handleNavigationStateChange,
      onShouldStartLoadWithRequest: handleShouldStartLoadWithRequest,
      onContentProcessDidTerminate: handleContentProcessDidTerminate,
      startInLoadingState: false,
      renderLoading: () => <View />,
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

    // MINIMALE LOGIN: Alleen simpele JWT sessie
    if (isAuthenticated && user && token) {
      console.log('[WebView] Auto-login enabled for authenticated user on URL:', url);
      
      return {
        ...baseProps,
        injectedJavaScript: `
          (function() {
            console.log('[ChiliMarket] Script injected');
            
            const token = '${token}';
            if (!token || token === 'undefined' || token === 'null') {
              return;
            }
            
            // Check cookies
            if (document.cookie.includes('wordpress_logged_in')) {
              return;
            }
            
            // Delayed JWT call
            setTimeout(() => {
              fetch('https://chili-market.com/wp-json/custom-jwt/v1/session', {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer ' + token
                }
              }).then(res => res.json()).then(data => {
                console.log('[ChiliMarket] JWT result:', data.success ? 'SUCCESS' : 'FAILED');
              }).catch(e => {
                console.log('[ChiliMarket] JWT error:', e.message);
              });
            }, 1000);
          })();
          true;
        `,
      };
    }
    
    return baseProps;
  }, [url, isAuthenticated, user, token, handleError, handleLoadStart, handleLoadEnd, handleMessage, handleNavigationStateChange, handleShouldStartLoadWithRequest, handleContentProcessDidTerminate]);

  // RENDER LOGIC - GEEN CONDITIONALE RETURNS TUSSEN HOOKS
  const renderContent = () => {
    // Alleen authenticatie scherm tonen als gebruiker niet ingelogd EN niet als gast doorgaat
    if (!isAuthenticated && !isGuest) {
      return (
        <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
          <ActivityIndicator size="large" color={Colors.primary} />
          <Text style={{ marginTop: 16 }}>Bezig met authenticatie...</Text>
        </View>
      );
    }

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
      <>
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
      </>
    );
  };

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={Colors.primary}
      />
      {renderContent()}
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
