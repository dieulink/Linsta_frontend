import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/models/response/daily_revenue.dart';
import 'package:linsta_app/screens/admin/widgets/app_bar_home.dart';
import 'package:linsta_app/screens/admin/widgets/item_new_by_month.dart';
import 'package:linsta_app/screens/admin/widgets/tag_home.dart';
import 'package:linsta_app/services/admin_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  String adminName = "";
  List<Map<String, dynamic>> data = [];

  AdminService adminService = AdminService();
  Map<String, dynamic>? _thisMonth;

  Future<void> _loadAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      adminName = prefs.getString('name') ?? 'Không có';
      print("Admin Name: $adminName");
    });
  }

  Future<void> _loadOrderByMonth() async {
    final ThisMonth = await adminService.getThisMonth();

    setState(() {
      _thisMonth = ThisMonth;
    });
  }

  Future<void> _loadRevenue7day() async {
    final getData = await adminService.getRevenue7day();

    setState(() {
      data = getData.map((item) {
        return {'date': item.date, 'revenue': item.revenue};
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAdmin();
    _loadOrderByMonth();
    _loadRevenue7day();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarHome(name: adminName),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 1,
                margin: EdgeInsets.only(top: 10, bottom: 20),
                color: borderColor,
              ),
              Container(
                child: Text(
                  "Thống kê theo tháng",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ItemNewByMonth(
                    title: "Đơn hàng mới",
                    count: "${_thisMonth?['orderThisMonth']}",
                    percentage: "${_thisMonth?['orderGrowthRate']}%",
                    color: mainColor,
                  ),
                  SizedBox(width: 10),
                  ItemNewByMonth(
                    title: "Người dùng mới",
                    count: "${_thisMonth?['userThisMonth']}",
                    percentage: "${_thisMonth?['userGrowthRate']}%",
                    color: textColor1,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ItemNewByMonth(
                    title: "Doanh thu",
                    count:
                        "${NumberFormat("#,###", "vi_VN").format(_thisMonth?['thisMonthTotalPrice'])}",
                    percentage: "${_thisMonth?['priceGrowth']}%",
                    color: textColor1,
                  ),
                  SizedBox(width: 10),
                  ItemNewByMonth(
                    title: "Số lượng bán ra",
                    count: "${_thisMonth?['thisMonthQuantity']}",
                    percentage: "${_thisMonth?['quantityGrowth']}%",
                    color: mainColor,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  "Doanh thu 7 ngày gần nhất",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 300,
                  child: LineChart(
                    LineChartData(
                      minY: 0,
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                "${value ~/ 1000}k",
                                style: const TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index < 0 || index >= data.length)
                                return const SizedBox();

                              final dateValue = data[index]['date'];
                              DateTime date;
                              if (dateValue is String) {
                                date = DateTime.parse(dateValue);
                              } else if (dateValue is DateTime) {
                                date = dateValue;
                              } else {
                                return const SizedBox();
                              }

                              String formattedDate = DateFormat(
                                'dd/MM',
                              ).format(date);
                              return Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            data.length,
                            (index) => FlSpot(
                              index.toDouble(),
                              (data[index]['revenue'] as num).toDouble(),
                            ),
                          ),
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  "Quản lý",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TagHome(
                imgPath: "assets/icons/system_icon/24px/List.png",
                name: "Quản lý đơn hàng",
                ontap: "adminManageOrder",
              ),
              TagHome(
                imgPath: "assets/icons/system_icon/24px/User.png",
                name: "Quản lý người dùng",
                ontap: "adminManageUser",
              ),
              TagHome(
                imgPath: "assets/icons/system_icon/24px/bag.png",
                name: "Quản lý sản phẩm",
                ontap: "",
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
