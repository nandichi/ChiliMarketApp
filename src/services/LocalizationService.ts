/**
 * Localization service for internationalization support
 */

import { Platform, NativeModules } from 'react-native';
import nlTranslations from '../localization/nl.json';
import enTranslations from '../localization/en.json';

type Translations = typeof nlTranslations;

class LocalizationService {
  private translations: Translations = nlTranslations;
  private currentLanguage: string = 'nl';

  constructor() {
    this.initializeLanguage();
  }

  /**
   * Initialize language based on device settings
   */
  private initializeLanguage() {
    try {
      let deviceLanguage = 'nl';

      if (Platform.OS === 'ios') {
        deviceLanguage =
          NativeModules.SettingsManager?.settings?.AppleLocale ||
          NativeModules.SettingsManager?.settings?.AppleLanguages?.[0] ||
          'nl';
      } else if (Platform.OS === 'android') {
        deviceLanguage = NativeModules.I18nManager?.localeIdentifier || 'nl';
      }

      // Extract language code (e.g., 'en-US' -> 'en')
      const languageCode = deviceLanguage
        .split('-')[0]
        .split('_')[0]
        .toLowerCase();

      // Set language to Dutch (nl) or English (en), default to Dutch
      this.setLanguage(languageCode === 'en' ? 'en' : 'nl');
    } catch (error) {
      console.log('Failed to detect device language, using Dutch as default');
      this.setLanguage('nl');
    }
  }

  /**
   * Set the current language
   */
  setLanguage(language: 'nl' | 'en') {
    this.currentLanguage = language;
    this.translations = language === 'en' ? enTranslations : nlTranslations;
  }

  /**
   * Get the current language
   */
  getCurrentLanguage(): string {
    return this.currentLanguage;
  }

  /**
   * Get translated text by key path
   */
  t(keyPath: string, ...args: any[]): string {
    try {
      const keys = keyPath.split('.');
      let value: any = this.translations;

      for (const key of keys) {
        if (value && typeof value === 'object' && key in value) {
          value = value[key];
        } else {
          console.warn(`Translation key not found: ${keyPath}`);
          return keyPath;
        }
      }

      if (typeof value === 'string') {
        // Replace placeholders with arguments
        return this.formatString(value, ...args);
      }

      console.warn(`Translation key is not a string: ${keyPath}`);
      return keyPath;
    } catch (error) {
      console.warn(`Error getting translation for key: ${keyPath}`, error);
      return keyPath;
    }
  }

  /**
   * Format string with arguments (simple placeholder replacement)
   */
  private formatString(template: string, ...args: any[]): string {
    return template
      .replace(/%s/g, () => {
        const arg = args.shift();
        return arg !== undefined ? String(arg) : '';
      })
      .replace(/%d/g, () => {
        const arg = args.shift();
        return arg !== undefined ? String(Number(arg)) : '';
      });
  }

  /**
   * Check if translations are loaded
   */
  isReady(): boolean {
    return !!this.translations;
  }

  /**
   * Get all available languages
   */
  getAvailableLanguages(): Array<{ code: string; name: string }> {
    return [
      { code: 'nl', name: 'Nederlands' },
      { code: 'en', name: 'English' },
    ];
  }
}

export default new LocalizationService();
