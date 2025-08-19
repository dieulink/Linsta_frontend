import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:linsta_app/models/response/product.dart';
import 'package:linsta_app/models/response/product_category.dart';
import 'package:linsta_app/screens/admin/widgets/app_bar_search.dart';
import 'package:linsta_app/screens/admin/widgets/item_products.dart';
import 'package:linsta_app/services/category_service.dart';
import 'package:linsta_app/services/product_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminManageProduct extends StatefulWidget {
  const AdminManageProduct({super.key});

  @override
  State<AdminManageProduct> createState() => _AdminManageProductState();
}

class _AdminManageProductState extends State<AdminManageProduct> {
  final ScrollController _scrollController = ScrollController();

  List<Product> _products = [];
  List<ProductCategory> _categories = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 0;
  final int _size = 20;
  String _address = '';
  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadCategories();
    _loadAddress();
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

  Future<void> _loadAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _address = prefs.getString('address') ?? 'Không có địa chỉ';
    });
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
            color: backgroudColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: textColor1,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: AppBarSearch(
                        hintText: "Bạn muốn tìm gì ?",
                        iconPath: "assets/icons/system_icon/24px/Search.png",
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

        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    return ItemProducts(product: _products[index]);
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
