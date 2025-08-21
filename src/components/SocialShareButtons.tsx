import React from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  ScrollView,
  Linking,
  Alert,
  Platform,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import MaterialCommunityIcons from 'react-native-vector-icons/MaterialCommunityIcons';
import { getColors } from '../constants/colors';
import { useTheme } from '../context/ThemeContext';
import NativeFeaturesService from '../services/NativeFeaturesService';
import HapticFeedbackService from '../services/HapticFeedbackService';

interface SocialShareButtonsProps {
  affiliateLink: string;
  shareText?: string;
  title?: string;
  showTitle?: boolean;
  showLabels?: boolean; // standaard icon-only
  variant?: 'default' | 'onPrimary';
  size?: 'small' | 'medium';
}

interface SocialPlatform {
  name: string;
  iconName: string;
  iconLib: 'MaterialIcons' | 'MaterialCommunityIcons';
  color: string;
  action: (link: string, text: string) => Promise<void>;
}

export default function SocialShareButtons({
  affiliateLink,
  shareText = 'Verdien geld met Chili Market! Gebruik mijn affiliate link:',
  title = 'Deel via sociale media',
  showTitle = false,
  showLabels = false,
  variant = 'default',
  size = 'small',
}: SocialShareButtonsProps) {
  const { isDark } = useTheme();
  const colors = getColors(isDark);

  const buttonSize = size === 'small' ? 44 : 52;
  const iconSize = size === 'small' ? 20 : 24;

  const handleWhatsApp = async (link: string, text: string) => {
    const message = encodeURIComponent(`${text}\n\n${link}`);
    const whatsappUrl = `whatsapp://send?text=${message}`;

    try {
      const canOpen = await Linking.canOpenURL(whatsappUrl);
      if (canOpen) {
        await Linking.openURL(whatsappUrl);
      } else {
        throw new Error('WhatsApp niet geïnstalleerd');
      }
    } catch (error) {
      // Fallback naar native share
      await NativeFeaturesService.showShareSheet(text, link);
    }
  };

  const handleFacebook = async (link: string, text: string) => {
    // Facebook deelt alleen URL via deep link
    const facebookUrl = `fb://facewebmodal/f?href=${encodeURIComponent(link)}`;

    try {
      const canOpen = await Linking.canOpenURL(facebookUrl);
      if (canOpen) {
        await Linking.openURL(facebookUrl);
      } else {
        throw new Error('Facebook niet geïnstalleerd');
      }
    } catch (error) {
      // Fallback naar native share
      await NativeFeaturesService.showShareSheet(text, link);
    }
  };

  const handleTwitter = async (link: string, text: string) => {
    const tweetText = encodeURIComponent(`${text} ${link}`);
    const twitterUrl = `twitter://post?message=${tweetText}`;

    try {
      const canOpen = await Linking.canOpenURL(twitterUrl);
      if (canOpen) {
        await Linking.openURL(twitterUrl);
      } else {
        throw new Error('X (Twitter) niet geïnstalleerd');
      }
    } catch (error) {
      // Fallback naar native share
      await NativeFeaturesService.showShareSheet(text, link);
    }
  };

  const handleLinkedIn = async (link: string, text: string) => {
    // LinkedIn gebruikt web URL voor delen
    const linkedinUrl = `https://www.linkedin.com/sharing/share-offsite/?url=${encodeURIComponent(
      link,
    )}`;

    try {
      await Linking.openURL(linkedinUrl);
    } catch (error) {
      // Fallback naar native share
      await NativeFeaturesService.showShareSheet(text, link);
    }
  };

  const handleTelegram = async (link: string, text: string) => {
    const message = encodeURIComponent(`${text}\n\n${link}`);
    const telegramUrl = `tg://msg?text=${message}`;

    try {
      const canOpen = await Linking.canOpenURL(telegramUrl);
      if (canOpen) {
        await Linking.openURL(telegramUrl);
      } else {
        throw new Error('Telegram niet geïnstalleerd');
      }
    } catch (error) {
      // Fallback naar native share
      await NativeFeaturesService.showShareSheet(text, link);
    }
  };

  const handleInstagram = async (link: string, text: string) => {
    // Instagram ondersteunt geen directe link delen via URL scheme
    // We gebruiken native share functionaliteit
    await NativeFeaturesService.showShareSheet(text, link);
  };

  const handleTikTok = async (link: string, text: string) => {
    // TikTok ondersteunt geen directe link delen via URL scheme
    // We gebruiken native share functionaliteit
    await NativeFeaturesService.showShareSheet(text, link);
  };

  const handleEmail = async (link: string, text: string) => {
    const subject = encodeURIComponent('Verdien geld met Chili Market!');
    const body = encodeURIComponent(
      `${text}\n\n${link}\n\nProbeer Chili Market vandaag nog en begin met verdienen!`,
    );
    const emailUrl = `mailto:?subject=${subject}&body=${body}`;

    try {
      await Linking.openURL(emailUrl);
    } catch (error) {
      // Fallback naar native share
      await NativeFeaturesService.showShareSheet(text, link);
    }
  };

  const socialPlatforms: SocialPlatform[] = [
    {
      name: 'WhatsApp',
      iconName: 'whatsapp',
      iconLib: 'MaterialCommunityIcons',
      color: '#25D366',
      action: handleWhatsApp,
    },
    {
      name: 'Facebook',
      iconName: 'facebook',
      iconLib: 'MaterialCommunityIcons',
      color: '#1877F2',
      action: handleFacebook,
    },
    {
      name: 'X (Twitter)',
      iconName: 'twitter',
      iconLib: 'MaterialCommunityIcons',
      color: '#1DA1F2',
      action: handleTwitter,
    },
    {
      name: 'LinkedIn',
      iconName: 'linkedin',
      iconLib: 'MaterialCommunityIcons',
      color: '#0A66C2',
      action: handleLinkedIn,
    },
    {
      name: 'Telegram',
      // Sommige builds tonen een '?' bij 'telegram' afhankelijk van fontversie
      // Gebruik een veilige fallback die overal beschikbaar is
      iconName: 'send',
      iconLib: 'MaterialCommunityIcons',
      color: '#0088CC',
      action: handleTelegram,
    },
    {
      name: 'Instagram',
      iconName: 'instagram',
      iconLib: 'MaterialCommunityIcons',
      color: '#E4405F',
      action: handleInstagram,
    },
    {
      name: 'TikTok',
      iconName: 'tiktok',
      iconLib: 'MaterialCommunityIcons',
      color: '#000000',
      action: handleTikTok,
    },
    {
      name: 'E-mail',
      iconName: 'email',
      iconLib: 'MaterialIcons',
      color: '#EA4335',
      action: handleEmail,
    },
  ];

  const handlePlatformPress = async (platform: SocialPlatform) => {
    try {
      await HapticFeedbackService.triggerForAction('button_press');
      await platform.action(affiliateLink, shareText);
    } catch (error) {
      console.error(`Error sharing via ${platform.name}:`, error);
      await HapticFeedbackService.triggerForAction('error');

      Alert.alert(
        'Delen mislukt',
        `Er ging iets mis bij het delen via ${platform.name}. Probeer opnieuw.`,
        [
          { text: 'Annuleren', style: 'cancel' },
          {
            text: 'Algemeen delen',
            onPress: async () => {
              try {
                await NativeFeaturesService.showShareSheet(
                  shareText,
                  affiliateLink,
                );
              } catch (fallbackError) {
                console.error('Fallback share also failed:', fallbackError);
              }
            },
          },
        ],
      );
    }
  };

  const renderSocialButton = (platform: SocialPlatform) => {
    const IconComponent =
      platform.iconLib === 'MaterialIcons' ? Icon : MaterialCommunityIcons;

    const isOnPrimary = variant === 'onPrimary';
    const containerBackgroundColor = isOnPrimary
      ? 'rgba(255,255,255,0.16)'
      : platform.color;
    const containerBorderColor = isOnPrimary
      ? 'rgba(255,255,255,0.28)'
      : 'transparent';
    const iconColor = '#FFFFFF';

    return (
      <TouchableOpacity
        key={platform.name}
        style={[
          styles.iconOnlyButton,
          {
            width: buttonSize,
            height: buttonSize,
            borderRadius: buttonSize / 2,
            backgroundColor: containerBackgroundColor,
            borderColor: containerBorderColor,
            shadowColor: colors.shadow,
          },
        ]}
        onPress={() => handlePlatformPress(platform)}
        activeOpacity={0.7}
        accessibilityLabel={`Delen via ${platform.name}`}
        accessibilityHint={`Deelt je affiliate link via ${platform.name}`}
      >
        <IconComponent
          name={platform.iconName}
          size={iconSize}
          color={iconColor}
        />
        {showLabels && (
          <Text
            style={[
              styles.iconLabel,
              { color: isOnPrimary ? '#FFFFFF' : colors.text },
            ]}
            numberOfLines={1}
          >
            {platform.name}
          </Text>
        )}
      </TouchableOpacity>
    );
  };

  return (
    <View style={styles.container}>
      {showTitle && !!title && (
        <Text
          style={[
            styles.title,
            { color: variant === 'onPrimary' ? '#FFFFFF' : colors.text },
          ]}
        >
          {title}
        </Text>
      )}
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.scrollContainer}
        style={styles.scrollView}
      >
        {socialPlatforms.map(renderSocialButton)}
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    marginTop: 12,
  },
  title: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 10,
    paddingHorizontal: 4,
    textAlign: 'center',
  },
  scrollView: {
    marginHorizontal: -4,
  },
  scrollContainer: {
    paddingHorizontal: 4,
    gap: 10,
  },
  iconOnlyButton: {
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: StyleSheet.hairlineWidth,
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.08,
    shadowRadius: 3,
    elevation: 2,
    marginRight: 8,
  },
  iconLabel: {
    fontSize: 10,
    fontWeight: '600',
    marginTop: 6,
  },
});
