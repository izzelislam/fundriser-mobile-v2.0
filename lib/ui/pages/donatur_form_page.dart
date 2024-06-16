import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class DonaturFormPage extends StatelessWidget {
  const DonaturFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bauat Donatur"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                CustomInput(
                  label: "Nama Donatur",
                  hintText: "nama donatur",
                ),
                CustomInput(
                  label: "Nomor Telepon",
                  hintText: "nomor telepon",
                ),
                CustomInput(
                  label: "Provinsi",
                  hintText: "provinsi",
                ),
                CustomInput(
                  label: "Kabupaten",
                  hintText: "kabupaten",
                ),
                CustomInput(
                  label: "Kecamatan",
                  hintText: "kecamatan",
                ),
                CustomInput(
                  label: "Alamat Lengkap",
                  hintText: "alamat lengkap",
                ),
                CustomInput(
                  label: "Latitude",
                  hintText: "latitude",
                ),
                CustomInput(
                  label: "Longitude",
                  hintText: "longitude",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      width: 120,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: blueColor)
                          )
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text("dapatkan koordinat", style: blueTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                    )
                  ],
                ),
                CustomButton(
                  title: "Simpan Donatur",
                  onPressed: () => Navigator.pop(context),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}