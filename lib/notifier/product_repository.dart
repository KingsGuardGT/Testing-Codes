// lib/notifier/product_repository.dart
import 'package:dio/dio.dart';
import '../sidebar/model/product.dart';

class ProductRepository {
  final Dio dio;

  ProductRepository(this.dio);

  Future<List<Product>> fetchProducts({int limit = 100, int page = 1}) async {
    try {
      final response = await dio.get(
        'https://api.escuelajs.co/api/v1/products',
        queryParameters: {
          'per_page': limit,
          'page': page,
        },
      );

      final List<dynamic> data = response.data;
      return data.map((item) => Product.fromJson(item)).toList();
    } catch (error) {
      throw Exception('Failed to fetch products');
    }
  }
}