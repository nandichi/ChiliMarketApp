import React, {
  createContext,
  useContext,
  useReducer,
  useEffect,
  ReactNode,
} from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';
import WordPressAPI, { WordPressUser } from '../services/WordPressAPI';
import BuddyBossAPI from '../services/BuddyBossAPI';

interface AuthState {
  user: WordPressUser | null;
  isLoading: boolean;
  isAuthenticated: boolean;
  isGuest: boolean;
  error: string | null;
  rateLimited: boolean;
  lastLoginAttempt: number;
}

type AuthAction =
  | { type: 'LOGIN_START' }
  | { type: 'LOGIN_SUCCESS'; payload: WordPressUser }
  | { type: 'LOGIN_FAILURE'; payload: string }
  | { type: 'LOGOUT' }
  | { type: 'CLEAR_ERROR' }
  | { type: 'SET_LOADING'; payload: boolean }
  | { type: 'SET_RATE_LIMITED'; payload: boolean }
  | { type: 'CONTINUE_AS_GUEST' };

interface AuthContextType extends AuthState {
  login: (username: string, password: string) => Promise<void>;
  logout: () => Promise<void>;
  continueAsGuest: () => void;
  clearError: () => void;
  api: WordPressAPI;
  buddyBossAPI: BuddyBossAPI;
}

const initialState: AuthState = {
  user: null,
  isLoading: false,
  isAuthenticated: false,
  isGuest: false,
  error: null,
  rateLimited: false,
  lastLoginAttempt: 0,
};

const authReducer = (state: AuthState, action: AuthAction): AuthState => {
  switch (action.type) {
    case 'LOGIN_START':
      return {
        ...state,
        isLoading: true,
        error: null,
        lastLoginAttempt: Date.now(),
      };
    case 'LOGIN_SUCCESS':
      return {
        ...state,
        isLoading: false,
        isAuthenticated: true,
        user: action.payload,
        error: null,
        rateLimited: false,
      };
    case 'LOGIN_FAILURE':
      return {
        ...state,
        isLoading: false,
        isAuthenticated: false,
        user: null,
        error: action.payload,
      };
    case 'LOGOUT':
      return {
        ...state,
        isLoading: false,
        isAuthenticated: false,
        isGuest: false,
        user: null,
        error: null,
        rateLimited: false,
      };
    case 'CLEAR_ERROR':
      return {
        ...state,
        error: null,
      };
    case 'SET_LOADING':
      return {
        ...state,
        isLoading: action.payload,
      };
    case 'SET_RATE_LIMITED':
      return {
        ...state,
        rateLimited: action.payload,
      };
    case 'CONTINUE_AS_GUEST':
      return {
        ...state,
        isGuest: true,
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
  const api = new WordPressAPI();
  const buddyBossAPI = new BuddyBossAPI();

  // Load saved credentials on app start
  useEffect(() => {
    loadSavedCredentials();
  }, []);

  const isRateLimited = () => {
    const timeSinceLastAttempt = Date.now() - state.lastLoginAttempt;
    return state.rateLimited && timeSinceLastAttempt < RATE_LIMIT_COOLDOWN;
  };

  const loadSavedCredentials = async () => {
    try {
      dispatch({ type: 'SET_LOADING', payload: true });

      const savedAuth = await AsyncStorage.getItem(AUTH_STORAGE_KEY);
      if (savedAuth) {
        const { username, password } = JSON.parse(savedAuth);

        // Controleer of we rate limited zijn
        if (isRateLimited()) {
          console.log('Rate limited, wachten met auto-login...');
          dispatch({ type: 'SET_LOADING', payload: false });
          return;
        }

        // Test if saved credentials are still valid with JWT
        try {
          console.log('Attempting auto-login with saved credentials...');
          const user = await api.login(username, password);
          // Update BuddyBoss API token
          const token = api.getAuthToken();
          if (token) {
            buddyBossAPI.setToken(token);
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
      dispatch({ type: 'SET_LOADING', payload: false });
    }
  };

  const login = async (username: string, password: string) => {
    try {
      // Controleer rate limiting
      if (isRateLimited()) {
        throw new Error(
          'Te veel inlogpogingen. Wacht 20 minuten en probeer opnieuw.',
        );
      }

      dispatch({ type: 'LOGIN_START' });

      const user = await api.login(username, password);

      // Update BuddyBoss API token
      const token = api.getAuthToken();
      if (token) {
        buddyBossAPI.setToken(token);
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
  };

  const logout = async () => {
    try {
      // Clear saved credentials
      await AsyncStorage.removeItem(AUTH_STORAGE_KEY);

      // Logout from API (clears JWT token)
      api.logout();

      dispatch({ type: 'LOGOUT' });
    } catch (error) {
      console.error('Error during logout:', error);
    }
  };

  const clearError = () => {
    dispatch({ type: 'CLEAR_ERROR' });
  };

  const continueAsGuest = () => {
    dispatch({ type: 'CONTINUE_AS_GUEST' });
  };

  const value: AuthContextType = {
    ...state,
    login,
    logout,
    continueAsGuest,
    clearError,
    api,
    buddyBossAPI,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = (): AuthContextType => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
