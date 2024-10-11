import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importing Riverpod for state management.
import 'package:testing/table/table_state.dart'; // Importing the TableState class.
import '../notifier/products_notifier.dart'; // Importing the ProductNotifier class.
import '../sidebar/model/product.dart'; // Importing the Product model.


final dataTableNotifierProvider = StateNotifierProvider<TableNotifier, TableState>( // Defining a provider for TableNotifier.
      (ref) {
    final productNotifier = ref.watch(productNotifierProvider.notifier); // Watching the ProductNotifier.
    return TableNotifier(productNotifier); // Returning an instance of TableNotifier.
  },
);

class TableNotifier extends StateNotifier<TableState> { // Defining a state notifier for TableState.
  final ProductNotifier _productNotifier; // Reference to the ProductNotifier.

  TableNotifier(this._productNotifier) : super(const TableState(products: [], selected: [], searchQuery: '')) {
    initializeTableProducts(); // Initializing table products.
  }

  void initializeTableProducts() {
    final products = _productNotifier.products; // Fetching products from ProductNotifier.
    state = state.copyWith(products: products, selected: List<bool>.filled(products.length, false)); // Setting initial state.
  }

  void setSelectedIndex(int index, bool value) {
    final newSelected = List<bool>.from(state.selected); // Creating a copy of the selected list.
    newSelected[index] = value; // Updating the selection state.
    state = state.copyWith(selected: newSelected); // Updating the state.
  }

  void sortProducts(Comparator<Product> comparator) {
    final sortedProducts = List<Product>.from(state.products)..sort(comparator); // Sorting products.
    state = state.copyWith(products: sortedProducts); // Updating the state with sorted products.
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query); // Updating the search query in the state.
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

