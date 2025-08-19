import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/models/response/user_revenue.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:linsta_app/services/admin_service.dart';
import 'package:linsta_app/ui_values.dart';

class ByMonth extends StatefulWidget {
  const ByMonth({super.key});

  @override
  State<ByMonth> createState() => _ByMonthState();
}

class _ByMonthState extends State<ByMonth> {
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  List<UserRevenue> revenueList = [];
  bool isLoading = false;

  void fetchData() async {
    final month = int.tryParse(monthController.text) ?? 0;
    final year = int.tryParse(yearController.text) ?? 0;

    if (month <= 0 || month > 12 || year <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập tháng/năm hợp lệ')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final data = await AdminService.fetchRevenueByMonth(month, year);
      setState(() => revenueList = data);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    }

    setState(() => isLoading = false);
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return SizedBox(
      width: getWidth(context) * 0.3,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(color: textColor2, fontFamily: "LD"),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: textColor2),
          hintText: hint,
          hintStyle: TextStyle(color: textColor2),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor1, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor1, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(name: "Thống kê doanh thu theo tháng"),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                buildInputField(
                  controller: monthController,
                  hint: "Tháng",
                  icon: Icons.calendar_today,
                ),
                const SizedBox(width: 10),
                buildInputField(
                  controller: yearController,
                  hint: "Năm",
                  icon: Icons.date_range,
                ),
                const Spacer(),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: fetchData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: textColor1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      "Lọc",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
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
                        dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.grey.shade200;
                            }
                            return null;
                          },
                        ),
                        columnSpacing: 25,
                        // dataRowHeight: 60,
                        // headingRowHeight: 70,
                        columns: const [
                          DataColumn(label: Center(child: Text('ID'))),
                          DataColumn(label: Center(child: Text('Tên'))),
                          DataColumn(label: Center(child: Text('Đơn hàng'))),
                          DataColumn(label: Center(child: Text('Sản phẩm'))),
                          DataColumn(label: Center(child: Text('Tổng tiền'))),
                        ],
                        rows: List.generate(revenueList.length, (index) {
                          final user = revenueList[index];
                          return DataRow(
                            color: MaterialStateProperty.all(
                              index % 2 == 0
                                  ? Colors.grey.shade100
                                  : Colors.white,
                            ),
                            cells: [
                              DataCell(
                                Center(
                                  child: Text(
                                    user.userId.toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: "LD",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    user.userName,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: "LD",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    user.orderCount.toString(),
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
                                    user.productCount.toString(),
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
                                    '${NumberFormat("#,###", "vi_VN").format(user.totalPrice)}',
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
          ],
        ),
      ),
    );
  }
}
