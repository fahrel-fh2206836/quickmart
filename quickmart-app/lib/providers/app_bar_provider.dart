import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppBarScreen { product, detail, favorite, cart }

class AppBarProvider extends Notifier<AppBarScreen> {
  @override
  AppBarScreen build() {
    return AppBarScreen.product;
  }

  void setAppBarScreen(AppBarScreen appBarScreen) {
    state = appBarScreen;
  }
}

final appBarNotifierProvider =
    NotifierProvider<AppBarProvider, AppBarScreen>(() => AppBarProvider());
