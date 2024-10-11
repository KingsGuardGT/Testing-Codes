import 'package:freezed_annotation/freezed_annotation.dart'; // Importing Freezed for immutable state management.
import '../sidebar/model/product.dart'; // Importing the Product model.

part 'table_state.freezed.dart'; // Part directive for code generation.

@freezed
class TableState with _$TableState { // Defining an immutable state class using Freezed.
  const factory TableState({
    @Default([]) List<Product> products, // List of products, defaulting to an empty list.
    @Default([]) List<bool> selected, // List of selection states, defaulting to an empty list.
    @Default('') String searchQuery, // Search query, defaulting to an empty string.
  }) = _TableState;
}