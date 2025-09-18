/**
 * TypeScript definitions for native iOS features
 */

export interface ShareSheetResult {
  completed: boolean;
}

export interface FilePickerResult {
  fileName?: string;
  fileSize?: number;
  filePath?: string;
  cancelled?: boolean;
}

export interface PhotoPickerFile {
  uri: string;
  name: string;
  type: string;
  size: number;
  mimeType: string;
}

export interface PhotoPickerResult {
  files: PhotoPickerFile[];
  cancelled: boolean;
}

export interface PhotoPickerAvailability {
  isAvailable: boolean;
  requiresPermission: boolean;
  status: 'available' | 'legacy';
}

export interface PermissionStatus {
  status:
    | 'authorized'
    | 'denied'
    | 'restricted'
    | 'notDetermined'
    | 'limited'
    | 'unknown';
}

export interface PermissionResult {
  granted: boolean;
  status?: number;
}

export interface HapticResult {
  success: boolean;
}

export interface InAppReviewResult {
  requested: boolean;
}

export interface MailComposeResult {
  result: 'sent' | 'saved' | 'cancelled' | 'failed' | 'unknown';
}

export interface OpenSettingsResult {
  opened: boolean;
}

export interface InAppBrowserResult {
  dismissed: boolean;
}

export interface BiometricSupportResult {
  isSupported: boolean;
  biometricType: 'faceID' | 'touchID' | 'none' | 'unknown';
  error: string;
}

export interface BiometricAuthResult {
  success: boolean;
  error?: string;
  errorCode?: number;
}

export interface SystemInfo {
  appName: string;
  appVersion: string;
  buildNumber: string;
  bundleIdentifier: string;
  deviceModel: string;
  deviceName: string;
  systemName: string;
  systemVersion: string;
  identifierForVendor: string;
}

export interface NativeFeaturesModule {
  // Share Sheet
  showShareSheet(text: string, url: string): Promise<ShareSheetResult>;

  // File Picker
  showFilePicker(): Promise<FilePickerResult>;

  // Camera Permission
  checkCameraPermission(): Promise<PermissionStatus>;
  requestCameraPermission(): Promise<PermissionResult>;

  // Photo Picker (replaces photo permissions)
  checkPhotoPickerAvailability(): Promise<PhotoPickerAvailability>;
  openPhotoPicker(
    maxSelection: number,
    mediaType: 'images' | 'videos' | 'both' | 'all',
  ): Promise<PhotoPickerResult>;

  // Haptics
  triggerImpactHaptic(
    style: 'light' | 'medium' | 'heavy',
  ): Promise<HapticResult>;
  triggerNotificationHaptic(
    type: 'success' | 'warning' | 'error',
  ): Promise<HapticResult>;

  // In App Review
  requestInAppReview(): Promise<InAppReviewResult>;

  // Mail Composer
  showMailComposer(
    subject: string,
    body: string,
    toRecipients: string[],
  ): Promise<MailComposeResult>;

  // Settings
  openAppSettings(): Promise<OpenSettingsResult>;

  // In App Browser
  openInAppBrowser(url: string): Promise<InAppBrowserResult>;

  // Biometric Authentication
  checkBiometricSupport(): Promise<BiometricSupportResult>;
  authenticateWithBiometric(reason: string): Promise<BiometricAuthResult>;

  // System Info
  getSystemInfo(): Promise<SystemInfo>;

  // Keychain Storage
  storeBiometricItem(key: string, value: string): Promise<boolean>;
  getBiometricItem(key: string): Promise<string | null>;
  removeBiometricItem(key: string): Promise<boolean>;
  storeItem(key: string, value: string): Promise<boolean>;
  getItem(key: string): Promise<string | null>;
  removeItem(key: string): Promise<boolean>;
  clearAll(): Promise<boolean>;
}

export interface KeychainModule {
  // Biometric Items
  storeBiometricItem(key: string, value: string): Promise<boolean>;
  getBiometricItem(key: string): Promise<string | null>;
  removeBiometricItem(key: string): Promise<boolean>;

  // Regular Items
  storeItem(key: string, value: string): Promise<boolean>;
  getItem(key: string): Promise<string | null>;
  removeItem(key: string): Promise<boolean>;
  clearAll(): Promise<boolean>;
}
