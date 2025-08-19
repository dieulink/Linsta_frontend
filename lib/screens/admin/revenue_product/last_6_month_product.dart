import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/models/response/product.dart';
import 'package:linsta_app/models/response/product_revenue.dart';
import 'package:linsta_app/models/response/user_revenue.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:linsta_app/services/admin_service.dart';
import 'package:linsta_app/ui_values.dart';

class Last6MonthProduct extends StatefulWidget {
  const Last6MonthProduct({super.key});

  @override
  State<Last6MonthProduct> createState() => _Last6MonthProductState();
}

class _Last6MonthProductState extends State<Last6MonthProduct> {
  List<ProductRevenue> revenueList = [];
  bool isLoading = false;

  void fetchData() async {
    setState(() => isLoading = true);

    try {
      final data = await AdminService.fetchProductRevenue6Month();
      setState(() => revenueList = data);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    }

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(name: "Thống kê doanh thu 6 tháng gần nhất"),
      body: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : revenueList.isEmpty
              ? const Center(
                  child: Text(
                    'Không có dữ liệu',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(textColor1),
                    headingTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      fontFamily: "LD",
                    ),
                    dataRowColor: MaterialStateProperty.resolveWith<Color?>((
                      Set<MaterialState> states,
                    ) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.grey.shade200;
                      }
                      return null;
                    }),
                    columnSpacing: 20,
                    dataRowHeight: 80,
                    headingRowHeight: 70,
                    columns: const [
                      DataColumn(
                        label: Center(
                          child: Text('ID', style: TextStyle(fontSize: 10)),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            'Hình ảnh',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            'Tên sản phẩm',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            'Số lượng đã bán',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            'Doanh thu',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(revenueList.length, (index) {
                      final product = revenueList[index];
                      return DataRow(
                        color: MaterialStateProperty.all(
                          index % 2 == 0 ? Colors.grey.shade100 : Colors.white,
                        ),
                        cells: [
                          DataCell(
                            Center(
                              child: Text(
                                product.productId.toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "LD",
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Image.network(
                                "${product.imageUrl}",
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              width: 80,
                              child: Text(
                                product.productName.toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "LD",
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 5,
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Text(
                                product.totalSold.toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "LD",
                                ),
                              ),
                            ),
                          ),

                          DataCell(
                            Center(
                              child: Text(
                                '${NumberFormat("#,###", "vi_VN").format(product.totalRevenue)}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "LD",
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
        ),
      ),
    );
  }
}
