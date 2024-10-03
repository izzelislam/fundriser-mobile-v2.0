import 'package:flutter/material.dart';
import 'package:flutter_awesome_select_clone/flutter_awesome_select.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/present/present_bloc.dart';
import 'package:fundriser/model/present/present_form_model.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';
import 'package:geolocator/geolocator.dart';

class AbsensiFormPage extends StatefulWidget {
  const AbsensiFormPage({super.key});

  @override
  State<AbsensiFormPage> createState() => _AbsensiFormPageState();
}

class _AbsensiFormPageState extends State<AbsensiFormPage> {
  String value = '';
  bool isLoading = false;
  double? lat;
  double? lng;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  TextEditingController noteField = TextEditingController(text: '');

  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'masuk', title: 'masuk'),
    S2Choice<String>(value: 'istirahat', title: 'istirahat'),
    S2Choice<String>(value: 'keluar', title: 'keluar'),
  ];

  Future<void> getCurrentLocation() async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Silahkan aktifkan lokasi'),
            content: const Text(
                'Lokasi tidak aktif, silahkan aktifkan terlebih dahulu'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await Geolocator.openLocationSettings();
                },
              ),
            ],
          );
        },
      );
      Navigator.pop(context);
      customSnackbar(
          context, 'Lokasi tidak aktif, silahkan aktifkan terlebih dahulu');
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    LocationSettings settings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 100);
    Position position =
        await Geolocator.getCurrentPosition(locationSettings: settings);

    setState(() {
      lat = position.latitude;
      lng = position.longitude;
    });
  }

  bool validated() {
    if (noteField.text.isEmpty && value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Absensi",
          style: TextStyle(color: whiteColor),
        ),
        backgroundColor: greenColor,
        iconTheme: IconThemeData(color: whiteColor),
      ),
      body: BlocConsumer<PresentBloc, PresentState>(
        listener: (context, state) {

          if (state is PresentSuccess) {
            successSnackbar(context, "Berhail melakukan absensi");
          }

          if (state is PresentCreateSuccess) {
            Navigator.pushNamed(context, "/presensi-detail",
                arguments: state.present
            );
          }

          if (state is PresentFailed) {
            setState(() {
              isLoading = false;
            });
            customSnackbar(context, state.message);
          }

          if (state is PresentLoading) {
            setState(() {
              isLoading = true;
            });
          }


        },
        builder: (context, state) {
          return Stack(
            children: [
              ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(130),
                            bottomRight: Radius.circular(130))),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/il_detail.png",
                        width: 280,
                        height: 280,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: CustomButton(
                      title: lat == null ? "Mendapatkan Lokasi ..." : "Absen",
                      isOutline: true,
                      isLoading: isLoading,
                      onPressed: () {
                        if (lat.toString().isNotEmpty) {
                          if (validated()) {
                            context.read<PresentBloc>().add(CreatePresent(
                              PresentFormModel(
                                  lat: lat.toString(),
                                  long: lng.toString(),
                                  type: value,
                                  note: noteField.text),
                            ));
                          }else{
                            customSnackbar(context, "semua wajib di isi");
                          }
                        }else{
                          customSnackbar(context, "koordinat tidak ditemukan");
                        }
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: isKeyboardVisible
                      ? MediaQuery.of(context).size.height * 0.1
                      : MediaQuery.of(context).size.height * 0.4,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: MediaQuery.of(context).size.height * 0.26,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Jenis Absensi",
                              style: darkGrayTextStyle.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 5),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: thinGrayColor, width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            child: SmartSelect<String>.single(
                                title: value,
                                selectedValue: value,
                                choiceItems: options,
                                modalType: S2ModalType.popupDialog,
                                modalFilter: true,
                                choiceStyle: S2ChoiceStyle(
                                  color: blueColor,
                                ),
                                onChange: (state) => {
                                      setState(() {
                                        value = state.value;
                                      })
                                    }),
                          ),
                          const SizedBox(height: 15),
                          CustomInput(
                            label: "Catatan (optional)",
                            controller: noteField,
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}
