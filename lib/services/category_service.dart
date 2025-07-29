import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:linsta_app/models/response/product.dart';
import 'package:linsta_app/models/response/product_category.dart';

class CategoryService {
  static Future<List<ProductCategory>> fetchCategories() async {
    try {
      final url = Uri.parse('http://192.168.5.136:8080/api/home/category');

      final response = await http.get(url);
      print("Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        return jsonData.map((item) => ProductCategory.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Lỗi fetchProducts: $e");
      return [];
    }
  }

  static Future<List<Product>> categoryItem({
    required String id,
    required page,
    required int size,
  }) async {
    try {
      final url = Uri.parse(
        'http://192.168.5.136:8080/api/home/categories?id=$id&page=$page&size=$size',
      );

      final response = await http.get(url);
      print("Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['products'] as List;

        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Lỗi fetchProducts: $e");
      return [];
    }
  }

  static Future<List<Product>> searchInCate({
    required String keyword,
    required page,
    required int id,
  }) async {
    try {
      final url = Uri.parse(
        'http://192.168.5.136:8080/api/home/products/searchinCate?keyword=$keyword&page=$page&id=$id',
      );

      final response = await http.get(url);
      print("Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['products'] as List;

        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Lỗi fetchProducts: $e");
      return [];
    }
  }

  static Future<List<Product>> searchInBrand({
    required String keyword,
    required page,
    required int size,
  }) async {
    try {
      final url = Uri.parse(
        'http://192.168.5.136:8080/api/home/products/brand?keyword=$keyword&page=$page&size=$size',
      );

      final response = await http.get(url);
      print("Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['products'] as List;

        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Lỗi fetchProducts: $e");
      return [];
    }
  }
}
