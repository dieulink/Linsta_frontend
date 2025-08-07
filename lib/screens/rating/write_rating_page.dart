import 'package:flutter/material.dart';
import 'package:linsta_app/screens/rating/widgets/app_bar_rating.dart';

class WriteRatingPage extends StatelessWidget {
  const WriteRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRating(name: "Viết đánh giá"),
      body: Container(),
    );
  }
}
