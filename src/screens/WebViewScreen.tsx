import React, { useState } from 'react';
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

export default function WebViewScreen({
  url = CHILI_MARKET_URL,
}: WebViewScreenProps) {
  const isDarkMode = useColorScheme() === 'dark';
  const { user, isAuthenticated, api } = useAuth();
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  const handleError = (syntheticEvent: any) => {
    const { nativeEvent } = syntheticEvent;
    console.warn('WebView error: ', nativeEvent);
    setError(true);
    setLoading(false);
  };

  const handleLoadStart = () => {
    console.log('Loading website...');
    setLoading(true);
    setError(false);
  };

  const handleLoadEnd = () => {
    console.log('Website loaded successfully');
    setLoading(false);
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
      startInLoadingState: true,
      scalesPageToFit: true,
      bounces: false,
      scrollEnabled: true,
      domStorageEnabled: true,
      javaScriptEnabled: true,
      mixedContentMode: 'compatibility' as const,
      allowsBackForwardNavigationGestures: true,
      userAgent: `ChiliMarketApp/1.0 (Mobile; ${
        isAuthenticated ? 'Authenticated' : 'Guest'
      })`,
      cacheEnabled: true,
      thirdPartyCookiesEnabled: true,
      sharedCookiesEnabled: true,
      allowsInlineMediaPlayback: true,
      mediaPlaybackRequiresUserAction: false,
      allowsFullscreenVideo: true,
    };

    // Alleen auto-login toevoegen voor bepaalde pagina's en als we geauthenticeerd zijn
    const shouldAutoLogin =
      isAuthenticated &&
      user &&
      (url?.includes('marktplaats') ||
        url?.includes('leden') ||
        url?.includes('nieuws-feed') ||
        url?.includes('mijn-account'));

    if (shouldAutoLogin) {
      const token = api.getAuthToken();
      const credentials = api.getCredentials();

      const autoLoginScript = `
        (function() {
          // Stel app gegevens in
          window.ChiliMarketApp = {
            isAuthenticated: true,
            user: ${JSON.stringify(user)},
            token: "${token || ''}",
            version: '1.0'
          };

          // Vlag om te voorkomen dat meerdere login pogingen tegelijk gebeuren
          if (window.ChiliMarketAppLoginAttempted) {
            console.log('ChiliMarketApp: Login al geprobeerd, overslaan...');
            return;
          }
          window.ChiliMarketAppLoginAttempted = true;

          // Functie om automatisch in te loggen
          function autoLogin() {
            try {
              // Controleer of gebruiker al is ingelogd
              const bodyClasses = document.body.className;
              
              if (bodyClasses.includes('logged-in') || 
                  document.querySelector('.wp-admin-bar') ||
                  document.querySelector('[href*="wp-admin"]') ||
                  document.querySelector('.user-logged-in')) {
                console.log('ChiliMarketApp: Gebruiker is al ingelogd op website');
                return;
              }

              // Controleer op rate limiting berichten
              const rateLimitMessages = document.querySelectorAll('*');
              for (let element of rateLimitMessages) {
                if (element.textContent && (
                  element.textContent.includes('te veel') || 
                  element.textContent.includes('too many') ||
                  element.textContent.includes('minuten')
                )) {
                  console.log('ChiliMarketApp: Rate limiting gedetecteerd, auto-login overslaan');
                  return;
                }
              }

              ${
                token
                  ? `
              // Probeer JWT token in localStorage en sessionStorage te zetten
              if (window.localStorage) {
                localStorage.setItem('chili_market_token', "${token}");
                localStorage.setItem('chili_market_user', JSON.stringify(${JSON.stringify(
                  user,
                )}));
              }
              if (window.sessionStorage) {
                sessionStorage.setItem('chili_market_token', "${token}");
                sessionStorage.setItem('chili_market_user', JSON.stringify(${JSON.stringify(
                  user,
                )}));
              }

              // Probeer JWT token als cookie in te stellen
              document.cookie = "chili_market_token=${token}; path=/; domain=.chili-market.com; max-age=86400; secure; samesite=lax";
              `
                  : ''
              }

              // Alleen automatisch inloggen als we geen rate limiting detecteren
              ${
                credentials
                  ? `
              setTimeout(() => {
                const loginForm = document.querySelector('#loginform, .login-form, form[action*="wp-login"], form[action*="login"]');
                const usernameField = document.querySelector('#user_login, #username, input[name="log"], input[name="username"], input[type="email"][name*="user"]');
                const passwordField = document.querySelector('#user_pass, #password, input[name="pwd"], input[name="password"], input[type="password"]');

                if (loginForm && usernameField && passwordField && !usernameField.value) {
                  console.log('ChiliMarketApp: Login formulier gevonden, voorzichtig invullen...');
                  
                  // Vul de velden in
                  usernameField.value = "${credentials.username}";
                  passwordField.value = "${credentials.password}";
                  
                  // Trigger events
                  ['input', 'change', 'blur'].forEach(eventType => {
                    usernameField.dispatchEvent(new Event(eventType, { bubbles: true }));
                    passwordField.dispatchEvent(new Event(eventType, { bubbles: true }));
                  });
                  
                  console.log('ChiliMarketApp: Login velden ingevuld, gebruiker kan handmatig submitten');
                }
              }, 2000);
              `
                  : ''
              }

            } catch (error) {
              console.error('ChiliMarketApp: Auto-login error:', error);
            }
          }

          // Voer auto-login uit na een vertraging
          setTimeout(autoLogin, 1500);

        })();
        true;
      `;

      return {
        ...baseProps,
        injectedJavaScript: autoLoginScript,
        onMessage: (event: WebViewMessageEvent) => {
          console.log('WebView message:', event.nativeEvent.data);
        },
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
        <WebView {...getWebViewProps()} />
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
