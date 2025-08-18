/**
 * Enhanced Haptic Feedback Service
 * Combines native implementation with react-native-haptic-feedback for optimal iOS experience
 */

import { Platform } from 'react-native';
// Conditional import with error handling
let ReactNativeHapticFeedback: any = null;
try {
  const module = require('react-native-haptic-feedback');
  ReactNativeHapticFeedback = module.default || module;
} catch (error) {
  console.log(
    'react-native-haptic-feedback not available, using native fallback only',
  );
}
import NativeFeaturesService from './NativeFeaturesService';

export type HapticFeedbackType =
  | 'selection'
  | 'impactLight'
  | 'impactMedium'
  | 'impactHeavy'
  | 'notificationSuccess'
  | 'notificationWarning'
  | 'notificationError'
  | 'rigid'
  | 'soft'
  | 'clockTick';

export type ActionContext =
  | 'button_press'
  | 'navigation'
  | 'success'
  | 'error'
  | 'warning'
  | 'selection'
  | 'toggle'
  | 'swipe'
  | 'long_press'
  | 'context_menu'
  | 'biometric_auth'
  | 'cart_action'
  | 'login'
  | 'logout'
  | 'search'
  | 'refresh';

class HapticFeedbackService {
  private isEnabled: boolean = true;

  /**
   * Haptic feedback configuratie opties
   */
  private hapticOptions = {
    enableVibrateFallback: true,
    ignoreAndroidSystemSettings: false,
  };

  /**
   * Check of haptic feedback beschikbaar is
   */
  isAvailable(): boolean {
    return (
      Platform.OS === 'ios' &&
      (ReactNativeHapticFeedback || NativeFeaturesService.isAvailable())
    );
  }

  /**
   * Enable/disable haptic feedback
   */
  setEnabled(enabled: boolean): void {
    this.isEnabled = enabled;
  }

  /**
   * Trigger haptic feedback based op actie context
   */
  async triggerForAction(context: ActionContext): Promise<void> {
    if (!this.isEnabled || !this.isAvailable()) {
      return;
    }

    try {
      switch (context) {
        case 'button_press':
        case 'selection':
          await this.trigger('selection');
          break;

        case 'navigation':
        case 'toggle':
          await this.trigger('impactLight');
          break;

        case 'success':
        case 'login':
          await this.trigger('notificationSuccess');
          break;

        case 'error':
          await this.trigger('notificationError');
          break;

        case 'warning':
          await this.trigger('notificationWarning');
          break;

        case 'swipe':
        case 'refresh':
          await this.trigger('impactMedium');
          break;

        case 'long_press':
        case 'context_menu':
          await this.trigger('impactHeavy');
          break;

        case 'biometric_auth':
          await this.trigger('rigid');
          break;

        case 'cart_action':
          await this.trigger('soft');
          break;

        case 'logout':
          await this.trigger('clockTick');
          break;

        case 'search':
          await this.trigger('selection');
          break;

        default:
          await this.trigger('selection');
      }
    } catch (error) {
      console.log('Haptic feedback failed:', error);
    }
  }

  /**
   * Trigger specifieke haptic feedback
   */
  async trigger(type: HapticFeedbackType): Promise<void> {
    if (!this.isEnabled || !this.isAvailable()) {
      return;
    }

    try {
      // Probeer eerst native implementatie voor impact en notification types
      if (type.startsWith('impact') || type.startsWith('notification')) {
        const success = await this.tryNativeHaptic(type);
        if (success) {
          return;
        }
      }

      // Fallback naar react-native-haptic-feedback (als beschikbaar)
      if (ReactNativeHapticFeedback) {
        ReactNativeHapticFeedback.trigger(type, this.hapticOptions);
      } else {
        // Final fallback naar native implementatie met basis types
        await this.fallbackToNativeHaptic(type);
      }
    } catch (error) {
      console.log('Haptic feedback failed:', error);
    }
  }

  /**
   * Fallback naar native haptic voor niet-beschikbare types
   */
  private async fallbackToNativeHaptic(
    type: HapticFeedbackType,
  ): Promise<void> {
    try {
      // Map externe types naar beschikbare native types
      switch (type) {
        case 'selection':
        case 'rigid':
        case 'soft':
        case 'clockTick':
          await this.tryNativeHaptic('impactLight');
          break;
        case 'impactLight':
        case 'impactMedium':
        case 'impactHeavy':
          await this.tryNativeHaptic(type);
          break;
        case 'notificationSuccess':
        case 'notificationWarning':
        case 'notificationError':
          await this.tryNativeHaptic(type);
          break;
        default:
          await this.tryNativeHaptic('impactLight');
      }
    } catch (error) {
      console.log('Native haptic fallback failed:', error);
    }
  }

  /**
   * Probeer native haptic implementatie
   */
  private async tryNativeHaptic(type: HapticFeedbackType): Promise<boolean> {
    try {
      if (type.startsWith('impact')) {
        const style = type.replace('impact', '').toLowerCase() as
          | 'light'
          | 'medium'
          | 'heavy';
        const result = await NativeFeaturesService.triggerImpactHaptic(style);
        return result.success;
      }

      if (type.startsWith('notification')) {
        const notificationType = type
          .replace('notification', '')
          .toLowerCase() as 'success' | 'warning' | 'error';
        const result = await NativeFeaturesService.triggerNotificationHaptic(
          notificationType,
        );
        return result.success;
      }

      return false;
    } catch (error) {
      console.log('Native haptic failed:', error);
      return false;
    }
  }

  /**
   * Lichte haptic voor subtiele feedback
   */
  async light(): Promise<void> {
    await this.trigger('impactLight');
  }

  /**
   * Medium haptic voor normale acties
   */
  async medium(): Promise<void> {
    await this.trigger('impactMedium');
  }

  /**
   * Zware haptic voor belangrijke acties
   */
  async heavy(): Promise<void> {
    await this.trigger('impactHeavy');
  }

  /**
   * Success feedback
   */
  async success(): Promise<void> {
    await this.trigger('notificationSuccess');
  }

  /**
   * Error feedback
   */
  async error(): Promise<void> {
    await this.trigger('notificationError');
  }

  /**
   * Warning feedback
   */
  async warning(): Promise<void> {
    await this.trigger('notificationWarning');
  }

  /**
   * Selection feedback voor UI selecties
   */
  async selection(): Promise<void> {
    await this.trigger('selection');
  }

  /**
   * Rigid feedback voor sterke interacties
   */
  async rigid(): Promise<void> {
    await this.trigger('rigid');
  }

  /**
   * Soft feedback voor zachte interacties
   */
  async soft(): Promise<void> {
    await this.trigger('soft');
  }

  /**
   * Sequence van haptic feedback voor complexe acties
   */
  async sequence(
    types: HapticFeedbackType[],
    delayMs: number = 100,
  ): Promise<void> {
    for (let i = 0; i < types.length; i++) {
      await this.trigger(types[i]);
      if (i < types.length - 1) {
        await new Promise(resolve => setTimeout(resolve, delayMs));
      }
    }
  }

  /**
   * Haptic feedback voor biometric authenticatie
   */
  async biometricAuth(success: boolean): Promise<void> {
    if (success) {
      await this.sequence(['impactLight', 'notificationSuccess'], 150);
    } else {
      await this.sequence(['impactMedium', 'notificationError'], 100);
    }
  }

  /**
   * Haptic feedback voor cart acties
   */
  async cartAction(type: 'add' | 'remove' | 'checkout'): Promise<void> {
    switch (type) {
      case 'add':
        await this.sequence(['selection', 'soft'], 80);
        break;
      case 'remove':
        await this.sequence(['impactLight', 'impactLight'], 120);
        break;
      case 'checkout':
        await this.sequence(['impactMedium', 'notificationSuccess'], 200);
        break;
    }
  }

  /**
   * Haptic feedback voor context menu acties
   */
  async contextMenu(action: 'open' | 'select' | 'close'): Promise<void> {
    switch (action) {
      case 'open':
        await this.trigger('impactHeavy');
        break;
      case 'select':
        await this.trigger('selection');
        break;
      case 'close':
        await this.trigger('impactLight');
        break;
    }
  }
}

export default new HapticFeedbackService();
