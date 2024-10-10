// lib/notifier/products_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing/notifier/product_repository.dart';
import 'package:testing/notifier/products_state.dart';
import '../sidebar/model/product.dart';
import 'dio.dart';

class ProductNotifier extends StateNotifier<ProductsState> {
  final ProductRepository _productRepository;

  ProductNotifier(this._productRepository) : super(const ProductsState()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final newProducts = await _productRepository.fetchProducts();
      state = state.copyWith(products: newProducts, errorMessage: '');
    } catch (error) {
      state = state.copyWith(errorMessage: 'Failed to fetch products: ${error.toString()}');
    }
  }

  List<Product> get products => state.products;
}

final productNotifierProvider = StateNotifierProvider<ProductNotifier, ProductsState>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return ProductNotifier(productRepository);
});