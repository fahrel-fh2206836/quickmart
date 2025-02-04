import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmart/providers/nav_bar_item_color_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/providers/show_bottom_nav_bar_provider.dart';
import 'package:quickmart/routes/app_router.dart';

class ShellScreen extends ConsumerStatefulWidget {
  final Widget? child;
  const ShellScreen({super.key, this.child});

  @override
  ConsumerState<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends ConsumerState<ShellScreen> {
  @override
  Widget build(BuildContext context) {
    final showBottomNavBar = ref.watch(showBottomNavBarNotifierProvider);
    final colorPicker = ref.watch(navBarItemColorNotifierProvider);
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: !showBottomNavBar
          ? null
          : BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shop,
                    color: colorPicker[0],
                  ),
                  label: 'Shop',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: colorPicker[1],
                  ),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: colorPicker[2],
                  ),
                  label: 'Favorites',
                ),
              ],
              onTap: (index) {
                setState(() {
                  if (index == 0) {
                    context.pushReplacement(AppRouter.product.path);
                    ref
                        .read(navBarItemColorNotifierProvider.notifier)
                        .moveToShopScreen();
                  } else if (index == 1) {
                    context.pushReplacementNamed(AppRouter.cart.name);
                    ref.read(productNotifierProvider.notifier).addAllProduct();
                    ref
                        .read(navBarItemColorNotifierProvider.notifier)
                        .moveToCartScreen();
                  } else {
                    context.pushReplacement(AppRouter.favorites.path);
                    ref
                        .read(navBarItemColorNotifierProvider.notifier)
                        .moveToFavoritesScreen();
                  }
                  ref
                      .read(showBottomNavBarNotifierProvider.notifier)
                      .showBottomNavBar(true);
                });
              },
            ),
    );
  }
}
