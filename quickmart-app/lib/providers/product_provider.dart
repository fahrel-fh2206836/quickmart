import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/repository/quick_mart_repo.dart';

class ProductNotifier extends Notifier<List<Product>> {
  final QuickMartRepo _quickMartRepo = QuickMartRepo();
  List<Product> productData = [];
  @override
  List<Product> build() {
    initializeProduct();
    return [];
  }

  void initializeProduct() async {
    var products = await _quickMartRepo.getProduct();
    state = products;
    for (Product product in products) {
      productData.add(product);
    }
  }

  void addProduct(Product product) {
    state = [...state, product];
  }

  void filterByCategory(String category) {
    state = productData;
    var filtered =
        state.where((product) => product.category == category).toList();
    state = filtered;
  }

  void filterByName(String name) {
    state = productData;
    var filtered = state
        .where((product) =>
            product.title.toLowerCase().contains(name.toLowerCase()))
        .toList();
    state = filtered;
  }

  void addAllProduct() {
    state = productData;
  }

  Product findProductOfCartItem(CartItem cartItem) {
    return state.firstWhere((product) => product.id == cartItem.productId);
  }

  Product getProduct(String id) =>
      state.firstWhere((product) => product.id == id);
}

final productNotifierProvider =
    NotifierProvider<ProductNotifier, List<Product>>(() => ProductNotifier());
