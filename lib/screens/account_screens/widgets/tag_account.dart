import 'package:flutter/material.dart';
import 'package:linsta_app/ui_values.dart';

class TagAccount extends StatelessWidget {
  final String imgPath;
  final String name;
  final String ontap;

  const TagAccount({
    super.key,
    required this.imgPath,
    required this.name,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ontap);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 15),
        margin: EdgeInsets.symmetric(vertical: 10),
        width: getWidth(context),
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(imgPath, color: mainColor, width: 30),
                SizedBox(width: 20),
                Text(
                  name,
                  style: TextStyle(
                    color: textColor1,
                    fontSize: 18,
                    fontFamily: "LD",
                    fontWeight: FontWeight.bold,
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
