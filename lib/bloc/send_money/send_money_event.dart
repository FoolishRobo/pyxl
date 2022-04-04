import 'package:pyxl_assignment/models/contact/contact.dart';

abstract class SendMoneyEvent {}

class SearchUserInputChanged extends SendMoneyEvent {
  final String searchText;

  SearchUserInputChanged({required this.searchText});
}

class SendMoneyTransaction extends SendMoneyEvent {
  final List<Contact> contacts;
  final Contact selectedContact;
  final double amount;
  final String responseMessage;

  SendMoneyTransaction({required this.contacts, required this.selectedContact, required this.amount, required this.responseMessage,});
}

class SelectContact extends SendMoneyEvent {
  final Contact selectedContact;

  SelectContact({required this.selectedContact});
}
