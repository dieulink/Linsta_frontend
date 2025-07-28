import 'package:flutter/material.dart';
import 'package:linsta_app/ui_values.dart';

class AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroudColor,
      padding: EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
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
          SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: white,
              ),
              child: TextField(
                style: TextStyle(
                  color: textColor2,
                  fontFamily: "LD",
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: textColor2, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor, width: 1.5),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  hintText: "Bạn muốn tìm gì ?",
                  hintStyle: TextStyle(color: textColor2, fontFamily: "LD"),
                  //prefixIcon: Icon(Icons.search, color: mainColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
