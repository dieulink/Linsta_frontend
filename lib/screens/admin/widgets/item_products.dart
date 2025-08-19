import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/models/request/add_cart_request.dart';
import 'package:linsta_app/models/response/product.dart';
import 'package:linsta_app/screens/admin/widgets/detail_product.dart';
import 'package:linsta_app/screens/home_screens/product_detail.dart';
import 'package:linsta_app/services/cart_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:linsta_app/screens/home_screens/widgets/item_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemProducts extends StatelessWidget {
  final Product product;

  const ItemProducts({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailProduct(id: product.id),
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
                  child: Text(
                    "ID: ${product.id}",
                    style: TextStyle(
                      color: textColor1,
                      fontSize: 12,
                      fontFamily: "LD",
                      fontWeight: FontWeight.bold,
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
