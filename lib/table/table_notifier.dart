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

class TableNotifier extends StateNotifier<TableState> {
  final ProductNotifier _productNotifier;
  List<Product> _initialProducts = [];

  TableNotifier(this._productNotifier) : super(const TableState()) {
    initializeTableProducts();
  }

  void initializeTableProducts() async {
    _setLoading(true);
    final products = _productNotifier.products;
    _initialProducts = products;
    state = state.copyWith(products: products, selected: List<bool>.filled(products.length, false));
    _setLoading(false);
  }

  Future<void> loadMoreProducts() async {
    _setLoading(true);
    await _productNotifier.fetchProducts(loadMore: true);
    initializeTableProducts();
  }

  void setSelectedIndex(int index, bool value) {
    _setLoading(true);
    final newSelected = List<bool>.from(state.selected);
    newSelected[index] = value;
    state = state.copyWith(selected: newSelected);
    _setLoading(false);
  }

  void sortProducts(Comparator<Product> comparator) {
    _setLoading(true);
    final sortedProducts = List<Product>.from(state.products)..sort(comparator);
    state = state.copyWith(products: sortedProducts);
    _setLoading(false);
  }

  void setSearchQuery(String query) {
    _setLoading(true);
    if (query.isEmpty) {
      state = state.copyWith(products: _initialProducts);
    } else {
      state = state.copyWith(
        products: _initialProducts.where((product) {
          final priceString = product.price.toString();
          final priceWithDollar = '\$${product.price}';
          return product.title.toLowerCase().contains(query.toLowerCase()) ||
              (product.description?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
              priceString.contains(query) ||
              priceWithDollar.contains(query);
        }).toList(),
      );
    }
    _setLoading(false);
  }

  void _setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  List<Product> get filteredProducts => state.products;
}