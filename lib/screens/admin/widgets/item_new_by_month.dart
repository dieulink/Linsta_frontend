import 'package:flutter/material.dart';
import 'package:linsta_app/ui_values.dart';

class ItemNewByMonth extends StatelessWidget {
  final String title;
  final String count;
  final String percentage;
  final Color color;
  const ItemNewByMonth({
    super.key,
    required this.title,
    required this.count,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: getWidth(context) * 0.43,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: white, fontFamily: "LD", fontSize: 15),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                count,
                style: TextStyle(
                  color: white,
                  fontFamily: "LD",
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                percentage,
                style: TextStyle(
                  color: white,
                  fontFamily: "LD",
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
