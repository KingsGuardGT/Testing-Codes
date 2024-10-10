// lib/table/table_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing/table/table_state.dart';
import '../notifier/products_notifier.dart';
import '../sidebar/model/product.dart';

class TableNotifier extends StateNotifier<TableState> {
  final ProductNotifier _productNotifier;

  TableNotifier(this._productNotifier) : super(const TableState(products: [], selected: [], searchQuery: '')) {
    initializeProducts();
  }

  void initializeProducts() {
    final products = _productNotifier.products;
    state = state.copyWith(products: products, selected: List<bool>.filled(products.length, false));
  }

  void setSelectedIndex(int index, bool value) {
    final newSelected = List<bool>.from(state.selected);
    newSelected[index] = value;
    state = state.copyWith(selected: newSelected);
  }

  void sortProducts(Comparator<Product> comparator) {
    final sortedProducts = List<Product>.from(state.products)..sort(comparator);
    state = state.copyWith(products: sortedProducts);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  List<Product> get filteredProducts {
    return state.products.where((product) {
      return product.title.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          product.description!.toLowerCase().contains(state.searchQuery.toLowerCase());
    }).toList();
  }
}

// lib/table/table_notifier.dart
final dataTableNotifierProvider = StateNotifierProvider<TableNotifier, TableState>(
      (ref) {
    final productNotifier = ref.watch(productNotifierProvider.notifier);
    return TableNotifier(productNotifier);
  },
);