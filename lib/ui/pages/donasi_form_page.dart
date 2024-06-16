import 'package:flutter/material.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class DonasiFormPage extends StatelessWidget {
  const DonasiFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Donasi"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                CustomInput(
                  label: "Kode Donatur",
                  hintText: "kode donatur",
                ),
                CustomInput(
                  label: "Nama Donatur",
                  hintText: "nama donatur",
                ),
                CustomInput(
                  label: "Nominal",
                  hintText: "nominal",
                  keyboardType: TextInputType.number,
                ),
                CustomInput(
                  label: "Jenis",
                  hintText: "jenis donasi",
                ),
                CustomInput(
                  label: "Catatan",
                  hintText: "Catatan donasi",
                ),
                CustomButton(
                  title: "Simpan Donasi",
                  onPressed: () => {
                    Navigator.pushNamed(context, "/donasi-detail")
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}