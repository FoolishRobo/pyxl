import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/auth/auth_bloc.dart';
import 'package:pyxl_assignment/bloc/auth/auth_event.dart';
import 'package:pyxl_assignment/bloc/splash/splash_state.dart';
import 'package:pyxl_assignment/models/user/user.dart';
import 'package:pyxl_assignment/services/login/login_service.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.idle);

  void onAnimationStart() => emit(SplashState.startAnimation);
  void aquireAuthData(BuildContext context) => checkCurrentUser(context);

  checkCurrentUser(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2)); // waiting to wait for animation to finish
    User? user = await LoginService().getLoggedInUser();
    if (user != null) {
      BlocProvider.of<AuthBloc>(context).add(UserLogedIn(user: user));
      return emit(SplashState.isLogedIn);
    } else {
      BlocProvider.of<AuthBloc>(context).add(UserLoggedOut());
      return emit(SplashState.isLogedOut);
    }
  }
}
