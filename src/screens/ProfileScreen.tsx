import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Alert,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import { useAuth } from '../context/AuthContext';

export default function ProfileScreen() {
  const { user, logout } = useAuth();

  const handleLogout = () => {
    Alert.alert('Uitloggen', 'Weet je zeker dat je wilt uitloggen?', [
      { text: 'Annuleren', style: 'cancel' },
      { text: 'Uitloggen', style: 'destructive', onPress: logout },
    ]);
  };

  const handleEditProfile = () => {
    Alert.alert(
      'Profiel Bewerken',
      'Ga naar de Chili Market website om je profiel te bewerken.',
      [{ text: 'OK', style: 'default' }],
    );
  };

  return (
    <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
      {/* Profile Header */}
      <View style={styles.profileHeader}>
        <View style={styles.avatarContainer}>
          <Icon name="person" size={50} color={Colors.white} />
        </View>
        <Text style={styles.userName}>{user?.name || 'Gebruiker'}</Text>
        <Text style={styles.userEmail}>
          {user?.email || user?.username || 'Geen email'}
        </Text>
        <TouchableOpacity
          style={styles.editProfileButton}
          onPress={handleEditProfile}
        >
          <Text style={styles.editProfileText}>Profiel Bewerken</Text>
        </TouchableOpacity>
      </View>

      {/* Quick Stats */}
      <View style={styles.statsContainer}>
        <View style={styles.statItem}>
          <Text style={styles.statNumber}>23</Text>
          <Text style={styles.statLabel}>Bestellingen</Text>
        </View>
        <View style={styles.statDivider} />
        <View style={styles.statItem}>
          <Text style={styles.statNumber}>156</Text>
          <Text style={styles.statLabel}>Punten</Text>
        </View>
        <View style={styles.statDivider} />
        <View style={styles.statItem}>
          <Text style={styles.statNumber}>€234</Text>
          <Text style={styles.statLabel}>Bespaard</Text>
        </View>
      </View>

      {/* Menu Items */}
      <View style={styles.menuContainer}>
        {menuItems.map((item, index) => (
          <TouchableOpacity key={index} style={styles.menuItem}>
            <View style={styles.menuItemLeft}>
              <View style={[styles.menuIcon, { backgroundColor: item.color }]}>
                <Icon name={item.icon} size={20} color={Colors.white} />
              </View>
              <Text style={styles.menuItemText}>{item.title}</Text>
            </View>
            <Icon name="chevron-right" size={20} color={Colors.gray400} />
          </TouchableOpacity>
        ))}
      </View>

      {/* Settings Section */}
      <View style={styles.sectionContainer}>
        <Text style={styles.sectionTitle}>Instellingen</Text>
        {settingsItems.map((item, index) => (
          <TouchableOpacity key={index} style={styles.menuItem}>
            <View style={styles.menuItemLeft}>
              <View style={[styles.menuIcon, { backgroundColor: item.color }]}>
                <Icon name={item.icon} size={20} color={Colors.white} />
              </View>
              <Text style={styles.menuItemText}>{item.title}</Text>
            </View>
            <Icon name="chevron-right" size={20} color={Colors.gray400} />
          </TouchableOpacity>
        ))}
      </View>

      {/* Logout Button */}
      <TouchableOpacity style={styles.logoutButton} onPress={handleLogout}>
        <Icon name="logout" size={20} color={Colors.error} />
        <Text style={styles.logoutText}>Uitloggen</Text>
      </TouchableOpacity>

      <View style={styles.bottomSpacing} />
    </ScrollView>
  );
}

const menuItems = [
  { title: 'Mijn Bestellingen', icon: 'receipt', color: Colors.primary },
  { title: 'Favorieten', icon: 'favorite', color: Colors.error },
  { title: 'Adressen', icon: 'location-on', color: Colors.info },
  { title: 'Betalingsmethoden', icon: 'payment', color: Colors.success },
  { title: 'Klantenservice', icon: 'support', color: Colors.warning },
];

const settingsItems = [
  { title: 'Notificaties', icon: 'notifications', color: Colors.accent },
  { title: 'Privacy', icon: 'security', color: Colors.gray600 },
  { title: 'Over Ons', icon: 'info', color: Colors.secondary },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  profileHeader: {
    backgroundColor: Colors.primary,
    alignItems: 'center',
    paddingVertical: 40,
    paddingHorizontal: 20,
  },
  avatarContainer: {
    width: 100,
    height: 100,
    borderRadius: 50,
    backgroundColor: Colors.primaryDark,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  userName: {
    fontSize: 24,
    fontWeight: '700',
    color: Colors.white,
    marginBottom: 4,
  },
  userEmail: {
    fontSize: 16,
    color: Colors.primaryLight,
    marginBottom: 20,
  },
  editProfileButton: {
    backgroundColor: Colors.white,
    borderRadius: 20,
    paddingHorizontal: 24,
    paddingVertical: 10,
  },
  editProfileText: {
    fontSize: 14,
    fontWeight: '600',
    color: Colors.primary,
  },
  statsContainer: {
    flexDirection: 'row',
    backgroundColor: Colors.white,
    marginHorizontal: 16,
    marginTop: -20,
    borderRadius: 12,
    paddingVertical: 20,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  statItem: {
    flex: 1,
    alignItems: 'center',
  },
  statNumber: {
    fontSize: 24,
    fontWeight: '700',
    color: Colors.text,
    marginBottom: 4,
  },
  statLabel: {
    fontSize: 14,
    color: Colors.textSecondary,
  },
  statDivider: {
    width: 1,
    backgroundColor: Colors.border,
    marginVertical: 8,
  },
  menuContainer: {
    backgroundColor: Colors.white,
    marginHorizontal: 16,
    marginTop: 20,
    borderRadius: 12,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  sectionContainer: {
    backgroundColor: Colors.white,
    marginHorizontal: 16,
    marginTop: 20,
    borderRadius: 12,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: Colors.text,
    padding: 20,
    paddingBottom: 0,
  },
  menuItem: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    padding: 20,
    borderBottomWidth: 1,
    borderBottomColor: Colors.borderLight,
  },
  menuItemLeft: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  menuIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  menuItemText: {
    fontSize: 16,
    fontWeight: '500',
    color: Colors.text,
  },
  logoutButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: Colors.white,
    marginHorizontal: 16,
    marginTop: 20,
    borderRadius: 12,
    padding: 16,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  logoutText: {
    fontSize: 16,
    fontWeight: '600',
    color: Colors.error,
    marginLeft: 8,
  },
  bottomSpacing: {
    height: 20,
  },
});
