import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:linsta_app/models/request/user_login_request.dart';
import 'package:linsta_app/models/request/user_register_request.dart';
import 'package:linsta_app/models/response/login_response.dart';
import 'package:linsta_app/services/login_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonInputRegister extends StatelessWidget {
  final String text;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  const ButtonInputRegister({
    super.key,
    required this.text,
    required this.emailController,
    required this.passwordController,
    required this.addressController,
    required this.nameController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        final phone = phoneController.text.trim();
        final name = nameController.text.trim();
        final address = addressController.text.trim();
        if (email.isEmpty ||
            password.isEmpty ||
            phone.isEmpty ||
            address.isEmpty ||
            name.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Vui lòng nhập đầy đủ thông tin",
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
          return;
        }
        final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
        final RegExp passwordRegex = RegExp(r'^[a-zA-Z0-9]{6,8}$');
        final RegExp phoneRegex = RegExp(r'^(0|\+84)[0-9]{9}$');
        final RegExp nameRegex = RegExp(r'^[a-zA-ZÀ-ỹ\s]+$');

        if (!emailRegex.hasMatch(email)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Email không hợp lệ !",
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
          return;
        }
        if (!passwordRegex.hasMatch(password)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Mật khẩu từ 6-8 kí tự, chỉ chứa chữ cái và số !",
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
          return;
        }
        if (!phoneRegex.hasMatch(phone)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Số điện thoại không hợp lệ !",
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
          return;
        }
        if (name.length > 50) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Tên đăng kí quá dài !",
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
          return;
        }
        if (!nameRegex.hasMatch(name)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Tên đăng kí không chứa số và kí tự đặc biệt !",
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
          return;
        }
        if (address.length > 100) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Địa chỉ đăng kí quá dài !",
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
          return;
        }
        if (address.length < 10 || address.length > 100) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Độ dài địa chỉ không hợp lệ !",
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
          return;
        }
        final request = UserRegisterRequest(
          email: email,
          password: password,
          name: name,
          phone: phone,
          address: address,
        );

        final loginService = LoginService();
        final response = await loginService.register(request);
        print(
          "Token value: ${response?.token}, isNull: ${response?.token == null}",
        );

        if (response != null && response.token.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          String role = prefs.getString('role') ?? '';
          if (role == 'ROLE_ADMIN') {
            Navigator.pushNamed(context, "adminPage");
          } else if (role == 'ROLE_USER') {
            Navigator.pushNamed(context, "home");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Vai trò không hợp lệ",
                  style: TextStyle(fontFamily: "LD"),
                ),
                backgroundColor: textColor1,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(30),
                duration: const Duration(seconds: 1),
                elevation: 8,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      response!.message,
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      child: SizedBox(
        width: getWidth(context),
        height: 60,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: white,
              fontFamily: "LD",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
