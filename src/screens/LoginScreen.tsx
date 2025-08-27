import React, { useState } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  Alert,
  ActivityIndicator,
  ScrollView,
  Dimensions,
  Image,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { getColors, Colors } from '../constants/colors';
import { useAuth } from '../context/AuthContext';
import { useTheme } from '../context/ThemeContext';
import HapticFeedbackService from '../services/HapticFeedbackService';

const { width } = Dimensions.get('window');

export default function LoginScreen() {
  const { login, continueAsGuest, isLoading, loadingMessage, error } =
    useAuth();
  const { isDark } = useTheme();
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);

  const colors = getColors(isDark);

  const handleLogin = async () => {
    await HapticFeedbackService.triggerForAction('button_press');

    if (!username.trim() || !password.trim()) {
      await HapticFeedbackService.triggerForAction('error');
      Alert.alert('Fout', 'Vul zowel gebruikersnaam als wachtwoord in.');
      return;
    }

    try {
      await login(username.trim(), password.trim());
      await HapticFeedbackService.triggerForAction('login');
      // Navigation wordt afgehandeld in AuthContext
    } catch (error) {
      await HapticFeedbackService.triggerForAction('error');
      const errorMessage =
        error instanceof Error ? error.message : 'Login mislukt';
      Alert.alert('Login Fout', errorMessage);
    }
  };

  return (
    <ScrollView
      style={[styles.container, { backgroundColor: colors.background }]}
      contentContainerStyle={styles.contentContainer}
    >
      <View style={styles.logoContainer}>
        <Image
          source={require('../../Chili-Market-Logo.png')}
          style={styles.appNameLogo}
          resizeMode="contain"
        />
        <Text style={[styles.subtitle, { color: colors.textSecondary }]}>
          Inloggen op je account
        </Text>
      </View>

      <View style={styles.formContainer}>
        <View
          style={[
            styles.inputContainer,
            { backgroundColor: colors.card, borderColor: colors.border },
          ]}
        >
          <Icon
            name="person"
            size={20}
            color={colors.primary}
            style={styles.inputIcon}
          />
          <TextInput
            style={[styles.input, { color: colors.text }]}
            placeholder="Gebruikersnaam of email"
            placeholderTextColor={colors.textSecondary}
            value={username}
            onChangeText={setUsername}
            autoCapitalize="none"
            autoCorrect={false}
            keyboardType="email-address"
          />
        </View>

        <View
          style={[
            styles.inputContainer,
            { backgroundColor: colors.card, borderColor: colors.border },
          ]}
        >
          <Icon
            name="lock"
            size={20}
            color={colors.primary}
            style={styles.inputIcon}
          />
          <TextInput
            style={[styles.input, { color: colors.text }]}
            placeholder="Wachtwoord"
            placeholderTextColor={colors.textSecondary}
            value={password}
            onChangeText={setPassword}
            secureTextEntry={!showPassword}
            autoCapitalize="none"
            autoCorrect={false}
          />
          <TouchableOpacity
            onPress={async () => {
              await HapticFeedbackService.triggerForAction('toggle');
              setShowPassword(!showPassword);
            }}
            style={styles.passwordToggle}
          >
            <Icon
              name={showPassword ? 'visibility-off' : 'visibility'}
              size={20}
              color={colors.textSecondary}
            />
          </TouchableOpacity>
        </View>

        <TouchableOpacity
          style={[
            styles.loginButton,
            { backgroundColor: colors.primary },
            isLoading && { backgroundColor: colors.textSecondary },
          ]}
          onPress={handleLogin}
          disabled={isLoading}
        >
          {isLoading ? (
            <View style={styles.loadingContainer}>
              <ActivityIndicator color={colors.white} size="small" />
              <Text style={[styles.loadingText, { color: colors.white }]}>
                {loadingMessage}
              </Text>
            </View>
          ) : (
            <Text style={[styles.loginButtonText, { color: colors.white }]}>
              Inloggen
            </Text>
          )}
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.guestButton}
          onPress={async () => {
            await HapticFeedbackService.triggerForAction('navigation');
            continueAsGuest();
          }}
          disabled={isLoading}
        >
          <Icon name="explore" size={20} color={colors.primary} />
          <Text style={[styles.guestButtonText, { color: colors.primary }]}>
            Doorgaan zonder inloggen
          </Text>
        </TouchableOpacity>

        {error && (
          <View
            style={[
              styles.errorContainer,
              { backgroundColor: colors.backgroundRed },
            ]}
          >
            <Icon name="error-outline" size={20} color={colors.error} />
            <Text style={[styles.errorText, { color: colors.error }]}>
              {error}
            </Text>
          </View>
        )}
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  contentContainer: {
    flexGrow: 1,
    justifyContent: 'center',
    paddingHorizontal: 24,
    paddingVertical: 40,
  },
  logoContainer: {
    alignItems: 'center',
    marginBottom: 40,
  },

  appNameLogo: {
    width: 280,
    height: 80,
    marginBottom: 8,
    opacity: 0.95,
    shadowColor: Colors.primary,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.25,
    shadowRadius: 8,
    elevation: 8,
    transform: [{ scale: 1.02 }],
  },
  subtitle: {
    fontSize: 16,
    color: Colors.textSecondary,
    marginTop: 8,
    textAlign: 'center',
  },
  tempAuthNotice: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: Colors.backgroundYellow,
    borderRadius: 8,
    padding: 8,
    marginTop: 12,
    borderWidth: 1,
    borderColor: Colors.warning,
  },
  tempAuthText: {
    color: Colors.warning,
    fontSize: 12,
    marginLeft: 6,
    textAlign: 'center',
    flex: 1,
  },
  formContainer: {
    width: '100%',
    maxWidth: 400,
    alignSelf: 'center',
  },
  inputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: Colors.white,
    borderRadius: 12,
    marginBottom: 16,
    paddingHorizontal: 16,
    paddingVertical: 4,
    borderWidth: 1,
    borderColor: Colors.border,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  inputIcon: {
    marginRight: 12,
  },
  input: {
    flex: 1,
    fontSize: 16,
    color: Colors.text,
    paddingVertical: 16,
  },
  passwordToggle: {
    padding: 4,
  },
  loginButton: {
    backgroundColor: Colors.primary,
    borderRadius: 12,
    paddingVertical: 16,
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 8,
    shadowColor: Colors.primary,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 4,
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
  },
  guestButton: {
    backgroundColor: 'transparent',
    borderWidth: 1,
    borderColor: Colors.primary,
    borderRadius: 12,
    paddingVertical: 16,
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 12,
    flexDirection: 'row',
  },
  guestButtonText: {
    color: Colors.primary,
    fontSize: 16,
    fontWeight: '500',
    marginLeft: 8,
  },
  errorContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: Colors.surface,
    borderRadius: 8,
    padding: 12,
    marginTop: 16,
  },
  errorText: {
    color: Colors.error,
    fontSize: 14,
    marginLeft: 8,
    flex: 1,
  },

  loadingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
  },
  loadingText: {
    color: Colors.white,
    fontSize: 14,
    marginLeft: 8,
  },
});
