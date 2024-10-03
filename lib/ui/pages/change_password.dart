import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/auth/auth_bloc.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isLoading = false;

  TextEditingController oldPasswordField = TextEditingController();
  TextEditingController newPasswordField = TextEditingController();
  TextEditingController confirmNewPasswordField = TextEditingController();

  bool validate () {
    if (oldPasswordField.text == "" || newPasswordField.text == "" || confirmNewPasswordField.text == "") {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              setState(() {
                isLoading = false;
              });
              Navigator.pop(context); 
              successSnackbar(context, "Berhasil mengubah password");
            }

            if (state is AuthFailed) {
              setState(() {
                isLoading = false;
              });
              customSnackbar(context, state.message);
            }

            if (state is AuthLoading) {
              setState(() {
                isLoading = true;
              });
            }
            
          },
          child: Column(
            children: [
              CustomInput(
                  label: "Password Lama",
                  obscureText: true,
                  controller: oldPasswordField),
              CustomInput(
                  label: "Password Baru",
                  obscureText: true,
                  controller: newPasswordField),
              CustomInput(
                  label: "Konfirmasi Password Baru",
                  obscureText: true,
                  controller: confirmNewPasswordField),
              const SizedBox(height: 20),
              CustomButton(
                isLoading: isLoading,
                title: "Ubah Password",
                onPressed: () {
                  if (validate()){
                    if (newPasswordField.text != confirmNewPasswordField.text) {
                      customSnackbar(context, "Konfirmasi password tidak sesuai");
                    }else{
                      context.read<AuthBloc>().add(AuthUpdatePassword(
                          oldPasswordField.text,
                          newPasswordField.text,
                          confirmNewPasswordField.text));
                    }
                  }else{
                    customSnackbar(context, "Semua kolom harus diisi");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
