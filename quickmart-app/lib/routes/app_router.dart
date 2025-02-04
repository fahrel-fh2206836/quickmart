import 'package:go_router/go_router.dart';
import 'package:quickmart/screens/cart_screen.dart';
import 'package:quickmart/screens/favorites_screen.dart';
import 'package:quickmart/screens/login_screen.dart';
import 'package:quickmart/screens/product_details_screen.dart';
import 'package:quickmart/screens/product_screen.dart';
import 'package:quickmart/screens/shell_screen.dart';

class AppRouter {
  static const login = (name: 'login', path: '/');
  static const product = (name: 'product', path: '/product');
  static const detail = (name: 'detail', path: '/product/detail:id');
  static const cart = (name: 'cart', path: '/cart');
  static const favorites = (name: 'favorites', path: '/favorites');

  static final router = GoRouter(
    initialLocation: login.path,
    routes: [
      GoRoute(
        path: login.path,
        name: login.name,
        builder: (context, state) => LoginScreen(),
        routes: [
          ShellRoute(
            builder: (context, state, child) => ShellScreen(child: child),
            routes: [
              GoRoute(
                path: product.path,
                name: product.name,
                builder: (context, state) => ProductScreen(),
                routes: [
                  GoRoute(
                      path: detail.path,
                      name: detail.name,
                      builder: (context, state) {
                        final id = state.pathParameters['id'];
                        return ProductDetailScreen(id: id!);
                      }),
                ],
              ),
              GoRoute(
                path: cart.path,
                name: cart.name,
                builder: (context, state) => CartScreen(),
              ),
              GoRoute(
                path: favorites.path,
                name: favorites.name,
                builder: (context, state) => FavoritesScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
