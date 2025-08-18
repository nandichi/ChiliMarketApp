/**
 * Test Screen voor Haptic Feedback en Context Menu functionaliteit
 * Alleen voor development en testing doeleinden
 */

import React from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  ScrollView,
  Alert,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import HapticFeedbackService from '../services/HapticFeedbackService';
import ContextMenu from './ContextMenu';

export default function HapticTestScreen() {
  const testHapticFeedback = async (type: string) => {
    try {
      switch (type) {
        case 'light':
          await HapticFeedbackService.light();
          break;
        case 'medium':
          await HapticFeedbackService.medium();
          break;
        case 'heavy':
          await HapticFeedbackService.heavy();
          break;
        case 'success':
          await HapticFeedbackService.success();
          break;
        case 'error':
          await HapticFeedbackService.error();
          break;
        case 'warning':
          await HapticFeedbackService.warning();
          break;
        case 'selection':
          await HapticFeedbackService.selection();
          break;
        case 'biometric_success':
          await HapticFeedbackService.biometricAuth(true);
          break;
        case 'biometric_error':
          await HapticFeedbackService.biometricAuth(false);
          break;
        case 'cart_add':
          await HapticFeedbackService.cartAction('add');
          break;
        case 'cart_remove':
          await HapticFeedbackService.cartAction('remove');
          break;
        case 'cart_checkout':
          await HapticFeedbackService.cartAction('checkout');
          break;
        case 'sequence':
          await HapticFeedbackService.sequence(
            ['impactLight', 'impactMedium', 'notificationSuccess'],
            150,
          );
          break;
        default:
          await HapticFeedbackService.selection();
      }
      const isAvailable = HapticFeedbackService.isAvailable();
      Alert.alert(
        'Haptic Test',
        `${type} haptic feedback ${
          isAvailable ? 'geactiveerd' : 'niet beschikbaar (using fallback)'
        }!`,
      );
    } catch (error) {
      Alert.alert('Fout', `Haptic feedback mislukt: ${error}`);
    }
  };

  const contextMenuOptions = [
    {
      title: 'Kopieer Tekst',
      systemIcon: 'doc.on.doc',
      onPress: async () => {
        await HapticFeedbackService.triggerForAction('selection');
        Alert.alert('Gekopieerd', 'Tekst is gekopieerd naar klembord');
      },
    },
    {
      title: 'Deel',
      systemIcon: 'square.and.arrow.up',
      onPress: async () => {
        await HapticFeedbackService.triggerForAction('button_press');
        Alert.alert('Delen', 'Deel functionaliteit geactiveerd');
      },
    },
    {
      title: 'Verwijder',
      systemIcon: 'trash',
      destructive: true,
      onPress: async () => {
        await HapticFeedbackService.triggerForAction('error');
        Alert.alert('Verwijderd', 'Item is verwijderd');
      },
    },
  ];

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.contentContainer}
    >
      <Text style={styles.title}>Haptic Feedback & Context Menu Test</Text>

      {/* Haptic Feedback Tests */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Haptic Feedback Types</Text>

        <View style={styles.buttonRow}>
          <TouchableOpacity
            style={[styles.testButton, styles.lightButton]}
            onPress={() => testHapticFeedback('light')}
          >
            <Icon name="touch-app" size={20} color={Colors.white} />
            <Text style={styles.buttonText}>Light</Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.testButton, styles.mediumButton]}
            onPress={() => testHapticFeedback('medium')}
          >
            <Icon name="vibration" size={20} color={Colors.white} />
            <Text style={styles.buttonText}>Medium</Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.testButton, styles.heavyButton]}
            onPress={() => testHapticFeedback('heavy')}
          >
            <Icon name="settings-vibrate" size={20} color={Colors.white} />
            <Text style={styles.buttonText}>Heavy</Text>
          </TouchableOpacity>
        </View>

        <View style={styles.buttonRow}>
          <TouchableOpacity
            style={[styles.testButton, styles.successButton]}
            onPress={() => testHapticFeedback('success')}
          >
            <Icon name="check-circle" size={20} color={Colors.white} />
            <Text style={styles.buttonText}>Success</Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.testButton, styles.errorButton]}
            onPress={() => testHapticFeedback('error')}
          >
            <Icon name="error" size={20} color={Colors.white} />
            <Text style={styles.buttonText}>Error</Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.testButton, styles.warningButton]}
            onPress={() => testHapticFeedback('warning')}
          >
            <Icon name="warning" size={20} color={Colors.white} />
            <Text style={styles.buttonText}>Warning</Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Special Haptics */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Speciale Haptic Feedback</Text>

        <TouchableOpacity
          style={[styles.testButton, styles.biometricButton]}
          onPress={() => testHapticFeedback('biometric_success')}
        >
          <Icon name="fingerprint" size={20} color={Colors.white} />
          <Text style={styles.buttonText}>Biometric Success</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={[styles.testButton, styles.biometricErrorButton]}
          onPress={() => testHapticFeedback('biometric_error')}
        >
          <Icon name="fingerprint" size={20} color={Colors.white} />
          <Text style={styles.buttonText}>Biometric Error</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={[styles.testButton, styles.sequenceButton]}
          onPress={() => testHapticFeedback('sequence')}
        >
          <Icon name="timeline" size={20} color={Colors.white} />
          <Text style={styles.buttonText}>Haptic Sequence</Text>
        </TouchableOpacity>
      </View>

      {/* Cart Actions */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Cart Haptic Actions</Text>

        <View style={styles.buttonRow}>
          <TouchableOpacity
            style={[styles.testButton, styles.cartAddButton]}
            onPress={() => testHapticFeedback('cart_add')}
          >
            <Icon name="add-shopping-cart" size={20} color={Colors.white} />
            <Text style={styles.buttonText}>Add to Cart</Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.testButton, styles.cartRemoveButton]}
            onPress={() => testHapticFeedback('cart_remove')}
          >
            <Icon name="remove-shopping-cart" size={20} color={Colors.white} />
            <Text style={styles.buttonText}>Remove from Cart</Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.testButton, styles.checkoutButton]}
            onPress={() => testHapticFeedback('cart_checkout')}
          >
            <Icon name="payment" size={20} color={Colors.white} />
            <Text style={styles.buttonText}>Checkout</Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Context Menu Test */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Context Menu Test</Text>

        <ContextMenu
          options={contextMenuOptions}
          title="Test Opties"
          subtitle="Houd ingedrukt voor opties"
          style={styles.contextMenuContainer}
        >
          <View style={styles.contextMenuDemo}>
            <Icon name="menu" size={30} color={Colors.primary} />
            <Text style={styles.contextMenuText}>
              Houd deze area ingedrukt voor een context menu
            </Text>
            <Text style={styles.contextMenuSubtext}>
              Test de native iOS context menu functionaliteit
            </Text>
          </View>
        </ContextMenu>
      </View>

      <View style={styles.footer}>
        <Text style={styles.footerText}>
          Deze test screen toont alle haptic feedback en context menu
          functionaliteit
        </Text>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  contentContainer: {
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: '700',
    color: Colors.text,
    textAlign: 'center',
    marginBottom: 30,
  },
  section: {
    marginBottom: 30,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: Colors.text,
    marginBottom: 15,
  },
  buttonRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 10,
  },
  testButton: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 12,
    borderRadius: 8,
    marginHorizontal: 4,
    marginBottom: 10,
  },
  buttonText: {
    color: Colors.white,
    fontSize: 12,
    fontWeight: '600',
    marginLeft: 4,
  },
  lightButton: {
    backgroundColor: '#4CAF50',
  },
  mediumButton: {
    backgroundColor: '#FF9800',
  },
  heavyButton: {
    backgroundColor: '#F44336',
  },
  successButton: {
    backgroundColor: '#2196F3',
  },
  errorButton: {
    backgroundColor: '#E91E63',
  },
  warningButton: {
    backgroundColor: '#FF5722',
  },
  biometricButton: {
    backgroundColor: '#9C27B0',
  },
  biometricErrorButton: {
    backgroundColor: '#795548',
  },
  sequenceButton: {
    backgroundColor: '#607D8B',
  },
  cartAddButton: {
    backgroundColor: '#4CAF50',
  },
  cartRemoveButton: {
    backgroundColor: '#FF5722',
  },
  checkoutButton: {
    backgroundColor: Colors.primary,
  },
  contextMenuContainer: {
    marginTop: 10,
  },
  contextMenuDemo: {
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 20,
    alignItems: 'center',
    borderWidth: 2,
    borderColor: Colors.primary,
    borderStyle: 'dashed',
  },
  contextMenuText: {
    fontSize: 16,
    fontWeight: '600',
    color: Colors.text,
    textAlign: 'center',
    marginTop: 10,
  },
  contextMenuSubtext: {
    fontSize: 14,
    color: Colors.textSecondary,
    textAlign: 'center',
    marginTop: 5,
  },
  footer: {
    marginTop: 20,
    padding: 15,
    backgroundColor: Colors.surface,
    borderRadius: 8,
  },
  footerText: {
    fontSize: 12,
    color: Colors.textSecondary,
    textAlign: 'center',
    fontStyle: 'italic',
  },
});
