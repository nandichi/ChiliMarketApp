import React, { useCallback, useMemo, useRef, useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Dimensions,
  TextInput,
  Image,
  Pressable,
  Platform,
  Animated,
  Alert,
} from 'react-native';
import Clipboard from '@react-native-clipboard/clipboard';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { useNavigation } from '@react-navigation/native';
import { Colors, getColors } from '../constants/colors';
import { useTheme } from '../context/ThemeContext';
import { useAuth } from '../context/AuthContext';
import HapticFeedbackService from '../services/HapticFeedbackService';
import NativeFeaturesService from '../services/NativeFeaturesService';
import SocialShareButtons from '../components/SocialShareButtons';

const { width } = Dimensions.get('window');

const BASE_URL = 'https://chili-market.com';

export default function UniversalHomeScreen() {
  const navigation = useNavigation();
  const { isDark } = useTheme();
  const colors = getColors(isDark);
  const { user } = useAuth();

  const [searchQuery, setSearchQuery] = useState('');

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
        name: 'Advertenties',
        icon: 'campaign',
        url: `${BASE_URL}/advertenties/`,
        color: colors.warning,
      },
      {
        name: 'Affiliate Dashboard',
        icon: 'trending-up',
        url: `${BASE_URL}/affiliate-dashboard/?from=network`,
        color: colors.success,
      },
      {
        name: 'Categorieën',
        icon: 'view-module',
        url: `${BASE_URL}/?post_type=post`,
        color: colors.info,
      },
      {
        name: 'Contact',
        icon: 'contact-support',
        url: `${BASE_URL}/contact/`,
        color: colors.error,
      },
    ],
    [colors],
  );

  const QuickLinkCard: React.FC<{
    link: { name: string; icon: string; url: string; color: string };
  }> = ({ link }) => {
    const scaleValue = useRef(new Animated.Value(1)).current;

    const handlePressIn = () => {
      Animated.spring(scaleValue, {
        toValue: 0.97,
        useNativeDriver: true,
        speed: 20,
        bounciness: 6,
      }).start();
    };

    const handlePressOut = () => {
      Animated.spring(scaleValue, {
        toValue: 1,
        useNativeDriver: true,
        speed: 20,
        bounciness: 6,
      }).start();
    };

    const handlePress = () => {
      openInWebView(link.url, link.name);
    };

    return (
      <Pressable
        onPress={handlePress}
        onPressIn={handlePressIn}
        onPressOut={handlePressOut}
        android_ripple={{ color: colors.gray200 }}
        style={({ pressed }) => [
          styles.quickCard,
          {
            backgroundColor: colors.card,
            shadowColor: colors.shadow,
            borderColor: isDark ? colors.borderLight : colors.border,
            opacity: pressed ? 0.98 : 1,
          },
        ]}
        accessibilityRole="button"
        accessibilityLabel={link.name}
      >
        <Animated.View
          style={[
            styles.quickCardInner,
            { transform: [{ scale: scaleValue }] },
          ]}
        >
          <View
            style={[
              styles.quickIcon,
              { backgroundColor: link.color, shadowColor: colors.shadow },
            ]}
          >
            <Icon name={link.icon as any} size={26} color={Colors.white} />
          </View>
          <Text
            style={[styles.quickText, { color: colors.text }]}
            numberOfLines={1}
          >
            {link.name}
          </Text>
          <Icon
            name="chevron-right"
            size={18}
            color={colors.textSecondary}
            style={styles.quickChevron}
          />
        </Animated.View>
      </Pressable>
    );
  };

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

  const handleCopyAffiliateLink = useCallback(async () => {
    if (!user) return;

    try {
      // Gebruik username of name als fallback
      const referralCode = user.username || user.name || 'user';
      const affiliateLink = `https://chili-market.com?r=${referralCode}`;

      // Kopieer naar clipboard
      await Clipboard.setString(affiliateLink);

      // Trigger success haptic
      await HapticFeedbackService.triggerForAction('success');

      Alert.alert(
        'Affiliate Link Gekopieerd!',
        `Je persoonlijke link is gekopieerd naar het klembord:\n\n${affiliateLink}\n\nDeel deze link met vrienden en verdien commissie op hun aankopen!`,
      );
    } catch (error) {
      console.error('Failed to copy affiliate link:', error);
      await HapticFeedbackService.triggerForAction('error');
      Alert.alert(
        'Fout',
        'Er is een fout opgetreden bij het kopiëren van je affiliate link. Probeer opnieuw.',
      );
    }
  }, [user]);

  return (
    <ScrollView
      style={[styles.container, { backgroundColor: colors.background }]}
      contentContainerStyle={styles.scrollContent}
      showsVerticalScrollIndicator={false}
    >
      <View
        style={[
          styles.header,
          {
            backgroundColor: colors.card,
            borderBottomColor: isDark ? colors.border : Colors.gray100,
          },
        ]}
      >
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
          { backgroundColor: isDark ? colors.surface : colors.primaryLight },
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

      {/* Affiliate Link Section */}
      {user && (
        <View style={styles.affiliateSection}>
          <View
            style={[
              styles.affiliateCard,
              isDark
                ? {
                    backgroundColor: colors.card,
                    borderWidth: 1,
                    borderColor: colors.border,
                  }
                : { backgroundColor: colors.primary },
            ]}
          >
            <View style={styles.affiliateHeader}>
              <Icon
                name="share"
                size={28}
                color={isDark ? colors.primary : colors.white}
              />
              <View style={styles.affiliateHeaderText}>
                <Text
                  style={[
                    styles.affiliateTitle,
                    { color: isDark ? colors.text : colors.white },
                  ]}
                >
                  Verdien Geld met Affiliate Links!
                </Text>
                <Text
                  style={[
                    styles.affiliateSubtitle,
                    { color: isDark ? colors.textSecondary : colors.white },
                  ]}
                >
                  Deel je persoonlijke link en verdien commissie
                </Text>
              </View>
            </View>

            <View
              style={[
                styles.affiliateLink,
                {
                  backgroundColor: isDark ? colors.surface : colors.white,
                  borderColor: isDark ? colors.border : 'rgba(0,0,0,0.05)',
                },
              ]}
            >
              <Text
                style={[
                  styles.affiliateLinkText,
                  { color: isDark ? colors.text : colors.textSecondary },
                ]}
                numberOfLines={1}
                ellipsizeMode="middle"
              >
                https://chili-market.com?r=
                {user.username || user.name || 'user'}
              </Text>
            </View>

            <TouchableOpacity
              style={[
                styles.affiliateButton,
                {
                  backgroundColor: isDark ? colors.surface : colors.white,
                  borderWidth: isDark ? 1 : 0,
                  borderColor: isDark ? colors.border : undefined,
                },
              ]}
              onPress={handleCopyAffiliateLink}
              activeOpacity={0.8}
            >
              <Icon name="content-copy" size={18} color={colors.primary} />
              <Text
                style={[styles.affiliateButtonText, { color: colors.primary }]}
              >
                Kopieer Affiliate Link
              </Text>
            </TouchableOpacity>

            <SocialShareButtons
              affiliateLink={`https://chili-market.com?r=${
                user.username || user.name || 'user'
              }`}
              shareText="Verdien geld met Chili Market! Gebruik mijn affiliate link"
              variant={isDark ? 'default' : 'onPrimary'}
              showTitle={false}
              showLabels={false}
              size="small"
            />
          </View>
        </View>
      )}

      <View style={styles.section}>
        <Text style={[styles.sectionTitleCentered, { color: colors.text }]}>
          Snel naar
        </Text>
        <Text
          style={[
            styles.sectionSubtitleCentered,
            { color: colors.textSecondary },
          ]}
        >
          Handige snelkoppelingen
        </Text>
        <View style={styles.quickGrid}>
          {quickLinks.map(link => (
            <QuickLinkCard key={link.name} link={link} />
          ))}
        </View>
      </View>

      <View style={styles.bottomSpace} />
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  scrollContent: {
    flexGrow: 1,
    paddingBottom: 120,
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
    marginBottom: 32,
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
  sectionSubtitleCentered: {
    fontSize: 13,
    fontWeight: '500',
    textAlign: 'center',
    opacity: 0.8,
    marginBottom: 10,
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
    paddingBottom: 20,
  },
  quickCard: {
    width: (width - 52) / 2,
    aspectRatio: 1.1,
    borderRadius: 16,
    padding: 16,
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: StyleSheet.hairlineWidth,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 4,
    marginBottom: 12,
  },
  quickCardInner: {
    width: '100%',
    height: '100%',
    alignItems: 'center',
    justifyContent: 'center',
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
  quickChevron: {
    position: 'absolute',
    right: 12,
    bottom: 12,
  },

  bottomSpace: {
    height: 60,
  },
  // Affiliate Link Styles
  affiliateSection: {
    paddingHorizontal: 20,
    marginTop: 16,
    marginBottom: 8,
  },
  affiliateCard: {
    borderRadius: 16,
    padding: 20,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 12,
    elevation: 8,
  },
  affiliateHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  affiliateHeaderText: {
    marginLeft: 12,
    flex: 1,
  },
  affiliateTitle: {
    fontSize: 18,
    fontWeight: '700',
    marginBottom: 4,
    letterSpacing: 0.3,
  },
  affiliateSubtitle: {
    fontSize: 14,
    fontWeight: '500',
    opacity: 0.9,
    lineHeight: 20,
  },
  affiliateLink: {
    borderRadius: 12,
    padding: 14,
    marginBottom: 16,
    borderWidth: 1,
    borderColor: 'rgba(0,0,0,0.05)',
  },
  affiliateLinkText: {
    fontSize: 13,
    fontFamily: Platform.OS === 'ios' ? 'Menlo' : 'monospace',
    textAlign: 'center',
    fontWeight: '500',
  },
  affiliateButton: {
    borderRadius: 12,
    paddingVertical: 14,
    paddingHorizontal: 20,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.15,
    shadowRadius: 6,
    elevation: 4,
  },
  affiliateButtonText: {
    fontSize: 15,
    fontWeight: '600',
    marginLeft: 8,
    letterSpacing: 0.2,
  },
});
