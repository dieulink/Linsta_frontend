import 'package:flutter/material.dart';
import 'package:linsta_app/screens/login_screens/confirm_email_page.dart';
import 'package:linsta_app/screens/login_screens/login_page.dart';
import 'package:linsta_app/screens/login_screens/on_boarding_page.dart';
import 'package:linsta_app/screens/login_screens/register_page.dart';
import 'package:linsta_app/screens/login_screens/reset_password_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      routes: {
        "/": (context) => ResetPasswordPage(),
        "loginPage": (context) => LoginPage(),
        "registerPage": (context) => RegisterPage(),
        "confirmEmailPage": (context) => ConfirmEmailPage(),
        "resetPasswordPage": (context) => ResetPasswordPage(),
      },
    );
  }
}
