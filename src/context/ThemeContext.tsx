import React, {
  createContext,
  useContext,
  useReducer,
  useEffect,
  ReactNode,
  useMemo,
  useCallback,
} from 'react';
import { Appearance, ColorSchemeName } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

export type ThemeMode = 'light' | 'dark' | 'system';

interface ThemeState {
  mode: ThemeMode;
  isDark: boolean;
  systemColorScheme: ColorSchemeName;
  isLoading: boolean;
}

type ThemeAction =
  | { type: 'SET_THEME_MODE'; payload: ThemeMode }
  | { type: 'SET_SYSTEM_COLOR_SCHEME'; payload: ColorSchemeName }
  | { type: 'SET_LOADING'; payload: boolean }
  | { type: 'SET_IS_DARK'; payload: boolean };

interface ThemeContextType extends ThemeState {
  setThemeMode: (mode: ThemeMode) => Promise<void>;
  toggleTheme: () => Promise<void>;
}

const initialState: ThemeState = {
  mode: 'system',
  isDark: false,
  systemColorScheme: Appearance.getColorScheme(),
  isLoading: true,
};

const themeReducer = (state: ThemeState, action: ThemeAction): ThemeState => {
  switch (action.type) {
    case 'SET_THEME_MODE':
      return {
        ...state,
        mode: action.payload,
      };
    case 'SET_SYSTEM_COLOR_SCHEME':
      return {
        ...state,
        systemColorScheme: action.payload,
      };
    case 'SET_LOADING':
      return {
        ...state,
        isLoading: action.payload,
      };
    case 'SET_IS_DARK':
      return {
        ...state,
        isDark: action.payload,
      };
    default:
      return state;
  }
};

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

const THEME_STORAGE_KEY = '@chili_market_theme_mode';

interface ThemeProviderProps {
  children: ReactNode;
}

export const ThemeProvider: React.FC<ThemeProviderProps> = ({ children }) => {
  const [state, dispatch] = useReducer(themeReducer, initialState);

  // Calculate if we should be in dark mode based on current settings
  const calculateIsDark = useCallback(
    (mode: ThemeMode, systemScheme: ColorSchemeName): boolean => {
      switch (mode) {
        case 'light':
          return false;
        case 'dark':
          return true;
        case 'system':
          return systemScheme === 'dark';
        default:
          return false;
      }
    },
    [],
  );

  // Update isDark whenever mode or system scheme changes
  useEffect(() => {
    const newIsDark = calculateIsDark(state.mode, state.systemColorScheme);
    if (newIsDark !== state.isDark) {
      dispatch({ type: 'SET_IS_DARK', payload: newIsDark });
    }
  }, [state.mode, state.systemColorScheme, state.isDark, calculateIsDark]);

  // Load saved theme mode on app start
  useEffect(() => {
    const loadSavedTheme = async () => {
      try {
        dispatch({ type: 'SET_LOADING', payload: true });

        const savedTheme = await AsyncStorage.getItem(THEME_STORAGE_KEY);
        if (savedTheme && ['light', 'dark', 'system'].includes(savedTheme)) {
          dispatch({
            type: 'SET_THEME_MODE',
            payload: savedTheme as ThemeMode,
          });
        }
      } catch (error) {
        console.error('Error loading saved theme:', error);
      } finally {
        dispatch({ type: 'SET_LOADING', payload: false });
      }
    };

    loadSavedTheme();
  }, []);

  // Listen to system color scheme changes
  useEffect(() => {
    const subscription = Appearance.addChangeListener(({ colorScheme }) => {
      dispatch({ type: 'SET_SYSTEM_COLOR_SCHEME', payload: colorScheme });
    });

    return () => subscription?.remove();
  }, []);

  const setThemeMode = useCallback(async (mode: ThemeMode) => {
    try {
      await AsyncStorage.setItem(THEME_STORAGE_KEY, mode);
      dispatch({ type: 'SET_THEME_MODE', payload: mode });
    } catch (error) {
      console.error('Error saving theme mode:', error);
    }
  }, []);

  const toggleTheme = useCallback(async () => {
    const newMode = state.isDark ? 'light' : 'dark';
    await setThemeMode(newMode);
  }, [state.isDark, setThemeMode]);

  const value: ThemeContextType = useMemo(
    () => ({
      ...state,
      setThemeMode,
      toggleTheme,
    }),
    [state, setThemeMode, toggleTheme],
  );

  return (
    <ThemeContext.Provider value={value}>{children}</ThemeContext.Provider>
  );
};

export const useTheme = (): ThemeContextType => {
  const context = useContext(ThemeContext);
  if (context === undefined) {
    throw new Error('useTheme must be used within a ThemeProvider');
  }
  return context;
};
