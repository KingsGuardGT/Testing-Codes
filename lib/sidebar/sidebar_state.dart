// lib/sidebar/provider/sidebar_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sidebar_state.freezed.dart';

@freezed
class SidebarState with _$SidebarState {
  const factory SidebarState({
    @Default(0) int selectedIndex,
    @Default(true) bool isCollapsed,
  }) = _SidebarState;
}