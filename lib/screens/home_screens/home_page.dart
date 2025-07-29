import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:linsta_app/models/response/product.dart';
import 'package:linsta_app/models/response/product_category.dart';
import 'package:linsta_app/screens/home_screens/category_item_page.dart';
import 'package:linsta_app/screens/home_screens/widgets/item_product.dart';
import 'package:linsta_app/screens/home_screens/widgets/search_input.dart';
import 'package:linsta_app/services/category_service.dart';
import 'package:linsta_app/services/product_service.dart';
import 'package:linsta_app/ui_values.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  List<Product> _products = [];
  List<ProductCategory> _categories = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 0;
  final int _size = 20;
  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadCategories();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await CategoryService.fetchCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print("Lỗi khi load category: $e");
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _loadProducts();
    }
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    try {
      final products = await ProductService.fetchProducts(
        page: _page,
        size: _size,
      );

      setState(() {
        _products.addAll(products);
        _isLoading = false;
        _page++;

        if (products.length < _size) {
          _hasMore = false;
        }
      });
    } catch (e) {
      print("Lỗi khi tải sản phẩm: $e");
      setState(() {
        _isLoading = false;
        _hasMore = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: SafeArea(
          child: Container(
            color: mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [mainColor, backgroudColor],
            stops: [0.8, 0.9],
            center: Alignment.topCenter,
            radius: 1,
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset("assets/imgs/logo_blue.png", height: 200),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   child:
              // //   Text(
              // //     "Danh mục sản phẩm",
              // //     overflow: TextOverflow.ellipsis,
              // //     style: TextStyle(
              // //       fontFamily: "LD",
              // //       fontWeight: FontWeight.bold,
              // //       color: textColor1,
              // //       fontSize: 16,
              // //     ),
              // //   ),
              // // ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((Category) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 115,
                        width: 85,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => CategoryItemPage(
                                          id: Category.id,
                                          name: Category.name,
                                        ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 60,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(color: borderColor),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    100,
                                  ),
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
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              SizedBox(height: 10),
              MasonryGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _products.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < _products.length) {
                    return ItemProduct(product: _products[index]);
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
