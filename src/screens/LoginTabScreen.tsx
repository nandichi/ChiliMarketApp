import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  SafeAreaView,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import { useAuth } from '../context/AuthContext';

export default function LoginTabScreen() {
  const { goToLogin } = useAuth();
  const [isProcessing, setIsProcessing] = useState(false);

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
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        <View style={styles.iconContainer}>
          <Icon name="login" size={80} color={Colors.primary} />
        </View>
        
        <Text style={styles.title}>Inloggen</Text>
        
        <Text style={styles.description}>
          Je bekijkt de website als gast. Log in om toegang te krijgen tot je account en alle functies.
        </Text>

        <TouchableOpacity
          style={[styles.loginButton, isProcessing && styles.loginButtonDisabled]}
          onPress={handleLogin}
          disabled={isProcessing}
        >
          <Icon name="login" size={24} color={Colors.white} />
          <Text style={styles.loginButtonText}>
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
    backgroundColor: Colors.background,
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: 24,
  },
  iconContainer: {
    backgroundColor: Colors.white,
    borderRadius: 50,
    padding: 20,
    marginBottom: 32,
    // Vereenvoudigde shadow styling
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: Colors.text,
    marginBottom: 16,
    textAlign: 'center',
  },
  description: {
    fontSize: 16,
    color: Colors.textSecondary,
    textAlign: 'center',
    lineHeight: 24,
    marginBottom: 40,
    paddingHorizontal: 20,
  },
  loginButton: {
    backgroundColor: Colors.primary,
    borderRadius: 12,
    paddingVertical: 16,
    paddingHorizontal: 32,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    // Vereenvoudigde shadow styling
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.15,
    shadowRadius: 4,
    elevation: 2,
    minWidth: 200,
  },
  loginButtonDisabled: {
    backgroundColor: Colors.textSecondary,
    shadowOpacity: 0,
    elevation: 0,
  },
  loginButtonText: {
    color: Colors.white,
    fontSize: 18,
    fontWeight: '600',
    marginLeft: 8,
  },
}); 