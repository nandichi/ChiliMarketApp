/**
 * Enhanced Context Menu Component voor iOS native feel
 * Gebruikt react-native-context-menu-view voor native iOS context menu's
 */

import React from 'react';
import { Platform, View } from 'react-native';
// Conditional import with error handling
let ContextMenuView: any = null;
let ContextMenuAction: any = null;
try {
  const contextModule = require('react-native-context-menu-view');
  ContextMenuView = contextModule.ContextMenuView;
  ContextMenuAction = contextModule.ContextMenuAction;
} catch (error) {
  console.log('react-native-context-menu-view not available, using fallback');
}
import HapticFeedbackService from '../services/HapticFeedbackService';

export interface ContextMenuOption {
  title: string;
  systemIcon?: string;
  destructive?: boolean;
  disabled?: boolean;
  inLine?: boolean;
  subtitle?: string;
  onPress: () => void | Promise<void>;
}

export interface ContextMenuProps {
  children: React.ReactNode;
  options: ContextMenuOption[];
  title?: string;
  subtitle?: string;
  disabled?: boolean;
  previewEnabled?: boolean;
  dropShadow?: boolean;
  style?: any;
}

const ContextMenu: React.FC<ContextMenuProps> = ({
  children,
  options,
  title,
  subtitle,
  disabled = false,
  previewEnabled = true,
  dropShadow = true,
  style,
}) => {
  // Alleen beschikbaar op iOS en als de module geladen is
  if (Platform.OS !== 'ios' || !ContextMenuView) {
    return <View style={style}>{children}</View>;
  }

  const handleMenuWillShow = async () => {
    await HapticFeedbackService.contextMenu('open');
  };

  const handleMenuDidHide = async () => {
    await HapticFeedbackService.contextMenu('close');
  };

  const handlePress = async (action: any) => {
    await HapticFeedbackService.contextMenu('select');

    const option = options.find(opt => opt.title === action.title);
    if (option && option.onPress) {
      await option.onPress();
    }
  };

  const actions: any[] = options.map(option => ({
    title: option.title,
    systemIcon: option.systemIcon,
    destructive: option.destructive,
    disabled: option.disabled,
    inLine: option.inLine,
    subtitle: option.subtitle,
  }));

  return (
    <ContextMenuView
      style={style}
      actions={actions}
      title={title}
      subtitle={subtitle}
      disabled={disabled}
      previewEnabled={previewEnabled}
      dropShadow={dropShadow}
      onPress={handlePress}
      onMenuWillShow={handleMenuWillShow}
      onMenuDidHide={handleMenuDidHide}
    >
      {children}
    </ContextMenuView>
  );
};

export default ContextMenu;
