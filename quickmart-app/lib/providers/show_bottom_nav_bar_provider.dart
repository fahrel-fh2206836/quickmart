import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowBottomNavBarProvider extends Notifier<bool> {
  @override
  bool build() {
    return true;
  }

  void showBottomNavBar(bool show) {
    state = show;
  }
}

final showBottomNavBarNotifierProvider =
    NotifierProvider<ShowBottomNavBarProvider, bool>(
        () => ShowBottomNavBarProvider());
