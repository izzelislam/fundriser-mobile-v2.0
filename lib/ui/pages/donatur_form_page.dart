import 'package:flutter/material.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';
import 'package:geolocator/geolocator.dart';

class DonaturFormPage extends StatefulWidget {
  const DonaturFormPage({super.key});

  @override
  State<DonaturFormPage> createState() => _DonaturFormPageState();
}

class _DonaturFormPageState extends State<DonaturFormPage> {
  double? lat;
  double? lng;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

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

    latController.text = position.latitude.toString();
    lngController.text = position.longitude.toString();

    setState(() {
      lat = position.latitude;
      lng = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bauat Donatur"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                CustomInput(
                  label: "Nama Donatur",
                  hintText: "nama donatur",
                  controller: nameController,
                ),
                CustomInput(
                  label: "Nomor Telepon",
                  hintText: "nomor telepon",
                  controller: phoneController,
                ),
                const CustomInput(
                  label: "Provinsi",
                  hintText: "provinsi",
                ),
                const CustomInput(
                  label: "Kabupaten",
                  hintText: "kabupaten",
                ),
                const CustomInput(
                  label: "Kecamatan",
                  hintText: "kecamatan",
                ),
                CustomInput(
                  label: "Alamat Lengkap",
                  hintText: "alamat lengkap",
                  controller: addressController,
                ),
                CustomInput(
                  isReadOnly: true,
                  label: "Latitude",
                  hintText: "latitude",
                  controller: latController,  
                ),
                CustomInput(
                  isReadOnly: true,
                  label: "Longitude",
                  hintText: "longitude",
                  controller: lngController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
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
                        onPressed: () {
                          getCurrentLocation();
                        },
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