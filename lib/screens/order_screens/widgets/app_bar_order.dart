import 'package:flutter/material.dart';
import 'package:linsta_app/screens/home_screens/home.dart';
import 'package:linsta_app/ui_values.dart';

class AppBarOrder extends StatelessWidget implements PreferredSizeWidget {
  const AppBarOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 30, left: 10, right: 25, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: mainColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "Đơn hàng",
                  style: TextStyle(
                    color: mainColor,
                    fontFamily: "LD",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).push(
          //       PageRouteBuilder(
          //         pageBuilder: (context, animation, secondaryAnimation) =>
          //             Home(),
          //         transitionsBuilder:
          //             (context, animation, secondaryAnimation, child) {
          //               return FadeTransition(opacity: animation, child: child);
          //             },
          //       ),
          //     );
          //   },
          //   child: Container(
          //     margin: EdgeInsets.only(right: 10),
          //     child: Icon(Icons.home, color: mainColor, size: 25),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
