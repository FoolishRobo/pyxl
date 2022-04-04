import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/auth/auth_bloc.dart';
import 'package:pyxl_assignment/bloc/splash/splash_cubit.dart';
import 'package:pyxl_assignment/bloc/splash/splash_state.dart';
import 'package:pyxl_assignment/utils/colors/colors.dart';
import 'package:pyxl_assignment/view/app/app.dart';
import 'package:pyxl_assignment/view/login/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    BlocProvider.of<SplashCubit>(context).aquireAuthData(context);
    Future.delayed(Duration(milliseconds: 500), () {
      BlocProvider.of<SplashCubit>(context).onAnimationStart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, splashState) {
            if (splashState == SplashState.isLogedIn) {
              AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
              if (authBloc.state.user != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => App(authBloc.state.user),
                  ),
                );
              }
            } else if (splashState == SplashState.isLogedOut)
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) => Login()), (route) => false);
          },
          builder: (context, splashState) {
            return AnimatedOpacity(
              duration: Duration(milliseconds: 1500),
              opacity: splashState != SplashState.idle ? 1.0 : 0.0,
              child: Text(
                'Pyxl Wallet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  wordSpacing: 2,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
