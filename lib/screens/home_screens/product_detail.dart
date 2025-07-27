import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/models/response/item.dart';
import 'package:linsta_app/screens/home_screens/widgets/app_bar_custom.dart';
import 'package:linsta_app/screens/home_screens/widgets/product_image_slider.dart';
import 'package:linsta_app/services/category_service.dart';
import 'package:linsta_app/services/product_service.dart';
import 'package:linsta_app/ui_values.dart';

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
    );
  }
}
