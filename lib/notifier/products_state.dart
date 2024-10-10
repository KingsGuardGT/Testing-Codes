// lib/notifier/products_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../sidebar/model/product.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default([]) List<Product> products,
    @Default([]) List<Product> sortedProducts,
    Product? currentProduct,
    int? currentIndex,
    @Default(false) bool isSorting,
    @Default('') String errorMessage,
    @Default(0) int sortColumnIndex,
    @Default(true) bool sortAscending,
  }) = _ProductsState;
}