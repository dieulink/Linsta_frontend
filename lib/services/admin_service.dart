import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:linsta_app/models/response/daily_revenue.dart';
import 'package:linsta_app/models/response/order_response.dart';
import 'package:linsta_app/models/response/product_revenue.dart';
import 'package:linsta_app/models/response/summary.dart';
import 'package:linsta_app/models/response/user.dart';
import 'package:linsta_app/models/response/user_revenue.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminService {
  Future<Map<String, dynamic>?> getThisMonth() async {
    final url = Uri.parse('http://192.168.5.136:8080/api/admin/this_month');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      //print("Response status: ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Lỗi: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
      return null;
    }
  }

  Future<List<DailyRevenue>> getRevenue7day() async {
    final url = Uri.parse('http://192.168.5.136:8080/api/admin/revenue7day');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print("Response status: ${response.body}");
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<DailyRevenue> revenues = jsonList.map((jsonItem) {
          return DailyRevenue.fromJson(jsonItem);
        }).toList();
        return revenues;
      } else {
        print("Lỗi: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
      return [];
    }
  }

  static Future<List<OrderResponse>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse('http://192.168.5.136:8080/api/admin/list_order');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => OrderResponse.fromJson(json)).toList();
      } else {
        throw Exception(
          "Lỗi khi lấy danh sách đơn hàng: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Lỗi kết nối tới server: $e");
    }
  }

  Future<bool> confirmOrder(int orderId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/admin/confirm_order/$orderId',
    );
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(orderId);
      print("Response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Lỗi cập nhật trạng thái: ${response.body}');
        return false;
      }
    } catch (e) {
      throw Exception("Lỗi kết nối tới server: $e");
    }
  }

  Future<List<User>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse('http://192.168.5.136:8080/api/admin/list_user');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception("Lỗi kết nối tới server: $e");
    }
  }

  static Future<User> getUserById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse('http://192.168.5.136:8080/api/admin/user/$id');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return User.fromJson(data);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception("Lỗi kết nối tới server: $e");
    }
  }

  Future<List<OrderResponse>> getOrdersByUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/order/list_order/user?userId=$userId',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => OrderResponse.fromJson(json)).toList();
      } else {
        throw Exception(
          "Lỗi khi lấy danh sách đơn hàng: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Lỗi kết nối tới server: $e");
    }
  }

  Future<Summary> getSummaryByUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/admin/summary/$userId',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Summary.fromJson(data);
      } else {
        throw Exception('Failed to load summary');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  static Future<List<UserRevenue>> fetchRevenueByMonth(
    int month,
    int year,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/admin/user/revenue_by_month?month=$month&year=$year',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => UserRevenue.fromJson(e)).toList();
      } else {
        throw Exception(
          'lỗi khi lấy doanh thu theo tháng: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('lỗi: $e');
    }
  }

  static Future<List<UserRevenue>> fetchRevenue6Month() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/admin/user/revenue_6_month',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => UserRevenue.fromJson(e)).toList();
      } else {
        throw Exception(
          'lỗi khi lấy doanh thu theo tháng: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('lỗi: $e');
    }
  }

  static Future<List<UserRevenue>> fetchRevenueCurrentYear() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/admin/user/revenue_current_year',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => UserRevenue.fromJson(e)).toList();
      } else {
        throw Exception(
          'lỗi khi lấy doanh thu theo NĂM: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('lỗi: $e');
    }
  }

  static Future<List<ProductRevenue>> fetchProductRevenueByMonth(
    int month,
    int year,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/admin/product/revenue_by_month?month=$month&year=$year',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => ProductRevenue.fromJson(e)).toList();
      } else {
        throw Exception(
          'lỗi khi lấy doanh thu theo tháng: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('lỗi: $e');
    }
  }

  static Future<List<ProductRevenue>> fetchProductRevenue6Month() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/admin/product/revenue_6_month',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => ProductRevenue.fromJson(e)).toList();
      } else {
        throw Exception(
          'lỗi khi lấy doanh thu theo tháng: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('lỗi: $e');
    }
  }

  static Future<List<ProductRevenue>> fetchProductRevenueCurrentYear() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/admin/product/revenue_current_year',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => ProductRevenue.fromJson(e)).toList();
      } else {
        throw Exception(
          'lỗi khi lấy doanh thu theo tháng: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('lỗi: $e');
    }
  }
}
