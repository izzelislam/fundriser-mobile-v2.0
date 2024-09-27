import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';

class DonaturDetailPage extends StatelessWidget {
  const DonaturDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Donatur", style: TextStyle(color: whiteColor),),
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
              const SizedBox(height: 230),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      width: 120,
                      height: 35,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: blueColor)
                          )
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text("Lihat di map", style: blueTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                    )
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: CustomButton(
                  title: "Kembali Ke Home",
                  onPressed: (){
                    Navigator.pushNamed(context, "/home");
                  },
                ),
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.26,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height * 0.49,
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
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: const AssetImage("assets/img_dumy.png"),
                          backgroundColor: greenColor,
                          radius: 25,
                        ),
                        const SizedBox(width: 17),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Senin 12 januari 2025 11:32", style: grayTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                            )),
                            const SizedBox(height: 5),
                            Text("Rp. 12.500.450", style: darkGrayTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                            )),

                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    const ListItem(
                      title: "Donatur",
                      subtitle: "Bpk, H. Joko Suwarno",
                    ),
                    const ListItem(
                      title: "Kode",
                      subtitle: "DNR-187281",
                    ),
                    const ListItem(
                      title: "Provinsi",
                      subtitle: "Jawatenggah",
                    ),
                    const ListItem(
                      title: "Kabupaten",
                      subtitle: "Magelang",
                    ),
                    const ListItem(
                      title: "Kecamatan",
                      subtitle: "Mertoyudan",
                    ),
                    const ListItem(
                      title: "Latitude",
                      subtitle: "-7.500000",
                    ),
                    const ListItem(
                      title: "Longitude",
                      subtitle: "110.000000",
                    ),
                    const ListItem(
                      title: "Tagl. Bergabung",
                      subtitle: "Senin 12 januari 2025 11:32",
                    ),
                    const ListItem(
                      title: "Alamat",
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
          SizedBox(
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