import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  ActivityIndicator,
  Alert,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import LocalizationService from '../services/LocalizationService';
import NativeFeaturesService from '../services/NativeFeaturesService';
import HapticFeedbackService from '../services/HapticFeedbackService';
import { useAuth } from '../context/AuthContext';

interface BiometricLockScreenProps {
  onUnlockSuccess: () => void;
}

export default function BiometricLockScreen({
  onUnlockSuccess,
}: BiometricLockScreenProps) {
  const { biometricFailureCount } = useAuth();
  const [isUnlocking, setIsUnlocking] = useState(false);
  const [unlockError, setUnlockError] = useState<string | null>(null);
  const [showRetryButton, setShowRetryButton] = useState(false);
  const [isPermamentlyLocked, setIsPermamentlyLocked] = useState(false);

  // Check if permanently locked due to too many failures
  useEffect(() => {
    setIsPermamentlyLocked(biometricFailureCount >= 3);
  }, [biometricFailureCount]);

  const handleUnlock = async () => {
    if (isUnlocking || isPermamentlyLocked) return;

    setIsUnlocking(true);
    setUnlockError(null);
    setShowRetryButton(false);

    try {
      console.log('BiometricLockScreen: Starting authentication...');

      const result = await NativeFeaturesService.authenticateForUnlock();

      console.log('BiometricLockScreen: Authentication result:', result);

      if (result.success) {
        // SUCCESS - Grant access immediately
        console.log('BiometricLockScreen: SUCCESS - calling onUnlockSuccess');
        await HapticFeedbackService.biometricAuth(true);
        onUnlockSuccess();
      } else {
        // FAILURE or CANCEL - Show retry button
        console.log('BiometricLockScreen: FAILED/CANCELLED - showing retry');
        setShowRetryButton(true);

        if (biometricFailureCount >= 2) {
          // Will be 3 after this failure
          setUnlockError('Te veel mislukte pogingen. App vergrendeld.');
          setIsPermamentlyLocked(true);

          Alert.alert(
            'App Vergrendeld',
            'Te veel mislukte Face ID pogingen. Open de app-instellingen om opnieuw te proberen.',
            [
              {
                text: 'Open Instellingen',
                onPress: () => NativeFeaturesService.openAppSettings(),
              },
            ],
          );
        } else {
          setUnlockError(
            result.error?.includes('cancel') || result.error?.includes('Cancel')
              ? 'Face ID geannuleerd. Probeer opnieuw om door te gaan.'
              : 'Face ID authenticatie mislukt. Probeer opnieuw.',
          );
        }

        await HapticFeedbackService.biometricAuth(false);
      }
    } catch (error) {
      console.error('BiometricLockScreen: Authentication error:', error);
      setShowRetryButton(true);
      setUnlockError('Er is een fout opgetreden. Probeer opnieuw.');
      await NativeFeaturesService.triggerNotificationHaptic('error');
    } finally {
      setIsUnlocking(false);
    }
  };

  const handleOpenSettings = () => {
    NativeFeaturesService.openAppSettings();
  };

  // Auto-start authentication on mount (after splash)
  useEffect(() => {
    const startAuth = async () => {
      // Small delay to ensure screen is rendered
      setTimeout(() => {
        if (!isPermamentlyLocked) {
          console.log('BiometricLockScreen: Auto-starting authentication');
          handleUnlock();
        }
      }, 500);
    };

    startAuth();
  }, []); // Only on mount

  return (
    <View style={styles.container}>
      <View style={styles.lockScreen}>
        <View style={styles.iconContainer}>
          <Icon
            name="face"
            size={100}
            color={isPermamentlyLocked ? Colors.error : Colors.primary}
          />
        </View>

        <Text style={styles.title}>
          {isPermamentlyLocked
            ? 'App Vergrendeld'
            : LocalizationService.t('features.biometricAuth.lockTitle')}
        </Text>

        <Text style={styles.subtitle}>
          {isPermamentlyLocked
            ? 'Te veel mislukte pogingen. Open app-instellingen om opnieuw te proberen.'
            : 'Gebruik Face ID om Chili Market te ontgrendelen'}
        </Text>

        {unlockError && (
          <View style={styles.errorContainer}>
            <Icon name="error" size={24} color={Colors.error} />
            <Text style={styles.errorText}>{unlockError}</Text>
          </View>
        )}

        {/* Main action button */}
        {!isPermamentlyLocked && (
          <TouchableOpacity
            style={[
              styles.unlockButton,
              (isUnlocking || isPermamentlyLocked) &&
                styles.unlockButtonDisabled,
            ]}
            onPress={handleUnlock}
            disabled={isUnlocking || isPermamentlyLocked}
          >
            {isUnlocking ? (
              <ActivityIndicator size="small" color={Colors.white} />
            ) : (
              <>
                <Icon name="face" size={28} color={Colors.white} />
                <Text style={styles.unlockButtonText}>
                  {showRetryButton
                    ? 'Probeer Opnieuw'
                    : 'Ontgrendel met Face ID'}
                </Text>
              </>
            )}
          </TouchableOpacity>
        )}

        {/* Settings button for permanent lockout */}
        {isPermamentlyLocked && (
          <TouchableOpacity
            style={styles.settingsButton}
            onPress={handleOpenSettings}
          >
            <Icon name="settings" size={24} color={Colors.white} />
            <Text style={styles.settingsButtonText}>Open App-Instellingen</Text>
          </TouchableOpacity>
        )}

        {/* Help button */}
        {!isPermamentlyLocked && showRetryButton && (
          <TouchableOpacity
            style={styles.helpButton}
            onPress={handleOpenSettings}
          >
            <Text style={styles.helpButtonText}>
              Problemen met Face ID? Open Instellingen
            </Text>
          </TouchableOpacity>
        )}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
    justifyContent: 'center',
    alignItems: 'center',
  },
  lockScreen: {
    width: '90%',
    maxWidth: 400,
    padding: 32,
    alignItems: 'center',
  },
  iconContainer: {
    marginBottom: 32,
    padding: 20,
    borderRadius: 50,
    backgroundColor: Colors.surface,
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: Colors.text,
    textAlign: 'center',
    marginBottom: 16,
  },
  subtitle: {
    fontSize: 16,
    color: Colors.textSecondary,
    textAlign: 'center',
    marginBottom: 32,
    lineHeight: 24,
  },
  errorContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: Colors.error + '20',
    padding: 16,
    borderRadius: 12,
    marginBottom: 24,
    width: '100%',
  },
  errorText: {
    color: Colors.error,
    fontSize: 14,
    marginLeft: 8,
    flex: 1,
    fontWeight: '500',
  },
  unlockButton: {
    backgroundColor: Colors.primary,
    paddingVertical: 16,
    paddingHorizontal: 32,
    borderRadius: 12,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    width: '100%',
    marginBottom: 16,
    elevation: 3,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
  },
  unlockButtonDisabled: {
    backgroundColor: Colors.gray400,
    elevation: 0,
    shadowOpacity: 0,
  },
  unlockButtonText: {
    color: Colors.white,
    fontSize: 18,
    fontWeight: '600',
    marginLeft: 12,
  },
  settingsButton: {
    backgroundColor: Colors.error,
    paddingVertical: 16,
    paddingHorizontal: 32,
    borderRadius: 12,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    width: '100%',
    marginBottom: 16,
  },
  settingsButtonText: {
    color: Colors.white,
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 8,
  },
  helpButton: {
    paddingVertical: 12,
    paddingHorizontal: 16,
  },
  helpButtonText: {
    color: Colors.primary,
    fontSize: 14,
    textAlign: 'center',
    textDecorationLine: 'underline',
  },
});
