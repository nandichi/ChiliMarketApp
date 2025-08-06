import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Alert,
  SafeAreaView,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import { useAuth } from '../context/AuthContext';

export default function LogoutScreen() {
  const { user, logout, isLoading } = useAuth();

  const handleLogout = () => {
    Alert.alert(
      'Uitloggen', 
      'Weet je zeker dat je wilt uitloggen?', 
      [
        { 
          text: 'Annuleren', 
          style: 'cancel' 
        },
        { 
          text: 'Uitloggen', 
          style: 'destructive', 
          onPress: async () => {
            try {
              console.log('LogoutScreen: User confirmed logout');
              await logout();
              console.log('LogoutScreen: Logout completed successfully');
              // Navigation wordt automatisch afgehandeld door AuthContext/AppNavigator
            } catch (error) {
              console.error('LogoutScreen: Logout error:', error);
              Alert.alert('Fout', 'Uitloggen is mislukt. Probeer opnieuw.');
            }
          }
        },
      ]
    );
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        <View style={styles.iconContainer}>
          <Icon name="logout" size={80} color={Colors.primary} />
        </View>
        
        <Text style={styles.title}>Uitloggen</Text>
        
                 {user && (
           <View style={styles.userInfo}>
             <Text style={styles.userInfoLabel}>Ingelogd als:</Text>
             <Text style={styles.userName}>{user.name || user.username}</Text>
           </View>
         )}
        
        <Text style={styles.description}>
          Klik op de knop hieronder om uit te loggen van je Chili Market account.
        </Text>

        <TouchableOpacity
          style={[styles.logoutButton, isLoading && styles.logoutButtonDisabled]}
          onPress={handleLogout}
          disabled={isLoading}
        >
          <Icon name="logout" size={24} color={Colors.white} />
          <Text style={styles.logoutButtonText}>
            {isLoading ? 'Uitloggen...' : 'Uitloggen'}
          </Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: 24,
  },
  iconContainer: {
    backgroundColor: Colors.white,
    borderRadius: 50,
    padding: 20,
    marginBottom: 32,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 8,
    elevation: 6,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: Colors.text,
    marginBottom: 16,
    textAlign: 'center',
  },
  userInfo: {
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 16,
    marginBottom: 24,
    alignItems: 'center',
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  userInfoLabel: {
    fontSize: 14,
    color: Colors.textSecondary,
    marginBottom: 4,
  },
  userName: {
    fontSize: 18,
    fontWeight: '600',
    color: Colors.text,
  },
  description: {
    fontSize: 16,
    color: Colors.textSecondary,
    textAlign: 'center',
    lineHeight: 24,
    marginBottom: 40,
    paddingHorizontal: 20,
  },
  logoutButton: {
    backgroundColor: Colors.error,
    borderRadius: 12,
    paddingVertical: 16,
    paddingHorizontal: 32,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    shadowColor: Colors.error,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 4,
    minWidth: 200,
  },
  logoutButtonDisabled: {
    backgroundColor: Colors.textSecondary,
    shadowOpacity: 0,
    elevation: 0,
  },
  logoutButtonText: {
    color: Colors.white,
    fontSize: 18,
    fontWeight: '600',
    marginLeft: 8,
  },
}); 