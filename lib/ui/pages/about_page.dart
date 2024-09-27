import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tentang Aplikasi"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20, left: 20, right: 20
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage("assets/img_dumy.png"),
              backgroundColor: whiteColor,
            ),
            const SizedBox(height: 20),
            Text("Update V2.0", style: darkGrayTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold
            )),
            const SizedBox(height: 20),
            Text("Aplikasi ini merupakan pengembangan atau update dari versi sebelumnya (v1.0), aplikasi ini bebas di gunakan oleh siapapun dan dimanapun oleh lembaga komersial dan non komersial secara gratis degan syarat dan ketentuan yang berlaku diantaranya :", style: grayTextStyle.copyWith(
              fontSize: 14
            ),
              textAlign: TextAlign.left
            ),
            const SizedBox(height: 20),
            Text("1. penguna dilarang mendistribusiakn ulang secara komersial", style: darkGrayTextStyle.copyWith(
              fontSize: 14
            ),
              textAlign: TextAlign.left
            ),
            const SizedBox(height: 20),
            Text("2. menyalahgunakan aplikasi seperti halnya penipuan/scam dll", style: darkGrayTextStyle.copyWith(
              fontSize: 14
            ),
              textAlign: TextAlign.left
            ),
            const SizedBox(height: 20),
            Text("jika ada kesulitan tentang pengunaan aplikasi atau ingin menambah fitur dari aplikasi secara custom", style: grayTextStyle.copyWith(
              fontSize: 14
            ),
              textAlign: TextAlign.left
            ),
            const SizedBox(height: 20),
            Text("bisa hubunggi tim developer melalui email bangfkr002@gmail.com", style: grayTextStyle.copyWith(
              fontSize: 14
            ),
              textAlign: TextAlign.left
            ),
          ],
        )
      )
    );
  }
}