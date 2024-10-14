// lib/table/table_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing/table/table_state.dart';
import '../notifier/products_notifier.dart';
import '../sidebar/model/product.dart';

final dataTableNotifierProvider = StateNotifierProvider<TableNotifier, TableState>(
      (ref) {
    final productNotifier = ref.watch(productNotifierProvider.notifier);
    return TableNotifier(productNotifier);
  },
);

// lib/table/table_notifier.dart
class TableNotifier extends StateNotifier<TableState> {
  final ProductNotifier _productNotifier;

  TableNotifier(this._productNotifier) : super(const TableState(products: [], selected: [], searchQuery: '')) {
    initializeTableProducts();
  }

  void initializeTableProducts() {
    final products = _productNotifier.products;
    state = state.copyWith(products: products, selected: List<bool>.filled(products.length, false));
  }

  Future<void> loadMoreProducts() async {
    await _productNotifier.fetchProducts(loadMore: true);
    initializeTableProducts();
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
    final query = state.searchQuery.toLowerCase();
    return state.products.where((product) {
      final priceString = product.price.toString();
      final priceWithDollar = '\$${product.price}';
      return product.title.toLowerCase().contains(query) ||
          (product.description?.toLowerCase().contains(query) ?? false) ||
          priceString.contains(query) ||
          priceWithDollar.contains(query);
    }).toList();
  }
}