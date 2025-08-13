import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Alert,
  SafeAreaView,
  ScrollView,
  ActivityIndicator,
  Platform,
  Switch,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import { useAuth } from '../context/AuthContext';
import NativeFeaturesService from '../services/NativeFeaturesService';
import LocalizationService from '../services/LocalizationService';

export default function LogoutScreen() {
  const {
    user,
    logout,
    isLoading,
    setBiometricEnabled: setBiometricEnabledAuth,
    biometricEnabled: authBiometricEnabled,
  } = useAuth();
  const [currentUser, setCurrentUser] = useState(user);
  const [currentLoading, setCurrentLoading] = useState(isLoading);
  const [systemInfo, setSystemInfo] = useState<any>(null);
  const [biometricInfo, setBiometricInfo] = useState<any>(null);
  const [biometricEnabled, setBiometricEnabled] = useState(false);
  const [loadingBiometric, setLoadingBiometric] = useState(false);
  const [featureLoading, setFeatureLoading] = useState<string | null>(null);

  // Stabiliseer de state om oneindige loops te voorkomen
  useEffect(() => {
    setCurrentUser(user);
  }, [user]);

  useEffect(() => {
    setCurrentLoading(isLoading);
  }, [isLoading]);

  // Load system info en biometric info bij startup
  useEffect(() => {
    loadSystemInfo();
    loadBiometricInfo();
  }, []);

  const loadSystemInfo = async () => {
    try {
      if (NativeFeaturesService.isAvailable()) {
        const info = await NativeFeaturesService.getSystemInfo();
        setSystemInfo(info);
      }
    } catch (error) {
      console.log('Failed to load system info:', error);
    }
  };

  const loadBiometricInfo = async () => {
    try {
      if (NativeFeaturesService.isAvailable()) {
        const info = await NativeFeaturesService.checkBiometricSupport();
        setBiometricInfo(info);
      }
    } catch (error) {
      console.log('Failed to load biometric info:', error);
    }
  };

  // Sync local state with AuthContext state without causing loops
  useEffect(() => {
    setBiometricEnabled(authBiometricEnabled);
  }, [authBiometricEnabled]);

  const handleLogout = () => {
    if (currentLoading) return; // Voorkom dubbele clicks

    Alert.alert(
      LocalizationService.t('logout.logout'),
      LocalizationService.t('logout.confirmLogout'),
      [
        {
          text: LocalizationService.t('common.cancel'),
          style: 'cancel',
        },
        {
          text: LocalizationService.t('logout.logout'),
          style: 'destructive',
          onPress: async () => {
            try {
              console.log('LogoutScreen: User confirmed logout');

              // Trigger success haptic
              NativeFeaturesService.triggerNotificationHaptic('success');

              // Disable de button tijdens logout
              setCurrentLoading(true);

              // Kleine vertraging om de button state te laten verwerken
              await new Promise(resolve => setTimeout(resolve, 100));

              await logout();
              console.log('LogoutScreen: Logout completed successfully');

              // Navigation wordt automatisch afgehandeld door AuthContext/AppNavigator
              // Geen extra navigatie acties hier
            } catch (error) {
              console.error('LogoutScreen: Logout error:', error);
              Alert.alert(
                LocalizationService.t('common.error'),
                LocalizationService.t('logout.logoutError'),
              );
              NativeFeaturesService.triggerNotificationHaptic('error');
              setCurrentLoading(false);
            }
          },
        },
      ],
    );
  };

  const handleFeature = async (
    featureName: string,
    action: () => Promise<void>,
  ) => {
    if (featureLoading) return;

    setFeatureLoading(featureName);
    try {
      await NativeFeaturesService.triggerImpactHaptic('light');
      await action();
    } catch (error) {
      console.error(`${featureName} error:`, error);
      Alert.alert('Fout', `${featureName} is mislukt. Probeer opnieuw.`);
      await NativeFeaturesService.triggerNotificationHaptic('error');
    } finally {
      setFeatureLoading(null);
    }
  };

  const handleShareApp = () =>
    handleFeature('Delen', async () => {
      await NativeFeaturesService.showShareSheet(
        'Probeer Chili Market - De beste marktplaats app!',
        'https://chili-market.com',
      );
    });

  const handleFilePicker = () =>
    handleFeature('Bestandskiezer', async () => {
      const result = await NativeFeaturesService.showFilePicker();
      if (result.fileName && !result.cancelled) {
        Alert.alert(
          'Bestand Geselecteerd',
          `Bestand: ${result.fileName}\nGrootte: ${result.fileSize} bytes`,
        );
      }
    });

  const handleCameraPermission = () =>
    handleFeature('Camera Toestemming', async () => {
      const status = await NativeFeaturesService.checkCameraPermission();
      if (status.status === 'notDetermined') {
        const result = await NativeFeaturesService.requestCameraPermission();
        Alert.alert(
          'Camera Toestemming',
          result.granted ? 'Toegang verleend!' : 'Toegang geweigerd',
        );
      } else {
        Alert.alert('Camera Toestemming', `Huidige status: ${status.status}`);
      }
    });

  const handlePhotosPermission = () =>
    handleFeature("Foto's Toestemming", async () => {
      const status = await NativeFeaturesService.checkPhotosPermission();
      if (status.status === 'notDetermined') {
        const result = await NativeFeaturesService.requestPhotosPermission();
        Alert.alert(
          "Foto's Toestemming",
          result.granted ? 'Toegang verleend!' : 'Toegang geweigerd',
        );
      } else {
        Alert.alert("Foto's Toestemming", `Huidige status: ${status.status}`);
      }
    });

  const handleHapticsTest = () =>
    handleFeature('Haptics Test', async () => {
      await NativeFeaturesService.triggerImpactHaptic('light');
      await new Promise(resolve => setTimeout(resolve, 200));
      await NativeFeaturesService.triggerImpactHaptic('medium');
      await new Promise(resolve => setTimeout(resolve, 200));
      await NativeFeaturesService.triggerImpactHaptic('heavy');
      await new Promise(resolve => setTimeout(resolve, 200));
      await NativeFeaturesService.triggerNotificationHaptic('success');
      Alert.alert('Haptics Test', 'Test voltooid!');
    });

  const handleInAppReview = () =>
    handleFeature('App Beoordeling', async () => {
      await NativeFeaturesService.requestInAppReview();
      Alert.alert(
        'App Beoordeling',
        'Beoordeling gevraagd (niet altijd zichtbaar)',
      );
    });

  const handleSupportEmail = () =>
    handleFeature('Support E-mail', async () => {
      const appName = systemInfo?.appName || 'Chili Market';
      const appVersion = systemInfo?.appVersion || 'Onbekend';
      const systemVersion = systemInfo?.systemVersion || 'Onbekend';

      const body = `
    
    ---
    App: ${appName} ${appVersion}
    iOS: ${systemVersion}
    Device: ${systemInfo?.deviceModel || 'Onbekend'}
    ---`;

      await NativeFeaturesService.showMailComposer(
        'Chili Market Support',
        body,
        ['support@chili-market.com'],
      );
    });

  const handleOpenSettings = () =>
    handleFeature('Instellingen', async () => {
      await NativeFeaturesService.openAppSettings();
    });

  const handlePrivacyPolicy = () =>
    handleFeature('Privacybeleid', async () => {
      await NativeFeaturesService.openInAppBrowser(
        'https://chili-market.com/privacy-policy/',
      );
    });

  const handleTermsOfService = () =>
    handleFeature('Gebruiksvoorwaarden', async () => {
      await NativeFeaturesService.openInAppBrowser(
        'https://chili-market.com/algemene-voorwaarden/',
      );
    });

  const handleBiometricToggle = async (enabled: boolean) => {
    if (loadingBiometric) return;

    setLoadingBiometric(true);

    try {
      const success = await setBiometricEnabledAuth(enabled);
      if (success) {
        // Don't manually set state - let useEffect handle it via authBiometricEnabled
        await NativeFeaturesService.triggerNotificationHaptic(
          enabled ? 'success' : 'warning',
        );
        Alert.alert(
          enabled
            ? LocalizationService.t('features.biometricAuth.activated')
            : LocalizationService.t('features.biometricAuth.deactivated'),
          enabled
            ? LocalizationService.t('features.biometricAuth.lockSubtitle')
            : 'Face ID vergrendeling is uitgeschakeld',
        );
      } else {
        Alert.alert(
          LocalizationService.t('common.error'),
          LocalizationService.t('features.biometricAuth.failed'),
        );
        await NativeFeaturesService.triggerNotificationHaptic('error');
      }
    } catch (error) {
      console.error('Biometric toggle error:', error);
      Alert.alert(
        LocalizationService.t('common.error'),
        'Er is een fout opgetreden. Probeer opnieuw.',
      );
      await NativeFeaturesService.triggerNotificationHaptic('error');
    } finally {
      setLoadingBiometric(false);
    }
  };

  const renderFeatureButton = (
    title: string,
    iconName: string,
    onPress: () => void,
    subtitle?: string,
    showSwitch?: boolean,
    switchValue?: boolean,
    onSwitchChange?: (value: boolean) => void,
  ) => (
    <TouchableOpacity
      style={styles.featureButton}
      onPress={onPress}
      disabled={featureLoading !== null}
      accessibilityLabel={title}
      accessibilityHint={subtitle}
    >
      <View style={styles.featureButtonContent}>
        <View style={styles.featureButtonLeft}>
          <Icon name={iconName} size={24} color={Colors.primary} />
          <View style={styles.featureButtonText}>
            <Text style={styles.featureButtonTitle}>{title}</Text>
            {subtitle && (
              <Text style={styles.featureButtonSubtitle}>{subtitle}</Text>
            )}
          </View>
        </View>
        <View style={styles.featureButtonRight}>
          {(featureLoading === title || loadingBiometric) && (
            <ActivityIndicator size="small" color={Colors.primary} />
          )}
          {showSwitch && !featureLoading && !loadingBiometric && (
            <Switch
              value={switchValue || false}
              onValueChange={onSwitchChange}
              trackColor={{ false: Colors.gray300, true: Colors.primary }}
              thumbColor={
                Platform.OS === 'ios'
                  ? undefined
                  : switchValue
                  ? Colors.white
                  : Colors.gray500
              }
            />
          )}
          {!showSwitch && !featureLoading && (
            <Icon name="chevron-right" size={24} color={Colors.gray400} />
          )}
        </View>
      </View>
    </TouchableOpacity>
  );

  const renderSection = (title: string, children: React.ReactNode) => (
    <View style={styles.section}>
      <Text style={styles.sectionTitle}>{title}</Text>
      <View style={styles.sectionContent}>{children}</View>
    </View>
  );

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
      >
        {/* Header Section */}
        <View style={styles.header}>
          <View style={styles.iconContainer}>
            <Icon name="settings" size={50} color={Colors.primary} />
          </View>
          <Text style={styles.title}>
            {LocalizationService.t('logout.title')}
          </Text>
          {currentUser && (
            <View style={styles.userInfo}>
              <Text style={styles.userInfoLabel}>
                {LocalizationService.t('logout.loggedInAs')}
              </Text>
              <Text style={styles.userName}>
                {currentUser.name || currentUser.username}
              </Text>
            </View>
          )}
        </View>

        {/* Beveiliging Section */}
        {biometricInfo?.isSupported &&
          renderSection(
            LocalizationService.t('sections.security'),
            renderFeatureButton(
              biometricInfo.biometricType === 'faceID'
                ? LocalizationService.t('features.biometricAuth.lockTitle')
                : biometricInfo.biometricType === 'touchID'
                ? LocalizationService.t('features.biometricAuth.touchID')
                : LocalizationService.t('features.biometricAuth.biometric'),
              biometricInfo.biometricType === 'faceID' ? 'face' : 'fingerprint',
              () => {},
              biometricEnabled
                ? LocalizationService.t('features.biometricAuth.enabled')
                : LocalizationService.t('features.biometricAuth.disabled'),
              true,
              biometricEnabled,
              handleBiometricToggle,
            ),
          )}

        {/* App Features Section */}
        {renderSection(
          'App-functies',
          <>
            {renderFeatureButton(
              LocalizationService.t('features.shareApp.title'),
              'share',
              handleShareApp,
              LocalizationService.t('features.shareApp.subtitle'),
            )}
          </>,
        )}

        {/* System & Info Section */}
        {renderSection(
          'Systeem & Info',
          <>
            {renderFeatureButton(
              'Camera Toestemming',
              'camera-alt',
              handleCameraPermission,
              'Beheer camera toegang',
            )}
            {renderFeatureButton(
              "Foto's Toestemming",
              'photo-library',
              handlePhotosPermission,
              "Beheer foto's toegang",
            )}
            {systemInfo &&
              renderFeatureButton(
                'App Informatie',
                'info',
                () =>
                  Alert.alert(
                    'App Informatie',
                    `${systemInfo.appName} ${systemInfo.appVersion} (${systemInfo.buildNumber})\n\nDevice: ${systemInfo.deviceModel}\niOS: ${systemInfo.systemVersion}`,
                  ),
                `${systemInfo.appVersion} (${systemInfo.buildNumber})`,
              )}
          </>,
        )}

        {/* Feedback Section */}
        {renderSection(
          'Feedback',
          <>
            {renderFeatureButton(
              'App Beoordelen',
              'star',
              handleInAppReview,
              'Geef een beoordeling in de App Store',
            )}
            {renderFeatureButton(
              'Support E-mail',
              'email',
              handleSupportEmail,
              'Stuur een support verzoek',
            )}
            {renderFeatureButton(
              'Privacybeleid',
              'privacy-tip',
              handlePrivacyPolicy,
              'Bekijk ons privacybeleid',
            )}
            {renderFeatureButton(
              'Gebruiksvoorwaarden',
              'description',
              handleTermsOfService,
              'Bekijk de gebruiksvoorwaarden',
            )}
          </>,
        )}

        {/* Logout Section */}
        {renderSection(
          LocalizationService.t('logout.logout'),
          <TouchableOpacity
            style={[
              styles.logoutButton,
              currentLoading && styles.logoutButtonDisabled,
            ]}
            onPress={handleLogout}
            disabled={currentLoading}
            accessibilityLabel="Uitloggen"
            accessibilityHint="Uitloggen van je account"
          >
            <Icon name="logout" size={24} color={Colors.white} />
            <Text style={styles.logoutButtonText}>
              {currentLoading
                ? LocalizationService.t('logout.loggingOut')
                : LocalizationService.t('logout.logout')}
            </Text>
          </TouchableOpacity>,
        )}

        {/* Bottom spacing */}
        <View style={styles.bottomSpacing} />
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  scrollView: {
    flex: 1,
  },
  header: {
    alignItems: 'center',
    paddingVertical: 24,
    paddingHorizontal: 24,
  },
  iconContainer: {
    backgroundColor: Colors.white,
    borderRadius: 40,
    padding: 20,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: Colors.text,
    marginBottom: 16,
    textAlign: 'center',
  },
  userInfo: {
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 16,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 2,
    elevation: 1,
    minWidth: 200,
  },
  userInfoLabel: {
    fontSize: 14,
    color: Colors.textSecondary,
    marginBottom: 4,
  },
  userName: {
    fontSize: 16,
    fontWeight: '600',
    color: Colors.text,
  },
  section: {
    paddingHorizontal: 16,
    marginBottom: 24,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: Colors.text,
    marginBottom: 12,
    paddingHorizontal: 8,
  },
  sectionContent: {
    backgroundColor: Colors.white,
    borderRadius: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 2,
    elevation: 1,
  },
  featureButton: {
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: Colors.border,
  },
  featureButtonContent: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingVertical: 16,
    paddingHorizontal: 16,
  },
  featureButtonLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
  },
  featureButtonText: {
    marginLeft: 12,
    flex: 1,
  },
  featureButtonTitle: {
    fontSize: 16,
    fontWeight: '500',
    color: Colors.text,
  },
  featureButtonSubtitle: {
    fontSize: 14,
    color: Colors.textSecondary,
    marginTop: 2,
  },
  featureButtonRight: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  logoutButton: {
    backgroundColor: Colors.error,
    borderRadius: 12,
    paddingVertical: 16,
    paddingHorizontal: 32,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginHorizontal: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.15,
    shadowRadius: 4,
    elevation: 2,
  },
  logoutButtonDisabled: {
    backgroundColor: Colors.textSecondary,
    shadowOpacity: 0,
    elevation: 0,
  },
  logoutButtonText: {
    color: Colors.white,
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 8,
  },
  bottomSpacing: {
    height: 100,
  },
});
