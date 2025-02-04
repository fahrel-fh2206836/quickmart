import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/providers/category_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/providers/show_dropdown_provider.dart';

class DropDownFilter extends ConsumerStatefulWidget {
  const DropDownFilter({super.key});

  @override
  ConsumerState<DropDownFilter> createState() => _DropDownFilterState();
}

class _DropDownFilterState extends ConsumerState<DropDownFilter> {
  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryNotifierProvider);
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.green),
              ],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
            ),
            child: IconButton(
              onPressed: () {
                ref
                    .read(showDropdownNotifierProvider.notifier)
                    .showDropDownFilter(false);
                ref.read(productNotifierProvider.notifier).addAllProduct();
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10),
          const Text(
            'Filter By Category:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            width: 10,
          ),
          DropdownMenu(
              onSelected: (value) {
                setState(() {
                  ref
                      .read(productNotifierProvider.notifier)
                      .filterByCategory(value!);
                });
              },
              dropdownMenuEntries: categories
                  .map<DropdownMenuEntry<String>>(
                      (String status) => DropdownMenuEntry<String>(
                            value: status,
                            label: status,
                          ))
                  .toList()),
        ],
      ),
    );
  }
}
