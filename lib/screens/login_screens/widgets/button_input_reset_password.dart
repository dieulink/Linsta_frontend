import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:linsta_app/models/request/user_login_request.dart';
import 'package:linsta_app/models/request/user_reset_password_request.dart';
import 'package:linsta_app/models/response/login_response.dart';
import 'package:linsta_app/services/login_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonInputResetPassword extends StatelessWidget {
  final String text;
  final String email;
  final TextEditingController otpController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const ButtonInputResetPassword({
    super.key,
    required this.text,
    required this.otpController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final otp = otpController.text.trim();
        final password = passwordController.text.trim();
        final password_confirm = confirmPasswordController.text.trim();

        if (otp.isEmpty || password.isEmpty || password_confirm.isEmpty) {
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
        final RegExp passwordRegex = RegExp(r'^[a-zA-Z0-9]{6,8}$');

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

        if (password_confirm != password) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Vui lòng xác thực mật khẩu !",
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

        final request = UserResetPasswordRequest(
          email: email,
          password: password,
          otp: otp,
        );

        final loginService = LoginService();
        final response = await loginService.resetPassword(request);
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
