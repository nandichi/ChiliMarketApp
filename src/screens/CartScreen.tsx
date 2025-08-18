import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  FlatList,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Colors } from '../constants/colors';
import HapticFeedbackService from '../services/HapticFeedbackService';
import ContextMenu from '../components/ContextMenu';

export default function CartScreen() {
  const renderCartItem = ({ item }: { item: any }) => (
    <View style={styles.cartItem}>
      <View style={styles.productImage}>
        <Icon name="local-grocery-store" size={30} color={Colors.primary} />
      </View>
      <View style={styles.productInfo}>
        <Text style={styles.productName}>{item.name}</Text>
        <Text style={styles.productPrice}>{item.price}</Text>
      </View>
      <View style={styles.quantityControls}>
        <TouchableOpacity
          style={styles.quantityButton}
          onPress={async () => {
            await HapticFeedbackService.cartAction('remove');
          }}
        >
          <Icon name="remove" size={20} color={Colors.primary} />
        </TouchableOpacity>
        <Text style={styles.quantityText}>{item.quantity}</Text>
        <TouchableOpacity
          style={styles.quantityButton}
          onPress={async () => {
            await HapticFeedbackService.cartAction('add');
          }}
        >
          <Icon name="add" size={20} color={Colors.primary} />
        </TouchableOpacity>
      </View>
      <ContextMenu
        options={[
          {
            title: 'Verwijder Item',
            systemIcon: 'trash',
            destructive: true,
            onPress: async () => {
              await HapticFeedbackService.cartAction('remove');
              // Item verwijderen logica
            },
          },
          {
            title: 'Bewaar voor Later',
            systemIcon: 'heart',
            onPress: async () => {
              await HapticFeedbackService.triggerForAction('selection');
              // Bewaar voor later logica
            },
          },
          {
            title: 'Product Details',
            systemIcon: 'info.circle',
            onPress: async () => {
              await HapticFeedbackService.triggerForAction('navigation');
              // Toon product details
            },
          },
        ]}
        title="Item Opties"
        subtitle="Kies een actie voor dit item"
      >
        <TouchableOpacity style={styles.removeButton}>
          <Icon name="delete" size={20} color={Colors.error} />
        </TouchableOpacity>
      </ContextMenu>
    </View>
  );

  return (
    <View style={styles.container}>
      {cartItems.length > 0 ? (
        <>
          <FlatList
            data={cartItems}
            renderItem={renderCartItem}
            keyExtractor={item => item.id}
            style={styles.cartList}
            showsVerticalScrollIndicator={false}
          />

          <View style={styles.summaryContainer}>
            <View style={styles.summaryRow}>
              <Text style={styles.summaryLabel}>Subtotaal:</Text>
              <Text style={styles.summaryValue}>€24,47</Text>
            </View>
            <View style={styles.summaryRow}>
              <Text style={styles.summaryLabel}>Bezorgkosten:</Text>
              <Text style={styles.summaryValue}>€2,95</Text>
            </View>
            <View style={[styles.summaryRow, styles.totalRow]}>
              <Text style={styles.totalLabel}>Totaal:</Text>
              <Text style={styles.totalValue}>€27,42</Text>
            </View>

            <TouchableOpacity
              style={styles.checkoutButton}
              onPress={async () => {
                await HapticFeedbackService.cartAction('checkout');
                // Checkout logica
              }}
            >
              <Text style={styles.checkoutButtonText}>Bestelling Plaatsen</Text>
              <Icon name="arrow-forward" size={20} color={Colors.white} />
            </TouchableOpacity>
          </View>
        </>
      ) : (
        <View style={styles.emptyCart}>
          <Icon name="shopping-cart" size={80} color={Colors.gray300} />
          <Text style={styles.emptyCartTitle}>Je winkelwagen is leeg</Text>
          <Text style={styles.emptyCartSubtitle}>
            Voeg producten toe om te beginnen met winkelen
          </Text>
          <TouchableOpacity
            style={styles.shopNowButton}
            onPress={async () => {
              await HapticFeedbackService.triggerForAction('navigation');
              // Navigatie naar shop
            }}
          >
            <Text style={styles.shopNowButtonText}>Nu Winkelen</Text>
          </TouchableOpacity>
        </View>
      )}
    </View>
  );
}

const cartItems = [
  { id: '1', name: 'Verse Tomaten', price: '€2,99', quantity: 2 },
  { id: '2', name: 'Biologische Bananen', price: '€1,89', quantity: 1 },
  { id: '3', name: 'Verse Basilicum', price: '€1,49', quantity: 3 },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  cartList: {
    flex: 1,
    padding: 16,
  },
  cartItem: {
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
  productPrice: {
    fontSize: 16,
    color: Colors.primary,
    fontWeight: '600',
  },
  quantityControls: {
    flexDirection: 'row',
    alignItems: 'center',
    marginRight: 16,
  },
  quantityButton: {
    width: 32,
    height: 32,
    borderRadius: 16,
    borderWidth: 1,
    borderColor: Colors.primary,
    justifyContent: 'center',
    alignItems: 'center',
  },
  quantityText: {
    fontSize: 16,
    fontWeight: '600',
    color: Colors.text,
    marginHorizontal: 16,
    minWidth: 20,
    textAlign: 'center',
  },
  removeButton: {
    padding: 8,
  },
  summaryContainer: {
    backgroundColor: Colors.white,
    padding: 20,
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    shadowColor: Colors.shadow,
    shadowOffset: { width: 0, height: -2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 5,
  },
  summaryRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 12,
  },
  summaryLabel: {
    fontSize: 16,
    color: Colors.textSecondary,
  },
  summaryValue: {
    fontSize: 16,
    fontWeight: '500',
    color: Colors.text,
  },
  totalRow: {
    borderTopWidth: 1,
    borderTopColor: Colors.border,
    paddingTop: 12,
    marginBottom: 20,
  },
  totalLabel: {
    fontSize: 18,
    fontWeight: '700',
    color: Colors.text,
  },
  totalValue: {
    fontSize: 18,
    fontWeight: '700',
    color: Colors.primary,
  },
  checkoutButton: {
    backgroundColor: Colors.primary,
    borderRadius: 12,
    padding: 16,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
  },
  checkoutButtonText: {
    fontSize: 16,
    fontWeight: '600',
    color: Colors.white,
    marginRight: 8,
  },
  emptyCart: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40,
  },
  emptyCartTitle: {
    fontSize: 24,
    fontWeight: '700',
    color: Colors.text,
    marginTop: 20,
    marginBottom: 12,
  },
  emptyCartSubtitle: {
    fontSize: 16,
    color: Colors.textSecondary,
    textAlign: 'center',
    marginBottom: 40,
  },
  shopNowButton: {
    backgroundColor: Colors.primary,
    borderRadius: 25,
    paddingHorizontal: 32,
    paddingVertical: 16,
  },
  shopNowButtonText: {
    fontSize: 16,
    fontWeight: '600',
    color: Colors.white,
  },
});
