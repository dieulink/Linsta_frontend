import 'package:flutter/material.dart';
import 'package:linsta_app/ui_values.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: mainColor,
              size: 30,
            ),
          ),
          Spacer(),
          Icon(Icons.shopping_bag_outlined, color: mainColor, size: 30),
          SizedBox(width: 20),
          Icon(Icons.home, color: mainColor, size: 30),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
