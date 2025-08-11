import 'package:flutter/material.dart';
import 'package:linsta_app/ui_values.dart';

class AppBarUser extends StatelessWidget implements PreferredSizeWidget {
  final String hintText;

  const AppBarUser({super.key, required this.hintText});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: white,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: mainColor,
              size: 30,
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "adminSearchUser");
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              width: getWidth(context) * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: white,
                border: Border.all(color: mainColor, width: 1),
              ),
              child: Text(
                hintText,
                style: TextStyle(
                  color: textColor2,
                  fontFamily: "LD",
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
