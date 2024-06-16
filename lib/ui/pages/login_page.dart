import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.symmetric(
          horizontal: 32
        ),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Image.asset("assets/il_login.png",),
                const SizedBox(height: 34),
                Text("Selamat Datang !", style: darkGrayTextStyle700.copyWith(
                  fontSize: 19,
                ),),
                const SizedBox(height: 9),
                Text("Silahkan masukkan email dan \npassword anda untuk melanjutkan ", style: grayTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500
                ),),
                const SizedBox(height: 34),
            
                CustomInput(
                  label: "Email",
                  controller: TextEditingController(),
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Masukkan email anda",
                ),
                CustomInput(
                  label: "Password",
                  obscureText: true,
                  controller: TextEditingController(),
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "Masukkan password anda",
                ),
                Text("lupa password ? silahkan hubunggi admin. ", style: grayTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500
                ),),
                const SizedBox(height: 100,),
                CustomButton(title: "Masuk", onPressed: (){
                  Navigator.pushNamed(context, "/home");
                }),
            
              ],
            ),
          ],
        ),
      )
    );
  }
}