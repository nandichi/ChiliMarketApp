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
import { Colors } from '../constants/colors';
import { useAuth } from '../context/AuthContext';
import WordPressAPI from '../services/WordPressAPI';

const { width } = Dimensions.get('window');

export default function LoginScreen() {
  const { login, continueAsGuest, isLoading, loadingMessage, error } = useAuth();
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [debugInfo, setDebugInfo] = useState<string>('');
  const [debugging, setDebugging] = useState(false);

  const handleLogin = async () => {
    if (!username.trim() || !password.trim()) {
      Alert.alert('Fout', 'Vul zowel gebruikersnaam als wachtwoord in.');
      return;
    }

    try {
      await login(username.trim(), password.trim());
      // Navigation wordt afgehandeld in AuthContext
    } catch (error) {
      const errorMessage =
        error instanceof Error ? error.message : 'Login mislukt';
      Alert.alert('Login Fout', errorMessage);
    }
  };

  const handleDebugAPI = async () => {
    setDebugging(true);
    setDebugInfo('Starting API debug...\n');

    try {
      const api = new WordPressAPI();

      // Clear previous debug info
      setDebugInfo('');

      // Redirect console.log to our debug info
      const originalLog = console.log;
      const originalError = console.error;

      console.log = (...args) => {
        const message = args
          .map(arg =>
            typeof arg === 'object'
              ? JSON.stringify(arg, null, 2)
              : String(arg),
          )
          .join(' ');
        setDebugInfo(prev => prev + message + '\n');
        originalLog(...args);
      };

      console.error = (...args) => {
        const message = args
          .map(arg =>
            typeof arg === 'object'
              ? JSON.stringify(arg, null, 2)
              : String(arg),
          )
          .join(' ');
        setDebugInfo(prev => prev + '❌ ' + message + '\n');
        originalError(...args);
      };

      await api.debugAPI();

      // Test connection
      const connectionTest = await api.testConnection();
      console.log('Connection test result:', connectionTest);

      // Test JWT Auth specifiek
      const jwtDebug = await api.debugJWTAuth();
      console.log('JWT Auth debug result:', jwtDebug);

      // Restore console functions
      console.log = originalLog;
      console.error = originalError;
    } catch (error) {
      setDebugInfo(prev => prev + `\n❌ Debug error: ${error}\n`);
    } finally {
      setDebugging(false);
    }
  };

  const clearDebugInfo = () => {
    setDebugInfo('');
  };

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.contentContainer}
    >
      <View style={styles.logoContainer}>
        <View style={styles.logoImageContainer}>
          <Image
            source={require('../../ChiliMarket-Logo.png')}
            style={styles.logoImage}
            resizeMode="contain"
          />
        </View>
        <Text style={styles.appName}>Chili Market</Text>
        <Text style={styles.subtitle}>Inloggen op je account</Text>
      </View>

      <View style={styles.formContainer}>
        <View style={styles.inputContainer}>
          <Icon
            name="person"
            size={20}
            color={Colors.textSecondary}
            style={styles.inputIcon}
          />
          <TextInput
            style={styles.input}
            placeholder="Gebruikersnaam of email"
            placeholderTextColor={Colors.textSecondary}
            value={username}
            onChangeText={setUsername}
            autoCapitalize="none"
            autoCorrect={false}
            keyboardType="email-address"
          />
        </View>

        <View style={styles.inputContainer}>
          <Icon
            name="lock"
            size={20}
            color={Colors.textSecondary}
            style={styles.inputIcon}
          />
          <TextInput
            style={styles.input}
            placeholder="Wachtwoord"
            placeholderTextColor={Colors.textSecondary}
            value={password}
            onChangeText={setPassword}
            secureTextEntry={!showPassword}
            autoCapitalize="none"
            autoCorrect={false}
          />
          <TouchableOpacity
            onPress={() => setShowPassword(!showPassword)}
            style={styles.passwordToggle}
          >
            <Icon
              name={showPassword ? 'visibility-off' : 'visibility'}
              size={20}
              color={Colors.textSecondary}
            />
          </TouchableOpacity>
        </View>

        <TouchableOpacity
          style={[styles.loginButton, isLoading && styles.loginButtonDisabled]}
          onPress={handleLogin}
          disabled={isLoading}
        >
          {isLoading ? (
            <View style={styles.loadingContainer}>
              <ActivityIndicator color={Colors.white} size="small" />
              <Text style={styles.loadingText}>{loadingMessage}</Text>
            </View>
          ) : (
            <Text style={styles.loginButtonText}>Inloggen</Text>
          )}
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.guestButton}
          onPress={() => continueAsGuest()}
          disabled={isLoading}
        >
          <Icon name="explore" size={20} color={Colors.primary} />
          <Text style={styles.guestButtonText}>Doorgaan zonder inloggen</Text>
        </TouchableOpacity>

        {error && (
          <View style={styles.errorContainer}>
            <Icon name="error-outline" size={20} color={Colors.error} />
            <Text style={styles.errorText}>{error}</Text>
          </View>
        )}

        {/* Debug Section */}
        <View style={styles.debugSection}>
          <Text style={styles.debugTitle}>WordPress API Debug</Text>

          <View style={styles.debugButtons}>
            <TouchableOpacity
              style={[
                styles.debugButton,
                debugging && styles.debugButtonDisabled,
              ]}
              onPress={handleDebugAPI}
              disabled={debugging}
            >
              {debugging ? (
                <ActivityIndicator color={Colors.white} size="small" />
              ) : (
                <>
                  <Icon name="bug-report" size={16} color={Colors.white} />
                  <Text style={styles.debugButtonText}>Test API</Text>
                </>
              )}
            </TouchableOpacity>

            <TouchableOpacity
              style={styles.clearButton}
              onPress={clearDebugInfo}
            >
              <Icon name="clear" size={16} color={Colors.primary} />
              <Text style={styles.clearButtonText}>Clear</Text>
            </TouchableOpacity>
          </View>

          {debugInfo ? (
            <ScrollView style={styles.debugOutput} nestedScrollEnabled={true}>
              <Text style={styles.debugText}>{debugInfo}</Text>
            </ScrollView>
          ) : null}
        </View>
      </View>

      <TouchableOpacity style={styles.websiteButton}>
        <Icon name="web" size={20} color={Colors.primary} />
        <Text style={styles.websiteButtonText}>Ga naar website</Text>
      </TouchableOpacity>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
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
  logoImageContainer: {
    width: 100,
    height: 100,
    borderRadius: 50,
    backgroundColor: Colors.white,
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 8,
    elevation: 6,
    marginBottom: 8,
  },
  logoImage: {
    width: 80,
    height: 80,
  },
  appName: {
    fontSize: 32,
    fontWeight: 'bold',
    color: Colors.primary,
    marginTop: 16,
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
  debugSection: {
    marginTop: 32,
    padding: 16,
    backgroundColor: Colors.card,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: Colors.border,
  },
  debugTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: Colors.text,
    marginBottom: 12,
  },
  debugButtons: {
    flexDirection: 'row',
    marginBottom: 12,
  },
  debugButton: {
    backgroundColor: Colors.primary,
    borderRadius: 8,
    paddingVertical: 8,
    paddingHorizontal: 12,
    flexDirection: 'row',
    alignItems: 'center',
    marginRight: 8,
  },
  debugButtonDisabled: {
    backgroundColor: Colors.textSecondary,
  },
  debugButtonText: {
    color: Colors.white,
    fontSize: 12,
    fontWeight: '500',
    marginLeft: 4,
  },
  clearButton: {
    backgroundColor: 'transparent',
    borderWidth: 1,
    borderColor: Colors.primary,
    borderRadius: 8,
    paddingVertical: 8,
    paddingHorizontal: 12,
    flexDirection: 'row',
    alignItems: 'center',
  },
  clearButtonText: {
    color: Colors.primary,
    fontSize: 12,
    fontWeight: '500',
    marginLeft: 4,
  },
  debugOutput: {
    backgroundColor: Colors.background,
    borderRadius: 8,
    padding: 12,
    maxHeight: 200,
    borderWidth: 1,
    borderColor: Colors.border,
  },
  debugText: {
    fontFamily: 'monospace',
    fontSize: 10,
    color: Colors.text,
    lineHeight: 14,
  },
  websiteButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 24,
    paddingVertical: 12,
  },
  websiteButtonText: {
    color: Colors.primary,
    fontSize: 16,
    fontWeight: '500',
    marginLeft: 8,
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
