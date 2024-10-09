// lib/table/table_state.dart
import '../sidebar/model/product.dart';

class TableState {
  final List<Product> products;
  final List<bool> selected;

  TableState({required this.products, required this.selected});

  TableState copyWith({List<Product>? products, List<bool>? selected}) {
    return TableState(
      products: products ?? this.products,
      selected: selected ?? this.selected,
    );
  }
}