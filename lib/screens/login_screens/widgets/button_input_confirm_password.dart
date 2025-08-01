import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:linsta_app/models/request/user_login_request.dart';
import 'package:linsta_app/models/response/login_response.dart';
import 'package:linsta_app/services/login_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonInputConfirmPassword extends StatelessWidget {
  final String text;
  final TextEditingController emailController;
  const ButtonInputConfirmPassword({
    super.key,
    required this.text,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final email = emailController.text.trim();

        if (email.isEmpty) {
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
              duration: const Duration(seconds: 2),
              elevation: 8,
            ),
          );
          return;
        }

        final loginService = LoginService();
        final response = await loginService.confirmEmail(email);

        if (response != null && response.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(response!, style: TextStyle(fontFamily: "LD")),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 2),
              elevation: 8,
            ),
          );
          Navigator.pushNamed(context, "resetPasswordPage", arguments: email);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Email chưa đăng kí",
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
              duration: const Duration(seconds: 2),
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
