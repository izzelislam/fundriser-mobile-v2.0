import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';

class DonasiDetailPage extends StatelessWidget {
  const DonasiDetailPage({super.key});

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
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(130),
                    bottomRight: Radius.circular(130)
                  )
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset("assets/il_detail.png", width: 280, height: 280,),
                ),
              ),
              const SizedBox(height: 250),
              Padding(
              padding: const EdgeInsets.all(24),
              child: CustomButton(
                title: "Kembali Ke Home",
                onPressed: (){
                  Navigator.pushNamed(context, "/home");
                },
              ),
            )
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height * 0.53,
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/sucess.json", width: 90, height: 90),
                    // CircleAvatar(
                    //   backgroundImage: const AssetImage("assets/img_dumy.png"),
                    //   backgroundColor: greenColor,
                    //   radius: 25,
                    // ),
                    const SizedBox(height: 17),
                    Text("Donasi berhasil Tercatat", style: darkGrayTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700
                    )),
                    const SizedBox(height: 5),
                    Text("Senin 12 januari 2025 11:32", style: grayTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                    )),
                    const SizedBox(height: 20),
                    Text("Rp. 120.500", style: darkGrayTextStyle700.copyWith(
                      fontSize: 26,
                    )),
                    const SizedBox(height: 20),
                    const ListItem(
                      title: "Donatur",
                      subtitle: "Bpk, H. Joko Suwarno",
                    ),
                    const ListItem(
                      title: "Jenis Donasi",
                      subtitle: "Shodaqoh",
                    ),
                    const ListItem(
                      title: "No Kwitansi",
                      subtitle: "189273812783672",
                    ),
                    const ListItem(
                      title: "Alamat",
                      subtitle: "Jl Kyai kasan rejo no 10, depan sd magersari wetan Mertoyudan magelang jawatenggah",
                    ),
                    const ListItem(
                      title: "catatan",
                      subtitle: "Jl Kyai kasan rejo no 10, depan sd magersari wetan Mertoyudan magelang jawatenggah",
                    ),

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

class ListItem extends StatelessWidget {
  final String title;
  final String? subtitle;

  const ListItem({
    super.key,
    required this.title,
    this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Text(title, style: grayTextStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400
          ),),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(subtitle ?? "-", style: darkGrayTextStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600
            ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}