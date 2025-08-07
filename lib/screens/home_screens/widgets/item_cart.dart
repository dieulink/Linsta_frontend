import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/services/cart_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemCart extends StatefulWidget {
  final String imgPath;
  final String name;
  final int price;
  final int quantity;
  final int productId;
  final VoidCallback onDeleteSuccess;
  final VoidCallback onIncreaseSuccess;
  final VoidCallback onDecreaseSuccess;

  const ItemCart({
    super.key,
    required this.imgPath,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.onDeleteSuccess,
    required this.onIncreaseSuccess,
    required this.onDecreaseSuccess,
  });

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      //margin: EdgeInsets.only(bottom: 1),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        //border: Border.all(color: borderColor),
        //borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            widget.imgPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset("assets/imgs/default.jpg");
            },
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getWidth(context) * 0.4,
                      child: Text(
                        widget.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "LD",
                          fontWeight: FontWeight.bold,
                          color: textColor3,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    // SizedBox(width: 20),
                    InkWell(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final userId = prefs.getString('userId');
                        int id = int.parse(userId!);
                        final response = await CartService.deleteFromCart(
                          widget.productId,
                          id,
                        );
                        if (response != null) {
                          widget.onDeleteSuccess();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.download_done_rounded,
                                    color: white,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      "Đã xóa sản phẩm khỏi giỏ hàng",
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
                              duration: const Duration(seconds: 1),
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
                                      "Xóa sản phẩm khỏi giỏ hàng thất bại",
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
                              duration: const Duration(seconds: 1),
                              elevation: 8,
                            ),
                          );
                        }
                      },
                      child: Container(
                        child: Icon(
                          Icons.delete_outline,
                          color: textColor2,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "${NumberFormat("#,###", "vi_VN").format(widget.price)}",
                        style: TextStyle(
                          fontFamily: "LD",
                          fontWeight: FontWeight.bold,
                          color: red,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: borderColor),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final userId = prefs.getString('userId');
                              int id = int.parse(userId!);
                              final response = await CartService.decrease(
                                widget.productId,
                                id,
                              );
                              //print("đây là responsee $response");
                              if (response != null) {
                                widget.onDecreaseSuccess();
                                print("okeee");
                              } else {
                                print(response);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(Icons.error_outline, color: white),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            "Giảm số lượng sản phẩm thất bại",
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
                            icon: const Icon(Icons.remove, size: 15),
                            color: textColor2,
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "${widget.quantity}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: textColor2,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final userId = prefs.getString('userId');
                              int id = int.parse(userId!);
                              final response = await CartService.increase(
                                widget.productId,
                                id,
                              );
                              //print("đây là responsee $response");
                              if (response != null) {
                                widget.onIncreaseSuccess();
                                print("okeee");
                              } else {
                                print(response);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(Icons.error_outline, color: white),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            "Tăng số lượng sản phẩm thất bại",
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
                            icon: const Icon(Icons.add, size: 15),
                            color: textColor2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
