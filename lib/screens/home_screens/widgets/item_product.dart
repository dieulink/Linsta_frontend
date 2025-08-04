import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/models/request/add_cart_request.dart';
import 'package:linsta_app/models/response/product.dart';
import 'package:linsta_app/screens/home_screens/product_detail.dart';
import 'package:linsta_app/services/cart_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:linsta_app/screens/home_screens/widgets/item_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemProduct extends StatelessWidget {
  final Product product;

  const ItemProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ProductDetail(id: product.id),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      },

      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10),
              child: Image.network(
                product.imageUrl,
                height: 130,
                width: 160,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/imgs/default.jpg',
                    height: 130,
                    width: 160,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                product.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "LD",
                  fontWeight: FontWeight.bold,
                  color: textColor1,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // RatingBarIndicator(
                //   rating: 4.5, // số sao muốn hiển thị
                //   itemBuilder: (context, index) =>
                //       Icon(Icons.star, color: Colors.amber),
                //   itemCount: 5,
                //   itemSize: 15.0, // kích thước sao
                //   direction: Axis.horizontal,
                // ),
                // SizedBox(width: 5),
                // SizedBox(
                //   child: Container(height: 15, width: 1, color: textColor2),
                // ),
                // SizedBox(width: 5),
                Text(
                  "Còn ${product.stock} sản phẩm",
                  style: TextStyle(color: textColor2, fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${NumberFormat("#,###", "vi_VN").format(product.price)} vnđ",
                    style: TextStyle(
                      fontFamily: "LD",
                      fontWeight: FontWeight.bold,
                      color: red,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final userId = prefs.getString('userId');
                      int id = int.parse(userId!);
                      final request = AddCartRequest(
                        userId: id,
                        id: product.id,
                      );
                      final response = await CartService.addToCart(request);
                      if (response != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.download_done_rounded, color: white),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "Đã thêm vào giỏ hàng",
                                    style: TextStyle(fontFamily: "LD"),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: textColor1,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(20),
                            duration: const Duration(seconds: 2),
                            elevation: 8,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.error_outline, color: white),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "Thêm vào giỏ hàng thất bại",
                                    style: TextStyle(fontFamily: "LD"),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: textColor1,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(20),
                            duration: const Duration(seconds: 2),
                            elevation: 8,
                          ),
                        );
                      }
                    },
                    child: Icon(
                      Icons.shopping_cart_checkout_outlined,
                      color: mainColor,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
