import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/send_money/send_money_event.dart';
import 'package:pyxl_assignment/bloc/send_money/send_money_state.dart';
import 'package:pyxl_assignment/mock_db/mock_apis/contacts/contacts.dart';
import 'package:pyxl_assignment/models/contact/contact.dart';
import 'package:pyxl_assignment/utils/utils.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  SendMoneyBloc() : super(SendMoneyState.initial()) {
    on<SearchUserInputChanged>((event, emit) async {
      List<Contact> contacts = getUserContacts();
      contacts = contacts
          .where((Contact contact) =>
              contactNameContainsText(event.searchText, contact.fullName()))
          .toList();
      emit(state.copyWith(contacts: contacts));
    });
    on<SelectContact>((event, emit) async {
      emit(state.copyWith(selectedContact: event.selectedContact));
    });
    on<SendMoneyTransaction>((event, emit) {
      emit(SendMoneyState.success(event.contacts, event.selectedContact,
          event.amount, "Transaction Successful", true));
    });
  }
}
