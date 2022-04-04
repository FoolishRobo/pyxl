import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/auth/auth_bloc.dart';
import 'package:pyxl_assignment/bloc/login/login_bloc.dart';
import 'package:pyxl_assignment/bloc/login/login_event.dart';
import 'package:pyxl_assignment/bloc/login/login_state.dart';
import 'package:pyxl_assignment/utils/colors/colors.dart';
import 'package:pyxl_assignment/view/app/app.dart';
import 'package:pyxl_assignment/view/register/register_view.dart';
import 'package:pyxl_assignment/view/widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(LoginState.initial(), context),
          ),
        ],
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _usernameField(),
              _passwordField(),
              vSpace(12),
              _loginButton(),
              vSpace(8),
              _registerText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState) {
        return TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Username',
          ),
          validator: (value) => null,
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(UserNameInputChanged(userName: value)),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.security),
            hintText: 'Password',
          ),
          validator: (value) => null,
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(PasswordInputChanged(password: value)),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, loginState) {
        if (loginState.isFailure)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Wrong username or password"),
            ),
          );
        else if (loginState.isSuccess) {
          AuthBloc auth = BlocProvider.of<AuthBloc>(context);
          if (auth.state.user != null) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => App(auth.state.user)),
                (route) => false);
          }
        }
      },
      builder: (context, loginState) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
                userName: loginState.userName, password: loginState.password));
          },
          child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xff199EFF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
                child: loginState.isSubmitting
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
          ),
        );
      },
    );
  }

  Widget _registerText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Register()));
      },
      child: Container(
        height: 20,
        width: 200,
        color: Colors.transparent,
        child: Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Don\'t have an account? '),
                TextSpan(
                  text: 'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
