import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/providers/cart_provider.dart';
import 'package:quickmart/providers/favorites_provider.dart';
import 'package:quickmart/providers/show_bottom_nav_bar_provider.dart';
import 'package:quickmart/routes/app_router.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoritesScreen> {
  final addedCartSnackBar = SnackBar(
    content: Text('Successfully Added to Cart!'),
  );
  final alreadyAddedCartSnackBar = SnackBar(
    content: Text('All Favorite Items has been added to Cart!'),
  );

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteNotifierProvider);
    final cart = ref.watch(cartItemNotifierProvider);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        ref
            .read(showBottomNavBarNotifierProvider.notifier)
            .showBottomNavBar(true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 222, 245, 223),
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
              'assets/images/quickmart_logo.png',
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            'My Favorites',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: favorites.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'No Favorites',
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.grey,
                    size: 50,
                  )
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            onTap: () {
                              context.pushNamed(AppRouter.detail.name,
                                  pathParameters: {'id': favorites[index].id});
                              ref
                                  .read(
                                      showBottomNavBarNotifierProvider.notifier)
                                  .showBottomNavBar(false);
                            },
                            leading: Image.asset(
                                'assets/images/products/${favorites[index].imageName}'),
                            title: Text(
                              favorites[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            subtitle: Text(
                              'QAR ${favorites[index].price} per unit',
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  ref
                                      .read(favoriteNotifierProvider.notifier)
                                      .removeFavorite(favorites[index].id);
                                });
                              },
                              icon: Icon(Icons.close),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 375,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        bool continueLoop = false;
                        bool allAdded = true;
                        for (var product in favorites) {
                          continueLoop = cart
                              .where((item) => item.productId == product.id)
                              .isNotEmpty;
                          if (continueLoop) {
                            continue;
                          }
                          ref
                              .read(cartItemNotifierProvider.notifier)
                              .addCartItem(CartItem(
                                  productId: product.id,
                                  productName: product.title,
                                  unitPrice: product.price));
                          allAdded = false;
                        }
                        if (allAdded) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(alreadyAddedCartSnackBar);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(addedCartSnackBar);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        'Add All To Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
      ),
    );
  }
}
