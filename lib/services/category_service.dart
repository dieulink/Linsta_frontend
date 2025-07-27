import 'dart:convert';
import 'package:http/http.dart' as http;
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
}
