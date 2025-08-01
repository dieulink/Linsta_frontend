import 'package:flutter/material.dart';
import 'package:linsta_app/ui_values.dart';

class TagProfile extends StatelessWidget {
  final String name;
  final String value;
  final String nextPage;
  final String iconPath;

  const TagProfile({
    super.key,
    required this.name,
    required this.value,
    required this.nextPage,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(7),
      ),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(iconPath, color: mainColor, height: 30),
              SizedBox(width: 15),
              Container(
                child: Text(
                  name,
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: Text(
                  value,
                  style: TextStyle(
                    color: textColor2,
                    fontFamily: "LD",
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(width: 15),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, nextPage);
                },
                child: Icon(
                  Icons.navigate_next_rounded,
                  color: textColor2,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
