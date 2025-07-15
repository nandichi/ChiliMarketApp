import React, { useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import SplashScreen from '../components/SplashScreen';
import TabNavigator from './TabNavigator';
import LoginScreen from '../screens/LoginScreen';
import { Colors } from '../constants/colors';
import { AuthProvider, useAuth } from '../context/AuthContext';

const Stack = createStackNavigator();

function AuthenticatedApp() {
  const { isAuthenticated, isGuest, isLoading: authLoading } = useAuth();
  const [showSplash, setShowSplash] = useState(true);

  const handleSplashEnd = () => {
    setShowSplash(false);
  };

  // Show splash screen first
  if (showSplash) {
    return <SplashScreen onAnimationEnd={handleSplashEnd} />;
  }

  // Show login screen if not authenticated and not guest
  if (!isAuthenticated && !isGuest && !authLoading) {
    return (
      <NavigationContainer>
        <Stack.Navigator
          screenOptions={{
            headerShown: false,
            cardStyle: { backgroundColor: Colors.background },
          }}
        >
          <Stack.Screen name="Login" component={LoginScreen} />
        </Stack.Navigator>
      </NavigationContainer>
    );
  }

  // Show loading during auth check
  if (authLoading) {
    return <SplashScreen onAnimationEnd={() => {}} />;
  }

  // Show main app if authenticated or guest
  return (
    <NavigationContainer>
      <Stack.Navigator
        screenOptions={{
          headerShown: false,
          cardStyle: { backgroundColor: Colors.background },
        }}
      >
        <Stack.Screen name="Main" component={TabNavigator} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

export default function AppNavigator() {
  return (
    <AuthProvider>
      <AuthenticatedApp />
    </AuthProvider>
  );
}
