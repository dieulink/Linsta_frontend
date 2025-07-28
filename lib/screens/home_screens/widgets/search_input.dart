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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "searchItem");
      },
      borderRadius: BorderRadius.circular(7),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: white,
          border: Border.all(color: mainColor, width: 1),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, color: mainColor, width: 24, height: 24),
            SizedBox(width: 10),
            Text(
              hintText,
              style: TextStyle(
                color: textColor2,
                fontFamily: "LD",
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
