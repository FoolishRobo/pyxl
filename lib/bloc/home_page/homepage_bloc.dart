import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/home_page/homepage_event.dart';
import 'package:pyxl_assignment/bloc/home_page/homepage_state.dart';
import 'package:pyxl_assignment/mock_db/mock_apis/portfolio/porfolio_api.dart';
import 'package:pyxl_assignment/mock_db/mock_apis/transaction_history/transaction_history_api.dart';
import 'package:pyxl_assignment/models/portfolio/portfolio.dart';
import 'package:pyxl_assignment/models/transaction/transaction.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageState.initial()) {
    on<GetPortfolioAndTransactionHistory>((event, emit) async {
      await Future.wait([
        PortfolioApi.getUserPortfolio(event.userName),
        TransactionHistoryApi.getUserTransactions(event.userName),
      ]).then((value) {
        emit(HomePageState.loading());
        emit(HomePageState.success(
            value[0] as Portfolio, value[1] as List<Transaction>));
      });
    });
    on<AddTransaction>((event, emit) {
      emit(HomePageState.success(
          state.portfolio, [event.transaction, ...state.transactions]));
    });
  }
}
