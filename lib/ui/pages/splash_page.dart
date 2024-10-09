import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/auth/auth_bloc.dart';
import 'package:fundriser/shared/theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: blueColor,
      backgroundColor: whiteColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
          } 
          
          if (state is AuthFailed) {
            Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
          }
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.38),
                Image.asset(
                  // "assets/logo.png",
                  "assets/icon/icon.png",
                  width: 140,
                  height: 140,
                ),
                const SizedBox(height: 2),
                // Text(
                //   "Fundriser",
                //   style:
                //       whiteTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
                // )
                Text(
                  "emha",
                  style:
                      grayTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
                ),
                Spacer(),
                Text(
                    "version 2.0.0",
                    style:
                        grayTextStyle.copyWith(fontSize: 16),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
