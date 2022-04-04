import 'package:pyxl_assignment/models/portfolio/portfolio.dart';

class PortfolioApi {
  static Future<Portfolio> getUserPortfolio(String username) async {
    await Future.delayed(Duration(seconds: 2));
    return Portfolio(
        accountType: "Ebl titanium account",
        accountNumber: "2234521",
        balance: 6190.0,
        numberOfCards: 5);
  }
}
