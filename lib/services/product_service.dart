import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:linsta_app/models/response/item.dart';
import 'package:linsta_app/models/response/product.dart';

class ProductService {
  static Future<List<Product>> fetchProducts({
    int page = 0,
    int size = 10,
  }) async {
    try {
      final url = Uri.parse(
        'http://192.168.5.136:8080/api/home/products?page=$page&size=$size',
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

  static Future<Item> fetchProductItem(int id) async {
    try {
      final url = Uri.parse(
        'http://192.168.5.136:8080/api/home/item_product/$id',
      );

      final response = await http.get(url);
      print("Status: ${response.statusCode}");
      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        return Item.fromJson(jsonData);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load product');
    }
  }

  static Future<List<Product>> search({
    required String keyword,
    required page,
    required int size,
  }) async {
    try {
      final url = Uri.parse(
        'http://192.168.5.136:8080/api/home/products/search?keyword=$keyword&page=$page&size=$size',
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
