import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing/sidebar/sidebar_state.dart';

class SidebarNotifier extends StateNotifier<SidebarState> {
  SidebarNotifier() : super(SidebarState());

  void setSelectedIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  void toggleIsCollapsed() {
    state = state.copyWith(isCollapsed: !state.isCollapsed);
  }
}

final sidebarNotifierProvider = StateNotifierProvider<SidebarNotifier, SidebarState>((ref) {
  return SidebarNotifier();
});