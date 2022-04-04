import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/auth/auth_bloc.dart';
import 'package:pyxl_assignment/bloc/splash/splash_cubit.dart';
import 'package:pyxl_assignment/view/splash/splash_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SplashCubit>(
            create: (_) => SplashCubit(),
          ),
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(),
          ),
        ],
        child: SplashView(),
      ),
    );
  }
}
