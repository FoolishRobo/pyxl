import 'package:pyxl_assignment/models/contact/contact.dart';
import 'package:pyxl_assignment/models/transaction/transaction.dart';

class TransactionHistoryApi {
  static Future<List<Transaction>> getUserTransactions(String username) async {
    await Future.delayed(Duration(seconds: 3));
    return [
      Transaction(
        contact: Contact(
          firstName: "Rebeka",
          secondName: "ratry",
          image: "assets/user_images/user2.png",
        ),
        date: DateTime.parse("2022-01-22 23:05:27.720"),
        amount: 1190,
        isOutGoing: false,
      ),
      Transaction(
        contact: Contact(
          firstName: "Sazzin",
          secondName: "molla",
          image: "assets/user_images/user3.png",
        ),
        date: DateTime.parse("2022-01-21 23:05:27.720"),
        amount: 75,
        isOutGoing: true,
      ),
      Transaction(
        contact: Contact(
          firstName: "Tonim",
          secondName: "khan",
          image: "assets/user_images/user4.png",
        ),
        date: DateTime.parse("2022-01-20 23:05:27.720"),
        amount: 220,
        isOutGoing: true,
      ),
      Transaction(
        contact: Contact(
          firstName: "Adrito",
          secondName: "rafsan",
          image: "assets/user_images/user5.png",
        ),
        date: DateTime.parse("2022-01-19 23:05:27.720"),
        amount: 2000,
        isOutGoing: false,
      ),
      Transaction(
        contact: Contact(
          firstName: "Sazzin",
          secondName: "molla",
          image: "assets/user_images/user3.png",
        ),
        date: DateTime.parse("2021-12-31 23:05:27.720"),
        amount: 75,
        isOutGoing: true,
      ),
      Transaction(
        contact: Contact(
          firstName: "Tonim",
          secondName: "khan",
          image: "assets/user_images/user4.png",
        ),
        date: DateTime.parse("2021-12-25 23:05:27.720"),
        amount: 220,
        isOutGoing: true,
      ),
    ];
  }
}
