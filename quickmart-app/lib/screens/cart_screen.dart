import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/providers/cart_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/providers/show_bottom_nav_bar_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  final successSnackBar = SnackBar(
    content: Text('Successfully purchased!'),
  );

  @override
  Widget build(BuildContext context) {
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
            'My Cart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: cart.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'No Items Yet',
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.grey,
                    size: 50,
                  )
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            child: ListTile(
                              leading: Image.asset(
                                  'assets/images/products/${ref.read(productNotifierProvider.notifier).findProductOfCartItem(cart[index]).imageName}'),
                              title: Text(
                                cart[index].productName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        ref
                                            .read(cartItemNotifierProvider
                                                .notifier)
                                            .updateItemQuanity(
                                              productId: cart[index].productId,
                                              increment: false,
                                            );
                                      });
                                    },
                                    icon: Icon(Icons.remove_circle),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${cart[index].quantity}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        ref
                                            .read(cartItemNotifierProvider
                                                .notifier)
                                            .updateItemQuanity(
                                              productId: cart[index].productId,
                                              increment: true,
                                            );
                                      });
                                    },
                                    icon: Icon(Icons.add_circle),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: 35,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          ref
                                              .read(cartItemNotifierProvider
                                                  .notifier)
                                              .removeCartItem(
                                                cart[index].productId,
                                              );
                                        });
                                      },
                                      icon: Icon(Icons.close),
                                    ),
                                  ),
                                  Text(
                                    'QAR ${cart[index].calculateTotalPrice()}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    width: 375,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            cart.isEmpty ? Colors.grey : Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          ref
                              .read(cartItemNotifierProvider.notifier)
                              .removeAllItem();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(successSnackBar);
                        });
                      },
                      child: Text(
                        'Checkout Now - QAR ${ref.read(cartItemNotifierProvider.notifier).totalPrice()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
      ),
    );
  }
}
