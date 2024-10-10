// lib/sidebar/sidebar_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing/sidebar/sidebar_state.dart';

class SidebarNotifier extends StateNotifier<SidebarState> {
  SidebarNotifier() : super(const SidebarState());

  void setSelectedIndex(int index) {
    state = SidebarState(selectedIndex: index, isCollapsed: state.isCollapsed);
  }

  void toggleIsCollapsed() {
    state = SidebarState(selectedIndex: state.selectedIndex, isCollapsed: !state.isCollapsed);
  }
}

final sidebarNotifierProvider = StateNotifierProvider<SidebarNotifier, SidebarState>((ref) {
  return SidebarNotifier();
});