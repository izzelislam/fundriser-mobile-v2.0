import 'package:flutter/material.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CustomInput(label: "Password Lama", obscureText: true,),
            const CustomInput(label: "Password Baru", obscureText: true,),
            const CustomInput(label: "Konfirmasi Password Baru", obscureText: true,),
            const SizedBox(height: 20),
            CustomButton(title: "Ubah Password", onPressed: () {},)
          ],
        ),
      ),
    );
  }
}