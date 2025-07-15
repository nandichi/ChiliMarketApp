import React, { useEffect, useRef } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Animated,
  Image,
  Dimensions,
} from 'react-native';
import { Colors } from '../constants/colors';

interface SplashScreenProps {
  onAnimationEnd: () => void;
}

const { width, height } = Dimensions.get('window');

export default function SplashScreen({ onAnimationEnd }: SplashScreenProps) {
  const logoScale = useRef(new Animated.Value(0)).current;
  const logoOpacity = useRef(new Animated.Value(0)).current;
  const logoRotation = useRef(new Animated.Value(0)).current;
  const textOpacity = useRef(new Animated.Value(0)).current;
  const textTranslateY = useRef(new Animated.Value(30)).current;
  const backgroundOpacity = useRef(new Animated.Value(0)).current;
  const pulseAnimation = useRef(new Animated.Value(1)).current;
  useEffect(() => {
    // Start pulsing animation for logo background
    const pulseLoop = Animated.loop(
      Animated.sequence([
        Animated.timing(pulseAnimation, {
          toValue: 1.05,
          duration: 2000,
          useNativeDriver: true,
        }),
        Animated.timing(pulseAnimation, {
          toValue: 1,
          duration: 2000,
          useNativeDriver: true,
        }),
      ]),
    );

    // Start the main animation sequence
    Animated.sequence([
      // Background fade in
      Animated.timing(backgroundOpacity, {
        toValue: 1,
        duration: 300,
        useNativeDriver: true,
      }),
      // Logo animations
      Animated.parallel([
        // Logo scale with spring effect
        Animated.spring(logoScale, {
          toValue: 1,
          tension: 40,
          friction: 4,
          useNativeDriver: true,
        }),
        // Logo fade in
        Animated.timing(logoOpacity, {
          toValue: 1,
          duration: 1000,
          useNativeDriver: true,
        }),
        // Subtle rotation
        Animated.timing(logoRotation, {
          toValue: 1,
          duration: 1200,
          useNativeDriver: true,
        }),
      ]),
      // Text animations
      Animated.parallel([
        Animated.timing(textOpacity, {
          toValue: 1,
          duration: 800,
          useNativeDriver: true,
        }),
        Animated.spring(textTranslateY, {
          toValue: 0,
          tension: 50,
          friction: 5,
          useNativeDriver: true,
        }),
      ]),
      // Hold for display
      Animated.delay(1500),
      // Fade out sequence
      Animated.parallel([
        Animated.timing(logoOpacity, {
          toValue: 0,
          duration: 400,
          useNativeDriver: true,
        }),
        Animated.timing(textOpacity, {
          toValue: 0,
          duration: 400,
          useNativeDriver: true,
        }),
        Animated.timing(backgroundOpacity, {
          toValue: 0,
          duration: 600,
          useNativeDriver: true,
        }),
      ]),
    ]).start(() => {
      onAnimationEnd();
    });

    // Start pulse animation
    pulseLoop.start();

    return () => {
      pulseLoop.stop();
    };
  }, []);

  const rotation = logoRotation.interpolate({
    inputRange: [0, 1],
    outputRange: ['0deg', '360deg'],
  });

  return (
    <Animated.View style={[styles.container, { opacity: backgroundOpacity }]}>
      {/* Background gradient effect */}
      <View style={styles.backgroundOverlay} />

      {/* Decorative circles */}
      <View style={styles.decorativeCircle1} />
      <View style={styles.decorativeCircle2} />

      <View style={styles.contentContainer}>
        <View style={styles.logoSection}>
          {/* Logo container with pulse effect */}
          <Animated.View
            style={[
              styles.logoContainer,
              {
                transform: [
                  { scale: Animated.multiply(logoScale, pulseAnimation) },
                  { rotate: rotation },
                ],
                opacity: logoOpacity,
              },
            ]}
          >
            <View style={styles.logoBackground}>
              <Image
                source={require('../../ChiliMarket-Logo.png')}
                style={styles.logoImage}
                resizeMode="contain"
              />
            </View>
            <View style={styles.logoGlow} />
          </Animated.View>

          {/* App name and tagline */}
          <Animated.View
            style={[
              styles.textContainer,
              {
                opacity: textOpacity,
                transform: [{ translateY: textTranslateY }],
              },
            ]}
          >
            <Text style={styles.appName}>CHILI-MARKET</Text>
            <View style={styles.divider} />
            <Text style={styles.tagline}>Duurzaam handelen, samen groeien</Text>
            <Text style={styles.subtitle}>
              Jouw marktplaats voor een verbonden community
            </Text>
          </Animated.View>
        </View>
      </View>
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.primary,
  },
  backgroundOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'rgba(0, 0, 0, 0.1)',
  },
  decorativeCircle1: {
    position: 'absolute',
    top: -50,
    right: -50,
    width: 200,
    height: 200,
    borderRadius: 100,
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
  },
  decorativeCircle2: {
    position: 'absolute',
    bottom: -80,
    left: -80,
    width: 300,
    height: 300,
    borderRadius: 150,
    backgroundColor: 'rgba(255, 255, 255, 0.03)',
  },
  contentContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: 40,
  },
  logoSection: {
    alignItems: 'center',
    marginBottom: 80,
  },
  logoContainer: {
    marginBottom: 40,
    alignItems: 'center',
    justifyContent: 'center',
  },
  logoBackground: {
    width: 180,
    height: 180,
    borderRadius: 90,
    backgroundColor: Colors.white,
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: Colors.black,
    shadowOffset: { width: 0, height: 15 },
    shadowOpacity: 0.3,
    shadowRadius: 25,
    elevation: 15,
    borderWidth: 3,
    borderColor: 'rgba(255, 255, 255, 0.9)',
  },
  logoGlow: {
    position: 'absolute',
    width: 200,
    height: 200,
    borderRadius: 100,
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
    zIndex: -1,
  },
  logoImage: {
    width: 140,
    height: 140,
  },
  textContainer: {
    alignItems: 'center',
  },
  appName: {
    fontSize: 28,
    fontWeight: '900',
    color: Colors.white,
    textAlign: 'center',
    letterSpacing: 2,
    marginBottom: 12,
    textShadowColor: 'rgba(0, 0, 0, 0.3)',
    textShadowOffset: { width: 0, height: 2 },
    textShadowRadius: 4,
  },
  divider: {
    width: 60,
    height: 3,
    backgroundColor: Colors.white,
    marginBottom: 16,
    borderRadius: 2,
  },
  tagline: {
    fontSize: 18,
    color: Colors.white,
    textAlign: 'center',
    fontWeight: '600',
    marginBottom: 8,
    opacity: 0.95,
  },
  subtitle: {
    fontSize: 14,
    color: Colors.white,
    textAlign: 'center',
    fontWeight: '400',
    opacity: 0.8,
    fontStyle: 'italic',
  },
});
