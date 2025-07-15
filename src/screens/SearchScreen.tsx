import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TextInput,
  TouchableOpacity,
  ScrollView,
  FlatList,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';

export default function SearchScreen() {
  const [searchText, setSearchText] = useState('');
  const [selectedFilter, setSelectedFilter] = useState('all');

  const renderProductItem = ({ item }: { item: any }) => (
    <TouchableOpacity style={styles.productItem}>
      <View style={styles.productImage}>
        <Icon name="local-grocery-store" size={30} color={Colors.primary} />
      </View>
      <View style={styles.productInfo}>
        <Text style={styles.productName}>{item.name}</Text>
        <Text style={styles.productDescription}>{item.description}</Text>
        <Text style={styles.productPrice}>{item.price}</Text>
      </View>
      <TouchableOpacity style={styles.addButton}>
        <Icon name="add" size={20} color={Colors.primary} />
      </TouchableOpacity>
    </TouchableOpacity>
  );

  return (
    <View style={styles.container}>
      {/* Search Header */}
      <View style={styles.searchHeader}>
        <View style={styles.searchBar}>
          <Icon name="search" size={20} color={Colors.gray400} />
          <TextInput
            style={styles.searchInput}
            placeholder="Zoek producten..."
            value={searchText}
            onChangeText={setSearchText}
            placeholderTextColor={Colors.gray400}
          />
          {searchText.length > 0 && (
            <TouchableOpacity onPress={() => setSearchText('')}>
              <Icon name="clear" size={20} color={Colors.gray400} />
            </TouchableOpacity>
          )}
        </View>
      </View>

      {/* Filters */}
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        style={styles.filtersContainer}
      >
        {filters.map(filter => (
          <TouchableOpacity
            key={filter.id}
            style={[
              styles.filterChip,
              selectedFilter === filter.id && styles.filterChipActive,
            ]}
            onPress={() => setSelectedFilter(filter.id)}
          >
            <Text
              style={[
                styles.filterText,
                selectedFilter === filter.id && styles.filterTextActive,
              ]}
            >
              {filter.name}
            </Text>
          </TouchableOpacity>
        ))}
      </ScrollView>

      {/* Results */}
      <FlatList
        data={searchResults}
        renderItem={renderProductItem}
        keyExtractor={item => item.id}
        style={styles.resultsList}
        showsVerticalScrollIndicator={false}
      />
    </View>
  );
}

const filters = [
  { id: 'all', name: 'Alles' },
  { id: 'vegetables', name: 'Groenten' },
  { id: 'fruits', name: 'Fruit' },
  { id: 'meat', name: 'Vlees' },
  { id: 'dairy', name: 'Zuivel' },
  { id: 'organic', name: 'Biologisch' },
];

const searchResults = [
  {
    id: '1',
    name: 'Verse Tomaten',
    description: 'Rijpe rode tomaten uit Nederland',
    price: '€2,99/kg',
  },
  {
    id: '2',
    name: 'Biologische Komkommer',
    description: 'Verse biologische komkommers',
    price: '€1,49/stuk',
  },
  {
    id: '3',
    name: 'Paprika Mix',
    description: "Rode, gele en groene paprika's",
    price: '€3,99/kg',
  },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  searchHeader: {
    backgroundColor: Colors.white,
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: Colors.border,
  },
  searchBar: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: Colors.gray100,
    borderRadius: 25,
    paddingHorizontal: 16,
    paddingVertical: 12,
  },
  searchInput: {
    flex: 1,
    marginLeft: 12,
    fontSize: 16,
    color: Colors.text,
  },
  filtersContainer: {
    backgroundColor: Colors.white,
    paddingVertical: 16,
    paddingLeft: 16,
    borderBottomWidth: 1,
    borderBottomColor: Colors.border,
  },
  filterChip: {
    backgroundColor: Colors.gray100,
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    marginRight: 12,
  },
  filterChipActive: {
    backgroundColor: Colors.primary,
  },
  filterText: {
    fontSize: 14,
    color: Colors.text,
    fontWeight: '500',
  },
  filterTextActive: {
    color: Colors.white,
  },
  resultsList: {
    flex: 1,
    padding: 16,
  },
  productItem: {
    flexDirection: 'row',
    backgroundColor: Colors.white,
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    alignItems: 'center',
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  productImage: {
    width: 60,
    height: 60,
    backgroundColor: Colors.gray100,
    borderRadius: 8,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  productInfo: {
    flex: 1,
  },
  productName: {
    fontSize: 16,
    fontWeight: '600',
    color: Colors.text,
    marginBottom: 4,
  },
  productDescription: {
    fontSize: 14,
    color: Colors.textSecondary,
    marginBottom: 4,
  },
  productPrice: {
    fontSize: 16,
    color: Colors.primary,
    fontWeight: '600',
  },
  addButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    borderWidth: 1,
    borderColor: Colors.primary,
    justifyContent: 'center',
    alignItems: 'center',
  },
});
