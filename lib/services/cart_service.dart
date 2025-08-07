import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:linsta_app/models/request/add_cart_request.dart';
import 'package:linsta_app/models/response/cart_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static Future<CartResponse?> fetchCart(int userId) async {
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/cart/list_cart/$userId',
    );
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // print("id nè ${userId}");
    // print(token);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        //body: json.encode(request.toJson()),
      );
      if (response.body.isEmpty) {
        print("Body rỗng");
      } else {
        print("Response body: ${response.body}");
      }
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CartResponse.fromJson(data);
        print(data);
      } else {
        print('Lỗi status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi fetch cart: $e');
      return null;
    }
  }

  static Future<CartResponse?> addToCart(AddCartRequest request) async {
    final url = Uri.parse('http://192.168.5.136:8080/api/cart/add');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(request.toJson()),
      );
      if (response.body.isEmpty) {
        print("Body rỗng");
      } else {
        print("Response body: ${response.body}");
      }
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CartResponse.fromJson(data);
      } else {
        print('Lỗi status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi fetch cart: $e');
      return null;
    }
  }

  static Future<CartResponse?> deleteFromCart(int productId, int userId) async {
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/cart/delete?productId=$productId&userId=$userId',
    );
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CartResponse.fromJson(data);
      } else {
        print('Xóa thất bại Status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi khi xóa: $e');
      return null;
    }
  }

  static Future<CartResponse?> increase(int productId, int userId) async {
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/cart/increase?userId=$userId&productId=$productId',
    );
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        // body: json.encode(request.toJson()),
      );
      if (response.body.isEmpty) {
        print("Body rỗng");
      } else {
        print("Response body: ${response.body}");
      }
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CartResponse.fromJson(data);
      } else {
        print('Lỗi status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi fetch cart: $e');
      return null;
    }
  }

  static Future<CartResponse?> decrease(int productId, int userId) async {
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/cart/decrease?userId=$userId&productId=$productId',
    );
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        // body: json.encode(request.toJson()),
      );
      if (response.body.isEmpty) {
        print("Body rỗng");
      } else {
        print("Response body: ${response.body}");
      }
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CartResponse.fromJson(data);
      } else {
        print('Lỗi status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi fetch cart: $e');
      return null;
    }
  }
}
