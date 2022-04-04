import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/auth/auth_bloc.dart';
import 'package:pyxl_assignment/bloc/auth/auth_event.dart';
import 'package:pyxl_assignment/bloc/auth/auth_state.dart';
import 'package:pyxl_assignment/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.user == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => MyApp()), (route) => false);
          }
        },
        builder: (context, state) {
          return Container(
            child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(UserLoggedOut());
                    },
                    child: Text('Logout'))),
          );
        },
      ),
    );
  }
}
