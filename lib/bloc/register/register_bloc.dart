import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/register/register_event.dart';
import 'package:pyxl_assignment/bloc/register/register_state.dart';
import 'package:pyxl_assignment/models/error/respone_message.dart';
import 'package:pyxl_assignment/models/user/user.dart';
import 'package:pyxl_assignment/services/register/register_service.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(RegisterState initialState) : super(initialState) {
    on<FirstNameInputChanged>((event, emit) {
      emit(state.copyWith(
        firstName: event.firstName,
        isFailure: false,
        isSuccess: false,
      ));
    });
    on<SecondNameInputChanged>((event, emit) {
      emit(state.copyWith(
        secondName: event.secondName,
        isFailure: false,
        isSuccess: false,
      ));
    });
    on<UserNameInputChanged>((event, emit) {
      emit(state.copyWith(
        username: event.username,
        isFailure: false,
        isSuccess: false,
      ));
    });
    on<PasswordInputChanged>((event, emit) {
      emit(state.copyWith(
        password: event.password,
        isFailure: false,
        isSuccess: false,
      ));
    });
    on<RegisterButtonPressed>((event, emit) async {
      if (event.username.isEmpty ||
          event.password.isEmpty ||
          event.firstName.isEmpty ||
          event.secondName.isEmpty) {
        emit(RegisterState.failure(
            event.firstName,
            event.secondName,
            event.username,
            event.password,
            event.image,
            event.contactUserIds,
            'All fields are required'));
        return;
      }
      emit(RegisterState.registering(event.firstName, event.secondName,
          event.username, event.password, event.image, event.contactUserIds));
      User newUser = User(
        firstName: event.firstName,
        secondName: event.secondName,
        username: event.username,
        password: event.password,
        image: event.image,
        contactUserIds: event.contactUserIds,
      );
      ResponeMessage responeMessage =
          await RegisterService().registerUser(newUser);
      if (responeMessage.isError) {
        emit(RegisterState.failure(
            event.firstName,
            event.secondName,
            event.username,
            event.password,
            event.image,
            event.contactUserIds,
            responeMessage.message));
      } else {
        emit(RegisterState.success(
            event.firstName,
            event.secondName,
            event.username,
            event.password,
            event.image,
            event.contactUserIds,
            responeMessage.message));
      }
    });
  }
}
