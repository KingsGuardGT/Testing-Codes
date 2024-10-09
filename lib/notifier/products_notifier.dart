import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing/notifier/product_repository.dart';
import 'package:testing/notifier/products_state.dart';
import 'package:testing/notifier/dio.dart';

import '../sidebar/model/product.dart';

final productNotifierProvider = ChangeNotifierProvider<ProductNotifier>((ref) {
  return ProductNotifier(ref.watch(productRepositoryProvider));
});

class ProductNotifier extends ChangeNotifier {
  final ProductRepository _productRepository;
  ProductsState _state = ProductsState();

  ProductNotifier(this._productRepository) {
    _fetchProducts();
  }

  ProductsState get state => _state;

  void setCurrentProduct(Product product, int index) {
    _state = _state.copyWith(currentProduct: product, currentIndex: index);
    notifyListeners();
  }

  Future<void> _fetchProducts() async {
    try {
      final newProducts = await _productRepository.fetchProducts();
      _state = _state.copyWith(products: newProducts, errorMessage: '');
    } catch (error) {
      _state = _state.copyWith(errorMessage: 'Failed to fetch products: ${error.toString()}');
    }
    notifyListeners();
  }

  Future<void> sortProducts(Comparator<Product> comparator) async {
    _state = _state.copyWith(isSorting: true);
    notifyListeners();

    try {
      final sortedList = List<Product>.from(_state.products)..sort(comparator);
      _state = _state.copyWith(sortedProducts: sortedList, errorMessage: '');
    } catch (error) {
      _state = _state.copyWith(errorMessage: 'Error sorting products: ${error.toString()}');
    } finally {
      _state = _state.copyWith(isSorting: false);
      notifyListeners();
    }
  }

  Product getProduct(int index) {
    return _state.products[index];
  }
}