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
  const { isAuthenticated, isGuest, isLoading } = useAuth();
  const [showSplash, setShowSplash] = useState(true);

  const handleSplashEnd = React.useCallback(() => {
    setShowSplash(false);
  }, []);

  const screenOptions = React.useMemo(() => ({
    headerShown: false,
    cardStyle: { backgroundColor: Colors.background },
  }), []);

  // Show splash screen first
  if (showSplash) {
    return <SplashScreen onAnimationEnd={handleSplashEnd} />;
  }

  // Show loading during auth check
  if (isLoading) {
    return <SplashScreen onAnimationEnd={() => {}} />;
  }

  // Simple navigation logic
  return (
    <NavigationContainer>
      <Stack.Navigator screenOptions={screenOptions}>
        {!isAuthenticated && !isGuest ? (
          <Stack.Screen name="Login" component={LoginScreen} />
        ) : (
          <Stack.Screen name="Main" component={TabNavigator} />
        )}
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
