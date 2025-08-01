import 'package:flutter/material.dart';
import 'package:linsta_app/screens/account_screens/address/address_page.dart';
import 'package:linsta_app/screens/account_screens/order/order_page.dart';
import 'package:linsta_app/screens/account_screens/profile/profile_page.dart';
import 'package:linsta_app/screens/home_screens/cart_page.dart';
import 'package:linsta_app/screens/home_screens/category_item_page.dart';
import 'package:linsta_app/screens/home_screens/home.dart';
import 'package:linsta_app/screens/home_screens/home_page.dart';
import 'package:linsta_app/screens/home_screens/product_detail.dart';
import 'package:linsta_app/screens/home_screens/search_item_page.dart';
import 'package:linsta_app/screens/login_screens/confirm_email_page.dart';
import 'package:linsta_app/screens/login_screens/login_page.dart';
import 'package:linsta_app/screens/login_screens/on_boarding_page.dart';
import 'package:linsta_app/screens/login_screens/register_page.dart';
import 'package:linsta_app/screens/login_screens/reset_password_page.dart';
import 'package:linsta_app/ui_values.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: backgroudColor),
      routes: {
        "/": (context) => OnBoardingPage(),
        "loginPage": (context) => LoginPage(),
        "registerPage": (context) => RegisterPage(),
        "confirmEmailPage": (context) => ConfirmEmailPage(),
        "resetPasswordPage": (context) => ResetPasswordPage(),
        "home": (context) => Home(),
        // "item": (context) => ProductDetail(),
        "cartPage": (context) => CartPage(),
        "searchItem": (context) => SearchItemPage(),
        "profilePage": (context) => ProfilePage(),
        "orderPage": (context) => OrderPage(),
        "addressPage": (context) => AddressPage(),
      },
    );
  }
}
