import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:linsta_app/screens/home_screens/account_page.dart';
import 'package:linsta_app/screens/home_screens/cart_page.dart';
import 'package:linsta_app/screens/home_screens/home_page.dart';
import 'package:linsta_app/screens/home_screens/search_page.dart';
import 'package:linsta_app/screens/home_screens/voucher_page.dart';
import 'package:linsta_app/ui_values.dart';

class Home extends StatefulWidget {
  final int startIndex;
  const Home({super.key, this.startIndex = 0});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  late int selectedIndex;

  final List<Widget> pages = [
    HomePage(),
    SearchPage(),
    // VoucherPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.startIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor,
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 10, top: 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: GNav(
            tabBorderRadius: 15,
            backgroundColor: Colors.white,
            color: textColor2,
            activeColor: mainColor,
            textStyle: TextStyle(
              fontFamily: "LD",
              color: mainColor,
              fontWeight: FontWeight.bold,
            ),
            //tabBackgroundColor: mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            tabs: [
              GButton(icon: Icons.home_sharp, text: ' Trang chủ'),
              GButton(icon: Icons.search_rounded, text: ' Tìm kiếm'),
              //GButton(icon: Icons.local_offer_outlined, text: ' Ưu đãi'),
              GButton(icon: Icons.account_circle_outlined, text: ' Tài khoản'),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
