import 'package:pyxl_assignment/mock_db/mock_apis/contacts/contacts.dart';
import 'package:pyxl_assignment/models/contact/contact.dart';

class SendMoneyState {
  List<Contact> contacts;
  Contact? selectedContact;
  double amount;
  bool isError;
  bool isSuccess;
  String responseMessage;

  SendMoneyState({
    required this.contacts,
    this.selectedContact,
    required this.amount,
    required this.isError,
    required this.responseMessage,
    required this.isSuccess,
  });

  factory SendMoneyState.initial() {
    return SendMoneyState(
      contacts: getUserContacts(),
      selectedContact: null,
      amount: 0.0,
      isError: false,
      responseMessage: "",
      isSuccess: false,
    );
  }

  factory SendMoneyState.loading(List<Contact> contacts, double amount) {
    return SendMoneyState(
      contacts: contacts,
      selectedContact: null,
      amount: amount,
      isError: false,
      responseMessage: "",
      isSuccess: false,
    );
  }

  factory SendMoneyState.failure(String responseMessage) {
    return SendMoneyState(
      contacts: [],
      selectedContact: null,
      amount: 0.0,
      isError: true,
      responseMessage: responseMessage,
      isSuccess: false,
    );
  }

  factory SendMoneyState.success(
      List<Contact> contacts,
      Contact selectedContact,
      double amount,
      String responseMessage,
      bool isSuccess) {
    return SendMoneyState(
      contacts: contacts,
      selectedContact: selectedContact,
      amount: amount,
      isError: false,
      responseMessage: responseMessage,
      isSuccess: isSuccess,
    );
  }

  SendMoneyState copyWith(
      {List<Contact>? contacts,
      Contact? selectedContact,
      double? amount,
      bool? isError,
      String? responseMessage,
      bool? isSuccess}) {
    return SendMoneyState(
      contacts: contacts ?? this.contacts,
      selectedContact: selectedContact ?? this.selectedContact,
      amount: amount ?? this.amount,
      isError: isError ?? this.isError,
      responseMessage: responseMessage ?? this.responseMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
