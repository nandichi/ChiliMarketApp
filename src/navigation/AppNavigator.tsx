import React, { useState, useEffect } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import WebViewScreen from '../screens/WebViewScreen';
import SplashScreen from '../components/SplashScreen';
import BiometricLockScreen from '../components/BiometricLockScreen';
import TabNavigator from './TabNavigator';
import LoginScreen from '../screens/LoginScreen';
import { getColors } from '../constants/colors';
import { AuthProvider, useAuth } from '../context/AuthContext';
import { ThemeProvider, useTheme } from '../context/ThemeContext';
import WebViewPreloadService from '../services/WebViewPreloadService';
import BackgroundLoadingManager from '../services/BackgroundLoadingManager';
import CacheOptimizationService from '../services/CacheOptimizationService';
import ConnectionOptimizationService from '../services/ConnectionOptimizationService';

const Stack = createStackNavigator();

function AuthenticatedApp() {
  const {
    isAuthenticated,
    isGuest,
    isLoading,
    biometricEnabled,
    biometricSupported,
    user,
  } = useAuth();
  const { isDark } = useTheme();
  const [showSplash, setShowSplash] = useState(true);
  const [showBiometricLock, setShowBiometricLock] = useState(false);

  const colors = getColors(isDark);

  // Initialiseer performance services bij app start
  useEffect(() => {
    const initializePerformanceServices = async () => {
      try {
        console.log('[AppNavigator] Initializing performance services');

        // Krijg service instances
        const preloadService = WebViewPreloadService.getInstance();
        const backgroundManager = BackgroundLoadingManager.getInstance();
        const cacheService = CacheOptimizationService.getInstance();
        const connectionService = ConnectionOptimizationService.getInstance();

        // Start alle services parallel
        await Promise.allSettled([
          preloadService.startPreloading(),
          backgroundManager.startBackgroundLoading(),
          cacheService.warmCache(user),
        ]);

        console.log('[AppNavigator] Performance services initialized');

        // Log status van alle services
        setTimeout(() => {
          console.log('[AppNavigator] Service Status:');
          console.log('  Preload:', preloadService.getStats());
          console.log('  Background:', backgroundManager.getStatus());
          console.log('  Cache:', cacheService.getStats());
          console.log('  Connection:', connectionService.getConnectionStats());
        }, 5000);
      } catch (error) {
        console.error(
          '[AppNavigator] Error initializing performance services:',
          error,
        );
      }
    };

    // Start na korte delay om app startup niet te vertragen
    const timeout = setTimeout(initializePerformanceServices, 1000);

    return () => clearTimeout(timeout);
  }, [user]);

  // Reset services bij auth state changes
  useEffect(() => {
    if (isAuthenticated !== undefined && isGuest !== undefined) {
      console.log('[AppNavigator] Auth state changed, updating services');

      const backgroundManager = BackgroundLoadingManager.getInstance();
      const cacheService = CacheOptimizationService.getInstance();
      const connectionService = ConnectionOptimizationService.getInstance();

      // Reset en herinitialiseer services
      backgroundManager.reset();
      connectionService.reset();

      // Warm cache met user-specific data
      if (user) {
        cacheService.warmCache(user);
      }
    }
  }, [isAuthenticated, isGuest, user]);

  const handleSplashEnd = React.useCallback(async () => {
    setShowSplash(false);

    // Check if we need to show biometric lock after splash
    if (isAuthenticated && biometricEnabled && biometricSupported) {
      console.log('Splash ended, showing biometric lock screen');
      setShowBiometricLock(true);
    }
  }, [isAuthenticated, biometricEnabled, biometricSupported]);

  const handleBiometricUnlock = React.useCallback(() => {
    console.log('Biometric unlock successful, hiding lock screen');
    setShowBiometricLock(false);
  }, []);

  const screenOptions = React.useMemo(
    () => ({
      headerShown: false,
      cardStyle: { backgroundColor: colors.background },
    }),
    [colors.background],
  );

  // Show splash screen first
  if (showSplash) {
    return <SplashScreen onAnimationEnd={handleSplashEnd} />;
  }

  // Show loading during auth check
  if (isLoading) {
    return <SplashScreen onAnimationEnd={() => {}} />;
  }

  // Show biometric lock screen after splash (if needed)
  if (showBiometricLock) {
    return <BiometricLockScreen onUnlockSuccess={handleBiometricUnlock} />;
  }

  // Main navigation logic
  return (
    <NavigationContainer>
      <Stack.Navigator screenOptions={screenOptions}>
        {!isAuthenticated && !isGuest ? (
          <Stack.Screen name="Login" component={LoginScreen} />
        ) : (
          <>
            <Stack.Screen name="Main" component={TabNavigator} />
            {/* WebView route boven tabs om vanuit Home te openen */}
            <Stack.Screen
              name="WebView"
              component={WebViewScreen}
              options={({ route }: any) => ({
                headerShown: true,
                headerTitle: route.params?.title || 'Chili Market',
                headerStyle: {
                  backgroundColor: colors.primary,
                },
                headerTintColor: colors.white,
                headerTitleStyle: {
                  fontWeight: '700' as const,
                  fontSize: 18,
                },
                headerBackTitle: 'Terug',
              })}
            />
          </>
        )}
      </Stack.Navigator>
    </NavigationContainer>
  );
}

export default function AppNavigator() {
  return (
    <ThemeProvider>
      <AuthProvider>
        <AuthenticatedApp />
      </AuthProvider>
    </ThemeProvider>
  );
}
