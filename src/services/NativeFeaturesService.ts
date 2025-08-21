/**
 * Service for accessing native iOS and Android features
 */

import { NativeModules, Platform } from 'react-native';
import {
  NativeFeaturesModule,
  ShareSheetResult,
  FilePickerResult,
  PermissionStatus,
  PermissionResult,
  HapticResult,
  InAppReviewResult,
  MailComposeResult,
  OpenSettingsResult,
  InAppBrowserResult,
  BiometricSupportResult,
  BiometricAuthResult,
  SystemInfo,
} from '../types/NativeFeatures';
import type { KeychainModule } from '../types/NativeFeatures';

const { NativeFeatures, KeychainModule } = NativeModules as {
  NativeFeatures: NativeFeaturesModule;
  KeychainModule: KeychainModule;
};

class NativeFeaturesService {
  /**
   * Check if native features are available (iOS and Android)
   */
  isAvailable(): boolean {
    return (
      (Platform.OS === 'ios' || Platform.OS === 'android') && !!NativeFeatures
    );
  }

  /**
   * Show share sheet (iOS and Android)
   */
  async showShareSheet(
    text: string = '',
    url: string = '',
  ): Promise<ShareSheetResult> {
    if (!this.isAvailable()) {
      throw new Error('Native features not available on this platform');
    }
    return NativeFeatures.showShareSheet(text, url);
  }

  /**
   * Show file picker
   */
  async showFilePicker(): Promise<FilePickerResult> {
    if (!this.isAvailable()) {
      throw new Error('Native features not available on this platform');
    }
    return NativeFeatures.showFilePicker();
  }

  /**
   * Check camera permission status
   */
  async checkCameraPermission(): Promise<PermissionStatus> {
    if (!this.isAvailable()) {
      throw new Error('Native features not available on this platform');
    }
    return NativeFeatures.checkCameraPermission();
  }

  /**
   * Check photos permission status
   */
  async checkPhotosPermission(): Promise<PermissionStatus> {
    if (!this.isAvailable()) {
      throw new Error('Native features not available on this platform');
    }
    return NativeFeatures.checkPhotosPermission();
  }

  /**
   * Request camera permission
   */
  async requestCameraPermission(): Promise<PermissionResult> {
    if (!this.isAvailable()) {
      throw new Error('Native features not available on this platform');
    }
    return NativeFeatures.requestCameraPermission();
  }

  /**
   * Request photos permission
   */
  async requestPhotosPermission(): Promise<PermissionResult> {
    if (!this.isAvailable()) {
      throw new Error('Native features not available on this platform');
    }
    return NativeFeatures.requestPhotosPermission();
  }

  /**
   * Trigger impact haptic feedback (iOS and Android)
   */
  async triggerImpactHaptic(
    style: 'light' | 'medium' | 'heavy' = 'medium',
  ): Promise<HapticResult> {
    if (!this.isAvailable()) {
      return { success: false };
    }
    try {
      return await NativeFeatures.triggerImpactHaptic(style);
    } catch (error) {
      console.log('Haptic feedback not available:', error);
      return { success: false };
    }
  }

  /**
   * Trigger notification haptic feedback (iOS and Android)
   */
  async triggerNotificationHaptic(
    type: 'success' | 'warning' | 'error' = 'success',
  ): Promise<HapticResult> {
    if (!this.isAvailable()) {
      return { success: false };
    }
    try {
      return await NativeFeatures.triggerNotificationHaptic(type);
    } catch (error) {
      console.log('Haptic feedback not available:', error);
      return { success: false };
    }
  }

  /**
   * Request in-app review
   */
  async requestInAppReview(): Promise<InAppReviewResult> {
    if (!this.isAvailable()) {
      throw new Error('Native features not available on this platform');
    }
    return NativeFeatures.requestInAppReview();
  }

  /**
   * Show mail composer
   */
  async showMailComposer(
    subject: string = 'Chili Market Support',
    body: string = '',
    toRecipients: string[] = ['support@chili-market.com'],
  ): Promise<MailComposeResult> {
    if (!this.isAvailable()) {
      throw new Error('Native features not available on this platform');
    }
    return NativeFeatures.showMailComposer(subject, body, toRecipients);
  }

  /**
   * Open app settings
   */
  async openAppSettings(): Promise<OpenSettingsResult> {
    if (!this.isAvailable()) {
      throw new Error('Native features not available on this platform');
    }
    return NativeFeatures.openAppSettings();
  }

  /**
   * Open in-app browser
   */
  async openInAppBrowser(url: string): Promise<InAppBrowserResult> {
    if (!this.isAvailable()) {
      throw new Error('Native features not available on this platform');
    }
    return NativeFeatures.openInAppBrowser(url);
  }

  /**
   * Check biometric support
   */
  async checkBiometricSupport(): Promise<BiometricSupportResult> {
    if (!this.isAvailable()) {
      return {
        isSupported: false,
        biometricType: 'none',
        error: 'Not available',
      };
    }
    return NativeFeatures.checkBiometricSupport();
  }

  /**
   * Authenticate with biometrics
   */
  async authenticateWithBiometric(
    reason: string = 'Authenticeer om door te gaan',
  ): Promise<BiometricAuthResult> {
    if (!this.isAvailable()) {
      return { success: false, error: 'Not available' };
    }
    return NativeFeatures.authenticateWithBiometric(reason);
  }

  /**
   * Get system information
   */
  async getSystemInfo(): Promise<SystemInfo> {
    if (!this.isAvailable()) {
      throw new Error('Native features not available on this platform');
    }
    return NativeFeatures.getSystemInfo();
  }

  /**
   * Enable/disable biometric lock with persistent storage
   */
  async setBiometricLockEnabled(enabled: boolean): Promise<boolean> {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      if (enabled) {
        // First authenticate to enable
        const authResult = await this.authenticateWithBiometric(
          'Activeer biometrische vergrendeling voor Chili Market',
        );

        if (!authResult.success) {
          return false;
        }

        // Store the setting securely
        return await NativeFeatures.storeBiometricItem(
          'chili_market_biometric_lock_enabled',
          'true',
        );
      } else {
        // Remove when disabling
        await NativeFeatures.removeBiometricItem(
          'chili_market_biometric_lock_enabled',
        );
        return true;
      }
    } catch (error) {
      console.error('Failed to set biometric lock preference:', error);
      return false;
    }
  }

  /**
   * Check if biometric lock is enabled
   */
  async isBiometricLockEnabled(): Promise<boolean> {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      const value = await NativeFeatures.getBiometricItem(
        'chili_market_biometric_lock_enabled',
      );
      return value === 'true';
    } catch (error) {
      // If we can't read it (e.g., biometry changed), assume disabled
      console.log('Failed to read biometric lock preference:', error);
      return false;
    }
  }

  /**
   * Authenticate for app unlock (with fallback handling)
   */
  async authenticateForUnlock(): Promise<BiometricAuthResult> {
    if (!this.isAvailable()) {
      return { success: false, error: 'Not available' };
    }

    try {
      return await this.authenticateWithBiometric(
        'Ontgrendel Chili Market met Face ID',
      );
    } catch (error) {
      console.error('Authentication for unlock failed:', error);
      return {
        success: false,
        error: error?.toString() || 'Authentication failed',
      };
    }
  }

  /**
   * Store background timestamp for timeout detection
   */
  async setBackgroundTime(timestamp?: number): Promise<boolean> {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      const time = timestamp || Date.now();
      return await NativeFeatures.storeItem(
        'chili_market_background_time',
        time.toString(),
      );
    } catch (error) {
      console.error('Failed to store background time:', error);
      return false;
    }
  }

  /**
   * Get background timestamp
   */
  async getBackgroundTime(): Promise<number | null> {
    if (!this.isAvailable()) {
      return null;
    }

    try {
      const value = await NativeFeatures.getItem(
        'chili_market_background_time',
      );
      return value ? parseInt(value, 10) : null;
    } catch (error) {
      console.error('Failed to get background time:', error);
      return null;
    }
  }

  /**
   * Check if background timeout has exceeded (5 minutes)
   */
  async shouldRequireAuth(): Promise<boolean> {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      const [isEnabled, backgroundTime] = await Promise.all([
        this.isBiometricLockEnabled(),
        this.getBackgroundTime(),
      ]);

      if (!isEnabled) {
        return false;
      }

      // If no background time recorded, no auth required
      if (!backgroundTime) {
        return false;
      }

      const now = Date.now();
      const timeoutMs = 5 * 60 * 1000; // 5 minutes
      const timeDiff = now - backgroundTime;

      const shouldRequire = timeDiff >= timeoutMs;
      return shouldRequire;
    } catch (error) {
      console.error('Failed to check auth requirement:', error);
      return false;
    }
  }

  /**
   * Clear background timestamp
   */
  async clearBackgroundTime(): Promise<boolean> {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      return await NativeFeatures.removeItem('chili_market_background_time');
    } catch (error) {
      console.error('Failed to clear background time:', error);
      return false;
    }
  }

  /**
   * Clear all app-related keychain data
   */
  async clearAppData(): Promise<boolean> {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      // Clear individual items since we don't have a full clear method for our specific keys
      await Promise.all([
        NativeFeatures.removeBiometricItem(
          'chili_market_biometric_lock_enabled',
        ),
        NativeFeatures.removeItem('chili_market_background_time'),
      ]);
      return true;
    } catch (error) {
      console.error('Failed to clear app keychain data:', error);
      return false;
    }
  }
}

export default new NativeFeaturesService();
