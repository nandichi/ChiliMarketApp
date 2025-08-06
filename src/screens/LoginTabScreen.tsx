import React from 'react';
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

  const handleLogin = async () => {
    try {
      console.log('LoginTabScreen: User wants to login, clearing guest mode');
      await goToLogin();
    } catch (error) {
      console.error('LoginTabScreen: Error going to login:', error);
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
          style={styles.loginButton}
          onPress={handleLogin}
        >
          <Icon name="login" size={24} color={Colors.white} />
          <Text style={styles.loginButtonText}>Inloggen</Text>
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
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 8,
    elevation: 6,
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
    shadowColor: Colors.primary,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 4,
    minWidth: 200,
  },
  loginButtonText: {
    color: Colors.white,
    fontSize: 18,
    fontWeight: '600',
    marginLeft: 8,
  },
}); 