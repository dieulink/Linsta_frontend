import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:linsta_app/models/response/product.dart';
import 'package:linsta_app/screens/home_screens/widgets/app_bar_brand_custom.dart';
import 'package:linsta_app/screens/home_screens/widgets/app_bar_search.dart';
import 'package:linsta_app/screens/home_screens/widgets/app_bar_search_cate.dart';
import 'package:linsta_app/screens/home_screens/widgets/item_product.dart';
import 'package:linsta_app/services/category_service.dart';
import 'package:linsta_app/services/product_service.dart';
import 'package:linsta_app/ui_values.dart';

class BrandItemPage extends StatefulWidget {
  final String name;
  final String image;
  const BrandItemPage({super.key, required this.image, required this.name});

  @override
  State<BrandItemPage> createState() => _SearchItemPageState();
}

class _SearchItemPageState extends State<BrandItemPage> {
  List<Product> products = [];
  int currentPage = 0;
  bool isLoading = false;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadProducts() async {
    if (isLoading || !hasMore || widget.name.isEmpty) return;
    setState(() => isLoading = true);

    final results = await CategoryService.searchInBrand(
      keyword: widget.name,
      page: currentPage,
      size: 15,
    );

    setState(() {
      if (results.isEmpty) {
        hasMore = false;
      } else {
        currentPage++;
        products.addAll(results);
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading) {
        _loadProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBrandCustom(name: "${widget.name}"),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(5),
                child: Image.asset(
                  widget.image,
                  height: 200,
                  width: getWidth(context),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: products.isEmpty
                  ? const Center(child: Text("Không tìm thấy sản phẩm"))
                  : MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: products.length + (hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < products.length) {
                          return ItemProduct(product: products[index]);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
