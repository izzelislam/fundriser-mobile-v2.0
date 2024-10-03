import 'package:flutter/material.dart';
import 'package:fundriser/model/present/present_model.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class PresentDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final PresentModel? data = ModalRoute.of(context)!.settings.arguments as PresentModel?;


    Future<void> launchMap() async {
      final lat = data!.lat;
      final long = data.long;

      Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Presensi", style: TextStyle(color: whiteColor),),
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
              const SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                    ),
                    child: SizedBox(
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
                        onPressed: () => launchMap(),
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
                title: "Kembali",
                onPressed: (){
                  Navigator.pushNamed( context, "/presensi");
                },
              ),
            )
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height * 0.47,
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
                    const SizedBox(height: 17),
                    Text("Berhasil Melakukan Absensi", style: darkGrayTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700
                    )),
                    const SizedBox(height: 5),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    ListItem(
                      title: "Jenis Presensi",
                      subtitle: data?.type,
                    ),
                    ListItem(
                      title: "Tanggal",
                      subtitle: parseDate2(data?.presentAt ?? ""),
                    ),
                    ListItem(
                      title: "Waktu",
                      subtitle: parseTime2(data?.presentAt ?? ""),
                    ),
                    ListItem(
                      title: "Catatan",
                      subtitle: data?.note,
                    ),
                    ListItem(
                      title: "latitude",
                      subtitle: data?.lat,
                    ),
                    ListItem(
                      title: "longitude",
                      subtitle: data?.long,
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