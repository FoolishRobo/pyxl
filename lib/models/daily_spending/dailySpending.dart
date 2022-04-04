import 'package:pyxl_assignment/models/daily_spending/spending.dart';

class DailySpending {
  DateTime date;
  List<Spending> spendings;
  double income;

  DailySpending({
    required this.date,
    required this.spendings,
    required this.income,
  });
}
