// lib/notifier/products_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing/notifier/product_repository.dart';
import 'package:testing/notifier/products_state.dart';
import '../sidebar/model/product.dart';
import 'dio.dart';

// lib/notifier/products_notifier.dart
class ProductNotifier extends StateNotifier<ProductsState> {
  final ProductRepository _productRepository;
  int _currentPage = 1;
  bool _isFetching = false; // Add a flag to indicate fetching state

  ProductNotifier(this._productRepository) : super(const ProductsState());

  Future<void> fetchProducts({int limit = 100, bool loadMore = false}) async {
    if (_isFetching) return; // Prevent multiple fetch requests
    _isFetching = true; // Set fetching flag

    try {
      if (!loadMore) {
        _currentPage = 1;
      } else {
        _currentPage++;
      }
      final newProducts = await _productRepository.fetchProducts(limit: limit, page: _currentPage);
      if (newProducts.isEmpty) {
        _currentPage--; // No more products to fetch, revert page increment
      } else {
        state = state.copyWith(
          products: loadMore ? [...state.products, ...newProducts] : newProducts,
          errorMessage: '',
        );
      }
    } catch (error) {
      state = state.copyWith(errorMessage: 'Failed to fetch products: ${error.toString()}');
    } finally {
      _isFetching = false; // Reset fetching flag
    }
  }

  List<Product> get products => state.products;
}

final productNotifierProvider = StateNotifierProvider<ProductNotifier, ProductsState>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return ProductNotifier(productRepository);
});