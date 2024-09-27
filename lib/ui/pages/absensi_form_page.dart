import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class AbsensiFormPage extends StatelessWidget {
  const AbsensiFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Donasi", style: TextStyle(color: whiteColor),),
        backgroundColor: greenColor,
        iconTheme: IconThemeData(
          color: whiteColor
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(130),
                    bottomRight: Radius.circular(130)
                  )
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset("assets/il_detail.png", width: 280, height: 280,),
                ),
              ),
              const SizedBox(height: 80),
              Padding(
              padding: const EdgeInsets.all(24),
              child: CustomButton(
                title: "Absen",
                isOutline: true,
                onPressed: (){
                  Navigator.pushNamed(context, "/home");
                },
              ),
            )
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.46,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomInput(
                      label: "Jenis Absensi",
                    )
                  ],
                )
              ),
            )
          )
        ],
      ),
    );
  }
}