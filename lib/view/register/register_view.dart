import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/register/register_bloc.dart';
import 'package:pyxl_assignment/bloc/register/register_event.dart';
import 'package:pyxl_assignment/bloc/register/register_state.dart';
import 'package:pyxl_assignment/utils/colors/colors.dart';
import 'package:pyxl_assignment/view/widgets.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterBloc(RegisterState.initial()),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _firstNameField(),
              _secondNameField(),
              _usernameField(),
              _passwordField(),
              vSpace(12),
              _registerButton(),
              vSpace(8),
              _loginText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstNameField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, loginState) {
        return TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'First Name',
          ),
          validator: (value) => null,
          onChanged: (value) => context
              .read<RegisterBloc>()
              .add(FirstNameInputChanged(firstName: value)),
        );
      },
    );
  }

  Widget _secondNameField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, loginState) {
        return TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Second Name',
          ),
          validator: (value) => null,
          onChanged: (value) => context
              .read<RegisterBloc>()
              .add(SecondNameInputChanged(secondName: value)),
        );
      },
    );
  }

  Widget _usernameField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, loginState) {
        return TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Username',
          ),
          validator: (value) => null,
          onChanged: (value) => context
              .read<RegisterBloc>()
              .add(UserNameInputChanged(username: value)),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.security),
            hintText: 'Password',
          ),
          validator: (value) => null,
          onChanged: (value) => context
              .read<RegisterBloc>()
              .add(PasswordInputChanged(password: value)),
        );
      },
    );
  }

  Widget _registerButton() {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, registerState) {
        if (registerState.isFailure)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(registerState.responeMessage),
            ),
          );
        else if (registerState.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(registerState.responeMessage),
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, registerState) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<RegisterBloc>(context).add(RegisterButtonPressed(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              firstName: registerState.firstName,
              secondName: registerState.secondName,
              username: registerState.username,
              password: registerState.password,
              image: "assets/user_images/user1.png",
              contactUserIds: [],
            ));
          },
          child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xff199EFF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
                child: registerState.isSubmitting
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
          ),
        );
      },
    );
  }

  Widget _loginText() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 20,
        width: 200,
        color: Colors.transparent,
        child: Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Already have an account? '),
                TextSpan(
                  text: 'Login',
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
