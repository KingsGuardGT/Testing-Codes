
import '../sidebar/model/product.dart';

class ProductsState {
  final List<Product> products;
  final List<Product> sortedProducts;
  final Product? currentProduct;
  final int? currentIndex;
  final bool isSorting;
  final String errorMessage;
  final int sortColumnIndex;
  final bool sortAscending;

  ProductsState({
    this.products = const [],
    this.sortedProducts = const [],
    this.currentProduct,
    this.currentIndex,
    this.isSorting = false,
    this.errorMessage = '',
    this.sortColumnIndex = 0,
    this.sortAscending = true,
  });

  ProductsState copyWith({
    List<Product>? products,
    List<Product>? sortedProducts,
    Product? currentProduct,
    int? currentIndex,
    bool? isSorting,
    String? errorMessage,
    int? sortColumnIndex,
    bool? sortAscending,
  }) {
    return ProductsState(
      products: products ?? this.products,
      sortedProducts: sortedProducts ?? this.sortedProducts,
      currentProduct: currentProduct ?? this.currentProduct,
      currentIndex: currentIndex ?? this.currentIndex,
      isSorting: isSorting ?? this.isSorting,
      errorMessage: errorMessage ?? this.errorMessage,
      sortColumnIndex: sortColumnIndex ?? this.sortColumnIndex,
      sortAscending: sortAscending ?? this.sortAscending,
    );
  }
}