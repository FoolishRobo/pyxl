import 'package:pyxl_assignment/models/portfolio/portfolio.dart';
import 'package:pyxl_assignment/models/transaction/transaction.dart';

class HomePageState {
  Portfolio portfolio;
  List<Transaction> transactions;
  bool isError;

  HomePageState({
    required this.portfolio,
    required this.transactions,
    required this.isError,
  });

  factory HomePageState.initial() {
    return HomePageState(
      portfolio: Portfolio.initial(),
      transactions: [],
      isError: false,
    );
  }

  factory HomePageState.loading() {
    return HomePageState(
      portfolio: Portfolio.initial(),
      transactions: [],
      isError: false,
    );
  }

  factory HomePageState.failure() {
    return HomePageState(
      portfolio: Portfolio.initial(),
      transactions: [],
      isError: true,
    );
  }

  factory HomePageState.success(
      Portfolio portfolio, List<Transaction> transactions) {
    return HomePageState(
      portfolio: portfolio,
      transactions: transactions,
      isError: false,
    );
  }

  HomePageState copyWith({
    Portfolio? portfolio,
    List<Transaction>? transactions,
    bool? isError,
  }) {
    return HomePageState(
      portfolio: portfolio ?? this.portfolio,
      transactions: transactions ?? this.transactions,
      isError: isError ?? this.isError,
    );
  }
}
