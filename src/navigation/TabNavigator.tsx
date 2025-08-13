import React, { useState, useEffect, useMemo } from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import {
  Platform,
  View,
  TouchableOpacity,
  Text,
  StyleSheet,
  Alert,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import { RootTabParamList } from '../types/navigation';
import { useAuth } from '../context/AuthContext';
import BackgroundLoadingManager from '../services/BackgroundLoadingManager';

// Import WebView screens
import WebViewScreen from '../screens/WebViewScreen';
import LogoutScreenComponent from '../screens/LogoutScreen';
import LoginTabScreenComponent from '../screens/LoginTabScreen';

const Tab = createBottomTabNavigator<RootTabParamList>();

// WebView screen components for each tab
const HomeWebViewScreen = React.memo(() => (
  <WebViewScreen url="https://chili-market.com/" />
));

const MarktplaatsWebViewScreen = React.memo(() => (
  <WebViewScreen url="https://chili-market.com/marktplaats/" />
));

const ProfielWebViewScreen = React.memo(() => {
  const { user } = useAuth();
  const backgroundManager = BackgroundLoadingManager.getInstance();

  const profileUrl = user?.username
    ? `https://chili-market.com/leden/${user.username}/`
    : 'https://chili-market.com/leden/';

  // Pre-load gebruiker profiel wanneer username beschikbaar is
  React.useEffect(() => {
    if (user?.username) {
      backgroundManager.preloadUserProfile(user.username);
    }
  }, [user?.username, backgroundManager]);

  return <WebViewScreen url={profileUrl} />;
});

const NieuwsFeedWebViewScreen = React.memo(() => (
  <WebViewScreen url="https://chili-market.com/nieuws-feed/" />
));

const LogoutScreen = React.memo(() => {
  const { isAuthenticated, isGuest } = useAuth();

  // Show login screen for guests, logout screen for authenticated users
  if (isGuest && !isAuthenticated) {
    return <LoginTabScreenComponent />;
  }

  return <LogoutScreenComponent />;
});

export default function TabNavigator() {
  const insets = useSafeAreaInsets();
  const { isAuthenticated, isGuest } = useAuth();
  const backgroundManager = BackgroundLoadingManager.getInstance();

  // Start background loading zodra navigator mount
  useEffect(() => {
    console.log('[TabNavigator] Starting background loading for all tabs');
    backgroundManager.startBackgroundLoading();

    // Warm cache voor common flows
    backgroundManager.warmCommonFlows();

    return () => {
      // Cleanup wanneer navigator unmount
      backgroundManager.destroy();
    };
  }, [backgroundManager]);

  // Reset cache bij auth state changes
  useEffect(() => {
    console.log(
      '[TabNavigator] Auth state changed, resetting background loading',
    );
    backgroundManager.reset();
  }, [isAuthenticated, isGuest, backgroundManager]);

  const getTabBarIconForRoute = React.useCallback(
    ({ route }: { route: any }) => {
      return ({ color, size }: { color: string; size: number }) => {
        let iconName: string;

        switch (route.name) {
          case 'Home':
            iconName = 'home';
            break;
          case 'Marktplaats':
            iconName = 'store';
            break;
          case 'Profiel':
            iconName = 'person';
            break;
          case 'NieuwsFeed':
            iconName = 'dynamic-feed';
            break;
          case 'BuddyBoss':
            iconName = 'groups';
            break;
          default:
            iconName = 'home';
        }

        return <Icon name={iconName} size={size} color={color} />;
      };
    },
    [],
  );

  const screenOptions = useMemo(
    () =>
      ({ route }: { route: any }) => ({
        tabBarIcon: getTabBarIconForRoute({ route }),
        tabBarActiveTintColor: Colors.primary,
        tabBarInactiveTintColor: Colors.gray400,
        tabBarStyle: {
          backgroundColor: Colors.white,
          borderTopColor: Colors.border,
          borderTopWidth: 1,
          paddingBottom: Platform.OS === 'ios' ? insets.bottom : 8,
          paddingTop: 8,
          height: Platform.OS === 'ios' ? 60 + insets.bottom : 70,
          position: 'absolute' as const,
          bottom: 0,
          left: 0,
          right: 0,
        },
        tabBarLabelStyle: {
          fontSize: 12,
          fontWeight: '600' as const,
        },
        headerStyle: {
          backgroundColor: Colors.primary,
          elevation: 0,
          shadowOpacity: 0,
          paddingTop: Platform.OS === 'ios' ? insets.top : 0,
          height: Platform.OS === 'ios' ? 44 + insets.top : 56,
        },
        headerTintColor: Colors.white,
        headerTitleStyle: {
          fontWeight: '700' as const,
          fontSize: 18,
        },
      }),
    [insets, getTabBarIconForRoute],
  );

  return (
    <Tab.Navigator screenOptions={screenOptions}>
      <Tab.Screen
        name="Home"
        component={HomeWebViewScreen}
        options={{
          title: 'Home',
          headerShown: true,
          headerTitle: 'Welkom bij Chili Market!',
        }}
      />
      <Tab.Screen
        name="Marktplaats"
        component={MarktplaatsWebViewScreen}
        options={{
          title: 'Marktplaats',
          headerShown: true,
        }}
      />
      {isAuthenticated && (
        <Tab.Screen
          name="Profiel"
          component={ProfielWebViewScreen}
          options={{
            title: 'Profiel',
            headerShown: true,
          }}
        />
      )}
      <Tab.Screen
        name="NieuwsFeed"
        component={NieuwsFeedWebViewScreen}
        options={{
          title: 'Nieuws Feed',
          headerShown: true,
        }}
      />
      <Tab.Screen
        name="Logout"
        component={LogoutScreen}
        options={{
          title: isGuest && !isAuthenticated ? 'Inloggen' : 'Uitloggen',
          headerShown: false,
          tabBarIcon: ({ color, size }) => (
            <Icon
              name={isGuest && !isAuthenticated ? 'login' : 'logout'}
              size={size}
              color={color}
            />
          ),
        }}
      />
    </Tab.Navigator>
  );
}

const styles = StyleSheet.create({
  logoutContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: Colors.background,
  },
});
