import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Dimensions,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';

const { width } = Dimensions.get('window');

export default function CategoriesScreen() {
  return (
    <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
      <View style={styles.categoriesGrid}>
        {categories.map((category, index) => (
          <TouchableOpacity key={index} style={styles.categoryCard}>
            <View
              style={[styles.categoryIcon, { backgroundColor: category.color }]}
            >
              <Icon name={category.icon} size={40} color={Colors.white} />
            </View>
            <Text style={styles.categoryTitle}>{category.name}</Text>
            <Text style={styles.categorySubtitle}>{category.items} items</Text>
          </TouchableOpacity>
        ))}
      </View>
    </ScrollView>
  );
}

const categories = [
  { name: 'Groenten', icon: 'eco', color: Colors.success, items: '150+' },
  { name: 'Fruit', icon: 'local-florist', color: Colors.accent, items: '80+' },
  {
    name: 'Vlees & Vis',
    icon: 'restaurant',
    color: Colors.primary,
    items: '45+',
  },
  { name: 'Zuivel', icon: 'local-drink', color: Colors.info, items: '35+' },
  {
    name: 'Brood & Banket',
    icon: 'bakery-dining',
    color: Colors.warning,
    items: '25+',
  },
  { name: 'Dranken', icon: 'local-bar', color: Colors.secondary, items: '60+' },
  { name: 'Kruiden', icon: 'spa', color: Colors.success, items: '40+' },
  { name: 'Biologisch', icon: 'nature', color: Colors.accent, items: '90+' },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  categoriesGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    padding: 16,
    justifyContent: 'space-between',
  },
  categoryCard: {
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 20,
    alignItems: 'center',
    width: (width - 48) / 2,
    marginBottom: 16,
    shadowColor: Colors.shadow,
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
    color: Colors.text,
    textAlign: 'center',
    marginBottom: 4,
  },
  categorySubtitle: {
    fontSize: 14,
    color: Colors.textSecondary,
    textAlign: 'center',
  },
});
