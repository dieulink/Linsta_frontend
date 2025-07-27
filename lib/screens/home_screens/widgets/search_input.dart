import 'package:flutter/material.dart';
import 'package:linsta_app/ui_values.dart';

class SearchInput extends StatelessWidget {
  final String hintText;
  final String iconPath;

  const SearchInput({
    super.key,
    required this.hintText,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: white,
      ),
      child: TextField(
        style: TextStyle(color: textColor2, fontFamily: "LD", fontSize: 15),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: textColor2, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1.5),
            borderRadius: BorderRadius.circular(7),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: textColor2, fontFamily: "LD"),
          prefixIcon: Padding(
            padding: EdgeInsets.all(1),
            child: Image.asset(iconPath, color: mainColor),
          ),
        ),
      ),
    );
  }
}
