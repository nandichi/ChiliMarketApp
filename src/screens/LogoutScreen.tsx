import React, { useState, useEffect } from 'react';
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
  const [currentUser, setCurrentUser] = useState(user);
  const [currentLoading, setCurrentLoading] = useState(isLoading);

  // Stabiliseer de state om oneindige loops te voorkomen
  useEffect(() => {
    setCurrentUser(user);
  }, [user]);

  useEffect(() => {
    setCurrentLoading(isLoading);
  }, [isLoading]);

  const handleLogout = () => {
    if (currentLoading) return; // Voorkom dubbele clicks
    
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
              
              // Disable de button tijdens logout
              setCurrentLoading(true);
              
              // Kleine vertraging om de button state te laten verwerken
              await new Promise(resolve => setTimeout(resolve, 100));
              
              await logout();
              console.log('LogoutScreen: Logout completed successfully');
              
              // Navigation wordt automatisch afgehandeld door AuthContext/AppNavigator
              // Geen extra navigatie acties hier
            } catch (error) {
              console.error('LogoutScreen: Logout error:', error);
              Alert.alert('Fout', 'Uitloggen is mislukt. Probeer opnieuw.');
              setCurrentLoading(false);
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
        
        {currentUser && (
          <View style={styles.userInfo}>
            <Text style={styles.userInfoLabel}>Ingelogd als:</Text>
            <Text style={styles.userName}>{currentUser.name || currentUser.username}</Text>
          </View>
        )}
        
        <Text style={styles.description}>
          Klik op de knop hieronder om uit te loggen van je Chili Market account.
        </Text>

        <TouchableOpacity
          style={[styles.logoutButton, currentLoading && styles.logoutButtonDisabled]}
          onPress={handleLogout}
          disabled={currentLoading}
        >
          <Icon name="logout" size={24} color={Colors.white} />
          <Text style={styles.logoutButtonText}>
            {currentLoading ? 'Uitloggen...' : 'Uitloggen'}
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
    // Vereenvoudigde shadow styling
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
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
    // Vereenvoudigde shadow styling
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 2,
    elevation: 1,
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
    // Vereenvoudigde shadow styling
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.15,
    shadowRadius: 4,
    elevation: 2,
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