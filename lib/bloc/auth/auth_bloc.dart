import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/auth/auth_event.dart';
import 'package:pyxl_assignment/bloc/auth/auth_state.dart';
import 'package:pyxl_assignment/services/login/login_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<UserLogedIn>((event, emit) {
      emit(AuthState.loggedIn(event.user));
    });
    on<UserLoggedOut>((event, emit) {
      LoginService().logout();
      emit(AuthState.loggedOut());
    });
  }
}
