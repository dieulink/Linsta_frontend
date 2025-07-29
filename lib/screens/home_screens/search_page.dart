import 'package:flutter/material.dart';
import 'package:linsta_app/models/response/brand.dart';
import 'package:linsta_app/models/response/product_category.dart';
import 'package:linsta_app/screens/home_screens/brand_item_page.dart';
import 'package:linsta_app/screens/home_screens/category_item_page.dart';
import 'package:linsta_app/screens/home_screens/widgets/search_input.dart';
import 'package:linsta_app/services/category_service.dart';
import 'package:linsta_app/ui_values.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ProductCategory> _categories = [];
  List<Brand> _brand = [
    Brand(name: "Campus", image: "assets/icons/cate_icon/campus.png"),
    Brand(name: "Casio", image: "assets/icons/cate_icon/casio.png"),
    Brand(name: "Deli", image: "assets/icons/cate_icon/deli.png"),
    Brand(name: "Fahasa", image: "assets/icons/cate_icon/fahasa.png"),
    Brand(name: "Hồng Hà", image: "assets/icons/cate_icon/hongha.png"),
    Brand(name: "Thiên Long", image: "assets/icons/cate_icon/thienlong.png"),
  ];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final data = await CategoryService.fetchCategories();
    setState(() {
      _categories = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: SafeArea(
          child: Container(
            color: mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SearchInput(
                        hintText: "Bạn muốn tìm gì ?",
                        iconPath: "assets/icons/system_icon/24px/Search.png",
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "cartPage");
                      },
                      child: Image.asset(
                        "assets/icons/system_icon/24px/Cart.png",
                        height: 50,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Danh mục sản phẩm",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "LD",
                    fontWeight: FontWeight.bold,
                    color: textColor1,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: GridView.count(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: _categories.map((Category) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        CategoryItemPage(
                                          id: Category.id,
                                          name: Category.name,
                                        ),
                                // transitionsBuilder:
                                //     (
                                //       context,
                                //       animation,
                                //       secondaryAnimation,
                                //       child,
                                //     ) {
                                //       return FadeTransition(
                                //         opacity: animation,
                                //         child: child,
                                //       );
                                //     },
                              ),
                            );
                          },

                          child: Container(
                            height: 50,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(7),
                              child: Image.asset(
                                "assets/icons/cate_icon/${Category.id}.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          Category.name,
                          style: TextStyle(
                            color: textColor1,
                            fontFamily: "LD",
                            fontSize: 10,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 30),
              Container(height: 1, color: borderColor),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Thương hiệu",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "LD",
                    fontWeight: FontWeight.bold,
                    color: textColor1,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: GridView.count(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: _brand.map((brand) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        BrandItemPage(
                                          image: brand.image,
                                          name: brand.name,
                                        ),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              child: Image.asset(
                                brand.image,
                                width: 50,
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadiusGeometry.circular(100),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          brand.name,
                          style: TextStyle(
                            color: textColor1,
                            fontFamily: "LD",
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
