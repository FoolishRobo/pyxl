import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/auth/auth_bloc.dart';
import 'package:pyxl_assignment/bloc/auth/auth_event.dart';
import 'package:pyxl_assignment/bloc/login/login_event.dart';
import 'package:pyxl_assignment/bloc/login/login_state.dart';
import 'package:pyxl_assignment/models/user/user.dart';
import 'package:pyxl_assignment/services/login/login_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState, BuildContext context) : super(initialState) {
    on<UserNameInputChanged>((event, emit) {
      emit(state.copyWith(
        userName: event.userName,
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
    on<LoginButtonPressed>((event, emit) async {
      if (event.userName.isEmpty || event.password.isEmpty) {
        return;
      }
      emit(LoginState.loading(event.userName, event.password));
      User? user = await LoginService().login(event.userName, event.password);
      
      if (user != null) {
        BlocProvider.of<AuthBloc>(context).add(UserLogedIn(user: user));
        emit(LoginState.success(event.userName, event.password));
      } else {
        emit(LoginState.failure(event.userName, event.password));
      }
    });
  }
  String email = '';
  String password = '';
}
