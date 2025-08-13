import React, {
  createContext,
  useContext,
  useReducer,
  useEffect,
  ReactNode,
  useMemo,
  useCallback,
} from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';
import WordPressAPI, { WordPressUser } from '../services/WordPressAPI';
import NativeFeaturesService from '../services/NativeFeaturesService';
import LocalizationService from '../services/LocalizationService';
// DISABLED: BuddyBoss API tijdelijk uitgeschakeld
// import BuddyBossAPI from '../services/BuddyBossAPI';

interface AuthState {
  user: WordPressUser | null;
  isLoading: boolean;
  isAuthenticated: boolean;
  isGuest: boolean;
  error: string | null;
  rateLimited: boolean;
  lastLoginAttempt: number;
  loadingMessage: string;
  justLoggedOut: boolean;
  // Face ID related states
  isLocked: boolean;
  biometricSupported: boolean;
  biometricEnabled: boolean;
  authenticationRequired: boolean;
  backgroundTime: number | null;
  hasPerformedInitialBiometricCheck: boolean;
  biometricFailureCount: number;
  lastFailedAttempt: number | null;
}

type AuthAction =
  | { type: 'LOGIN_START'; payload?: string }
  | { type: 'LOGIN_SUCCESS'; payload: WordPressUser }
  | { type: 'LOGIN_FAILURE'; payload: string }
  | { type: 'LOGOUT' }
  | { type: 'CLEAR_ERROR' }
  | { type: 'SET_LOADING'; payload: { isLoading: boolean; message?: string } }
  | { type: 'SET_RATE_LIMITED'; payload: boolean }
  | { type: 'CONTINUE_AS_GUEST' }
  | { type: 'CLEAR_LOGOUT_FLAG' }
  | { type: 'SET_BIOMETRIC_SUPPORT'; payload: boolean }
  | { type: 'SET_BIOMETRIC_ENABLED'; payload: boolean }
  | { type: 'SET_LOCKED'; payload: boolean }
  | { type: 'SET_AUTH_REQUIRED'; payload: boolean }
  | { type: 'SET_BACKGROUND_TIME'; payload: number | null }
  | { type: 'UNLOCK_SUCCESS' }
  | { type: 'UNLOCK_FAILURE'; payload: string }
  | { type: 'SET_INITIAL_BIOMETRIC_CHECK_DONE' }
  | { type: 'INCREMENT_BIOMETRIC_FAILURE' }
  | { type: 'RESET_BIOMETRIC_FAILURE' };

interface AuthContextType extends AuthState {
  login: (username: string, password: string) => Promise<void>;
  logout: () => Promise<void>;
  continueAsGuest: () => Promise<void>;
  goToLogin: () => Promise<void>;
  clearError: () => void;
  clearLogoutFlag: () => void;
  api: WordPressAPI;
  // Face ID methods
  setBiometricEnabled: (enabled: boolean) => Promise<boolean>;
  authenticateWithBiometric: () => Promise<boolean>;
  setBackgroundTime: () => Promise<void>;
  checkAuthRequired: () => Promise<boolean>;
  unlock: () => Promise<boolean>;
  initializeBiometric: () => Promise<void>;
  // DISABLED: BuddyBoss API tijdelijk uitgeschakeld
  // buddyBossAPI: BuddyBossAPI;
}

const initialState: AuthState = {
  user: null,
  isLoading: false,
  isAuthenticated: false,
  isGuest: false,
  error: null,
  rateLimited: false,
  lastLoginAttempt: 0,
  loadingMessage: '',
  justLoggedOut: false,
  // Face ID initial states
  isLocked: false,
  biometricSupported: false,
  biometricEnabled: false,
  authenticationRequired: false,
  backgroundTime: null,
  hasPerformedInitialBiometricCheck: false,
  biometricFailureCount: 0,
  lastFailedAttempt: null,
};

const authReducer = (state: AuthState, action: AuthAction): AuthState => {
  switch (action.type) {
    case 'LOGIN_START':
      return {
        ...state,
        isLoading: true,
        loadingMessage: action.payload || 'Inloggen...',
        error: null,
        lastLoginAttempt: Date.now(),
      };
    case 'LOGIN_SUCCESS':
      return {
        ...state,
        isLoading: false,
        loadingMessage: '',
        isAuthenticated: true,
        user: action.payload,
        error: null,
        rateLimited: false,
        justLoggedOut: false,
        isLocked: false,
        authenticationRequired: false,
      };
    case 'LOGIN_FAILURE':
      return {
        ...state,
        isLoading: false,
        loadingMessage: '',
        isAuthenticated: false,
        user: null,
        error: action.payload,
      };
    case 'LOGOUT':
      return {
        ...state,
        isLoading: false,
        loadingMessage: '',
        isAuthenticated: false,
        isGuest: false,
        user: null,
        error: null,
        rateLimited: false,
        justLoggedOut: true,
      };
    case 'CLEAR_ERROR':
      return {
        ...state,
        error: null,
      };
    case 'SET_LOADING':
      return {
        ...state,
        isLoading: action.payload.isLoading,
        loadingMessage: action.payload.message || '',
      };
    case 'SET_RATE_LIMITED':
      return {
        ...state,
        rateLimited: action.payload,
      };
    case 'CONTINUE_AS_GUEST':
      return {
        ...state,
        isLoading: false,
        loadingMessage: '',
        isAuthenticated: false,
        isGuest: true,
        user: null,
        error: null,
        rateLimited: false,
        justLoggedOut: false,
      };
    case 'CLEAR_LOGOUT_FLAG':
      return {
        ...state,
        justLoggedOut: false,
      };
    case 'SET_BIOMETRIC_SUPPORT':
      return {
        ...state,
        biometricSupported: action.payload,
      };
    case 'SET_BIOMETRIC_ENABLED':
      return {
        ...state,
        biometricEnabled: action.payload,
      };
    case 'SET_LOCKED':
      return {
        ...state,
        isLocked: action.payload,
        authenticationRequired: action.payload,
      };
    case 'SET_AUTH_REQUIRED':
      return {
        ...state,
        authenticationRequired: action.payload,
      };
    case 'SET_BACKGROUND_TIME':
      return {
        ...state,
        backgroundTime: action.payload,
      };
    case 'UNLOCK_SUCCESS':
      return {
        ...state,
        isLocked: false,
        authenticationRequired: false,
        error: null,
        backgroundTime: null, // Clear background time after successful unlock
        biometricFailureCount: 0, // Reset failure count on success
        lastFailedAttempt: null,
      };
    case 'UNLOCK_FAILURE':
      return {
        ...state,
        error: action.payload,
      };
    case 'SET_INITIAL_BIOMETRIC_CHECK_DONE':
      return {
        ...state,
        hasPerformedInitialBiometricCheck: true,
      };
    case 'INCREMENT_BIOMETRIC_FAILURE':
      return {
        ...state,
        biometricFailureCount: state.biometricFailureCount + 1,
        lastFailedAttempt: Date.now(),
      };
    case 'RESET_BIOMETRIC_FAILURE':
      return {
        ...state,
        biometricFailureCount: 0,
        lastFailedAttempt: null,
      };
    default:
      return state;
  }
};

const AuthContext = createContext<AuthContextType | undefined>(undefined);

const AUTH_STORAGE_KEY = '@chili_market_auth';
const RATE_LIMIT_COOLDOWN = 20 * 60 * 1000; // 20 minuten

interface AuthProviderProps {
  children: ReactNode;
}

export const AuthProvider: React.FC<AuthProviderProps> = ({ children }) => {
  const [state, dispatch] = useReducer(authReducer, initialState);
  const api = useMemo(() => new WordPressAPI(), []);
  // DISABLED: BuddyBoss API tijdelijk uitgeschakeld
  // const buddyBossAPI = new BuddyBossAPI();

  // Load saved credentials on app start
  useEffect(() => {
    let isMounted = true;

    const initializeAuth = async () => {
      if (isMounted) {
        await initializeBiometric();
        await loadSavedCredentials();
      }
    };

    initializeAuth();

    return () => {
      isMounted = false;
    };
  }, []); // Alleen bij mount uitvoeren

  const isRateLimited = useCallback(() => {
    const timeSinceLastAttempt = Date.now() - state.lastLoginAttempt;
    return state.rateLimited && timeSinceLastAttempt < RATE_LIMIT_COOLDOWN;
  }, [state.lastLoginAttempt, state.rateLimited]);

  const loadSavedCredentials = useCallback(async () => {
    try {
      dispatch({
        type: 'SET_LOADING',
        payload: { isLoading: true, message: 'Laden...' },
      });

      // Skip auto-login als gebruiker al als gast doorgaat of al ingelogd is
      if (state.isGuest) {
        console.log('User is already in guest mode, skipping credential load');
        dispatch({ type: 'SET_LOADING', payload: { isLoading: false } });
        return;
      }

      if (state.isAuthenticated) {
        console.log('User is already authenticated, skipping credential load');
        dispatch({ type: 'SET_LOADING', payload: { isLoading: false } });
        return;
      }

      const savedAuth = await AsyncStorage.getItem(AUTH_STORAGE_KEY);
      if (savedAuth) {
        const { username, password } = JSON.parse(savedAuth);

        // Controleer of we rate limited zijn
        if (isRateLimited()) {
          console.log('Rate limited, wachten met auto-login...');
          dispatch({ type: 'SET_LOADING', payload: { isLoading: false } });
          return;
        }

        // Test if saved credentials are still valid with JWT
        try {
          console.log('Attempting auto-login with saved credentials...');
          const user = await api.login(username, password);
          // Update BuddyBoss API token
          const token = api.getAuthToken();
          if (token) {
            // buddyBossAPI.setToken(token); // DISABLED: BuddyBoss API tijdelijk uitgeschakeld
          }
          dispatch({ type: 'LOGIN_SUCCESS', payload: user });
        } catch (error) {
          console.log('Auto-login failed, removing saved credentials');

          // Controleer of het een rate limiting error is
          if (
            error instanceof Error &&
            (error.message.includes('te veel') ||
              error.message.includes('too many') ||
              error.message.includes('retries'))
          ) {
            dispatch({ type: 'SET_RATE_LIMITED', payload: true });
          }

          // If credentials are invalid, remove them
          await AsyncStorage.removeItem(AUTH_STORAGE_KEY);
          dispatch({ type: 'LOGOUT' });
        }
      } else {
        // Geen opgeslagen credentials, zet loading uit
        dispatch({ type: 'SET_LOADING', payload: { isLoading: false } });
      }
    } catch (error) {
      console.error('Error loading saved credentials:', error);
      dispatch({ type: 'SET_LOADING', payload: { isLoading: false } });
    }
  }, [state.isGuest, state.isAuthenticated, isRateLimited, api]);

  const login = useCallback(
    async (username: string, password: string) => {
      try {
        // Controleer rate limiting
        if (isRateLimited()) {
          throw new Error(
            'Te veel inlogpogingen. Wacht 20 minuten en probeer opnieuw.',
          );
        }

        dispatch({ type: 'LOGIN_START', payload: 'Inloggen...' });

        const user = await api.login(username, password);

        // Update BuddyBoss API token
        const token = api.getAuthToken();
        if (token) {
          // buddyBossAPI.setToken(token); // DISABLED: BuddyBoss API tijdelijk uitgeschakeld
        }

        // Save credentials for auto-login (JWT tokens will be handled by API class)
        await AsyncStorage.setItem(
          AUTH_STORAGE_KEY,
          JSON.stringify({ username, password }),
        );

        dispatch({ type: 'LOGIN_SUCCESS', payload: user });
      } catch (error) {
        let errorMessage =
          error instanceof Error ? error.message : 'Login failed';

        // Detecteer rate limiting
        if (
          errorMessage.includes('te veel') ||
          errorMessage.includes('too many') ||
          errorMessage.includes('retries')
        ) {
          dispatch({ type: 'SET_RATE_LIMITED', payload: true });
          errorMessage =
            'Te veel inlogpogingen. Probeer het over 20 minuten opnieuw.';
        }

        dispatch({ type: 'LOGIN_FAILURE', payload: errorMessage });
        throw error;
      }
    },
    [dispatch, api, isRateLimited],
  );

  const logout = useCallback(async () => {
    try {
      // Clear saved credentials
      await AsyncStorage.removeItem(AUTH_STORAGE_KEY);

      // Logout from API (clears JWT token)
      api.logout();

      // Dispatch logout
      dispatch({ type: 'LOGOUT' });
    } catch (error) {
      console.error('Error during logout:', error);
      dispatch({ type: 'LOGOUT' });
    }
  }, [dispatch, api]);

  const clearError = useCallback(() => {
    dispatch({ type: 'CLEAR_ERROR' });
  }, [dispatch]);

  const clearLogoutFlag = useCallback(() => {
    dispatch({ type: 'CLEAR_LOGOUT_FLAG' });
  }, [dispatch]);

  const continueAsGuest = useCallback(async () => {
    try {
      console.log('Continue as guest: Starting guest mode process...');

      // Clear saved credentials wanneer als gast doorgaan wordt gekozen
      await AsyncStorage.removeItem(AUTH_STORAGE_KEY);
      console.log('Continue as guest: AsyncStorage credentials cleared');

      // Clear API token
      api.logout();
      console.log('Continue as guest: API logout completed');

      // Ensure complete state reset first, then set guest mode
      dispatch({ type: 'LOGOUT' });
      console.log('Continue as guest: State reset to logged out');

      // Small delay to ensure logout state is processed
      await new Promise(resolve => setTimeout(resolve, 100));

      dispatch({ type: 'CONTINUE_AS_GUEST' });
      console.log('Continue as guest: Guest mode activated');

      // Kleine vertraging om de state update te laten verwerken
      await new Promise(resolve => setTimeout(resolve, 100));
    } catch (error) {
      console.error('Error clearing credentials for guest mode:', error);
      // Alsnog doorgaan als gast, ook als credentials wissen faalt
      // Zorg voor state reset ook bij errors
      dispatch({ type: 'LOGOUT' });
      dispatch({ type: 'CONTINUE_AS_GUEST' });
    }
  }, [dispatch, api]);

  const goToLogin = useCallback(async () => {
    try {
      console.log(
        'Go to login: Clearing guest mode and redirecting to login...',
      );

      // Clear saved credentials
      await AsyncStorage.removeItem(AUTH_STORAGE_KEY);
      console.log('Go to login: AsyncStorage credentials cleared');

      // Clear API token
      api.logout();
      console.log('Go to login: API logout completed');

      // Reset to login state (not guest, not authenticated)
      dispatch({ type: 'LOGOUT' });
      console.log('Go to login: State reset - will show login screen');

      // Kleine vertraging om de state update te laten verwerken
      await new Promise(resolve => setTimeout(resolve, 100));
    } catch (error) {
      console.error('Error going to login:', error);
      // Alsnog naar login state gaan, ook bij errors
      dispatch({ type: 'LOGOUT' });
    }
  }, [dispatch, api]);

  // Face ID Methods
  const initializeBiometric = useCallback(async () => {
    try {
      if (NativeFeaturesService.isAvailable()) {
        const biometricInfo =
          await NativeFeaturesService.checkBiometricSupport();
        dispatch({
          type: 'SET_BIOMETRIC_SUPPORT',
          payload: biometricInfo.isSupported,
        });

        if (biometricInfo.isSupported) {
          const isEnabled =
            await NativeFeaturesService.isBiometricLockEnabled();
          dispatch({ type: 'SET_BIOMETRIC_ENABLED', payload: isEnabled });
        }
      }
    } catch (error) {
      console.error('Failed to initialize biometric:', error);
    }
  }, []);

  const setBiometricEnabled = useCallback(
    async (enabled: boolean): Promise<boolean> => {
      try {
        const success = await NativeFeaturesService.setBiometricLockEnabled(
          enabled,
        );
        if (success) {
          dispatch({ type: 'SET_BIOMETRIC_ENABLED', payload: enabled });
        }
        return success;
      } catch (error) {
        console.error('Failed to set biometric enabled:', error);
        return false;
      }
    },
    [],
  );

  const authenticateWithBiometric = useCallback(async (): Promise<boolean> => {
    try {
      const result = await NativeFeaturesService.authenticateForUnlock();
      if (result.success) {
        dispatch({ type: 'UNLOCK_SUCCESS' });
        dispatch({ type: 'RESET_BIOMETRIC_FAILURE' });
        return true;
      } else {
        // SECURITY: Increment failure count for ANY failure (including cancel)
        dispatch({ type: 'INCREMENT_BIOMETRIC_FAILURE' });
        const errorMessage =
          result.error ||
          LocalizationService.t('features.biometricAuth.failed');
        dispatch({ type: 'UNLOCK_FAILURE', payload: errorMessage });
        return false;
      }
    } catch (error) {
      console.error('Biometric authentication failed:', error);
      // SECURITY: Also increment on exceptions
      dispatch({ type: 'INCREMENT_BIOMETRIC_FAILURE' });
      const errorMessage =
        error instanceof Error
          ? error.message
          : LocalizationService.t('features.biometricAuth.failed');
      dispatch({ type: 'UNLOCK_FAILURE', payload: errorMessage });
      return false;
    }
  }, []);

  const setBackgroundTime = useCallback(async (): Promise<void> => {
    try {
      const timestamp = Date.now();
      await NativeFeaturesService.setBackgroundTime(timestamp);
      dispatch({ type: 'SET_BACKGROUND_TIME', payload: timestamp });
    } catch (error) {
      console.error('Failed to set background time:', error);
    }
  }, []);

  const checkAuthRequired = useCallback(async (): Promise<boolean> => {
    return new Promise(resolve => {
      // Use setTimeout to ensure we get the latest state
      setTimeout(async () => {
        try {
          // Get fresh state reference
          const currentState = state;

          if (!currentState.biometricEnabled || !currentState.isAuthenticated) {
            resolve(false);
            return;
          }

          // Avoid checking if already locked to prevent loops
          if (currentState.isLocked || currentState.authenticationRequired) {
            resolve(currentState.authenticationRequired);
            return;
          }

          const shouldRequireAuth =
            await NativeFeaturesService.shouldRequireAuth();

          if (shouldRequireAuth) {
            dispatch({ type: 'SET_AUTH_REQUIRED', payload: true });
            dispatch({ type: 'SET_LOCKED', payload: true });
          }

          resolve(shouldRequireAuth);
        } catch (error) {
          console.error('Failed to check auth requirement:', error);
          resolve(false);
        }
      }, 0);
    });
  }, [state]); // Now we can safely depend on state

  const unlock = useCallback(async (): Promise<boolean> => {
    try {
      if (!state.authenticationRequired) {
        return true;
      }

      const success = await authenticateWithBiometric();
      if (success) {
        // Clear background time both locally and in native storage
        await NativeFeaturesService.clearBackgroundTime();
        dispatch({ type: 'SET_BACKGROUND_TIME', payload: null });
      }
      return success;
    } catch (error) {
      console.error('Failed to unlock:', error);
      return false;
    }
  }, [state.authenticationRequired, authenticateWithBiometric]);

  const value: AuthContextType = React.useMemo(
    () => ({
      ...state,
      login,
      logout,
      continueAsGuest,
      goToLogin,
      clearError,
      clearLogoutFlag,
      api,
      // Face ID methods
      setBiometricEnabled,
      authenticateWithBiometric,
      setBackgroundTime,
      checkAuthRequired,
      unlock,
      initializeBiometric,
      // DISABLED: BuddyBoss API tijdelijk uitgeschakeld
      // buddyBossAPI,
    }),
    [
      state,
      login,
      logout,
      continueAsGuest,
      goToLogin,
      clearError,
      clearLogoutFlag,
      api,
      setBiometricEnabled,
      authenticateWithBiometric,
      setBackgroundTime,
      checkAuthRequired,
      unlock,
      initializeBiometric,
    ],
  );

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = (): AuthContextType => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
