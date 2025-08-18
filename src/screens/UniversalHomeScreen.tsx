import React, { useCallback, useEffect, useMemo, useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Dimensions,
  TextInput,
  Image,
  ActivityIndicator,
  RefreshControl,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { useNavigation } from '@react-navigation/native';
import { Colors, getColors } from '../constants/colors';
import { useTheme } from '../context/ThemeContext';
import { useAuth } from '../context/AuthContext';
import HapticFeedbackService from '../services/HapticFeedbackService';
import { WordPressPost, WordPressCategory } from '../services/WordPressAPI';

const { width } = Dimensions.get('window');

const BASE_URL = 'https://chili-market.com';

export default function UniversalHomeScreen() {
  const navigation = useNavigation();
  const { isDark } = useTheme();
  const colors = getColors(isDark);
  const { user, api } = useAuth();

  const [searchQuery, setSearchQuery] = useState('');
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [posts, setPosts] = useState<WordPressPost[]>([]);
  const [categories, setCategories] = useState<WordPressCategory[]>([]);

  useEffect(() => {
    loadData();
  }, []);

  const onRefresh = useCallback(() => {
    loadData(true);
  }, []);

  const loadData = useCallback(
    async (isRefresh = false) => {
      try {
        setError(null);
        if (isRefresh) setRefreshing(true);
        else setLoading(true);

        const [postsResponse, cats] = await Promise.all([
          api.getPosts({ per_page: 8 }),
          api.getCategories({ per_page: 12, hide_empty: true }),
        ]);

        setPosts(postsResponse.data);
        setCategories(cats);
      } catch (e) {
        setError('Kon inhoud niet laden. Probeer opnieuw.');
      } finally {
        if (isRefresh) setRefreshing(false);
        else setLoading(false);
      }
    },
    [api],
  );

  const quickLinks = useMemo(
    () => [
      {
        name: 'Home',
        icon: 'home',
        url: `${BASE_URL}/`,
        color: colors.primary,
      },
      {
        name: 'Marktplaats',
        icon: 'store',
        url: `${BASE_URL}/marktplaats/`,
        color: colors.accent,
      },
      {
        name: 'Nieuws Feed',
        icon: 'article',
        url: `${BASE_URL}/nieuws-feed/`,
        color: colors.info,
      },
      {
        name: 'Leden',
        icon: 'people',
        url: `${BASE_URL}/leden/`,
        color: colors.secondary,
      },
      {
        name: 'Categorieën',
        icon: 'view-module',
        url: `${BASE_URL}/?post_type=post`,
        color: colors.success,
      },
      {
        name: 'Contact',
        icon: 'contact-support',
        url: `${BASE_URL}/contact/`,
        color: colors.warning,
      },
    ],
    [colors],
  );

  const openInWebView = useCallback(
    async (url: string, title?: string) => {
      await HapticFeedbackService.triggerForAction('button_press');
      // Navigeer naar de parent stack om de WebView boven de tabs te openen
      const parent = (navigation as any).getParent?.();
      if (parent) {
        parent.navigate('WebView', { url, title });
      } else {
        // Fallback: probeer directe navigatie
        (navigation as any).navigate('WebView', { url, title });
      }
    },
    [navigation],
  );

  const handleSearch = useCallback(() => {
    const q = searchQuery.trim();
    if (!q) return;
    const url = `${BASE_URL}/?s=${encodeURIComponent(q)}`;
    openInWebView(url, `Zoeken: ${q}`);
  }, [searchQuery, openInWebView]);

  const getPostImage = (post: WordPressPost): string | undefined => {
    return post._embedded?.['wp:featuredmedia']?.[0]?.source_url;
  };

  const stripHtml = (html: string) => html.replace(/<[^>]*>/g, '').trim();

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('nl-NL', {
      day: 'numeric',
      month: 'short',
      year: 'numeric',
    });
  };

  return (
    <ScrollView
      style={[styles.container, { backgroundColor: colors.background }]}
      refreshControl={
        <RefreshControl
          refreshing={refreshing}
          onRefresh={onRefresh}
          colors={[colors.primary]}
          tintColor={colors.primary}
        />
      }
      showsVerticalScrollIndicator={false}
    >
      <View style={[styles.header, { backgroundColor: colors.card }]}>
        <Image
          source={require('../../ChiliMarket-Logo.png')}
          style={styles.logo}
          resizeMode="contain"
        />
        <Text style={[styles.welcomeTitle, { color: colors.text }]}>
          Welkom{' '}
          {user?.name
            ? `terug, ${user.name.split(' ')[0]}`
            : 'bij Chili Market'}
        </Text>
        <Text style={[styles.welcomeSubtitle, { color: colors.textSecondary }]}>
          Alles van Chili direct binnen handbereik
        </Text>
      </View>

      <View
        style={[
          styles.searchContainer,
          { backgroundColor: colors.primaryLight },
        ]}
      >
        <View
          style={[
            styles.searchBar,
            { backgroundColor: colors.card, shadowColor: colors.shadow },
          ]}
        >
          <Icon name="search" size={20} color={colors.gray400} />
          <TextInput
            style={[styles.searchInput, { color: colors.text }]}
            placeholder="Zoek op de website..."
            placeholderTextColor={colors.gray400}
            value={searchQuery}
            onChangeText={setSearchQuery}
            onSubmitEditing={handleSearch}
            returnKeyType="search"
          />
          <TouchableOpacity
            onPress={handleSearch}
            style={[styles.searchButton, { backgroundColor: colors.primary }]}
          >
            <Icon name="search" size={18} color={colors.white} />
          </TouchableOpacity>
        </View>
      </View>

      <View style={styles.section}>
        <Text style={[styles.sectionTitleCentered, { color: colors.text }]}>
          Snel naar
        </Text>
        <View style={styles.quickGrid}>
          {quickLinks.map(link => (
            <TouchableOpacity
              key={link.name}
              style={[
                styles.quickCard,
                { backgroundColor: colors.card, shadowColor: Colors.shadow },
              ]}
              onPress={() => openInWebView(link.url, link.name)}
              activeOpacity={0.85}
            >
              <View style={[styles.quickIcon, { backgroundColor: link.color }]}>
                <Icon name={link.icon as any} size={26} color={Colors.white} />
              </View>
              <Text style={[styles.quickText, { color: colors.text }]}>
                {link.name}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>

      {loading && (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={colors.primary} />
          <Text style={[styles.loadingText, { color: colors.textSecondary }]}>
            Inhoud laden...
          </Text>
        </View>
      )}

      {!!error && (
        <View
          style={[
            styles.errorContainer,
            { backgroundColor: colors.card, shadowColor: Colors.shadow },
          ]}
        >
          <Icon name="error-outline" size={22} color={Colors.error} />
          <Text style={[styles.errorText, { color: Colors.error }]}>
            {error}
          </Text>
          <TouchableOpacity
            style={[styles.retryButton, { backgroundColor: colors.primary }]}
            onPress={() => loadData()}
          >
            <Text style={styles.retryText}>Opnieuw proberen</Text>
          </TouchableOpacity>
        </View>
      )}

      {!loading && posts.length > 0 && (
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <Text style={[styles.sectionTitle, { color: colors.text }]}>
              Laatste van de site
            </Text>
            <TouchableOpacity
              onPress={() => openInWebView(`${BASE_URL}/`, 'Chili Market')}
            >
              <Text style={[styles.seeAll, { color: colors.primary }]}>
                Alles
              </Text>
            </TouchableOpacity>
          </View>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            style={styles.horizontalScroll}
          >
            {posts.map(post => (
              <TouchableOpacity
                key={post.id}
                style={[
                  styles.postCard,
                  { backgroundColor: colors.card, shadowColor: Colors.shadow },
                ]}
                onPress={() =>
                  openInWebView(post.link, stripHtml(post.title.rendered))
                }
                activeOpacity={0.9}
              >
                {getPostImage(post) ? (
                  <Image
                    source={{ uri: getPostImage(post) }}
                    style={styles.postImage}
                    resizeMode="cover"
                  />
                ) : (
                  <View
                    style={[
                      styles.postImagePlaceholder,
                      { backgroundColor: Colors.gray100 },
                    ]}
                  >
                    <Icon name="article" size={40} color={colors.primary} />
                  </View>
                )}
                <Text
                  style={[styles.postTitle, { color: colors.text }]}
                  numberOfLines={2}
                >
                  {stripHtml(post.title.rendered)}
                </Text>
                <Text
                  style={[styles.postExcerpt, { color: colors.textSecondary }]}
                  numberOfLines={3}
                >
                  {stripHtml(post.excerpt.rendered)}
                </Text>
                <Text style={[styles.postDate, { color: colors.textLight }]}>
                  {formatDate(post.date)}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        </View>
      )}

      {!loading && categories.length > 0 && (
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <Text style={[styles.sectionTitle, { color: colors.text }]}>
              Populaire categorieën
            </Text>
            <TouchableOpacity
              onPress={() =>
                openInWebView(`${BASE_URL}/?post_type=post`, 'Categorieën')
              }
            >
              <Text style={[styles.seeAll, { color: colors.primary }]}>
                Alles
              </Text>
            </TouchableOpacity>
          </View>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            style={styles.horizontalScroll}
          >
            {categories.map(cat => (
              <TouchableOpacity
                key={cat.id}
                style={[
                  styles.catChip,
                  { backgroundColor: colors.card, borderColor: colors.border },
                ]}
                onPress={() =>
                  openInWebView(`${BASE_URL}/?cat=${cat.id}`, cat.name)
                }
              >
                <Icon name="label" size={16} color={colors.primary} />
                <Text
                  style={[styles.catText, { color: colors.text }]}
                  numberOfLines={1}
                >
                  {cat.name}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        </View>
      )}

      <View style={styles.bottomSpace} />
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    alignItems: 'center',
    paddingVertical: 24,
    paddingHorizontal: 20,
    borderBottomWidth: 1,
    borderBottomColor: Colors.gray100,
  },
  logo: {
    width: 140,
    height: 70,
    marginBottom: 4,
  },
  welcomeTitle: {
    fontSize: 24,
    fontWeight: '700',
    textAlign: 'center',
    marginBottom: 4,
    letterSpacing: 0.3,
  },
  welcomeSubtitle: {
    fontSize: 15,
    textAlign: 'center',
    lineHeight: 22,
    opacity: 0.8,
  },
  searchContainer: {
    paddingHorizontal: 20,
    paddingVertical: 16,
    backgroundColor: Colors.primaryLight,
  },
  searchBar: {
    flexDirection: 'row',
    alignItems: 'center',
    borderRadius: 16,
    paddingHorizontal: 16,
    paddingVertical: 14,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 3,
  },
  searchInput: {
    flex: 1,
    marginHorizontal: 12,
    fontSize: 16,
    fontWeight: '500',
  },
  searchButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    alignItems: 'center',
    justifyContent: 'center',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.2,
    shadowRadius: 2,
    elevation: 2,
  },
  section: {
    marginTop: 24,
  },
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    marginBottom: 16,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: '700',
    letterSpacing: 0.2,
  },
  sectionTitleCentered: {
    fontSize: 20,
    fontWeight: '700',
    letterSpacing: 0.2,
    textAlign: 'center',
    marginBottom: 8,
    paddingHorizontal: 20,
  },
  seeAll: {
    fontSize: 14,
    fontWeight: '600',
    letterSpacing: 0.1,
  },
  quickGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    gap: 12,
  },
  quickCard: {
    width: (width - 52) / 2,
    aspectRatio: 1.2,
    borderRadius: 16,
    padding: 16,
    alignItems: 'center',
    justifyContent: 'center',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 4,
  },
  quickIcon: {
    width: 56,
    height: 56,
    borderRadius: 28,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 12,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.15,
    shadowRadius: 4,
    elevation: 2,
  },
  quickText: {
    fontSize: 14,
    fontWeight: '600',
    textAlign: 'center',
    letterSpacing: 0.1,
  },
  loadingContainer: {
    alignItems: 'center',
    paddingVertical: 40,
    paddingHorizontal: 20,
  },
  loadingText: {
    marginTop: 12,
    fontSize: 15,
    fontWeight: '500',
  },
  errorContainer: {
    marginHorizontal: 20,
    marginTop: 16,
    borderRadius: 16,
    padding: 20,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 3,
    alignItems: 'center',
  },
  errorText: {
    marginVertical: 12,
    fontSize: 15,
    textAlign: 'center',
    lineHeight: 22,
  },
  retryButton: {
    borderRadius: 12,
    paddingHorizontal: 20,
    paddingVertical: 12,
    marginTop: 4,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.15,
    shadowRadius: 4,
    elevation: 2,
  },
  retryText: {
    color: Colors.white,
    fontWeight: '600',
    fontSize: 14,
    letterSpacing: 0.1,
  },
  horizontalScroll: {
    paddingLeft: 20,
  },
  postCard: {
    width: 200,
    borderRadius: 16,
    padding: 16,
    marginRight: 16,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 4,
  },
  postImage: {
    width: '100%',
    height: 120,
    borderRadius: 12,
    marginBottom: 12,
  },
  postImagePlaceholder: {
    width: '100%',
    height: 120,
    borderRadius: 12,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 12,
  },
  postTitle: {
    fontSize: 15,
    fontWeight: '700',
    marginBottom: 6,
    lineHeight: 20,
    letterSpacing: 0.1,
  },
  postExcerpt: {
    fontSize: 13,
    lineHeight: 18,
    marginBottom: 8,
    opacity: 0.8,
  },
  postDate: {
    fontSize: 12,
    fontWeight: '500',
    opacity: 0.6,
  },
  catChip: {
    flexDirection: 'row',
    alignItems: 'center',
    borderWidth: 1.5,
    borderRadius: 24,
    paddingHorizontal: 16,
    paddingVertical: 10,
    marginRight: 12,
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 2,
    elevation: 1,
  },
  catText: {
    marginLeft: 8,
    maxWidth: 160,
    fontSize: 13,
    fontWeight: '600',
    letterSpacing: 0.1,
  },
  bottomSpace: {
    height: 32,
  },
});
