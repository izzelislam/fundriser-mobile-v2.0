import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/auth/auth_bloc.dart';
import 'package:fundriser/shared/theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
          } 
          
          if (state is AuthFailed) {
            Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                width: 82,
                height: 82,
              ),
              const SizedBox(height: 2),
              Text(
                "Fundriser",
                style:
                    whiteTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
