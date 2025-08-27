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
import Clipboard from '@react-native-clipboard/clipboard';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { getColors } from '../constants/colors';
import { useAuth } from '../context/AuthContext';
import { useTheme } from '../context/ThemeContext';
import NativeFeaturesService from '../services/NativeFeaturesService';
import LocalizationService from '../services/LocalizationService';
import SocialShareButtons from '../components/SocialShareButtons';

export default function LogoutScreen() {
  const {
    user,
    logout,
    isLoading,
    setBiometricEnabled: setBiometricEnabledAuth,
    biometricEnabled: authBiometricEnabled,
    api,
  } = useAuth();
  const { isDark, mode, setThemeMode, toggleTheme } = useTheme();
  const [currentUser, setCurrentUser] = useState(user);
  const [currentLoading, setCurrentLoading] = useState(isLoading);
  const [systemInfo, setSystemInfo] = useState<any>(null);
  const [biometricInfo, setBiometricInfo] = useState<any>(null);
  const [biometricEnabled, setBiometricEnabled] = useState(false);
  const [loadingBiometric, setLoadingBiometric] = useState(false);
  const [featureLoading, setFeatureLoading] = useState<string | null>(null);

  const colors = getColors(isDark);

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

  const handleCopyAffiliateLink = async () => {
    if (!currentUser) return;

    try {
      // Gebruik username of name als fallback
      const referralCode = currentUser.username || currentUser.name || 'user';
      const affiliateLink = `https://chili-market.com?r=${referralCode}`;

      // Kopieer naar clipboard
      await Clipboard.setString(affiliateLink);

      // Trigger success haptic
      await NativeFeaturesService.triggerNotificationHaptic('success');

      Alert.alert(
        'Affiliate Link Gekopieerd!',
        `Je persoonlijke link is gekopieerd naar het klembord:\n\n${affiliateLink}\n\nDeel deze link met vrienden en verdien commissie op hun aankopen!`,
      );
    } catch (error) {
      console.error('Failed to copy affiliate link:', error);
      await NativeFeaturesService.triggerNotificationHaptic('error');
      Alert.alert(
        'Fout',
        'Er is een fout opgetreden bij het kopiëren van je affiliate link. Probeer opnieuw.',
      );
    }
  };

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

  const handleDarkModeToggle = async () => {
    try {
      await NativeFeaturesService.triggerImpactHaptic('light');
      await toggleTheme();
      await NativeFeaturesService.triggerNotificationHaptic('success');
    } catch (error) {
      console.error('Dark mode toggle error:', error);
      await NativeFeaturesService.triggerNotificationHaptic('error');
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
      style={[styles.featureButton, { borderBottomColor: colors.border }]}
      onPress={onPress}
      disabled={featureLoading !== null}
      accessibilityLabel={title}
      accessibilityHint={subtitle}
    >
      <View style={styles.featureButtonContent}>
        <View style={styles.featureButtonLeft}>
          <Icon name={iconName} size={24} color={colors.primary} />
          <View style={styles.featureButtonText}>
            <Text style={[styles.featureButtonTitle, { color: colors.text }]}>
              {title}
            </Text>
            {subtitle && (
              <Text
                style={[
                  styles.featureButtonSubtitle,
                  { color: colors.textSecondary },
                ]}
              >
                {subtitle}
              </Text>
            )}
          </View>
        </View>
        <View style={styles.featureButtonRight}>
          {(featureLoading === title || loadingBiometric) && (
            <ActivityIndicator size="small" color={colors.primary} />
          )}
          {showSwitch && !featureLoading && !loadingBiometric && (
            <Switch
              value={switchValue || false}
              onValueChange={onSwitchChange}
              trackColor={{ false: colors.gray300, true: colors.primary }}
              thumbColor={
                Platform.OS === 'ios'
                  ? undefined
                  : switchValue
                  ? colors.white
                  : colors.gray500
              }
            />
          )}
          {!showSwitch && !featureLoading && (
            <Icon name="chevron-right" size={24} color={colors.gray400} />
          )}
        </View>
      </View>
    </TouchableOpacity>
  );

  const renderSection = (title: string, children: React.ReactNode) => (
    <View style={styles.section}>
      <Text style={[styles.sectionTitle, { color: colors.text }]}>{title}</Text>
      <View style={[styles.sectionContent, { backgroundColor: colors.card }]}>
        {children}
      </View>
    </View>
  );

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: colors.background }]}
    >
      <ScrollView
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
      >
        {/* Header Section */}
        <View style={styles.header}>
          <View
            style={[styles.iconContainer, { backgroundColor: colors.card }]}
          >
            <Icon name="settings" size={50} color={colors.primary} />
          </View>
          <Text style={[styles.title, { color: colors.text }]}>
            {LocalizationService.t('logout.title')}
          </Text>
          {currentUser && (
            <View
              style={[
                styles.userInfo,
                { backgroundColor: colors.card, borderColor: colors.border },
              ]}
              accessibilityRole="text"
              accessibilityLabel={`${LocalizationService.t(
                'logout.loggedInAs',
              )} ${currentUser.name || currentUser.username}`}
            >
              <View
                style={[styles.statusDot, { backgroundColor: colors.success }]}
              />
              <Text
                style={[styles.userInfoLabel, { color: colors.textSecondary }]}
              >
                {LocalizationService.t('logout.loggedInAs')}
              </Text>
              <View
                style={[
                  styles.userNameChip,
                  {
                    backgroundColor: colors.surface,
                    borderColor: colors.border,
                  },
                ]}
              >
                <Text style={[styles.userNameChipText, { color: colors.text }]}>
                  {currentUser.name || currentUser.username}
                </Text>
              </View>
            </View>
          )}
        </View>

        {/* Affiliate Link Section - Prominent Feature */}
        {currentUser && (
          <View style={styles.affiliateSection}>
            <View
              style={[
                styles.affiliateCard,
                { backgroundColor: colors.primary },
              ]}
            >
              <View style={styles.affiliateHeader}>
                <Icon name="share" size={32} color={colors.white} />
                <View style={styles.affiliateHeaderText}>
                  <Text
                    style={[styles.affiliateTitle, { color: colors.white }]}
                  >
                    Verdien Met Affiliate Links!
                  </Text>
                  <Text
                    style={[styles.affiliateSubtitle, { color: colors.white }]}
                  >
                    Deel je persoonlijke link en verdien commissie
                  </Text>
                </View>
              </View>

              <View
                style={[
                  styles.affiliateLink,
                  { backgroundColor: colors.white },
                ]}
              >
                <Text
                  style={[
                    styles.affiliateLinkText,
                    { color: colors.textSecondary },
                  ]}
                >
                  https://chili-market.com?r=
                  {currentUser.username || currentUser.name || 'user'}
                </Text>
              </View>

              <TouchableOpacity
                style={[
                  styles.affiliateButton,
                  { backgroundColor: colors.white },
                ]}
                onPress={handleCopyAffiliateLink}
                activeOpacity={0.8}
              >
                <Icon name="content-copy" size={20} color={colors.primary} />
                <Text
                  style={[
                    styles.affiliateButtonText,
                    { color: colors.primary },
                  ]}
                >
                  Kopieer Affiliate Link
                </Text>
              </TouchableOpacity>

              <SocialShareButtons
                affiliateLink={`https://chili-market.com?r=${
                  currentUser.username || currentUser.name || 'user'
                }`}
                shareText="Verdien geld met Chili Market! Gebruik mijn affiliate link"
                variant="onPrimary"
                showTitle={false}
                showLabels={false}
                size="small"
              />
            </View>
          </View>
        )}

        {/* Beveiliging Section */}
        {renderSection(
          LocalizationService.t('sections.security'),
          <>
            {biometricInfo?.isSupported &&
              renderFeatureButton(
                biometricInfo.biometricType === 'faceID'
                  ? LocalizationService.t('features.biometricAuth.lockTitle')
                  : biometricInfo.biometricType === 'touchID'
                  ? LocalizationService.t('features.biometricAuth.touchID')
                  : LocalizationService.t('features.biometricAuth.biometric'),
                biometricInfo.biometricType === 'faceID'
                  ? 'face'
                  : 'fingerprint',
                () => {},
                biometricEnabled
                  ? LocalizationService.t('features.biometricAuth.enabled')
                  : LocalizationService.t('features.biometricAuth.disabled'),
                true,
                biometricEnabled,
                handleBiometricToggle,
              )}
            {renderFeatureButton(
              'Dark Mode',
              isDark ? 'brightness-6' : 'brightness-7',
              handleDarkModeToggle,
              mode === 'system'
                ? `Volgt systeem (momenteel ${isDark ? 'donker' : 'licht'})`
                : isDark
                ? 'Donkere modus actief'
                : 'Lichte modus actief',
              true,
              isDark,
              enabled => setThemeMode(enabled ? 'dark' : 'light'),
            )}
          </>,
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
              { backgroundColor: colors.error },
              currentLoading && { backgroundColor: colors.textSecondary },
            ]}
            onPress={handleLogout}
            disabled={currentLoading}
            accessibilityLabel="Uitloggen"
            accessibilityHint="Uitloggen van je account"
          >
            <Icon name="logout" size={24} color={colors.white} />
            <Text style={[styles.logoutButtonText, { color: colors.white }]}>
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
    marginBottom: 16,
    textAlign: 'center',
  },
  userInfo: {
    borderRadius: 12,
    padding: 12,
    alignItems: 'center',
    flexDirection: 'row',
    borderWidth: StyleSheet.hairlineWidth,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 2,
    elevation: 1,
    minWidth: 200,
  },
  userInfoLabel: {
    fontSize: 14,
    marginRight: 8,
  },
  statusDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    marginRight: 8,
  },
  userNameChip: {
    borderRadius: 16,
    paddingVertical: 6,
    paddingHorizontal: 10,
    borderWidth: StyleSheet.hairlineWidth,
    marginLeft: 4,
  },
  userNameChipText: {
    fontSize: 14,
    fontWeight: '600',
  },
  userName: {
    fontSize: 16,
    fontWeight: '600',
  },
  section: {
    paddingHorizontal: 16,
    marginBottom: 24,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 12,
    paddingHorizontal: 8,
  },
  sectionContent: {
    borderRadius: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 2,
    elevation: 1,
  },
  featureButton: {
    borderBottomWidth: StyleSheet.hairlineWidth,
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
  },
  featureButtonSubtitle: {
    fontSize: 14,
    marginTop: 2,
  },
  featureButtonRight: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  logoutButton: {
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
  logoutButtonText: {
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 8,
  },
  bottomSpacing: {
    height: 100,
  },
  // Affiliate Link Styles
  affiliateSection: {
    paddingHorizontal: 16,
    marginBottom: 24,
  },
  affiliateCard: {
    borderRadius: 16,
    padding: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.2,
    shadowRadius: 8,
    elevation: 8,
  },
  affiliateHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  affiliateHeaderText: {
    marginLeft: 12,
    flex: 1,
  },
  affiliateTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 4,
  },
  affiliateSubtitle: {
    fontSize: 14,
    opacity: 0.9,
  },
  affiliateLink: {
    borderRadius: 12,
    padding: 12,
    marginBottom: 16,
  },
  affiliateLinkText: {
    fontSize: 14,
    fontFamily: Platform.OS === 'ios' ? 'Menlo' : 'monospace',
    textAlign: 'center',
  },
  affiliateButton: {
    borderRadius: 12,
    paddingVertical: 14,
    paddingHorizontal: 20,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  affiliateButtonText: {
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 8,
  },
});
