class DailyRevenue {
  final DateTime date;
  final int revenue;

  DailyRevenue({required this.date, required this.revenue});

  factory DailyRevenue.fromJson(Map<String, dynamic> json) {
    return DailyRevenue(
      date: DateTime.parse(json['date']),
      revenue: json['revenue'],
    );
  }
}
