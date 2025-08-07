import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:linsta_app/models/request/edit_address_request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/request/edit_name_request.dart';
import '../models/response/login_response.dart';

class UserService {
  static Future<LoginResponse?> editName(EditNameRequest request) async {
    final url = Uri.parse('http://192.168.5.136:8080/api/user/edit_name');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
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
        final jsonData = json.decode(response.body);
        return LoginResponse.fromJson(jsonData);
      } else {
        print('Lỗi khi đổi tên: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi exception khi đổi tên: $e');
      return null;
    }
  }

  static Future<LoginResponse?> editAddress(EditAddressRequest request) async {
    final url = Uri.parse('http://192.168.5.136:8080/api/user/edit_address');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
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
        final jsonData = json.decode(response.body);
        return LoginResponse.fromJson(jsonData);
      } else {
        print('Lỗi khi đổi địa chỉ ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi exception khi đổi địa chỉ: $e');
      return null;
    }
  }
}
