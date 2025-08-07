import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:linsta_app/models/response/delete_rating_result.dart';
import 'package:linsta_app/models/response/rating_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingService {
  static Future<List<RatingResponse>> fetchRatings(int productId) async {
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/rating/list/$productId',
    );
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => RatingResponse.fromJson(json)).toList();
    } else {
      throw Exception('lỗi');
    }
  }

  static Future<List<RatingResponse>> fetchRatingsUser(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userId = prefs.getString('userId');
    int id = int.parse(userId!);
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/rating/list/$productId/$id',
    );
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => RatingResponse.fromJson(json)).toList();
    } else {
      throw Exception('lỗi');
    }
  }

  static Future<DeleteRatingResult> deleteRating(int ratingId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse(
      'http://192.168.5.136:8080/api/rating/delete/$ratingId',
    );
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      return DeleteRatingResult.fromJson(jsonBody);
    } else {
      throw Exception('Xoá đánh giá thất bại: ${response.statusCode}');
    }
  }

  static Future<int> checkIfUserPurchased(int userId, int productId) async {
    final url = Uri.parse(
      "http://192.168.5.136:8080/api/rating/check_purchased?userId=$userId&productId=$productId",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return int.parse(response.body);
      } else {
        throw Exception("Failed to check purchase status");
      }
    } catch (e) {
      print("Lỗi khi gọi API kiểm tra mua hàng: $e");
      rethrow;
    }
  }
}
