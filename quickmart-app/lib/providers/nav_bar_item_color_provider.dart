import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavBarItemColorProvider extends Notifier<List<MaterialColor>> {
  // First Index for Shop Item Color
  // Second Index for Cart Item Color
  // Third index for Favorite Item Color
  @override
  List<MaterialColor> build() {
    return [Colors.green, Colors.grey, Colors.grey];
  }

  void moveToShopScreen() {
    state = [Colors.green, Colors.grey, Colors.grey];
  }

  void moveToCartScreen() {
    state = [Colors.grey, Colors.green, Colors.grey];
  }

  void moveToFavoritesScreen() {
    state = [Colors.grey, Colors.grey, Colors.green];
  }
}

final navBarItemColorNotifierProvider =
    NotifierProvider<NavBarItemColorProvider, List<MaterialColor>>(
        () => NavBarItemColorProvider());
