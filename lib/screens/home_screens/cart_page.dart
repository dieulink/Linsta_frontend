import 'package:flutter/material.dart';
import 'package:linsta_app/screens/home_screens/widgets/app_bar_cart_custom.dart';
import 'package:linsta_app/ui_values.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCartCustom(),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Container(
          height: 100,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: white,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset("assets/icons/cate_icon/deli.png"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 250,
                          child: Text(
                            "Tên ở đây nèeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: "LD",
                              fontWeight: FontWeight.bold,
                              color: textColor1,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        // SizedBox(width: 20),
                        Container(
                          child: Icon(
                            Icons.delete_outline,
                            color: textColor2,
                            size: 32,
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
                            "giá tiền",
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
                                onPressed: () {},
                                icon: const Icon(Icons.remove, size: 15),
                                color: borderColor,
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: Text(
                                  '1',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: textColor1,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.add, size: 15),
                                color: borderColor,
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
        ),
      ),
    );
  }
}
