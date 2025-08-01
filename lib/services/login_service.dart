import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:linsta_app/models/request/user_login_request.dart';
import 'package:linsta_app/models/request/user_register_request.dart';
import 'package:linsta_app/models/request/user_reset_password_request.dart';
import 'package:linsta_app/models/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Future<LoginResponse?> login(UserLoginRequest request) async {
    final url = Uri.parse('http://192.168.5.136:8080/api/login_register/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );
      print(response.body);
      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);

          if (json['token'] != null && json['token'].toString().isNotEmpty) {
            final prefs = await SharedPreferences.getInstance();
            Map<String, dynamic> decodedToken = JwtDecoder.decode(
              json['token'],
            );
            String userId = decodedToken['id'].toString();
            String name = decodedToken['name'];
            String email = decodedToken['email'];
            String role = decodedToken['role'];
            String address = decodedToken['address'];

            await prefs.setString('token', json['token']);
            await prefs.setString('userId', userId);
            await prefs.setString('name', name);
            await prefs.setString('email', email);
            await prefs.setString('role', role);
            await prefs.setString('address', address);

            print("SharedPreferences");
            print("ID: ${prefs.getString('userId')}");
            print("Tên: ${prefs.getString('name')}");
            print("Email: ${prefs.getString('email')}");
            print("Vai trò: ${prefs.getString('role')}");
            print("địa chỉ: ${prefs.getString('address')}");
          }
          return LoginResponse.fromJson(json);
        }
      } else {
        print('Lỗi');
        return null;
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');
      return null;
    }
  }

  Future<LoginResponse?> register(UserRegisterRequest request) async {
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/login_register/register',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );
      print(response.body);
      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);

          if (json['token'] != null && json['token'].toString().isNotEmpty) {
            final prefs = await SharedPreferences.getInstance();
            Map<String, dynamic> decodedToken = JwtDecoder.decode(
              json['token'],
            );

            String userId = decodedToken['id'].toString();
            String name = decodedToken['name'];
            String email = decodedToken['email'];
            String role = decodedToken['role'];
            String address = decodedToken['address'];

            await prefs.setString('token', json['token']);
            await prefs.setString('userId', userId);
            await prefs.setString('name', name);
            await prefs.setString('email', email);
            await prefs.setString('role', role);
            await prefs.setString('address', address);

            print("SharedPreferences");
            print("ID: ${prefs.getString('userId')}");
            print("Tên: ${prefs.getString('name')}");
            print("Email: ${prefs.getString('email')}");
            print("Vai trò: ${prefs.getString('role')}");
            print("địa chỉ: ${prefs.getString('address')}");
          }
          return LoginResponse.fromJson(json);
        }
      } else {
        print('Lỗi');
        return null;
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');
      return null;
    }
  }

  Future<String?> confirmEmail(String request) async {
    final url = Uri.parse('http://192.168.5.136:8080/api/login_register/otp');
    Map<String, String> email = {'email': request};

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(email),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Lỗi');
        return null;
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');
      return null;
    }
  }

  Future<LoginResponse?> resetPassword(UserResetPasswordRequest request) async {
    final url = Uri.parse(
      'http://192.168.5.136:8080/api/login_register/reset_password',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );
      print(response.body);
      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);

          if (json['token'] != null && json['token'].toString().isNotEmpty) {
            final prefs = await SharedPreferences.getInstance();
            Map<String, dynamic> decodedToken = JwtDecoder.decode(
              json['token'],
            );
            String userId = decodedToken['id'].toString();
            String name = decodedToken['name'];
            String email = decodedToken['email'];
            String role = decodedToken['role'];
            String address = decodedToken['address'];

            await prefs.setString('token', json['token']);
            await prefs.setString('userId', userId);
            await prefs.setString('name', name);
            await prefs.setString('email', email);
            await prefs.setString('role', role);
            await prefs.setString('address', address);

            print("SharedPreferences");
            print("ID: ${prefs.getString('userId')}");
            print("Tên: ${prefs.getString('name')}");
            print("Email: ${prefs.getString('email')}");
            print("Vai trò: ${prefs.getString('role')}");
            print("địa chỉ: ${prefs.getString('address')}");
          }
          return LoginResponse.fromJson(json);
        }
      } else {
        print('Lỗi');
        return null;
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');
      return null;
    }
  }
}
