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
import { getColors } from '../constants/colors';
import { RootTabParamList } from '../types/navigation';
import { useAuth } from '../context/AuthContext';
import { useTheme } from '../context/ThemeContext';
import BackgroundLoadingManager from '../services/BackgroundLoadingManager';

// Import WebView screens
import WebViewScreen from '../screens/WebViewScreen';
import UniversalHomeScreen from '../screens/UniversalHomeScreen';
import LogoutScreenComponent from '../screens/LogoutScreen';
import LoginTabScreenComponent from '../screens/LoginTabScreen';

const Tab = createBottomTabNavigator<RootTabParamList>();

// WebView screen components voor tabs (Home vervangen door native UniversalHomeScreen)

const MarktplaatsWebViewScreen = React.memo(() => (
  <WebViewScreen url="https://chili-market.com/marktplaats/" />
));

const ProfielWebViewScreen = React.memo(() => {
  const { user } = useAuth();

  const profileUrl = user?.username
    ? `https://chili-market.com/leden/${user.username}/`
    : 'https://chili-market.com/leden/';

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
  const { isDark } = useTheme();
  const colors = getColors(isDark);
  const backgroundManager = BackgroundLoadingManager.getInstance();

  // Cleanup bij unmount (zonder automatische background loading)
  useEffect(() => {
    return () => {
      // Cleanup wanneer navigator unmount
      backgroundManager.destroy();
    };
  }, [backgroundManager]);

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
        tabBarActiveTintColor: colors.primary,
        tabBarInactiveTintColor: colors.gray400,
        tabBarStyle: {
          backgroundColor: colors.card,
          borderTopColor: colors.border,
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
          color: colors.text,
        },
        headerStyle: {
          backgroundColor: colors.primary,
          elevation: 0,
          shadowOpacity: 0,
          paddingTop: Platform.OS === 'ios' ? insets.top : 0,
          height: Platform.OS === 'ios' ? 44 + insets.top : 56,
        },
        headerTintColor: colors.textOnPrimary,
        headerTitleStyle: {
          color: colors.textOnPrimary,
          fontWeight: '700' as const,
          fontSize: 18,
        },
      }),
    [insets, getTabBarIconForRoute, colors],
  );

  return (
    <Tab.Navigator screenOptions={screenOptions}>
      <Tab.Screen
        name="Home"
        component={UniversalHomeScreen}
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
  },
});
