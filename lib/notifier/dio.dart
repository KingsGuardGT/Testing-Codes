// dio and repository provider setup

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing/notifier/product_repository.dart';

// Provide a single instance of Dio
final dioProvider = Dio();

// Provide an instance of ProductRepository, using the Dio instance
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dio = dioProvider;
  return ProductRepository(dio);
});