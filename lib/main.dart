import 'package:flutter/material.dart';
import 'package:linsta_app/screens/account_screens/address/address_page.dart';
import 'package:linsta_app/screens/account_screens/list_order/detail_ordered.dart';
import 'package:linsta_app/screens/account_screens/list_order/done_order_page.dart';
import 'package:linsta_app/screens/account_screens/list_order/list_order_page.dart';
import 'package:linsta_app/screens/account_screens/list_order/processing_page.dart';
import 'package:linsta_app/screens/account_screens/list_order/shipping_page.dart';
import 'package:linsta_app/screens/account_screens/profile/edit_email_page.dart';
import 'package:linsta_app/screens/account_screens/profile/edit_name_page.dart';
import 'package:linsta_app/screens/account_screens/profile/edit_phone_page.dart';
import 'package:linsta_app/screens/account_screens/profile/profile_page.dart';
import 'package:linsta_app/screens/admin/admin_manage_order.dart';
import 'package:linsta_app/screens/admin/admin_manage_product.dart';
import 'package:linsta_app/screens/admin/admin_manage_user.dart';
import 'package:linsta_app/screens/admin/admin_revenue_product.dart';
import 'package:linsta_app/screens/admin/admin_revenue_user.dart';
import 'package:linsta_app/screens/admin/home_admin.dart';
import 'package:linsta_app/screens/admin/manage_orders/admin_order_details.dart';
import 'package:linsta_app/screens/admin/manage_orders/done_order.dart';
import 'package:linsta_app/screens/admin/manage_orders/processing_order.dart';
import 'package:linsta_app/screens/admin/manage_orders/shipping_order.dart';
import 'package:linsta_app/screens/admin/manage_products/list_products.dart';
import 'package:linsta_app/screens/admin/manage_users/list_order_user.dart';
import 'package:linsta_app/screens/admin/manage_users/search_user.dart';
import 'package:linsta_app/screens/admin/revenue_product/by_month_product.dart';
import 'package:linsta_app/screens/admin/revenue_product/current_year_product.dart';
import 'package:linsta_app/screens/admin/revenue_product/last_6_month_product.dart';
import 'package:linsta_app/screens/admin/revenue_user/by_month.dart';
import 'package:linsta_app/screens/admin/revenue_user/current_year.dart';
import 'package:linsta_app/screens/admin/revenue_user/last_6_month.dart';
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
import 'package:linsta_app/screens/order_screens/edit_receive_name.dart';
import 'package:linsta_app/screens/order_screens/order_page.dart';
import 'package:linsta_app/screens/rating/rating_page.dart';
import 'package:linsta_app/screens/rating/write_rating_page.dart';
import 'package:linsta_app/screens/rating/your_rating_page.dart';
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
        "editNamePage": (context) => EditNamePage(),
        "editReceiveNamePage": (context) => EditReceiveNamePage(),
        "listOrderPage": (context) => ListOrderPage(),
        "doneOrderPage": (context) => DoneOrderPage(),
        "shippingPage": (context) => ShippingPage(),
        "processingPage": (context) => ProcessingPage(),
        "ratingPage": (context) => RatingPage(),
        "yourRatingPage": (context) => YourRatingPage(),
        // "editEmailPage": (context) => EditEmailPage(),
        // "editPhonePage": (context) => EditPhonePage(),
        "writeRatingPage": (context) => WriteRatingPage(),
        "orderDetailPage": (context) => DetailOrdered(),
        "adminPage": (context) => HomeAdmin(),
        "adminManageOrder": (context) => AdminManageOrder(),
        "adminDoneOrder": (context) => AdminDoneOrder(),
        "adminShippingOrder": (context) => AdminShippingOrder(),
        "adminProcessingOrder": (context) => AdminProcessingOrder(),
        "adminOrderDetailPage": (context) => AdminOrderDetails(),
        "adminManageUser": (context) => AdminManageUser(),
        "adminSearchUser": (context) => SearchUser(),
        "listOrderUser": (context) => ListOrderUser(),
        "adminManageProduct": (context) => AdminManageProduct(),
        "listProducts": (context) => ListProducts(),
        "adminRevenueProduct": (context) => AdminRevenueProduct(),
        "adminRevenueUser": (context) => AdminRevenueUser(),
        "byMonth": (context) => ByMonth(),
        "last6Month": (context) => Last6Month(),
        "currentYear": (context) => CurrentYear(),
        "byMonthProduct": (context) => ByMonthProduct(),
        "last6MonthProduct": (context) => Last6MonthProduct(),
        "currentYearProduct": (context) => CurrentYearProduct(),
      },
    );
  }
}
