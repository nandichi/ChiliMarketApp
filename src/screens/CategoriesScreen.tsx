import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Dimensions,
  RefreshControl,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { getColors } from '../constants/colors';
import { useTheme } from '../context/ThemeContext';

const { width } = Dimensions.get('window');

export default function CategoriesScreen() {
  const { isDark } = useTheme();
  const colors = getColors(isDark);
  const [refreshing, setRefreshing] = useState(false);

  const onRefresh = () => {
    setRefreshing(true);
    // Simuleer data refresh
    setTimeout(() => {
      setRefreshing(false);
    }, 1000);
  };

  return (
    <ScrollView
      style={[styles.container, { backgroundColor: colors.background }]}
      showsVerticalScrollIndicator={false}
      refreshControl={
        <RefreshControl
          refreshing={refreshing}
          onRefresh={onRefresh}
          colors={[colors.primary]}
          tintColor={colors.primary}
        />
      }
    >
      <View style={styles.categoriesGrid}>
        {categories.map((category, index) => (
          <TouchableOpacity
            key={index}
            style={[styles.categoryCard, { backgroundColor: colors.card }]}
          >
            <View
              style={[styles.categoryIcon, { backgroundColor: category.color }]}
            >
              <Icon name={category.icon} size={40} color={colors.white} />
            </View>
            <Text style={[styles.categoryTitle, { color: colors.text }]}>
              {category.name}
            </Text>
            <Text
              style={[styles.categorySubtitle, { color: colors.textSecondary }]}
            >
              {category.items} items
            </Text>
          </TouchableOpacity>
        ))}
      </View>
    </ScrollView>
  );
}

const categories = [
  { name: 'Groenten', icon: 'eco', color: '#38A169', items: '150+' },
  { name: 'Fruit', icon: 'local-florist', color: '#FAC500', items: '80+' },
  {
    name: 'Vlees & Vis',
    icon: 'restaurant',
    color: '#BC1B20',
    items: '45+',
  },
  { name: 'Zuivel', icon: 'local-drink', color: '#3182CE', items: '35+' },
  {
    name: 'Brood & Banket',
    icon: 'bakery-dining',
    color: '#D69E2E',
    items: '25+',
  },
  { name: 'Dranken', icon: 'local-bar', color: '#657177', items: '60+' },
  { name: 'Kruiden', icon: 'spa', color: '#38A169', items: '40+' },
  { name: 'Biologisch', icon: 'nature', color: '#FAC500', items: '90+' },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  categoriesGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    padding: 16,
    justifyContent: 'space-between',
  },
  categoryCard: {
    borderRadius: 12,
    padding: 20,
    alignItems: 'center',
    width: (width - 48) / 2,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  categoryIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 12,
  },
  categoryTitle: {
    fontSize: 16,
    fontWeight: '600',
    textAlign: 'center',
    marginBottom: 4,
  },
  categorySubtitle: {
    fontSize: 14,
    textAlign: 'center',
  },
});
