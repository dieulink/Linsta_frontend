import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/models/request/add_cart_request.dart';
import 'package:linsta_app/models/response/item.dart';
import 'package:linsta_app/screens/home_screens/widgets/app_bar_custom.dart';
import 'package:linsta_app/screens/home_screens/widgets/product_image_slider.dart';
import 'package:linsta_app/services/cart_service.dart';
import 'package:linsta_app/services/category_service.dart';
import 'package:linsta_app/services/product_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetail extends StatefulWidget {
  final int id;

  const ProductDetail({super.key, required this.id});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Item? _item;
  int? productId;

  @override
  void initState() {
    super.initState();
    _loadProductItem(widget.id);
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
      appBar: AppBarCustom(),
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
                      Text(
                        textAlign: TextAlign.justify,
                        _item!.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "LD",
                          fontWeight: FontWeight.bold,
                          color: textColor1,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _item!.description,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: "LD",
                          color: textColor2,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: mainColor),
                borderRadius: BorderRadius.circular(7),
              ),
              //width: getWidth(context) * 0.4,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (_item!.stock == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.error_outline, color: white),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Đã hết hàng",
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
                    final prefs = await SharedPreferences.getInstance();
                    final userId = prefs.getString('userId');
                    int id = int.parse(userId!);
                    final request = AddCartRequest(userId: id, id: _item!.id);
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
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'Thêm vào giỏ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: getWidth(context) * 0.4,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'Mua ngay',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
