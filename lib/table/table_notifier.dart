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
  List<Product> _initialProducts = []; // Add a variable to store initial fetched products

  TableNotifier(this._productNotifier) : super(const TableState(products: [], selected: [], searchQuery: '')) {
    initializeTableProducts();
  }

  void initializeTableProducts() {
    final products = _productNotifier.products;
    _initialProducts = products; // Store the initial fetched products
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
    state = state.copyWith(searchQuery: ''); // Clear the search bar
    if (query.isEmpty) {
      state = state.copyWith(products: _initialProducts); // Reset to initial fetched products
    } else {
      state = state.copyWith(products: _initialProducts.where((product) {
        final priceString = product.price.toString();
        final priceWithDollar = '\$${product.price}';
        return product.title.toLowerCase().contains(query.toLowerCase()) ||
            (product.description?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
            priceString.contains(query) ||
            priceWithDollar.contains(query);
      }).toList());
    }
  }

  List<Product> get filteredProducts {
    return state.products;
  }
}