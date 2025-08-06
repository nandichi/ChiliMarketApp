import React from 'react';
import {
  View,
  Text,
  StyleSheet,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';

// DISABLED: BuddyBoss functionaliteit tijdelijk uitgeschakeld
// Deze component toont een bericht dat de functionaliteit binnenkort beschikbaar is
export default function BuddyBossScreen() {
  return (
    <View style={styles.disabledContainer}>
      <Icon name="groups" size={80} color={Colors.gray400} />
      <Text style={styles.disabledTitle}>BuddyBoss Community</Text>
      <Text style={styles.disabledMessage}>
        Deze functionaliteit wordt binnenkort beschikbaar gesteld.
      </Text>
      <Text style={styles.disabledSubMessage}>
        Gebruik de website voor alle community functies.
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  disabledContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
    backgroundColor: Colors.background,
  },
  disabledTitle: {
    fontSize: 24,
    fontWeight: '700',
    color: Colors.text,
    marginTop: 16,
  },
  disabledMessage: {
    fontSize: 16,
    color: Colors.textSecondary,
    textAlign: 'center',
    marginTop: 8,
  },
  disabledSubMessage: {
    fontSize: 14,
    color: Colors.gray400,
    textAlign: 'center',
    marginTop: 4,
  },
});

/* 
ORIGINELE BUDDYBOSS IMPLEMENTATIE - VOLLEDIG UITGESCHAKELD
=====================================

import React, { useEffect, useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Dimensions,
  ActivityIndicator,
  Alert,
  Image,
  RefreshControl,
  TextInput,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import { useAuth } from '../context/AuthContext';
import {
  BuddyBossGroup,
  BuddyBossActivity,
  BuddyBossMember,
  BuddyBossMessage,
  BuddyBossNotification,
} from '../services/BuddyBossAPI';

const { width } = Dimensions.get('window');

type TabType = 'groups' | 'activity' | 'members' | 'messages' | 'notifications';

export default function BuddyBossScreen() {
  const { buddyBossAPI, isAuthenticated, user } = useAuth();
  const [activeTab, setActiveTab] = useState<TabType>('activity');
  const [loading, setLoading] = useState(false);
  const [refreshing, setRefreshing] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Data states
  const [groups, setGroups] = useState<BuddyBossGroup[]>([]);
  const [activities, setActivities] = useState<BuddyBossActivity[]>([]);
  const [members, setMembers] = useState<BuddyBossMember[]>([]);
  const [messages, setMessages] = useState<BuddyBossMessage[]>([]);
  const [notifications, setNotifications] = useState<BuddyBossNotification[]>(
    [],
  );

  // Search and filters
  const [searchQuery, setSearchQuery] = useState('');
  const [groupFilter, setGroupFilter] = useState<
    'active' | 'newest' | 'alphabetical'
  >('active');

  // [REST VAN ORIGINELE IMPLEMENTATIE - NIET GETOOND WEGENS LENGTE]
}

*/
