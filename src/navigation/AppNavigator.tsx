import React, { useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import SplashScreen from '../components/SplashScreen';
import BiometricLockScreen from '../components/BiometricLockScreen';
import TabNavigator from './TabNavigator';
import LoginScreen from '../screens/LoginScreen';
import { Colors } from '../constants/colors';
import { AuthProvider, useAuth } from '../context/AuthContext';

const Stack = createStackNavigator();

function AuthenticatedApp() {
  const {
    isAuthenticated,
    isGuest,
    isLoading,
    biometricEnabled,
    biometricSupported,
  } = useAuth();
  const [showSplash, setShowSplash] = useState(true);
  const [showBiometricLock, setShowBiometricLock] = useState(false);

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
      cardStyle: { backgroundColor: Colors.background },
    }),
    [],
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
