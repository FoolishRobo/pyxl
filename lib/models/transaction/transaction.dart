import 'package:pyxl_assignment/models/contact/contact.dart';

class Transaction {
  Contact contact;
  DateTime date;
  double amount;
  bool isOutGoing;

  Transaction({
    required this.contact,
    required this.date,
    required this.amount,
    required this.isOutGoing,
  });

  factory Transaction.fromMap(Map<dynamic, dynamic> transaction) {
    return Transaction(
      contact: Contact.fromMap(transaction["contact"]),
      date: DateTime.parse(transaction["date"]),
      amount: transaction["amount"],
      isOutGoing: transaction["isOutGoing"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "contact": contact.toMap(),
      "date": date.toIso8601String(),
      "amount": amount,
      "isOutGoing": isOutGoing,
    };
  }

  Transaction copyWith({
    Contact? contact,
    DateTime? date,
    double? amount,
    bool? isOutGoing,
  }) {
    return Transaction(
      contact: contact ?? this.contact,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      isOutGoing: isOutGoing ?? this.isOutGoing,
    );
  }
}
