import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_pro_barcode_scanner/flutter_pro_barcode_scanner.dart';
import 'package:fundriser/bloc/auth/auth_bloc.dart';
import 'package:fundriser/bloc/content/content_bloc.dart';
import 'package:fundriser/bloc/donation/donation_bloc.dart';
import 'package:fundriser/bloc/donatur/donatur_bloc.dart';
import 'package:fundriser/main.dart';
import 'package:fundriser/model/content_data_model.dart';
import 'package:fundriser/model/donation_data_model.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }

  Future<void> _initializeFirebaseMessaging() async {
    FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');

      if (message.notification != null) {
        _showForegroundNotification(message.notification!);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle the message when the app is opened from a notification
      // print('A new onMessageOpenedApp event was published!');
    });
  }
  void _showForegroundNotification(RemoteNotification notification) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: blueColor,
        bottomNavigationBar: const BottomNav(),
        body: SizedBox(
          width: double.infinity,
          height: size.height,
          child: Stack(
            children: [

              /* header section */
              Positioned(
                // bottom status bar 20 px
                top: size.height * 0.05,
                child: SizedBox(
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthSuccess) {
                            return Container(
                              width: 120,
                              height: 38,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 5
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundImage: NetworkImage( state.data.imageUrl ?? 'Guest'),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.data.name ?? 'Guest',
                                        style: grayTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                            
                          return Container();
                        },
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "/notif"),
                        child: Container(
                          width: 31,
                          height: 31,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Image.asset(
                              "assets/ic_bell.png",
                              width: 19,
                              height: 19,
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
              /* end header section */
          
              /* quote section */
              Positioned(
                top: size.height * 0.14,
                left: 0,
                right: 0,
                child: Center(
                  child: Text("“Selalu bersholawat agar mendapat syafaat”",
                      style: whiteTextStyle.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w500)),
                ),
              ),
              /* end quote sction */
          
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.72,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: RefreshIndicator(
                      color: blueColor,
                      onRefresh: () async {
                        BlocProvider.of<DonationBloc>(context).add(const GetAllDonation());
                        BlocProvider.of<ContentBloc>(context).add(GetAllcontent());
                        BlocProvider.of<AuthBloc>(context).add(AuthGetProfile());
                      },
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /* amount section */
                              const AmountSection(),
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
                                            builder: (context) =>
                                                CreateDonationModal());
                                      }),
                                  MenuItem(
                                      title: "Donasi",
                                      color: blueColor,
                                      image: "assets/ic_donasi_list.png",
                                      onTap: () {
                                        Navigator.pushNamed(context, "/donasi");
                                      }),
                                  MenuItem(
                                      title: "Buat Donatur",
                                      color: greenColor,
                                      image: "assets/ic_donatur.png",
                                      onTap: () {
                                        Navigator.pushNamed(context, "/donatur-form");
                                      }),
                                  MenuItem(
                                      title: "Donatur",
                                      color: blueColor,
                                      image: "assets/ic_donatur_list.png",
                                      onTap: () {
                                        Navigator.pushNamed(context, "/donatur");
                                      }),
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
                                            builder: (context) =>
                                                const AbsensiModal());
                                      }),
                                  MenuItem(
                                      title: "Izin",
                                      color: orangeColor,
                                      image: "assets/ic_permit.png",
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                const PermitModal());
                                      }),
                                  MenuItem(
                                      title: "Rekap",
                                      color: greenColor,
                                      image: "assets/ic_rekap.png",
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                const CominSoonModal());
                                      }),
                                  MenuItem(
                                      title: "Riwayat",
                                      color: grayColor,
                                      image: "assets/ic_riwayat.png",
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                const CominSoonModal());
                                      }),
                                ],
                              ),
                              /*end menu section */
                      
                              /* donation section */
                              const SizedBox(height: 49),
                              Text("Donasi Terbaru",
                                  style: darkGrayTextStyle.copyWith(
                                      fontSize: 14, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 17),
                              BlocProvider(
                                create: (context) =>
                                    DonationBloc()..add(GetAllDonation()),
                                child: BlocBuilder<DonationBloc, DonationState>(
                                  builder: (context, state) {
                                    if (state is DonationLoading) {
                                      return Center(
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: blueColor,
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      );
                                    }
                      
                                    if (state is DonationAllSuccess) {
                                      if (state.data.isNotEmpty){
                                        final length = state.data.length >= 5 ? 5 : state.data.length;
                                        return Column(
                                          children: state.data.sublist(0, length)
                                              .map((e) => DonationCard(data: e))
                                              .toList(),
                                        );
                                      }else{
                                        return Center(
                                          child: Text("Belum ada donasi", style: thinGrayTextStyle.copyWith(
                                              fontSize: 14, fontWeight: FontWeight.w700)),
                                        );
                                      }
                                    }
                      
                                    return Container();
                                  },
                                ),
                              ),
                      
                              /* end donation section */
                      
                              /* info section */
                              const SizedBox(height: 27),
                              Text("Informasi Terbaru",
                                  style: darkGrayTextStyle.copyWith(
                                      fontSize: 14, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 13),
                              BlocProvider(
                                create: (context) =>
                                    ContentBloc()..add(GetAllcontent()),
                                child: BlocBuilder<ContentBloc, ContentState>(
                                  builder: (context, state) {
                                    if (state is ContentSuccess) {
                      
                                      if (state.contents.isNotEmpty){
                                        return Column(
                                          children: state.contents
                                            .map((e) => InfoCard(data: e)
                                          )
                                          .toList()
                                        );
                                      }else{
                                        return Center(
                                          child: Text("Belum ada informasi", style: thinGrayTextStyle.copyWith(
                                              fontSize: 14, fontWeight: FontWeight.w700)),
                                        );
                                      }
                      
                                    }
                      
                                    return Container();
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              /* end section */
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
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
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/ic_coming_soon.png",
                    width: 300,
                    height: 300,
                  ),
                  Text("Cooming Soon Update, InsyaAllah!",
                      style: darkGrayTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(
                    "Do'akan semoga developer diberi umur panjang 😊🤲.",
                    style: grayTextStyle.copyWith(fontSize: 12),
                  )
                ])));
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
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              title: "Ajukan Perizinan",
              isOutline: true,
              onPressed: () {
                Navigator.pushNamed(context, "/permit-form");
              },
            ),
            const SizedBox(height: 15),
            Text("Atau ?",
                style: darkGrayTextStyle.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w700)),
            const SizedBox(height: 15),
            CustomButton(
              title: "Lihat Daftar Perizinan",
              onPressed: () {
                Navigator.pushNamed(context, "/permit");
              },
            )
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
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              title: "Lakukan Absensi",
              isOutline: true,
              onPressed: () {
                Navigator.pushNamed(context, "/presensi-form");
              },
            ),
            const SizedBox(height: 15),
            Text("Atau ?",
                style: darkGrayTextStyle.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w700)),
            const SizedBox(height: 15),
            CustomButton(
              title: "Lihat Daftar Absensi",
              onPressed: () {
                Navigator.pushNamed(context, "/presensi");
              },
            )
          ],
        ),
      ),
    );
  }
}

class CreateDonationModal extends StatefulWidget {
  const CreateDonationModal({
    super.key,
  });

  @override
  State<CreateDonationModal> createState() => _CreateDonationModalState();
}

class _CreateDonationModalState extends State<CreateDonationModal> {
  TextEditingController uuidField = TextEditingController();
  bool isLoading = false;

  bool validated() {
    if (uuidField.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    void handleScan(String param) {
      context.read<DonaturBloc>().add(FindDoatur(uuid: param));
    }

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Silahkan Masukkan Kode Donatur !",
              style: darkGrayTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 15),
            CustomInput(
              label: "Kode Donatur",
              controller: uuidField,
            ),
            const SizedBox(height: 15),
            BlocListener<DonaturBloc, DonaturState>(
              listener: (context, state) {
                if (state is DonaturFailed) {
                  customSnackbar(context, state.message);
                  setState(() {
                    isLoading = false;
                  });
                }

                if (state is DonaturFindSuccess) {
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.pushNamed(context, "/donasi-form",
                      arguments: state.data);
                }

                if (state is DonaturLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: CustomButton(
                  title: "Cari Donatur",
                  isLoading: isLoading,
                  onPressed: () {
                    if (!validated()) {
                      customSnackbar(context, "kode donatur wajib diisi");
                    } else {
                      // context.read<DonaturBloc>().add(FindDoatur(uuid: uuidField.text));
                      context
                          .read<DonaturBloc>()
                          .add(FindDoatur(uuid: uuidField.text));
                    }
                  }),
            ),
            const SizedBox(height: 15),
            Text(
              "Atau Scan QR Code ?",
              style: darkGrayTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 15),
            BlocListener<DonaturBloc, DonaturState>(
              listener: (context, state) {
                if (state is DonaturFailed) {
                  customSnackbar(context, state.message);
                  setState(() {
                    isLoading = false;
                  });
                }

                if (state is DonaturFindSuccess) {
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.pushNamed(context, "/donasi-form",
                      arguments: state.data);
                }
              },
              child: CustomButton(
                title: "Scan Kode QR",
                isOutline: true,
                onPressed: () async {
                  String res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScannerScreen()));

                  if (res.isNotEmpty) {
                    handleScan(res);
                  }
                },
              ),
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
    void handleScan(String param) {
      context.read<DonaturBloc>().add(FindDoatur(uuid: param));
    }

    return SafeArea(
        child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [BoxShadow(color: grayColor, blurRadius: 2)]),
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
                  Image.asset(
                    "assets/ic_home_bottom.png",
                    width: 25,
                    height: 25,
                  ),
                  Text(
                    "Home",
                    style: greenTextStyle.copyWith(
                        fontSize: 10, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, "/donasi"),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/ic_donasi_bottom.png",
                      width: 25,
                      height: 25,
                    ),
                    Text(
                      "Donasi",
                      style: grayTextStyle.copyWith(
                          fontSize: 10, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            BlocListener<DonaturBloc, DonaturState>(
              listener: (context, state) {
                if (state is DonaturFindSuccess) {
                  Navigator.pushNamed(context, "/donasi-form",
                      arguments: state.data);
                }

                if (state is DonaturFailed) {
                  customSnackbar(context, state.message);
                }
              },
              child: GestureDetector(
                onTap: () async {
                  String res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScannerScreen()));

                  if (res.isNotEmpty) {
                    handleScan(res);
                  }
                },
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Image.asset(
                      "assets/ic_qr.png",
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, "/donatur"),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/ic_donatur_bottom.png",
                      width: 25,
                      height: 25,
                    ),
                    Text(
                      "Donatur",
                      style: grayTextStyle.copyWith(
                          fontSize: 10, fontWeight: FontWeight.w700),
                    )
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
                    Image.asset(
                      "assets/ic_account_bottom.png",
                      width: 25,
                      height: 25,
                    ),
                    Text(
                      "Akun",
                      style: grayTextStyle.copyWith(
                          fontSize: 10, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class InfoCard extends StatelessWidget {
  final ContentDataModel data;

  const InfoCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/content-detail", arguments: data);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: thinGrayColor),
        ),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: Image.network(
                  data.imageLink ?? "https://alkuwaiti.com/wp-content/uploads/2020/05/Image-Placeholder-Dark.png",
                  width: 142,
                  height: 80,
                  fit: BoxFit.cover,
                )),
            const SizedBox(width: 9),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 180,
                  child: Text(
                    data.title ?? "",
                    style: darkGrayTextStyle700.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w700),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                ),
                Text("Published :  ${stringToDate(data.createdAt ?? '')}",
                    style: grayTextStyle.copyWith(
                        fontSize: 9, fontStyle: FontStyle.italic)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Image.asset(
                      "assets/ic_admin.png",
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: 3),
                    Text("Admin",
                        style: darkGrayTextStyle700.copyWith(fontSize: 9))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DonationCard extends StatelessWidget {
  final DonationDataModel data;

  const DonationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, "/donasi-detail", arguments: data),
      child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: thinGrayColor)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 37,
                      height: 37,
                      decoration: BoxDecoration(
                          color: slateColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Image.asset(
                          "assets/ic_person_placeholder.png",
                          width: 28,
                          height: 28,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Donasi Dari",
                          style: grayTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(
                          "assets/ic_badge_check.png",
                          width: 14,
                          height: 14,
                        )
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(data.donor?.name ?? 'Unknown Donor',
                        style: darkGrayTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w700))
                  ],
                ),
                const Spacer(),
                Text(numberToIdr(data.amount ?? 0),
                    style: darkGrayTextStyle700.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w500))
              ],
            ),
          )),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final Color color;
  final String image;
  final Function() onTap;

  const MenuItem(
      {super.key,
      required this.title,
      required this.color,
      required this.image,
      required this.onTap});

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
                color: color, borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Image.asset(
                image,
                width: 32,
                height: 32,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(title,
              style: grayTextStyle.copyWith(
                  fontSize: 10, fontWeight: FontWeight.w700))
        ],
      ),
    );
  }
}

class AmountSection extends StatefulWidget {
  const AmountSection({
    super.key,
  });

  @override
  State<AmountSection> createState() => _AmountSectionState();
}

class _AmountSectionState extends State<AmountSection> {
  @override
  Widget build(BuildContext context) {
    void handleScan(String param) {
      context.read<DonaturBloc>().add(FindDoatur(uuid: param));
    }

    return Container(
      width: double.infinity,
      // height: 95,
      margin: const EdgeInsets.only(bottom: 34),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: thinGrayColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 19),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Perolehan Donasi Bulan ${getCurrentMonth()}",
                    style: grayTextStyle.copyWith(
                        fontSize: 11, fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                BlocProvider(
                  create: (context) => DonationBloc()..add(GetTotalDonation()),
                  child: BlocBuilder<DonationBloc, DonationState>(
                    builder: (context, state) {
                      if (state is DonationTotalSuccess) {
                        return Text(
                            // number format idr
                            "${numberToIdr(int.parse(state.totalDonation.total ?? '0'))}",
                            style: darkGrayTextStyle700.copyWith(
                              fontSize: 19,
                            ));
                      }

                      return Text("Rp. 0",
                          style: darkGrayTextStyle700.copyWith(
                            fontSize: 18,
                          ));
                    },
                  ),
                ),
                const SizedBox(height: 2),
                Text("Perolehan akan direset setiap bulannya",
                    style: greenTextStyle.copyWith(
                        fontSize: 9, fontWeight: FontWeight.w600)),
              ],
            ),
            const Spacer(),
            Container(
              width: 1,
              height: 73,
              color: thinGrayColor,
            ),
            const SizedBox(width: 25),
            BlocListener<DonaturBloc, DonaturState>(
              listener: (context, state) {
                if (state is DonaturFindSuccess) {
                  Navigator.pushNamed(context, "/donasi-form",
                      arguments: state.data);
                }

                if (state is DonaturFailed) {
                  customSnackbar(context, state.message);
                }
              },
              child: GestureDetector(
                onTap: () async {
                  String res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScannerScreen()));

                  if (res.isNotEmpty) {
                    handleScan(res);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Image.asset(
                          "assets/ic_qr.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text("Scan QR",
                        style: grayTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w600))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> ScanQr(BuildContext context) async {
    String res = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ScannerScreen()));

    if (res.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/donasi-form", arguments: res);
    }
  }
}
