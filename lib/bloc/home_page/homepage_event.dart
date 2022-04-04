import 'package:pyxl_assignment/models/transaction/transaction.dart';

abstract class HomePageEvent {}

class GetPortfolioAndTransactionHistory extends HomePageEvent {
  final String userName;

  GetPortfolioAndTransactionHistory({required this.userName});
}

class AddTransaction extends HomePageEvent {
  final Transaction transaction;

  AddTransaction({required this.transaction});
}
