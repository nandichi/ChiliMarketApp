import React, { useEffect } from 'react';
import {
  SafeAreaView,
  StatusBar,
  useColorScheme,
  StyleSheet,
} from 'react-native';
import { Colors } from '../constants/colors';
import EnhancedWebView from '../components/EnhancedWebView';
import WebViewPreloadService from '../services/WebViewPreloadService';

const CHILI_MARKET_URL = 'https://chili-market.com';

interface WebViewScreenProps {
  url?: string;
}

export default function WebViewScreen({
  url = CHILI_MARKET_URL,
}: WebViewScreenProps) {
  const isDarkMode = useColorScheme() === 'dark';
  const preloadService = WebViewPreloadService.getInstance();

  // Start preloading wanneer screen mount
  useEffect(() => {
    preloadService.startPreloading();
  }, []);

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={Colors.primary}
      />
      <EnhancedWebView
        url={url}
        preloadEnabled={true}
        showLoadingProgress={true}
        enableAdvancedCaching={true}
        blockAds={true}
        enableResourceOptimization={true}
        style={styles.webView}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  webView: {
    flex: 1,
  },
});
