import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:linsta_app/ui_values.dart';

class ItemRating extends StatelessWidget {
  final String name;
  final double score;
  final String time;
  final String comment;

  const ItemRating({
    super.key,
    required this.name,
    required this.score,
    required this.time,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Container(height: 1, color: backgroudColor),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(100),
                      child: Image.asset("assets/imgs/avt.png", height: 20),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "LD",
                      fontWeight: FontWeight.bold,
                      color: textColor3,
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "LD",
                  color: textColor3,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          RatingBarIndicator(
            rating: score,
            itemBuilder: (context, index) =>
                Icon(Icons.star, color: Colors.amber),
            itemCount: 5,
            itemSize: 17.0,
            direction: Axis.horizontal,
          ),
          SizedBox(height: 5),
          Text(
            comment,
            style: TextStyle(fontSize: 12, fontFamily: "LD", color: textColor2),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
