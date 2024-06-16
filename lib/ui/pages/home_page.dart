import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_pro_barcode_scanner/flutter_pro_barcode_scanner.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      bottomNavigationBar: BottomNav(),
      body: Column(
        children: [
          /* header section */
          const SizedBox(height: 45,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 133,
                  height: 44,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset("assets/img_dumy.png", width: 28, height: 28,)
                        ),
                        const SizedBox(width: 8,),
                        Text("Abdul latif", style: grayTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700
                        ),)
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/notif"),
                  child: Container(
                    width: 31,
                    height: 31,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: Image.asset("assets/ic_bell.png", width: 19, height: 19,),
                    ),
                  ),
                )
              ]
            ),
          ),
          /* end header section */

          /* quote section */
          const SizedBox(height: 37),
          Text("“Selalu bersholawat agar mendapat syafaat”", style: whiteTextStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500
          )),
          const SizedBox(height: 17),
          /* end quote sction */

          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.73,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35)
              )
            ),
            child: Padding(
              padding:const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      /* amount section */
                      AmountSection(),
                      /*emd amount section */
                  
                      /* menu section */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MenuItem(
                            title: "Buat Donasi",
                            color: greenColor,
                            image: "assets/ic_donasi.png",
                            onTap: () {
                              showModalBottomSheet(
                                context: context, 
                                builder: (context) => CreateDonationModal()
                              );
                            }
                          ),
                          MenuItem(
                            title: "Donasi",
                            color: blueColor,
                            image: "assets/ic_donasi_list.png",
                            onTap: () {
                              Navigator.pushNamed(context, "/donasi");
                            }
                          ),
                          MenuItem(
                            title: "Buat Donatur",
                            color: greenColor,
                            image: "assets/ic_donatur.png",
                            onTap: () {
                              Navigator.pushNamed(context, "/donatur-form");
                            }
                          ),
                          MenuItem(
                            title: "Donatur",
                            color: blueColor,
                            image: "assets/ic_donatur_list.png",
                            onTap: () {
                              Navigator.pushNamed(context, "/donatur");
                            }
                          ),
                        ],
                      ),
                      const SizedBox(height: 29),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MenuItem(
                            title: "Absensi",
                            color: greenColor,
                            image: "assets/ic_present.png",
                            onTap: () {
                              showModalBottomSheet(
                                context: context, 
                                builder: (context) => AbsensiModal()
                              );
                            }
                          ),
                          MenuItem(
                            title: "Izin",
                            color: orangeColor,
                            image: "assets/ic_permit.png",
                            onTap: () {
                              showModalBottomSheet(
                                context: context, 
                                builder: (context) => PermitModal()
                              );
                            }
                          ),
                          MenuItem(
                            title: "Rekap",
                            color: greenColor,
                            image: "assets/ic_rekap.png",
                            onTap: () {
                              showModalBottomSheet(
                                context: context, 
                                builder: (context) => CominSoonModal()
                              );
                            }
                          ),
                          MenuItem(
                            title: "Riwayat",
                            color: grayColor,
                            image: "assets/ic_riwayat.png",
                            onTap: () {
                              showModalBottomSheet(
                                context: context, 
                                builder: (context) => CominSoonModal()
                              );
                            }
                          ),
                        ],
                      ),
                      /*end menu section */
                  
                      /* donation section */
                      const SizedBox(height: 49),
                      Text("Donasi Terbaru", style: darkGrayTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      const SizedBox(height: 17),
                      const DonationCard(),
                      const DonationCard(),
                      const DonationCard(),
                      const DonationCard(),
                      const DonationCard(),
                      /* end donation section */

                      /* info section */
                      const SizedBox(height: 27),
                      Text("Donasi Terbaru", style: darkGrayTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      const SizedBox(height: 13),
                      InfoCard(),
                      InfoCard(),
                      InfoCard(),
                      InfoCard(),
                      InfoCard(),
                      const SizedBox(height: 10),
                      /* end section */
                  
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

class CominSoonModal extends StatelessWidget {
  const CominSoonModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20, top: 40, right: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/ic_coming_soon.png", width: 300, height: 300,),
            Text("Cooming Soon Update, InsyaAllah!", style: darkGrayTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700
            )),
            Text("Do'akan semoga developer diberi umur panjang 😊🤲.",
              style: grayTextStyle.copyWith(
                fontSize: 12
              ),
            )
          ]
        )
      )
    );
  }
}

class PermitModal extends StatelessWidget {
  const PermitModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20, top: 40, right: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(title: "Ajukan Perizinan", isOutline: true, onPressed: () {},),
            const SizedBox(height: 15),
            Text("Atau ?", style: darkGrayTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700
            )),
            const SizedBox(height: 15),
            CustomButton(title: "Lihat Daftar Perizinan", onPressed: () {
              Navigator.pushNamed(context, "/permit");
            },)
          ],
        ),
      ),
    );
  }
}

class AbsensiModal extends StatelessWidget {
  const AbsensiModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20, top: 40, right: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(title: "Lakukan Absensi", isOutline: true, onPressed: () {
              Navigator.pushNamed(context, "/presensi-form");
            },),
            const SizedBox(height: 15),
            Text("Atau ?", style: darkGrayTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700
            )),
            const SizedBox(height: 15),
            CustomButton(title: "Lihat Daftar Absensi", onPressed: () {
              Navigator.pushNamed(context, "/presensi");
            },)
          ],
        ),
      ),
    );
  }
}

class CreateDonationModal extends StatelessWidget {
  const CreateDonationModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20, top: 40, right: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Silahkan Masukkan Kode Donatur !", style: darkGrayTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700
            ),),
            const SizedBox(height: 15),
            CustomInput(label: "Kode Donatur"),
            const SizedBox(height: 15),
            CustomButton(title: "Cari Donatur", onPressed: () => Navigator.pushNamed(context, "/donasi-form"),),
            const SizedBox(height: 15),
            Text("Atau Scan QR Code ?", style: darkGrayTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700
            ),),
            const SizedBox(height: 15),
            CustomButton(title: "Scan Kode QR", isOutline: true,
              onPressed: () async {
                String res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScannerScreen()
                ));
                
                if (res.isNotEmpty){
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, "/donasi-form", arguments: res);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 67.4,
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: grayColor,
              blurRadius: 2
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
    
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                      Image.asset("assets/ic_home_bottom.png", width: 25, height: 25,),
                      Text("Home", style: greenTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700
                      ),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, "/donasi"),
                  child: Column(
                    children: [
                        Image.asset("assets/ic_donasi_bottom.png", width: 25, height: 25,),
                        Text("Donasi", style: grayTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w700
                        ),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async  {

                  String res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScannerScreen()
                  ));

                  if (res.isNotEmpty){
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, "/donasi-form", arguments: res);
                  }

                },
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: Image.asset("assets/ic_qr.png", width: 32, height: 32,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, "/donatur"),
                  child: Column(
                    children: [
                        Image.asset("assets/ic_donatur_bottom.png", width: 25, height: 25,),
                        Text("Donatur", style: grayTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w700
                        ),)
                    ],
                  ),
                ),
              ),
    
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, "/profile"),
                  child: Column(
                    children: [
                        Image.asset("assets/ic_account_bottom.png", width: 25, height: 25,),
                        Text("Akun", style: grayTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w700
                        ),)
                    ],
                  ),
                ),
              ),
    
            ],
          ),
        ),
      )
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: thinGrayColor
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20)
            ),
            child: Image.asset("assets/img_dumy.png", width: 142, height: 80, fit: BoxFit.cover,)
          ),
          const SizedBox(width: 9),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 180,
                child: Text("Pendapatan dan laporan Bulan juni tahun 2024", style: darkGrayTextStyle700.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700
                ), 
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                ),
              ),
              Text("Published :  12 juli 2024", style: grayTextStyle.copyWith(
                fontSize: 9,
                fontStyle: FontStyle.italic
              )),
              const SizedBox(height: 4),
              Row(
                children: [
                  Image.asset("assets/ic_admin.png", width: 14, height: 14,),
                  const SizedBox(width: 3),
                  Text("Admin", style: darkGrayTextStyle700.copyWith(
                    fontSize: 9
                  ))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class DonationCard extends StatelessWidget {
  const DonationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/donasi-detail"),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: thinGrayColor
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8      
          ),
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 37,
                    height: 37,
                    decoration: BoxDecoration(
                      color: slateColor,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: Image.asset("assets/ic_person_placeholder.png", width: 28, height: 28,),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Donasi Dari", style: grayTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700
                      ),),
                      const SizedBox(width: 5),
                      Image.asset("assets/ic_badge_check.png", width: 14, height: 14,)
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text("Bpk, H Joko Suwarno", style: darkGrayTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700
                  ))
                ],
              ),
              const Spacer(),
              Text("Rp. 250.000", style: darkGrayTextStyle700.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500
              ))
            ],
          ),
        )
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final Color color;
  final String image;
  final Function() onTap;

  const MenuItem({
    super.key,
    required this.title,
    required this.color,
    required this.image,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 53,
            height: 53,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Center(
              child: Image.asset(image, width: 32, height: 32,),
            ),
          ),
          const SizedBox(height: 5),
          Text(title, style: grayTextStyle.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w700
          ))
        ],
      ),
    );
  }
}

class AmountSection extends StatelessWidget {
  const AmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      margin: const EdgeInsets.only(bottom: 34),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: thinGrayColor
        )
      ),
      child: Padding(
        padding: const  EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 19
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Perolehan Donasi Bulan Agustus", style: grayTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600
                )),
                const SizedBox(height: 5),
                Text("Rp. 12.500.450", style: darkGrayTextStyle700.copyWith(
                  fontSize: 22,
                )),
                const SizedBox(height: 5),
                Text("Perolehan akan direset setiap bulannya", style: greenTextStyle.copyWith(
                  fontSize: 9,
                  fontWeight: FontWeight.w600
                )),
              ],
            ),
            const Spacer(),
            Container(
              width: 1,
              height: 73,
              color: thinGrayColor,
            ),
            const SizedBox(width: 25),
            GestureDetector(
              onTap: () async {
                await ScanQr(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Center(
                      child: Image.asset("assets/ic_qr.png", width: 30, height: 30,),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text("Scan QR", style: grayTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> ScanQr(BuildContext context) async {
    String res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ScannerScreen()
    ));
    
    if (res.isNotEmpty){
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/donasi-form", arguments: res);
    }
  }
}