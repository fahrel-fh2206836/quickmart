import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmart/providers/cart_provider.dart';
import 'package:quickmart/providers/favorites_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/providers/show_bottom_nav_bar_provider.dart';
import 'package:quickmart/routes/app_router.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const ProductDetailScreen({super.key, required this.id});
  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreen();
}

class _ProductDetailScreen extends ConsumerState<ProductDetailScreen> {
  var dummyCartQuantity = 1;
  @override
  Widget build(BuildContext context) {
    final product =
        ref.read(productNotifierProvider.notifier).getProduct(widget.id);
    final favorites = ref.watch(favoriteNotifierProvider);
    final cartItem =
        ref.read(cartItemNotifierProvider.notifier).getCartItem(product);
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
          centerTitle: true,
          title: Text(
            'Product Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 207, 245, 209),
                  border: Border(
                    top: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                    bottom: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                ),
                width: 500,
                child: Card(
                  color: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/products/${product.imageName}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    title: Text(
                      product.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.category,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Price per unit',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          if (!favorites.contains(product)) {
                            ref
                                .read(favoriteNotifierProvider.notifier)
                                .addFavorite(product);
                          } else {
                            ref
                                .read(favoriteNotifierProvider.notifier)
                                .removeFavorite(product.id);
                          }
                        });
                      },
                      icon: !favorites.contains(product)
                          ? Icon(Icons.favorite_border)
                          : Icon(
                              Icons.favorite,
                              color: Colors.green,
                            ),
                    ),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (ref
                                  .read(cartItemNotifierProvider.notifier)
                                  .isProductInCart(product.id)) {
                                ref
                                    .read(cartItemNotifierProvider.notifier)
                                    .updateItemQuanity(
                                      productId: cartItem.productId,
                                      increment: false,
                                    );
                              } else {
                                dummyCartQuantity = dummyCartQuantity == 1
                                    ? dummyCartQuantity
                                    : dummyCartQuantity - 1;
                              }
                            });
                          },
                          icon: Icon(Icons.remove_circle),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          ref
                                  .read(cartItemNotifierProvider.notifier)
                                  .isProductInCart(product.id)
                              ? '${cartItem.quantity}'
                              : '$dummyCartQuantity',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (ref
                                  .read(cartItemNotifierProvider.notifier)
                                  .isProductInCart(product.id)) {
                                ref
                                    .read(cartItemNotifierProvider.notifier)
                                    .updateItemQuanity(
                                      productId: cartItem.productId,
                                      increment: true,
                                    );
                              } else {
                                dummyCartQuantity = dummyCartQuantity + 1;
                              }
                            });
                          },
                          icon: Icon(Icons.add_circle),
                        ),
                      ],
                    ),
                    trailing: Text(
                      "QAR ${product.price}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Divider(
                    endIndent: 10,
                    indent: 10,
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        'Product Detail',
                        style: TextStyle(fontSize: 15),
                      ),
                      childrenPadding:
                          EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      children: [
                        Text(
                          product.description,
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    endIndent: 10,
                    indent: 10,
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        'Rating',
                        style: TextStyle(fontSize: 15),
                      ),
                      childrenPadding: EdgeInsets.only(bottom: 10),
                      children: [
                        SizedBox(
                          width: 125,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              for (int i = 0; i < 5 - product.rating; i++)
                                Icon(
                                  Icons.star_border,
                                  color: Colors.yellow,
                                ),
                              for (int i = 0; i < product.rating; i++)
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                endIndent: 10,
                indent: 10,
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 375,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    setState(() {
                      if (!ref
                          .read(cartItemNotifierProvider.notifier)
                          .isProductInCart(product.id)) {
                        cartItem.quantity = dummyCartQuantity;
                        ref
                            .read(cartItemNotifierProvider.notifier)
                            .addCartItem(cartItem);
                      }
                      ref
                          .read(showBottomNavBarNotifierProvider.notifier)
                          .showBottomNavBar(true);

                      ref
                          .read(productNotifierProvider.notifier)
                          .addAllProduct();
                      context.pushReplacement(AppRouter.cart.path);
                    });
                  },
                  child: Text(
                    !ref
                            .read(cartItemNotifierProvider.notifier)
                            .isProductInCart(product.id)
                        ? 'Add to Basket'
                        : 'Item already in Cart -  Go to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
