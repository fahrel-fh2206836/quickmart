import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/providers/cart_provider.dart';
import 'package:quickmart/providers/favorites_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/providers/show_bottom_nav_bar_provider.dart';
import 'package:quickmart/providers/show_dropdown_provider.dart';
import 'package:quickmart/routes/app_router.dart';
import 'package:quickmart/widget/drop_down_filter.dart';
import 'package:quickmart/widget/product_search_bar.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productNotifierProvider);
    final favorites = ref.watch(favoriteNotifierProvider);
    final showDropDownFilter = ref.watch(showDropdownNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 222, 245, 223),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: SizedBox(
          height: 50,
          width: 50,
          child: Image.asset(
            'assets/images/quickmart_logo.png',
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          'QuickMart',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          showDropDownFilter == false ? ProductSearchBar() : DropDownFilter(),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: GridView.count(
              childAspectRatio: .65,
              crossAxisCount: 2,
              children: List.generate(
                products.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRouter.detail.name,
                          pathParameters: {'id': products[index].id});
                      ref
                          .read(showBottomNavBarNotifierProvider.notifier)
                          .showBottomNavBar(false);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          width: 2,
                          color: Colors.lightGreen,
                        ),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.asset(
                                'assets/images/products/${products[index].imageName}',
                                width: 200,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              products[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              products[index].category,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'QR ${products[index].price}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 40,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (!favorites
                                              .contains(products[index])) {
                                            ref
                                                .read(favoriteNotifierProvider
                                                    .notifier)
                                                .addFavorite(products[index]);
                                          } else {
                                            ref
                                                .read(favoriteNotifierProvider
                                                    .notifier)
                                                .removeFavorite(
                                                    products[index].id);
                                          }
                                        });
                                      },
                                      icon: !favorites.contains(products[index])
                                          ? Icon(Icons.favorite_border)
                                          : Icon(
                                              Icons.favorite,
                                              color: Colors.green,
                                            )),
                                ),
                                SizedBox(
                                  width: 40,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (!ref
                                            .read(cartItemNotifierProvider
                                                .notifier)
                                            .isProductInCart(
                                                products[index].id)) {
                                          ref
                                              .read(cartItemNotifierProvider
                                                  .notifier)
                                              .addCartItem(
                                                CartItem(
                                                    productId:
                                                        products[index].id,
                                                    productName:
                                                        products[index].title,
                                                    unitPrice:
                                                        products[index].price),
                                              );
                                        } else {
                                          ref
                                              .read(cartItemNotifierProvider
                                                  .notifier)
                                              .removeCartItem(
                                                  products[index].id);
                                        }
                                      });
                                    },
                                    icon: !ref
                                            .read(cartItemNotifierProvider
                                                .notifier)
                                            .isProductInCart(products[index].id)
                                        ? Icon(
                                            Icons.add_box,
                                            color: Colors.grey,
                                          )
                                        : Icon(
                                            Icons.add_box,
                                            color: Colors.green,
                                          ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
