/**
 * Chili Market App
 * Native React Native implementation met professionele navigatie
 *
 * @format
 */

import React from 'react';
import { StatusBar } from 'react-native';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import AppNavigator from './src/navigation/AppNavigator';
import { Colors } from './src/constants/colors';

function App(): React.JSX.Element {
  return (
    <SafeAreaProvider>
      <StatusBar
        barStyle="light-content"
        backgroundColor={Colors.primary}
        translucent={false}
      />
      <AppNavigator />
    </SafeAreaProvider>
  );
}

export default App;
