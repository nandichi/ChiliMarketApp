import React, { useEffect, useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Dimensions,
  TextInput,
  Alert,
  ActivityIndicator,
  Image,
  RefreshControl,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import { useAuth } from '../context/AuthContext';
import { WordPressPost, WordPressCategory } from '../services/WordPressAPI';

const { width } = Dimensions.get('window');

export default function HomeScreen() {
  const { api, user } = useAuth();
  const [posts, setPosts] = useState<WordPressPost[]>([]);
  const [categories, setCategories] = useState<WordPressCategory[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [searchQuery, setSearchQuery] = useState('');

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async (isRefresh = false) => {
    try {
      if (isRefresh) {
        setRefreshing(true);
      } else {
        setLoading(true);
      }
      setError(null);

      // Laad posts en categorieën parallel
      const [postsResponse, categoriesData] = await Promise.all([
        api.getPosts({ per_page: 10 }),
        api.getCategories({ per_page: 8 }),
      ]);

      setPosts(postsResponse.data);
      setCategories(categoriesData);
    } catch (error) {
      console.error('Error loading data:', error);
      setError('Kon gegevens niet laden. Probeer opnieuw.');
    } finally {
      if (isRefresh) {
        setRefreshing(false);
      } else {
        setLoading(false);
      }
    }
  };

  const onRefresh = () => {
    loadData(true);
  };

  const handleSearch = async () => {
    if (!searchQuery.trim()) return;

    try {
      setLoading(true);
      const results = await api.search(searchQuery.trim());
      setPosts(results);
    } catch (error) {
      console.error('Search error:', error);
      Alert.alert('Fout', 'Zoeken mislukt. Probeer opnieuw.');
    } finally {
      setLoading(false);
    }
  };

  const handleCategoryPress = async (categoryId: number) => {
    try {
      setLoading(true);
      const { data } = await api.getPosts({
        categories: [categoryId],
        per_page: 20,
      });
      setPosts(data);
    } catch (error) {
      console.error('Category filter error:', error);
      Alert.alert('Fout', 'Laden van categorie mislukt.');
    } finally {
      setLoading(false);
    }
  };

  const stripHtml = (html: string) => {
    return html.replace(/<[^>]*>/g, '').trim();
  };

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('nl-NL', {
      day: 'numeric',
      month: 'short',
      year: 'numeric',
    });
  };

  const handleWebsitePress = () => {
    Alert.alert(
      'Naar Website',
      'Wil je naar de volledige Chili Market website gaan?',
      [
        { text: 'Annuleren', style: 'cancel' },
        {
          text: 'Ga door',
          onPress: () => {
            // Hier kun je navigeren naar WebViewScreen of externe browser
            console.log('Navigating to full website...');
          },
        },
      ],
    );
  };

  return (
    <ScrollView
      style={styles.container}
      showsVerticalScrollIndicator={false}
      refreshControl={
        <RefreshControl
          refreshing={refreshing}
          onRefresh={onRefresh}
          colors={[Colors.primary]}
          tintColor={Colors.primary}
        />
      }
    >
      {/* Search Bar */}
      <View style={styles.searchContainer}>
        <View style={styles.searchBar}>
          <Icon name="search" size={20} color={Colors.gray400} />
          <TextInput
            style={styles.searchInput}
            placeholder="Zoek naar producten..."
            placeholderTextColor={Colors.gray400}
            value={searchQuery}
            onChangeText={setSearchQuery}
            onSubmitEditing={handleSearch}
            returnKeyType="search"
          />
          <TouchableOpacity style={styles.filterButton} onPress={handleSearch}>
            <Icon name="search" size={20} color={Colors.primary} />
          </TouchableOpacity>
        </View>
      </View>

      {/* Header with Logo */}
      <View style={styles.headerSection}>
        <Image
          source={require('../../ChiliMarket-Logo.png')}
          style={styles.headerLogo}
          resizeMode="contain"
        />
      </View>

      {/* Welcome Section */}
      <View style={styles.welcomeSection}>
        <Text style={styles.welcomeTitle}>
          Welkom{' '}
          {user?.name
            ? `terug, ${user.name.split(' ')[0]}`
            : 'bij Chili Market'}
        </Text>
        <Text style={styles.welcomeSubtitle}>
          Ontdek de beste deals en verse producten
        </Text>
      </View>

      {/* Loading State */}
      {loading && (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={Colors.primary} />
          <Text style={styles.loadingText}>Laden...</Text>
        </View>
      )}

      {/* Error State */}
      {error && (
        <View style={styles.errorContainer}>
          <Icon name="error" size={24} color={Colors.error} />
          <Text style={styles.errorText}>{error}</Text>
          <TouchableOpacity style={styles.retryButton} onPress={loadData}>
            <Text style={styles.retryButtonText}>Opnieuw proberen</Text>
          </TouchableOpacity>
        </View>
      )}

      {/* Website Access Button */}
      <View style={styles.websiteSection}>
        <TouchableOpacity
          style={styles.websiteButton}
          onPress={handleWebsitePress}
        >
          <View style={styles.websiteButtonContent}>
            <Icon name="language" size={24} color={Colors.white} />
            <Text style={styles.websiteButtonText}>
              Volledige Website Bekijken
            </Text>
            <Icon name="arrow-forward" size={20} color={Colors.white} />
          </View>
        </TouchableOpacity>
      </View>

      {/* Categories Section */}
      <View style={styles.section}>
        <View style={styles.sectionHeader}>
          <Text style={styles.sectionTitle}>Categorieën</Text>
          <TouchableOpacity>
            <Text style={styles.seeAllText}>Zie alles</Text>
          </TouchableOpacity>
        </View>

        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          style={styles.categoriesScroll}
        >
          {categories.map(category => (
            <TouchableOpacity
              key={category.id}
              style={styles.categoryCard}
              onPress={() => handleCategoryPress(category.id)}
            >
              <View
                style={[
                  styles.categoryIcon,
                  { backgroundColor: Colors.primary },
                ]}
              >
                <Icon name="category" size={30} color={Colors.white} />
              </View>
              <Text style={styles.categoryText}>{category.name}</Text>
              <Text style={styles.categoryCount}>{category.count} items</Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>

      {/* Recent Posts/Products */}
      {!loading && posts.length > 0 && (
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>Laatste Berichten</Text>
            <TouchableOpacity onPress={loadData}>
              <Text style={styles.seeAllText}>Vernieuwen</Text>
            </TouchableOpacity>
          </View>

          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            style={styles.productsScroll}
          >
            {posts.map(post => (
              <TouchableOpacity key={post.id} style={styles.productCard}>
                {post._embedded?.['wp:featuredmedia']?.[0]?.source_url ? (
                  <Image
                    source={{
                      uri: post._embedded['wp:featuredmedia'][0].source_url,
                    }}
                    style={styles.productImage}
                    resizeMode="cover"
                  />
                ) : (
                  <View style={styles.productImagePlaceholder}>
                    <Icon name="article" size={40} color={Colors.primary} />
                  </View>
                )}
                <Text style={styles.productName} numberOfLines={2}>
                  {stripHtml(post.title.rendered)}
                </Text>
                <Text style={styles.productDescription} numberOfLines={3}>
                  {stripHtml(post.excerpt.rendered)}
                </Text>
                <Text style={styles.productDate}>{formatDate(post.date)}</Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        </View>
      )}

      {/* Quick Actions */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Snelle Acties</Text>
        <View style={styles.quickActionsGrid}>
          {quickActions.map((action, index) => (
            <TouchableOpacity key={index} style={styles.quickActionCard}>
              <View
                style={[
                  styles.quickActionIcon,
                  { backgroundColor: action.color },
                ]}
              >
                <Icon name={action.icon} size={24} color={Colors.white} />
              </View>
              <Text style={styles.quickActionText}>{action.name}</Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>

      <View style={styles.bottomSpacing} />
    </ScrollView>
  );
}

const categories = [
  { name: 'Groenten', icon: 'eco', color: Colors.success },
  { name: 'Fruit', icon: 'local-florist', color: Colors.accent },
  { name: 'Vlees', icon: 'restaurant', color: Colors.primary },
  { name: 'Zuivel', icon: 'local-drink', color: Colors.info },
  { name: 'Brood', icon: 'bakery-dining', color: Colors.warning },
];

const featuredProducts = [
  { name: 'Verse Tomaten', price: '€2,99/kg' },
  { name: 'Biologische Bananen', price: '€1,89/kg' },
  { name: 'Verse Basilicum', price: '€1,49' },
  { name: 'Kerstomaatjes', price: '€3,49/bakje' },
];

const quickActions = [
  { name: 'Bestellingen', icon: 'receipt', color: Colors.primary },
  { name: 'Favorieten', icon: 'favorite', color: Colors.error },
  { name: 'Aanbiedingen', icon: 'local-offer', color: Colors.warning },
  { name: 'Support', icon: 'help', color: Colors.info },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  searchContainer: {
    backgroundColor: Colors.primary,
    paddingHorizontal: 16,
    paddingBottom: 16,
    paddingTop: 8,
  },
  searchBar: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: Colors.white,
    borderRadius: 25,
    paddingHorizontal: 16,
    paddingVertical: 12,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  searchInput: {
    flex: 1,
    marginLeft: 12,
    fontSize: 16,
    color: Colors.text,
  },
  filterButton: {
    marginLeft: 12,
  },
  headerSection: {
    backgroundColor: Colors.white,
    paddingVertical: 16,
    paddingHorizontal: 20,
    alignItems: 'center',
    borderBottomWidth: 1,
    borderBottomColor: Colors.gray100,
  },
  headerLogo: {
    width: 120,
    height: 60,
  },
  welcomeSection: {
    padding: 20,
    alignItems: 'center',
  },
  welcomeTitle: {
    fontSize: 24,
    fontWeight: '700',
    color: Colors.text,
    marginBottom: 8,
  },
  welcomeSubtitle: {
    fontSize: 16,
    color: Colors.textSecondary,
    textAlign: 'center',
  },
  websiteSection: {
    paddingHorizontal: 16,
    marginBottom: 24,
  },
  websiteButton: {
    backgroundColor: Colors.secondary,
    borderRadius: 12,
    padding: 16,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 8,
    elevation: 6,
  },
  websiteButtonContent: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  websiteButtonText: {
    flex: 1,
    fontSize: 16,
    fontWeight: '600',
    color: Colors.white,
    marginLeft: 12,
  },
  section: {
    marginBottom: 24,
  },
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 16,
    marginBottom: 16,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: '600',
    color: Colors.text,
  },
  seeAllText: {
    fontSize: 14,
    color: Colors.primary,
    fontWeight: '500',
  },
  categoriesScroll: {
    paddingLeft: 16,
  },
  categoryCard: {
    alignItems: 'center',
    marginRight: 20,
    width: 80,
  },
  categoryIcon: {
    width: 60,
    height: 60,
    borderRadius: 30,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 8,
  },
  categoryText: {
    fontSize: 12,
    fontWeight: '500',
    color: Colors.text,
    textAlign: 'center',
  },
  categoryCount: {
    fontSize: 10,
    color: Colors.textSecondary,
    textAlign: 'center',
    marginTop: 2,
  },
  loadingContainer: {
    alignItems: 'center',
    padding: 40,
  },
  loadingText: {
    fontSize: 16,
    color: Colors.textSecondary,
    marginTop: 10,
  },
  errorContainer: {
    alignItems: 'center',
    padding: 20,
    margin: 16,
    backgroundColor: Colors.white,
    borderRadius: 12,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  errorText: {
    fontSize: 16,
    color: Colors.error,
    textAlign: 'center',
    marginVertical: 10,
  },
  retryButton: {
    backgroundColor: Colors.primary,
    borderRadius: 8,
    paddingHorizontal: 20,
    paddingVertical: 10,
    marginTop: 10,
  },
  retryButtonText: {
    fontSize: 14,
    fontWeight: '600',
    color: Colors.white,
  },
  productsScroll: {
    paddingLeft: 16,
  },
  productCard: {
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 12,
    marginRight: 16,
    width: 150,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  productImage: {
    width: '100%',
    height: 80,
    borderRadius: 8,
    marginBottom: 8,
  },
  productImagePlaceholder: {
    width: '100%',
    height: 80,
    backgroundColor: Colors.gray100,
    borderRadius: 8,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 8,
  },
  productDescription: {
    fontSize: 12,
    color: Colors.textSecondary,
    marginBottom: 4,
    lineHeight: 16,
  },
  productDate: {
    fontSize: 10,
    color: Colors.textLight,
    marginTop: 'auto',
  },
  productName: {
    fontSize: 14,
    fontWeight: '600',
    color: Colors.text,
    marginBottom: 4,
  },
  productPrice: {
    fontSize: 14,
    color: Colors.primary,
    fontWeight: '600',
    marginBottom: 8,
  },
  addToCartButton: {
    backgroundColor: Colors.primary,
    borderRadius: 16,
    width: 32,
    height: 32,
    justifyContent: 'center',
    alignItems: 'center',
    alignSelf: 'flex-end',
  },
  quickActionsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    paddingHorizontal: 16,
    justifyContent: 'space-between',
  },
  quickActionCard: {
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 16,
    alignItems: 'center',
    width: (width - 48) / 2,
    marginBottom: 12,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  quickActionIcon: {
    width: 48,
    height: 48,
    borderRadius: 24,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 8,
  },
  quickActionText: {
    fontSize: 14,
    fontWeight: '500',
    color: Colors.text,
    textAlign: 'center',
  },
  bottomSpacing: {
    height: 20,
  },
});
