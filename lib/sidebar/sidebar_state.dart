// lib/sidebar/provider/sidebar_state.dart

class SidebarState {
  final int selectedIndex;
  final bool isCollapsed;

  SidebarState({this.selectedIndex = 0, this.isCollapsed = true});

  SidebarState copyWith({int? selectedIndex, bool? isCollapsed}) {
    return SidebarState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isCollapsed: isCollapsed ?? this.isCollapsed,
    );
  }
}