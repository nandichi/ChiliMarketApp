import React, { useEffect } from 'react';
import { SafeAreaView, StatusBar, StyleSheet } from 'react-native';
import { useRoute } from '@react-navigation/native';
import { getColors } from '../constants/colors';
import { useTheme } from '../context/ThemeContext';
import EnhancedWebView from '../components/EnhancedWebView';
import WebViewPreloadService from '../services/WebViewPreloadService';

const CHILI_MARKET_URL = 'https://chili-market.com';

interface WebViewScreenProps {
  url?: string;
}

export default function WebViewScreen({ url: propUrl }: WebViewScreenProps) {
  const route = useRoute<any>();
  const url = route?.params?.url || propUrl || CHILI_MARKET_URL;
  const { isDark } = useTheme();
  const colors = getColors(isDark);

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: colors.background }]}
    >
      <StatusBar
        barStyle={isDark ? 'light-content' : 'dark-content'}
        backgroundColor={colors.primary}
      />
      <EnhancedWebView
        url={url}
        preloadEnabled={false}
        showLoadingProgress={true}
        enableAdvancedCaching={true}
        blockAds={true}
        enableResourceOptimization={true}
        showShareButton={true}
        style={styles.webView}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  webView: {
    flex: 1,
  },
});
