import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/providers/show_dropdown_provider.dart';

class ProductSearchBar extends ConsumerStatefulWidget {
  const ProductSearchBar({super.key});

  @override
  ConsumerState<ProductSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<ProductSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: MediaQuery.sizeOf(context).width - 10,
      child: TextField(
        onChanged: (value) {
          ref.read(productNotifierProvider.notifier).filterByName(value);
        },
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              ref
                  .read(showDropdownNotifierProvider.notifier)
                  .showDropDownFilter(true);
            },
            icon: Icon(
              Icons.tune,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
