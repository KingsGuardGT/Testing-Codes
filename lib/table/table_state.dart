import 'package:freezed_annotation/freezed_annotation.dart';
import '../sidebar/model/product.dart';

part 'table_state.freezed.dart';

@freezed
class TableState with _$TableState {
  const factory TableState({
    @Default([]) List<Product> products,
    @Default([]) List<bool> selected,
    @Default('') String searchQuery,
    @Default(false) bool isLoading, // Add loading state
  }) = _TableState;
}