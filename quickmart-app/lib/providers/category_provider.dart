import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/repository/quick_mart_repo.dart';

class CategoryProvider extends Notifier<List<String>> {
  final QuickMartRepo quickMartRepo = QuickMartRepo();

  @override
  List<String> build() {
    initializeCategories();
    return [];
  }

  void initializeCategories() async {
    var categories = await quickMartRepo.getCategories();
    state = categories;
  }
}

final categoryNotifierProvider =
    NotifierProvider<CategoryProvider, List<String>>(() => CategoryProvider());
