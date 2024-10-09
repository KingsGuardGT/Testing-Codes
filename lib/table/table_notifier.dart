// lib/table/table_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing/notifier/product_repository.dart';
import 'package:testing/table/table_state.dart';
import '../notifier/dio.dart';
import '../sidebar/model/product.dart';

class TableNotifier extends StateNotifier<TableState> {
  final ProductRepository _productRepository;

  TableNotifier(this._productRepository) : super(TableState(products: [], selected: [])) {
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await _productRepository.fetchProducts();
      state = state.copyWith(
        products: products,
        selected: List<bool>.generate(products.length, (index) => false),
      );
    } catch (error) {
      // Handle error
    }
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
}

final dataTableNotifierProvider = StateNotifierProvider<TableNotifier, TableState>(
      (ref) => TableNotifier(ref.watch(productRepositoryProvider)),
);