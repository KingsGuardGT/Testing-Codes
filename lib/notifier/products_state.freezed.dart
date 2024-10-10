// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductsState {
  List<Product> get products => throw _privateConstructorUsedError;
  List<Product> get sortedProducts => throw _privateConstructorUsedError;
  Product? get currentProduct => throw _privateConstructorUsedError;
  int? get currentIndex => throw _privateConstructorUsedError;
  bool get isSorting => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  int get sortColumnIndex => throw _privateConstructorUsedError;
  bool get sortAscending => throw _privateConstructorUsedError;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductsStateCopyWith<ProductsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsStateCopyWith<$Res> {
  factory $ProductsStateCopyWith(
          ProductsState value, $Res Function(ProductsState) then) =
      _$ProductsStateCopyWithImpl<$Res, ProductsState>;
  @useResult
  $Res call(
      {List<Product> products,
      List<Product> sortedProducts,
      Product? currentProduct,
      int? currentIndex,
      bool isSorting,
      String errorMessage,
      int sortColumnIndex,
      bool sortAscending});

  $ProductCopyWith<$Res>? get currentProduct;
}

/// @nodoc
class _$ProductsStateCopyWithImpl<$Res, $Val extends ProductsState>
    implements $ProductsStateCopyWith<$Res> {
  _$ProductsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? sortedProducts = null,
    Object? currentProduct = freezed,
    Object? currentIndex = freezed,
    Object? isSorting = null,
    Object? errorMessage = null,
    Object? sortColumnIndex = null,
    Object? sortAscending = null,
  }) {
    return _then(_value.copyWith(
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      sortedProducts: null == sortedProducts
          ? _value.sortedProducts
          : sortedProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      currentProduct: freezed == currentProduct
          ? _value.currentProduct
          : currentProduct // ignore: cast_nullable_to_non_nullable
              as Product?,
      currentIndex: freezed == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      isSorting: null == isSorting
          ? _value.isSorting
          : isSorting // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      sortColumnIndex: null == sortColumnIndex
          ? _value.sortColumnIndex
          : sortColumnIndex // ignore: cast_nullable_to_non_nullable
              as int,
      sortAscending: null == sortAscending
          ? _value.sortAscending
          : sortAscending // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get currentProduct {
    if (_value.currentProduct == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_value.currentProduct!, (value) {
      return _then(_value.copyWith(currentProduct: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductsStateImplCopyWith<$Res>
    implements $ProductsStateCopyWith<$Res> {
  factory _$$ProductsStateImplCopyWith(
          _$ProductsStateImpl value, $Res Function(_$ProductsStateImpl) then) =
      __$$ProductsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Product> products,
      List<Product> sortedProducts,
      Product? currentProduct,
      int? currentIndex,
      bool isSorting,
      String errorMessage,
      int sortColumnIndex,
      bool sortAscending});

  @override
  $ProductCopyWith<$Res>? get currentProduct;
}

/// @nodoc
class __$$ProductsStateImplCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res, _$ProductsStateImpl>
    implements _$$ProductsStateImplCopyWith<$Res> {
  __$$ProductsStateImplCopyWithImpl(
      _$ProductsStateImpl _value, $Res Function(_$ProductsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? sortedProducts = null,
    Object? currentProduct = freezed,
    Object? currentIndex = freezed,
    Object? isSorting = null,
    Object? errorMessage = null,
    Object? sortColumnIndex = null,
    Object? sortAscending = null,
  }) {
    return _then(_$ProductsStateImpl(
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      sortedProducts: null == sortedProducts
          ? _value._sortedProducts
          : sortedProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      currentProduct: freezed == currentProduct
          ? _value.currentProduct
          : currentProduct // ignore: cast_nullable_to_non_nullable
              as Product?,
      currentIndex: freezed == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      isSorting: null == isSorting
          ? _value.isSorting
          : isSorting // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      sortColumnIndex: null == sortColumnIndex
          ? _value.sortColumnIndex
          : sortColumnIndex // ignore: cast_nullable_to_non_nullable
              as int,
      sortAscending: null == sortAscending
          ? _value.sortAscending
          : sortAscending // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ProductsStateImpl implements _ProductsState {
  const _$ProductsStateImpl(
      {final List<Product> products = const [],
      final List<Product> sortedProducts = const [],
      this.currentProduct,
      this.currentIndex,
      this.isSorting = false,
      this.errorMessage = '',
      this.sortColumnIndex = 0,
      this.sortAscending = true})
      : _products = products,
        _sortedProducts = sortedProducts;

  final List<Product> _products;
  @override
  @JsonKey()
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<Product> _sortedProducts;
  @override
  @JsonKey()
  List<Product> get sortedProducts {
    if (_sortedProducts is EqualUnmodifiableListView) return _sortedProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sortedProducts);
  }

  @override
  final Product? currentProduct;
  @override
  final int? currentIndex;
  @override
  @JsonKey()
  final bool isSorting;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final int sortColumnIndex;
  @override
  @JsonKey()
  final bool sortAscending;

  @override
  String toString() {
    return 'ProductsState(products: $products, sortedProducts: $sortedProducts, currentProduct: $currentProduct, currentIndex: $currentIndex, isSorting: $isSorting, errorMessage: $errorMessage, sortColumnIndex: $sortColumnIndex, sortAscending: $sortAscending)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductsStateImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other._sortedProducts, _sortedProducts) &&
            (identical(other.currentProduct, currentProduct) ||
                other.currentProduct == currentProduct) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.isSorting, isSorting) ||
                other.isSorting == isSorting) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.sortColumnIndex, sortColumnIndex) ||
                other.sortColumnIndex == sortColumnIndex) &&
            (identical(other.sortAscending, sortAscending) ||
                other.sortAscending == sortAscending));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_sortedProducts),
      currentProduct,
      currentIndex,
      isSorting,
      errorMessage,
      sortColumnIndex,
      sortAscending);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductsStateImplCopyWith<_$ProductsStateImpl> get copyWith =>
      __$$ProductsStateImplCopyWithImpl<_$ProductsStateImpl>(this, _$identity);
}

abstract class _ProductsState implements ProductsState {
  const factory _ProductsState(
      {final List<Product> products,
      final List<Product> sortedProducts,
      final Product? currentProduct,
      final int? currentIndex,
      final bool isSorting,
      final String errorMessage,
      final int sortColumnIndex,
      final bool sortAscending}) = _$ProductsStateImpl;

  @override
  List<Product> get products;
  @override
  List<Product> get sortedProducts;
  @override
  Product? get currentProduct;
  @override
  int? get currentIndex;
  @override
  bool get isSorting;
  @override
  String get errorMessage;
  @override
  int get sortColumnIndex;
  @override
  bool get sortAscending;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductsStateImplCopyWith<_$ProductsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
