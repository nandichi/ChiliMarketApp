import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  SafeAreaView,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { getColors } from '../constants/colors';
import { useTheme } from '../context/ThemeContext';
import { useAuth } from '../context/AuthContext';

export default function LoginTabScreen() {
  const { goToLogin } = useAuth();
  const { isDark } = useTheme();
  const [isProcessing, setIsProcessing] = useState(false);

  const colors = getColors(isDark);

  const handleLogin = async () => {
    if (isProcessing) return; // Voorkom dubbele clicks

    try {
      setIsProcessing(true);
      console.log('LoginTabScreen: User wants to login, clearing guest mode');
      await goToLogin();
    } catch (error) {
      console.error('LoginTabScreen: Error going to login:', error);
    } finally {
      setIsProcessing(false);
    }
  };

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: colors.background }]}
    >
      <View style={styles.content}>
        <View style={[styles.iconContainer, { backgroundColor: colors.card }]}>
          <Icon name="login" size={80} color={colors.primary} />
        </View>

        <Text style={[styles.title, { color: colors.text }]}>Inloggen</Text>

        <Text style={[styles.description, { color: colors.textSecondary }]}>
          Je bekijkt de website als gast. Log in om toegang te krijgen tot je
          account en alle functies.
        </Text>

        <TouchableOpacity
          style={[
            styles.loginButton,
            { backgroundColor: colors.primary },
            isProcessing && { backgroundColor: colors.textSecondary },
          ]}
          onPress={handleLogin}
          disabled={isProcessing}
        >
          <Icon name="login" size={24} color={colors.white} />
          <Text style={[styles.loginButtonText, { color: colors.white }]}>
            {isProcessing ? 'Bezig...' : 'Inloggen'}
          </Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: 24,
  },
  iconContainer: {
    borderRadius: 50,
    padding: 20,
    marginBottom: 32,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    marginBottom: 16,
    textAlign: 'center',
  },
  description: {
    fontSize: 16,
    textAlign: 'center',
    lineHeight: 24,
    marginBottom: 40,
    paddingHorizontal: 20,
  },
  loginButton: {
    borderRadius: 12,
    paddingVertical: 16,
    paddingHorizontal: 32,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.15,
    shadowRadius: 4,
    elevation: 2,
    minWidth: 200,
  },
  loginButtonText: {
    fontSize: 18,
    fontWeight: '600',
    marginLeft: 8,
  },
});
