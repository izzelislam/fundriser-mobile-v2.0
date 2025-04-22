import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/auth/auth_bloc.dart';
import 'package:fundriser/model/login_model.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void showCustomSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool validateForm() {
    if (phoneController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void handleLogin() {
    if (validateForm()) {
      context.read<AuthBloc>().add(
        AuthLogin(
          LoginModel(
            phoneNumber: phoneController.text,
            password: passwordController.text
          )
        )
      );
    }else{
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: redColor,
        duration: const Duration(seconds: 2),
        message: 'Nomor telepon dan password harus diisi',
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {

            if (state is AuthLoading) {
              setState(() {
                isLoading = true;
              });
            }
            
            if (state is AuthFailed){
              setState(() {
                isLoading = false;
              });

              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: redColor,
                message: state.message,
                duration: const Duration(seconds: 3),
                icon: const Icon(Icons.error, color:Colors.white),
                
              ).show(context);
            }

            if (state is AuthSuccess) {
              setState(() {
                isLoading = false;
              });
              print(state.data);
              Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
            }
        },
        builder: (context, state) {
          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Image.asset(
                    "assets/il_login.png",
                  ),
                  const SizedBox(height: 34),
                  Text(
                    "Selamat Datang !",
                    style: darkGrayTextStyle700.copyWith(
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    "Silahkan masukkan no hp dan \npassword anda untuk melanjutkan ",
                    style: grayTextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 34),
                  CustomInput(
                    label: "No. Handphone",
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    hintText: "Masukkan no hp anda",
                  ),
                  CustomInput(
                    label: "Password",
                    obscureText: true,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Masukkan password anda",
                  ),
                  Text(
                    "lupa password ? silahkan hubunggi admin. ",
                    style: grayTextStyle.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  CustomButton(
                    isLoading: isLoading,
                    title: "Masuk",
                    onPressed: () {
                        handleLogin();
                    }),
                ],
              ),
            ],
          );
        },
      ),
    ));
  }
}
