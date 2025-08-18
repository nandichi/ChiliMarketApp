const lightColors = {
  // Primary colors - gespecificeerde systeemkleuren
  primary: '#BC1B20',
  primaryDark: '#9A1418',
  primaryLight: '#F8E8E9',

  // Secondary colors
  secondary: '#657177',
  secondaryDark: '#4A5568',
  secondaryLight: '#A0AEC0',

  // Neutral colors
  white: '#FFFFFF',
  black: '#000000',
  gray100: '#F7F7F7',
  gray200: '#E9E9E9',
  gray300: '#CBD5E0',
  gray400: '#A0AEC0',
  gray500: '#718096',
  gray600: '#657177',
  gray700: '#2D3748',
  gray800: '#1A202C',
  gray900: '#171923',

  // Accent colors
  accent: '#FAC500',
  accentDark: '#E6B200',
  accentLight: '#FFD700',

  // Status colors
  success: '#38A169',
  warning: '#D69E2E',
  error: '#BC1B20',
  info: '#3182CE',

  // Background colors
  background: '#FFFFFF',
  backgroundYellow: '#FFFDF2',
  backgroundRed: '#F8E8E9',
  surface: '#F8F9FA',
  card: '#FFFFFF',

  // Text colors
  text: '#222222',
  textSecondary: '#657177',
  textLight: '#A0AEC0',
  textOnPrimary: '#FFFFFF',

  // Border colors
  border: '#E9E9E9',
  borderLight: '#F1F5F9',

  // Button colors
  buttonLight: '#EEF9F5',

  // Shadow colors
  shadow: 'rgba(0, 0, 0, 0.1)',
  shadowDark: 'rgba(0, 0, 0, 0.2)',
};

const darkColors = {
  // Primary colors - aangepast voor dark mode
  primary: '#DC2626',
  primaryDark: '#B91C1C',
  primaryLight: '#7F1D1D',

  // Secondary colors
  secondary: '#9CA3AF',
  secondaryDark: '#6B7280',
  secondaryLight: '#D1D5DB',

  // Neutral colors
  white: '#000000',
  black: '#FFFFFF',
  gray100: '#1F2937',
  gray200: '#374151',
  gray300: '#4B5563',
  gray400: '#6B7280',
  gray500: '#9CA3AF',
  gray600: '#D1D5DB',
  gray700: '#E5E7EB',
  gray800: '#F3F4F6',
  gray900: '#F9FAFB',

  // Accent colors
  accent: '#FBBF24',
  accentDark: '#F59E0B',
  accentLight: '#FCD34D',

  // Status colors
  success: '#10B981',
  warning: '#F59E0B',
  error: '#DC2626',
  info: '#3B82F6',

  // Background colors
  background: '#111827',
  backgroundYellow: '#1F2937',
  backgroundRed: '#1F1213',
  surface: '#1F2937',
  card: '#374151',

  // Text colors
  text: '#F9FAFB',
  textSecondary: '#D1D5DB',
  textLight: '#9CA3AF',
  textOnPrimary: '#FFFFFF',

  // Border colors
  border: '#4B5563',
  borderLight: '#374151',

  // Button colors
  buttonLight: '#064E3B',

  // Shadow colors
  shadow: 'rgba(0, 0, 0, 0.3)',
  shadowDark: 'rgba(0, 0, 0, 0.5)',
};

export const getColors = (isDark: boolean) => {
  return isDark ? darkColors : lightColors;
};

// Backward compatibility - gebruik light colors als default
export const Colors = lightColors;

const lightGradients = {
  primary: ['#BC1B20', '#F8E8E9'],
  secondary: ['#657177', '#FAC500'],
  warm: ['#FAC500', '#FFD700'],
  cool: ['#3182CE', '#63B3ED'],
};

const darkGradients = {
  primary: ['#DC2626', '#7F1D1D'],
  secondary: ['#9CA3AF', '#FBBF24'],
  warm: ['#FBBF24', '#FCD34D'],
  cool: ['#3B82F6', '#93C5FD'],
};

export const getGradients = (isDark: boolean) => {
  return isDark ? darkGradients : lightGradients;
};

// Backward compatibility
export const gradients = lightGradients;
