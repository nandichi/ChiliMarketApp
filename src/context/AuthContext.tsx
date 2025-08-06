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
  | { type: 'CLEAR_LOGOUT_FLAG' };

interface AuthContextType extends AuthState {
  login: (username: string, password: string) => Promise<void>;
  logout: () => Promise<void>;
  continueAsGuest: () => Promise<void>;
  goToLogin: () => Promise<void>;
  clearError: () => void;
  clearLogoutFlag: () => void;
  api: WordPressAPI;
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
    loadSavedCredentials();
  }, []);

  const isRateLimited = useCallback(() => {
    const timeSinceLastAttempt = Date.now() - state.lastLoginAttempt;
    return state.rateLimited && timeSinceLastAttempt < RATE_LIMIT_COOLDOWN;
  }, [state.lastLoginAttempt, state.rateLimited]);

  const loadSavedCredentials = useCallback(async () => {
    try {
      dispatch({ type: 'SET_LOADING', payload: { isLoading: true, message: 'Laden...' } });

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
      }
    } catch (error) {
      console.error('Error loading saved credentials:', error);
    } finally {
      dispatch({ type: 'SET_LOADING', payload: { isLoading: false } });
    }
  }, [dispatch, api, state.isGuest, state.isAuthenticated, isRateLimited]);

  const login = useCallback(async (username: string, password: string) => {
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
  }, [dispatch, api, isRateLimited]);

  const logout = useCallback(async () => {
    try {
      console.log('Logout: Starting logout process...');
      
      // Clear saved credentials
      await AsyncStorage.removeItem(AUTH_STORAGE_KEY);
      console.log('Logout: AsyncStorage credentials cleared');

      // Verify credentials are actually cleared
      const remainingAuth = await AsyncStorage.getItem(AUTH_STORAGE_KEY);
      if (remainingAuth) {
        console.error('WARNING: Credentials still found after removal attempt!');
      } else {
        console.log('Logout: Verified credentials are completely cleared');
      }

      // Logout from API (clears JWT token)
      api.logout();
      console.log('Logout: API logout completed');

      // Dispatch logout - this will trigger navigation to login screen
      dispatch({ type: 'LOGOUT' });
      console.log('Logout: State updated to logged out - user will see login screen');
    } catch (error) {
      console.error('Error during logout:', error);
      // Altijd de state updaten, ook bij errors
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
      console.log('Go to login: Clearing guest mode and redirecting to login...');
      
      // Clear saved credentials
      await AsyncStorage.removeItem(AUTH_STORAGE_KEY);
      console.log('Go to login: AsyncStorage credentials cleared');
      
      // Clear API token
      api.logout();
      console.log('Go to login: API logout completed');
      
      // Reset to login state (not guest, not authenticated)
      dispatch({ type: 'LOGOUT' });
      console.log('Go to login: State reset - will show login screen');
    } catch (error) {
      console.error('Error going to login:', error);
      // Alsnog naar login state gaan, ook bij errors
      dispatch({ type: 'LOGOUT' });
    }
  }, [dispatch, api]);

  const value: AuthContextType = React.useMemo(() => ({
    ...state,
    login,
    logout,
    continueAsGuest,
    goToLogin,
    clearError,
    clearLogoutFlag,
    api,
    // DISABLED: BuddyBoss API tijdelijk uitgeschakeld
    // buddyBossAPI,
  }), [state, login, logout, continueAsGuest, goToLogin, clearError, clearLogoutFlag, api]);

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = (): AuthContextType => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
