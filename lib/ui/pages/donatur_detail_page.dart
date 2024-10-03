import 'package:flutter/material.dart';
import 'package:fundriser/model/donatur/donatur_data_model.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DonaturDetailPage extends StatelessWidget {
 const DonaturDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    final DonaturDataModel? data = ModalRoute.of(context)!.settings.arguments as DonaturDataModel?;


    Future<void> launchMap() async {
      final lat = data!.lat;
      final long = data.lng;

      Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    
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
                    Navigator.pop(context);
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
                            Text(numberToIdr(int.parse(data?.donationSumAmount ?? '0')), style: darkGrayTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                            )),

                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    ListItem(
                      title: "Donatur",
                      subtitle: data?.name,
                    ),
                    ListItem(
                      title: "Kode",
                      subtitle: data?.uuid,
                    ),
                    ListItem(
                      title: "Provinsi",
                      subtitle: data?.province?.name,
                    ),
                    ListItem(
                      title: "Kabupaten",
                      subtitle: data?.regency?.name,
                    ),
                    ListItem(
                      title: "Kecamatan",
                      subtitle: data?.district?.name,
                    ),
                    ListItem(
                      title: "Latitude",
                      subtitle: data?.lat,
                    ),
                    ListItem(
                      title: "Longitude",
                      subtitle: data?.lng,
                    ),
                    ListItem(
                      title: "Tagl. Bergabung",
                      subtitle: stringToDateTime(data?.createdAt.toString() ?? ""),
                    ),
                    ListItem(
                      title: "Alamat",
                      subtitle: data?.address,
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