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
  const [memberFilter, setMemberFilter] = useState<
    'newest' | 'active' | 'alphabetical'
  >('active');

  useEffect(() => {
    if (isAuthenticated) {
      loadInitialData();
    }
  }, [isAuthenticated, activeTab]);

  const loadInitialData = async () => {
    if (!isAuthenticated) {
      setError('Inloggen vereist voor BuddyBoss features');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      await loadDataForActiveTab();
    } catch (error) {
      console.error('Error loading BuddyBoss data:', error);
      setError(
        error instanceof Error ? error.message : 'Fout bij laden van gegevens',
      );
    } finally {
      setLoading(false);
    }
  };

  const loadDataForActiveTab = async () => {
    switch (activeTab) {
      case 'groups':
        const groupsData = await buddyBossAPI.getGroups({
          per_page: 20,
          type: groupFilter,
        });
        setGroups(groupsData);
        break;

      case 'activity':
        const activityData = await buddyBossAPI.getActivity({
          per_page: 20,
        });
        setActivities(activityData);
        break;

      case 'members':
        const membersData = await buddyBossAPI.getMembers({
          per_page: 20,
          type: memberFilter,
          search: searchQuery || undefined,
        });
        setMembers(membersData);
        break;

      case 'messages':
        const messagesData = await buddyBossAPI.getMessages({
          per_page: 20,
        });
        setMessages(messagesData);
        break;

      case 'notifications':
        const notificationsData = await buddyBossAPI.getNotifications({
          per_page: 20,
        });
        setNotifications(notificationsData);
        break;
    }
  };

  const onRefresh = async () => {
    setRefreshing(true);
    try {
      await loadDataForActiveTab();
    } catch (error) {
      console.error('Refresh error:', error);
    } finally {
      setRefreshing(false);
    }
  };

  const handleTabChange = (tab: TabType) => {
    setActiveTab(tab);
    setSearchQuery('');
    setError(null);
  };

  const handleJoinGroup = async (groupId: number) => {
    try {
      await buddyBossAPI.joinGroup(groupId);
      Alert.alert('Succes', 'Je bent toegevoegd aan de groep');
      onRefresh();
    } catch (error) {
      Alert.alert('Fout', 'Kon niet deelnemen aan groep');
    }
  };

  const handleFavoriteActivity = async (
    activityId: number,
    isFavorited: boolean,
  ) => {
    try {
      if (isFavorited) {
        await buddyBossAPI.unfavoriteActivity(activityId);
      } else {
        await buddyBossAPI.favoriteActivity(activityId);
      }
      onRefresh();
    } catch (error) {
      Alert.alert('Fout', 'Kon activiteit niet markeren als favoriet');
    }
  };

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('nl-NL', {
      day: 'numeric',
      month: 'short',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  const stripHtml = (html: string | undefined | null) => {
    if (!html || typeof html !== 'string') {
      return '';
    }
    return html.replace(/<[^>]*>/g, '').trim();
  };

  if (!isAuthenticated) {
    return (
      <View style={styles.centerContainer}>
        <Icon name="login" size={64} color={Colors.gray400} />
        <Text style={styles.centerText}>
          Log in om BuddyBoss features te gebruiken
        </Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>BuddyBoss Community</Text>
        <Text style={styles.headerSubtitle}>Welkom {user?.name}</Text>
      </View>

      {/* Tab Navigation */}
      <View style={styles.tabContainer}>
        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
          {tabs.map(tab => (
            <TouchableOpacity
              key={tab.key}
              style={[styles.tab, activeTab === tab.key && styles.activeTab]}
              onPress={() => handleTabChange(tab.key)}
            >
              <Icon
                name={tab.icon}
                size={20}
                color={activeTab === tab.key ? Colors.white : Colors.gray400}
              />
              <Text
                style={[
                  styles.tabText,
                  activeTab === tab.key && styles.activeTabText,
                ]}
              >
                {tab.label}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>

      {/* Search Bar (voor members tab) */}
      {activeTab === 'members' && (
        <View style={styles.searchContainer}>
          <View style={styles.searchBar}>
            <Icon name="search" size={20} color={Colors.gray400} />
            <TextInput
              style={styles.searchInput}
              placeholder="Zoek leden..."
              placeholderTextColor={Colors.gray400}
              value={searchQuery}
              onChangeText={setSearchQuery}
              onSubmitEditing={loadInitialData}
              returnKeyType="search"
            />
          </View>
        </View>
      )}

      {/* Filter Buttons */}
      {(activeTab === 'groups' || activeTab === 'members') && (
        <View style={styles.filterContainer}>
          <ScrollView horizontal showsHorizontalScrollIndicator={false}>
            {(activeTab === 'groups' ? groupFilters : memberFilters).map(
              filter => (
                <TouchableOpacity
                  key={filter.key}
                  style={[
                    styles.filterButton,
                    (activeTab === 'groups' ? groupFilter : memberFilter) ===
                      filter.key && styles.activeFilterButton,
                  ]}
                  onPress={() => {
                    if (activeTab === 'groups') {
                      setGroupFilter(filter.key as any);
                    } else {
                      setMemberFilter(filter.key as any);
                    }
                    loadInitialData();
                  }}
                >
                  <Text
                    style={[
                      styles.filterButtonText,
                      (activeTab === 'groups' ? groupFilter : memberFilter) ===
                        filter.key && styles.activeFilterButtonText,
                    ]}
                  >
                    {filter.label}
                  </Text>
                </TouchableOpacity>
              ),
            )}
          </ScrollView>
        </View>
      )}

      {/* Content */}
      <ScrollView
        style={styles.content}
        refreshControl={
          <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
        }
      >
        {loading && !refreshing && (
          <View style={styles.loadingContainer}>
            <ActivityIndicator size="large" color={Colors.primary} />
            <Text style={styles.loadingText}>Laden...</Text>
          </View>
        )}

        {error && (
          <View style={styles.errorContainer}>
            <Icon name="error" size={24} color={Colors.error} />
            <Text style={styles.errorText}>{error}</Text>
            <TouchableOpacity
              style={styles.retryButton}
              onPress={loadInitialData}
            >
              <Text style={styles.retryButtonText}>Opnieuw proberen</Text>
            </TouchableOpacity>
          </View>
        )}

        {!loading && !error && (
          <>
            {activeTab === 'groups' && renderGroups()}
            {activeTab === 'activity' && renderActivity()}
            {activeTab === 'members' && renderMembers()}
            {activeTab === 'messages' && renderMessages()}
            {activeTab === 'notifications' && renderNotifications()}
          </>
        )}
      </ScrollView>
    </View>
  );

  function renderGroups() {
    return (
      <View style={styles.section}>
        {groups.length === 0 ? (
          <View style={styles.emptyContainer}>
            <Icon name="groups" size={48} color={Colors.gray400} />
            <Text style={styles.emptyText}>Geen groepen gevonden</Text>
          </View>
        ) : (
          groups.map(group => (
            <View key={group.id} style={styles.groupCard}>
              <View style={styles.groupHeader}>
                <View style={styles.groupAvatar}>
                  {group.avatar_urls?.thumb ? (
                    <Image
                      source={{ uri: group.avatar_urls.thumb }}
                      style={styles.avatarImage}
                    />
                  ) : (
                    <Icon name="group" size={24} color={Colors.primary} />
                  )}
                </View>
                <View style={styles.groupInfo}>
                  <Text style={styles.groupName}>{group.name}</Text>
                  <Text style={styles.groupDescription} numberOfLines={2}>
                    {stripHtml(group.description)}
                  </Text>
                  <Text style={styles.groupMeta}>
                    {group.total_member_count} leden •{' '}
                    {formatDate(group.date_created)}
                  </Text>
                </View>
              </View>
              <TouchableOpacity
                style={styles.joinButton}
                onPress={() => handleJoinGroup(group.id)}
              >
                <Text style={styles.joinButtonText}>Deelnemen</Text>
              </TouchableOpacity>
            </View>
          ))
        )}
      </View>
    );
  }

  function renderActivity() {
    return (
      <View style={styles.section}>
        {activities.length === 0 ? (
          <View style={styles.emptyContainer}>
            <Icon name="timeline" size={48} color={Colors.gray400} />
            <Text style={styles.emptyText}>Geen activiteiten gevonden</Text>
          </View>
        ) : (
          activities.map(activity => (
            <View key={activity.id} style={styles.activityCard}>
              <View style={styles.activityHeader}>
                <Image
                  source={{ uri: activity.user_avatar }}
                  style={styles.userAvatar}
                />
                <View style={styles.activityInfo}>
                  <Text style={styles.userName}>{activity.user_name}</Text>
                  <Text style={styles.activityDate}>
                    {formatDate(activity.date)}
                  </Text>
                </View>
                <TouchableOpacity
                  onPress={() =>
                    handleFavoriteActivity(
                      activity.id,
                      activity.favorited || false,
                    )
                  }
                >
                  <Icon
                    name={activity.favorited ? 'favorite' : 'favorite-border'}
                    size={20}
                    color={activity.favorited ? Colors.error : Colors.gray400}
                  />
                </TouchableOpacity>
              </View>
              <Text style={styles.activityContent}>
                {stripHtml(activity.content)}
              </Text>
              {activity.comment_count && activity.comment_count > 0 && (
                <Text style={styles.commentCount}>
                  {activity.comment_count} reacties
                </Text>
              )}
            </View>
          ))
        )}
      </View>
    );
  }

  function renderMembers() {
    return (
      <View style={styles.section}>
        {members.length === 0 ? (
          <View style={styles.emptyContainer}>
            <Icon name="people" size={48} color={Colors.gray400} />
            <Text style={styles.emptyText}>Geen leden gevonden</Text>
          </View>
        ) : (
          <View style={styles.membersGrid}>
            {members.map(member => (
              <View key={member.id} style={styles.memberCard}>
                <Image
                  source={{ uri: member.avatar_urls.thumb }}
                  style={styles.memberAvatar}
                />
                <Text style={styles.memberName} numberOfLines={1}>
                  {member.name}
                </Text>
                <Text style={styles.memberActivity}>
                  Laatst actief: {formatDate(member.last_activity)}
                </Text>
                {member.latest_update && (
                  <Text style={styles.memberUpdate} numberOfLines={2}>
                    {stripHtml(member.latest_update)}
                  </Text>
                )}
              </View>
            ))}
          </View>
        )}
      </View>
    );
  }

  function renderMessages() {
    return (
      <View style={styles.section}>
        {messages.length === 0 ? (
          <View style={styles.emptyContainer}>
            <Icon name="message" size={48} color={Colors.gray400} />
            <Text style={styles.emptyText}>Geen berichten gevonden</Text>
          </View>
        ) : (
          messages.map(message => (
            <View key={message.id} style={styles.messageCard}>
              <View style={styles.messageHeader}>
                <Image
                  source={{ uri: message.sender_avatar }}
                  style={styles.userAvatar}
                />
                <View style={styles.messageInfo}>
                  <Text style={styles.messageSender}>
                    {message.sender_name}
                  </Text>
                  <Text style={styles.messageSubject}>{message.subject}</Text>
                  <Text style={styles.messageDate}>
                    {formatDate(message.date_sent)}
                  </Text>
                </View>
                {message.is_starred && (
                  <Icon name="star" size={20} color={Colors.warning} />
                )}
              </View>
              <Text style={styles.messageContent} numberOfLines={3}>
                {stripHtml(message.message)}
              </Text>
            </View>
          ))
        )}
      </View>
    );
  }

  function renderNotifications() {
    return (
      <View style={styles.section}>
        {notifications.length === 0 ? (
          <View style={styles.emptyContainer}>
            <Icon name="notifications" size={48} color={Colors.gray400} />
            <Text style={styles.emptyText}>Geen meldingen gevonden</Text>
          </View>
        ) : (
          notifications.map(notification => (
            <View
              key={notification.id}
              style={[
                styles.notificationCard,
                notification.is_new && styles.newNotification,
              ]}
            >
              <View style={styles.notificationHeader}>
                <Icon
                  name="notifications"
                  size={20}
                  color={notification.is_new ? Colors.primary : Colors.gray400}
                />
                <Text style={styles.notificationDate}>
                  {formatDate(notification.date_notified)}
                </Text>
                {notification.is_new && (
                  <View style={styles.newBadge}>
                    <Text style={styles.newBadgeText}>Nieuw</Text>
                  </View>
                )}
              </View>
              <Text style={styles.notificationContent}>
                {notification.description}
              </Text>
            </View>
          ))
        )}
      </View>
    );
  }
}

const tabs = [
  { key: 'activity' as TabType, label: 'Activiteit', icon: 'timeline' },
  { key: 'groups' as TabType, label: 'Groepen', icon: 'groups' },
  { key: 'members' as TabType, label: 'Leden', icon: 'people' },
  { key: 'messages' as TabType, label: 'Berichten', icon: 'message' },
  {
    key: 'notifications' as TabType,
    label: 'Meldingen',
    icon: 'notifications',
  },
];

const groupFilters = [
  { key: 'active', label: 'Actief' },
  { key: 'newest', label: 'Nieuwste' },
  { key: 'alphabetical', label: 'Alfabetisch' },
];

const memberFilters = [
  { key: 'active', label: 'Actief' },
  { key: 'newest', label: 'Nieuwste' },
  { key: 'alphabetical', label: 'Alfabetisch' },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  centerContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  centerText: {
    fontSize: 16,
    color: Colors.textSecondary,
    textAlign: 'center',
    marginTop: 16,
  },
  header: {
    backgroundColor: Colors.primary,
    paddingHorizontal: 16,
    paddingTop: 16,
    paddingBottom: 12,
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: '700',
    color: Colors.white,
  },
  headerSubtitle: {
    fontSize: 14,
    color: Colors.white,
    opacity: 0.8,
    marginTop: 4,
  },
  tabContainer: {
    backgroundColor: Colors.white,
    borderBottomWidth: 1,
    borderBottomColor: Colors.border,
  },
  tab: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 12,
    marginHorizontal: 4,
    borderRadius: 20,
  },
  activeTab: {
    backgroundColor: Colors.primary,
  },
  tabText: {
    fontSize: 14,
    fontWeight: '500',
    color: Colors.gray400,
    marginLeft: 6,
  },
  activeTabText: {
    color: Colors.white,
  },
  searchContainer: {
    backgroundColor: Colors.white,
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderBottomWidth: 1,
    borderBottomColor: Colors.border,
  },
  searchBar: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: Colors.gray100,
    borderRadius: 20,
    paddingHorizontal: 16,
    paddingVertical: 8,
  },
  searchInput: {
    flex: 1,
    marginLeft: 8,
    fontSize: 14,
    color: Colors.text,
  },
  filterContainer: {
    backgroundColor: Colors.white,
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderBottomWidth: 1,
    borderBottomColor: Colors.border,
  },
  filterButton: {
    paddingHorizontal: 16,
    paddingVertical: 6,
    borderRadius: 16,
    backgroundColor: Colors.gray100,
    marginRight: 8,
  },
  activeFilterButton: {
    backgroundColor: Colors.primary,
  },
  filterButtonText: {
    fontSize: 12,
    fontWeight: '500',
    color: Colors.gray600,
  },
  activeFilterButtonText: {
    color: Colors.white,
  },
  content: {
    flex: 1,
  },
  section: {
    padding: 16,
  },
  loadingContainer: {
    alignItems: 'center',
    padding: 40,
  },
  loadingText: {
    fontSize: 14,
    color: Colors.textSecondary,
    marginTop: 8,
  },
  errorContainer: {
    alignItems: 'center',
    padding: 20,
    margin: 16,
    backgroundColor: Colors.white,
    borderRadius: 12,
  },
  errorText: {
    fontSize: 14,
    color: Colors.error,
    textAlign: 'center',
    marginVertical: 8,
  },
  retryButton: {
    backgroundColor: Colors.primary,
    borderRadius: 8,
    paddingHorizontal: 16,
    paddingVertical: 8,
    marginTop: 8,
  },
  retryButtonText: {
    fontSize: 12,
    fontWeight: '600',
    color: Colors.white,
  },
  emptyContainer: {
    alignItems: 'center',
    padding: 40,
  },
  emptyText: {
    fontSize: 16,
    color: Colors.textSecondary,
    marginTop: 12,
  },
  // Group Styles
  groupCard: {
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  groupHeader: {
    flexDirection: 'row',
    marginBottom: 12,
  },
  groupAvatar: {
    width: 50,
    height: 50,
    borderRadius: 25,
    backgroundColor: Colors.gray100,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  avatarImage: {
    width: 50,
    height: 50,
    borderRadius: 25,
  },
  groupInfo: {
    flex: 1,
  },
  groupName: {
    fontSize: 16,
    fontWeight: '600',
    color: Colors.text,
    marginBottom: 4,
  },
  groupDescription: {
    fontSize: 14,
    color: Colors.textSecondary,
    marginBottom: 4,
  },
  groupMeta: {
    fontSize: 12,
    color: Colors.textLight,
  },
  joinButton: {
    backgroundColor: Colors.primary,
    borderRadius: 8,
    paddingHorizontal: 16,
    paddingVertical: 8,
    alignSelf: 'flex-start',
  },
  joinButtonText: {
    fontSize: 12,
    fontWeight: '600',
    color: Colors.white,
  },
  // Activity Styles
  activityCard: {
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  activityHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  userAvatar: {
    width: 40,
    height: 40,
    borderRadius: 20,
    marginRight: 12,
  },
  activityInfo: {
    flex: 1,
  },
  userName: {
    fontSize: 14,
    fontWeight: '600',
    color: Colors.text,
  },
  activityDate: {
    fontSize: 12,
    color: Colors.textLight,
    marginTop: 2,
  },
  activityContent: {
    fontSize: 14,
    color: Colors.text,
    lineHeight: 20,
    marginBottom: 8,
  },
  commentCount: {
    fontSize: 12,
    color: Colors.primary,
    fontWeight: '500',
  },
  // Members Styles
  membersGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  memberCard: {
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 12,
    marginBottom: 12,
    width: (width - 48) / 2,
    alignItems: 'center',
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  memberAvatar: {
    width: 60,
    height: 60,
    borderRadius: 30,
    marginBottom: 8,
  },
  memberName: {
    fontSize: 14,
    fontWeight: '600',
    color: Colors.text,
    textAlign: 'center',
    marginBottom: 4,
  },
  memberActivity: {
    fontSize: 10,
    color: Colors.textLight,
    textAlign: 'center',
    marginBottom: 4,
  },
  memberUpdate: {
    fontSize: 10,
    color: Colors.textSecondary,
    textAlign: 'center',
  },
  // Message Styles
  messageCard: {
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  messageHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  messageInfo: {
    flex: 1,
    marginLeft: 12,
  },
  messageSender: {
    fontSize: 14,
    fontWeight: '600',
    color: Colors.text,
  },
  messageSubject: {
    fontSize: 12,
    fontWeight: '500',
    color: Colors.primary,
    marginTop: 2,
  },
  messageDate: {
    fontSize: 12,
    color: Colors.textLight,
    marginTop: 2,
  },
  messageContent: {
    fontSize: 14,
    color: Colors.text,
    lineHeight: 18,
  },
  // Notification Styles
  notificationCard: {
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 16,
    marginBottom: 8,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  newNotification: {
    borderLeftWidth: 4,
    borderLeftColor: Colors.primary,
  },
  notificationHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  notificationDate: {
    fontSize: 12,
    color: Colors.textLight,
    marginLeft: 8,
    flex: 1,
  },
  newBadge: {
    backgroundColor: Colors.primary,
    borderRadius: 10,
    paddingHorizontal: 8,
    paddingVertical: 2,
  },
  newBadgeText: {
    fontSize: 10,
    fontWeight: '600',
    color: Colors.white,
  },
  notificationContent: {
    fontSize: 14,
    color: Colors.text,
    lineHeight: 18,
  },
});
