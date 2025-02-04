import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/product.dart';

class CartProvider extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  void addCartItem(CartItem cartItem) {
    state = [...state, cartItem];
  }

  void updateItemQuanity({required String productId, required bool increment}) {
    var targetProduct = state
        .where((cartItem) => cartItem.productId == productId)
        .toList()
        .first;
    if (increment) {
      targetProduct.quantity = targetProduct.quantity + 1;
    } else {
      targetProduct.quantity = targetProduct.quantity == 1
          ? targetProduct.quantity
          : targetProduct.quantity - 1;
    }
  }

  void removeCartItem(String productId) {
    state.removeWhere((item) => item.productId == productId);
  }

  void removeAllItem() {
    state = [];
  }

  bool isProductInCart(String productId) =>
      state.where((cartItem) => cartItem.productId == productId).isNotEmpty;

  double totalPrice() => double.parse(state
      .map((cartItem) => cartItem.calculateTotalPrice())
      .reduce((total, currPrice) => total + currPrice)
      .toStringAsFixed(2));

  CartItem getCartItem(Product product) => state.firstWhere(
        (item) => item.productId == product.id,
        orElse: () => CartItem(
            productId: product.id,
            productName: product.title,
            unitPrice: product.price),
      );
}

final cartItemNotifierProvider =
    NotifierProvider<CartProvider, List<CartItem>>(() => CartProvider());
