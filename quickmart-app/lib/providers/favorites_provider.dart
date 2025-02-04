import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';

class FavoritesProvider extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    // TODO: implement build
    return [];
  }

  void addFavorite(Product product) {
    state = [...state, product];
  }

  void removeFavorite(String id) {
    state.removeWhere((prod) => prod.id == id);
  }
}

final favoriteNotifierProvider =
    NotifierProvider<FavoritesProvider, List<Product>>(
        () => FavoritesProvider());
