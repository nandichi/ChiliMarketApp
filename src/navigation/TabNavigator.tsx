import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { Platform } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import { RootTabParamList } from '../types/navigation';

// Import WebView screens
import WebViewScreen from '../screens/WebViewScreen';
import BuddyBossScreen from '../screens/BuddyBossScreen';

const Tab = createBottomTabNavigator<RootTabParamList>();

// WebView screen components for each tab
const HomeWebViewScreen = () => (
  <WebViewScreen url="https://chili-market.com/" />
);

const MarktplaatsWebViewScreen = () => (
  <WebViewScreen url="https://chili-market.com/marktplaats/" />
);

const ProfielWebViewScreen = () => (
  <WebViewScreen url="https://chili-market.com/leden/admin/" />
);

const NieuwsFeedWebViewScreen = () => (
  <WebViewScreen url="https://chili-market.com/nieuws-feed/" />
);

const getTabBarIcon = ({ route }: { route: any }) => {
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
};

export default function TabNavigator() {
  const insets = useSafeAreaInsets();

  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        tabBarIcon: getTabBarIcon({ route }),
        tabBarActiveTintColor: Colors.primary,
        tabBarInactiveTintColor: Colors.gray400,
        tabBarStyle: {
          backgroundColor: Colors.white,
          borderTopColor: Colors.border,
          borderTopWidth: 1,
          paddingBottom: Platform.OS === 'ios' ? insets.bottom : 8,
          paddingTop: 8,
          height: Platform.OS === 'ios' ? 60 + insets.bottom : 70,
          position: 'absolute',
          bottom: 0,
          left: 0,
          right: 0,
        },
        tabBarLabelStyle: {
          fontSize: 12,
          fontWeight: '600',
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
          fontWeight: '700',
          fontSize: 18,
        },
      })}
    >
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
      <Tab.Screen
        name="Profiel"
        component={ProfielWebViewScreen}
        options={{
          title: 'Profiel',
          headerShown: true,
        }}
      />
      <Tab.Screen
        name="NieuwsFeed"
        component={NieuwsFeedWebViewScreen}
        options={{
          title: 'Nieuws Feed',
          headerShown: true,
        }}
      />
      <Tab.Screen
        name="BuddyBoss"
        component={BuddyBossScreen}
        options={{
          title: 'Community',
          headerShown: false,
        }}
      />
    </Tab.Navigator>
  );
}
