import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/models/request/add_cart_request.dart';
import 'package:linsta_app/models/response/cart_item_model.dart';
import 'package:linsta_app/models/response/item.dart';
import 'package:linsta_app/models/response/rating_response.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:linsta_app/screens/rating/widgets/item_rating.dart';
import 'package:linsta_app/screens/home_screens/widgets/app_bar_custom.dart';
import 'package:linsta_app/screens/home_screens/widgets/product_image_slider.dart';
import 'package:linsta_app/services/cart_service.dart';
import 'package:linsta_app/services/category_service.dart';
import 'package:linsta_app/services/product_service.dart';
import 'package:linsta_app/services/rating_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProduct extends StatefulWidget {
  final int id;

  const DetailProduct({super.key, required this.id});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  Item? _item;
  int? productId;
  List<RatingResponse> _ratings = [];

  @override
  void initState() {
    super.initState();
    _loadProductItem(widget.id);
    _loadRatings(widget.id);
  }

  Future<void> _loadRatings(int id) async {
    try {
      final ratings = await RatingService.fetchRatings(widget.id);
      setState(() {
        _ratings = ratings;
      });
    } catch (e) {
      print("Lỗi khi load ratings: $e");
    }
  }

  double getAverageRating() {
    if (_ratings.isEmpty) return 0.0;

    int totalScore = _ratings.fold(0, (sum, rating) => sum + rating.score);
    return totalScore / _ratings.length;
  }

  Future<void> _loadProductItem(int id) async {
    try {
      final item = await ProductService.fetchProductItem(id);
      setState(() {
        _item = item;
      });
    } catch (e) {
      print("Lỗi khi load category: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(name: "Chi tiết sản phẩm"),
      body: _item == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                color: white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: ProductImageSlider(
                          mainImage: _item!.imageUrl,
                          descImages: _item!.descImages,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${NumberFormat("#,###", "vi_VN").format(_item!.price)} vnđ",
                              style: TextStyle(
                                // fontFamily: "LD",
                                fontWeight: FontWeight.bold,
                                color: red,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              "Số lượng còn : ${_item!.stock}",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: "LD",
                                color: textColor2,
                              ),
                              // textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      Container(height: 2, color: backgroudColor),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          textAlign: TextAlign.justify,
                          _item!.name,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "LD",
                            fontWeight: FontWeight.bold,
                            color: textColor1,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _item!.description,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: "LD",
                          color: textColor3,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10),
                      Container(height: 2, color: backgroudColor),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    textAlign: TextAlign.justify,
                                    "${getAverageRating().toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: "LD",
                                      fontWeight: FontWeight.bold,
                                      color: textColor1,
                                    ),
                                  ),
                                ),
                                Icon(Icons.star, color: Colors.amber, size: 18),
                                SizedBox(width: 10),
                                Text(
                                  textAlign: TextAlign.justify,
                                  "Đánh giá (${_ratings.length})",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "LD",
                                    fontWeight: FontWeight.bold,
                                    color: textColor1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                "ratingPage",
                                arguments: {'productId': _item!.id},
                              ).then((_) {
                                _loadRatings(widget.id);
                              });
                            },

                            child: Row(
                              children: [
                                Text(
                                  "Tất cả đánh giá",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "LD",
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                ),
                                Icon(
                                  Icons.navigate_next_rounded,
                                  color: mainColor,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      _ratings.isNotEmpty
                          ? ItemRating(
                              name: _ratings[0].userName,
                              score: _ratings[0].score.toDouble(),
                              time: DateFormat(
                                'dd/MM/yyyy',
                              ).format(_ratings[0].createdAt),
                              comment: _ratings[0].comment,
                            )
                          : Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Chưa có đánh giá",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textColor3,
                                  fontFamily: "LD",
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
