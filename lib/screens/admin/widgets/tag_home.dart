import 'package:flutter/material.dart';
import 'package:linsta_app/ui_values.dart';

class TagHome extends StatelessWidget {
  final String imgPath;
  final String name;
  final dynamic ontap;
  final Color color;

  const TagHome({
    super.key,
    required this.imgPath,
    required this.name,
    required this.ontap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (ontap is String) {
          Navigator.pushNamed(context, ontap);
        } else if (ontap is Function) {
          ontap();
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 15),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: mainColor, width: 1),
        ),
        width: getWidth(context),
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(imgPath, color: mainColor, width: 30),
                    SizedBox(width: 15),
                    Text(
                      name,
                      style: TextStyle(
                        color: textColor1,
                        fontSize: 15,
                        fontFamily: "LD",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: mainColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
