import 'package:flutter/material.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:linsta_app/ui_values.dart';

class AdminRevenueUser extends StatefulWidget {
  const AdminRevenueUser({super.key});

  @override
  State<AdminRevenueUser> createState() => _AdminRevenueUserState();
}

class _AdminRevenueUserState extends State<AdminRevenueUser> {
  int year = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(name: "Thống kê doanh thu theo người dùng"),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "byMonth");
              },
              child: item(text: "Thống kê doanh thu theo tháng"),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "last6Month");
              },
              child: item(text: "Thống kê doanh thu 6 tháng gần đây"),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "currentYear");
              },
              child: item(text: "Thống kê doanh thu năm ${year}"),
            ),
          ],
        ),
      ),
    );
  }
}

class item extends StatelessWidget {
  const item({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        children: [
          Text(
            "$text",
            style: TextStyle(
              color: textColor3,
              fontFamily: "LD",
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Spacer(),
          Icon(Icons.navigate_next_rounded, color: textColor3, size: 30),
        ],
      ),
    );
  }
}
