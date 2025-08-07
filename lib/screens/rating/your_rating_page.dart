import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/models/response/rating_response.dart';
import 'package:linsta_app/screens/rating/widgets/app_bar_rating.dart';
import 'package:linsta_app/screens/rating/widgets/item_rating.dart';
import 'package:linsta_app/screens/rating/widgets/item_rating_delete.dart';
import 'package:linsta_app/services/rating_service.dart';
import 'package:linsta_app/ui_values.dart';

class YourRatingPage extends StatefulWidget {
  const YourRatingPage({super.key});

  @override
  State<YourRatingPage> createState() => _YourRatingPageState();
}

class _YourRatingPageState extends State<YourRatingPage> {
  List<RatingResponse> _ratings = [];
  int? _productId;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['productId'] != null) {
      _productId = args['productId'];
      fetchRatings(_productId!);
    }
  }

  Future<void> fetchRatings(int productId) async {
    try {
      final result = await RatingService.fetchRatingsUser(productId);
      setState(() {
        _ratings = result;
        _isLoading = false;
      });
    } catch (e) {
      print("Lỗi: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarRating(name: "Đánh giá của bạn"),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _ratings.isEmpty
          ? Center(child: Text("Chưa có đánh giá nào."))
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _ratings.length,
              itemBuilder: (context, index) {
                final rating = _ratings[index];
                return ItemRatingDelete(
                  name: rating.userName,
                  score: rating.score.toDouble(),
                  time: DateFormat('dd/MM/yyyy').format(rating.createdAt),
                  comment: rating.comment,
                  ratingId: rating.id,
                  onDelete: () async {
                    try {
                      final result = await RatingService.deleteRating(
                        rating.id,
                      );
                      setState(() {
                        _ratings = result.ratings;
                      });
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(result.message)));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Xóa thất bại: $e")),
                      );
                    }
                  },
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: Container(
          height: 50,
          width: getWidth(context) * 0.8,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "writeRatingPage");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: Text(
              'Viết đánh giá',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: "LD",
                color: white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
