/**
 * Service for secure keychain storage with biometric access control
 */

import { NativeModules, Platform } from 'react-native';

interface KeychainModule {
  storeBiometricItem(key: string, value: string): Promise<boolean>;
  getBiometricItem(key: string): Promise<string | null>;
  removeBiometricItem(key: string): Promise<boolean>;
  storeItem(key: string, value: string): Promise<boolean>;
  getItem(key: string): Promise<string | null>;
  removeItem(key: string): Promise<boolean>;
  clearAll(): Promise<boolean>;
}

const { KeychainModule: NativeKeychain } = NativeModules as {
  KeychainModule: KeychainModule;
};

export interface BiometricStorageOptions {
  accessibility?: 'whenUnlockedThisDeviceOnly' | 'whenUnlocked';
  accessControl?: 'biometryCurrentSet' | 'biometryAny';
  invalidateOnBiometryChange?: boolean;
}

class KeychainService {
  private static readonly BIOMETRIC_LOCK_KEY =
    'chili_market_biometric_lock_enabled';
  private static readonly LAST_BIOMETRY_HASH_KEY =
    'chili_market_last_biometry_hash';
  private static readonly BACKGROUND_TIME_KEY = 'chili_market_background_time';
  private static readonly BACKGROUND_TIMEOUT_MINUTES = 5;

  /**
   * Check if keychain features are available (iOS only)
   */
  isAvailable(): boolean {
    return Platform.OS === 'ios' && !!NativeKeychain;
  }

  /**
   * Store biometric lock preference securely
   */
  async setBiometricLockEnabled(enabled: boolean): Promise<boolean> {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      const value = enabled ? 'true' : 'false';

      if (enabled) {
        // Store with biometric protection when enabling
        return await NativeKeychain.storeBiometricItem(
          KeychainService.BIOMETRIC_LOCK_KEY,
          value,
        );
      } else {
        // Remove when disabling
        await NativeKeychain.removeBiometricItem(
          KeychainService.BIOMETRIC_LOCK_KEY,
        );
        return true;
      }
    } catch (error) {
      console.error('Failed to set biometric lock preference:', error);
      return false;
    }
  }

  /**
   * Get biometric lock preference
   */
  async isBiometricLockEnabled(): Promise<boolean> {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      const value = await NativeKeychain.getBiometricItem(
        KeychainService.BIOMETRIC_LOCK_KEY,
      );
      return value === 'true';
    } catch (error) {
      // If we can't read it (e.g., biometry changed), assume disabled
      console.log('Failed to read biometric lock preference:', error);
      return false;
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
      return await NativeKeychain.storeItem(
        KeychainService.BACKGROUND_TIME_KEY,
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
      const value = await NativeKeychain.getItem(
        KeychainService.BACKGROUND_TIME_KEY,
      );
      return value ? parseInt(value, 10) : null;
    } catch (error) {
      console.error('Failed to get background time:', error);
      return null;
    }
  }

  /**
   * Check if background timeout has exceeded
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

      if (!isEnabled || !backgroundTime) {
        return false;
      }

      const now = Date.now();
      const timeoutMs = KeychainService.BACKGROUND_TIMEOUT_MINUTES * 60 * 1000;
      const timeDiff = now - backgroundTime;

      return timeDiff >= timeoutMs;
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
      return await NativeKeychain.removeItem(
        KeychainService.BACKGROUND_TIME_KEY,
      );
    } catch (error) {
      console.error('Failed to clear background time:', error);
      return false;
    }
  }

  /**
   * Store a biometry hash to detect changes
   */
  async storeBiometryHash(hash: string): Promise<boolean> {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      return await NativeKeychain.storeItem(
        KeychainService.LAST_BIOMETRY_HASH_KEY,
        hash,
      );
    } catch (error) {
      console.error('Failed to store biometry hash:', error);
      return false;
    }
  }

  /**
   * Get stored biometry hash
   */
  async getBiometryHash(): Promise<string | null> {
    if (!this.isAvailable()) {
      return null;
    }

    try {
      return await NativeKeychain.getItem(
        KeychainService.LAST_BIOMETRY_HASH_KEY,
      );
    } catch (error) {
      console.error('Failed to get biometry hash:', error);
      return null;
    }
  }

  /**
   * Check if biometry has changed since last storage
   */
  async hasBiometryChanged(currentHash: string): Promise<boolean> {
    const storedHash = await this.getBiometryHash();
    return storedHash !== null && storedHash !== currentHash;
  }

  /**
   * Clear all app-related keychain data
   */
  async clearAppData(): Promise<boolean> {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      await Promise.all([
        NativeKeychain.removeBiometricItem(KeychainService.BIOMETRIC_LOCK_KEY),
        NativeKeychain.removeItem(KeychainService.LAST_BIOMETRY_HASH_KEY),
        NativeKeychain.removeItem(KeychainService.BACKGROUND_TIME_KEY),
      ]);
      return true;
    } catch (error) {
      console.error('Failed to clear app keychain data:', error);
      return false;
    }
  }

  /**
   * Store generic item in keychain
   */
  async store(key: string, value: string): Promise<boolean> {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      return await NativeKeychain.storeItem(key, value);
    } catch (error) {
      console.error(`Failed to store keychain item ${key}:`, error);
      return false;
    }
  }

  /**
   * Get generic item from keychain
   */
  async get(key: string): Promise<string | null> {
    if (!this.isAvailable()) {
      return null;
    }

    try {
      return await NativeKeychain.getItem(key);
    } catch (error) {
      console.error(`Failed to get keychain item ${key}:`, error);
      return null;
    }
  }

  /**
   * Remove generic item from keychain
   */
  async remove(key: string): Promise<boolean> {
    if (!this.isAvailable()) {
      return false;
    }

    try {
      return await NativeKeychain.removeItem(key);
    } catch (error) {
      console.error(`Failed to remove keychain item ${key}:`, error);
      return false;
    }
  }
}

export default new KeychainService();
