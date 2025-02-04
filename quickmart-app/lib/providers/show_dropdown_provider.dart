import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowDropdownProvider extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void showDropDownFilter(bool show) {
    state = show;
  }
}

final showDropdownNotifierProvider =
    NotifierProvider<ShowDropdownProvider, bool>(() => ShowDropdownProvider());
