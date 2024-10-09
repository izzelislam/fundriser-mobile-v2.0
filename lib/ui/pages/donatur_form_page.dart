import 'package:flutter/material.dart';
import 'package:flutter_awesome_select_clone/flutter_awesome_select.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/donatur/donatur_bloc.dart';
import 'package:fundriser/model/donatur/donatur_data_model.dart';
import 'package:fundriser/model/donatur/donatur_form_model.dart';
import 'package:fundriser/service/location_service.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/pages/donatur_page.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';
import 'package:geolocator/geolocator.dart';

class DonaturFormPage extends StatefulWidget {
  final DonaturDataModel? data;

  const DonaturFormPage({super.key, this.data});

  @override
  State<DonaturFormPage> createState() => _DonaturFormPageState();
}

class _DonaturFormPageState extends State<DonaturFormPage> {
  String value = '';
  bool isLoading = false;
  double? lat;
  double? lng;
  String? provincelabel;
  String? regencylabel;
  String? districtlabel;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  String provinceId = '';
  String regencyId = '';
  String districtId = '';

  List<S2Choice<String>> options = [];
  List<S2Choice<String>> provinceOptions = [];
  List<S2Choice<String>> regencyOptions = [];
  List<S2Choice<String>> districtOptions = [];

  bool validate() {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        latController.text.isEmpty ||
        lngController.text.isEmpty ||
        provinceId.isEmpty ||
        regencyId.isEmpty ||
        districtId.isEmpty) {
      customSnackbar(context, 'Semua kolom harus diisi');
      return false;
    } else {
      return true;
    }
  }

  // fetch provinces
  Future<void> getProvinces() async {
    try {
      final res = await LocationService().getProvince();
      List<S2Choice<String>> data = [];
      res.forEach((element) {
        data.add(S2Choice<String>(
            value: element.id.toString(), title: element.name));
      });
      setState(() {
        provinceOptions = data;
      });
    } catch (e) {
      print(e);
    }
  }

  // fetch regencies
  Future<void> getRegencies(String provinceId) async {
    try {
      final res = await LocationService().getRegency(provinceId);
      List<S2Choice<String>> data = [];
      res.forEach((element) {
        data.add(S2Choice<String>(
            value: element.id.toString(), title: element.name));
      });
      setState(() {
        regencyOptions = data;
      });
    } catch (e) {
      print(e);
    }
  }

  // fetch districts
  Future<void> getDistricts(String regencyId) async {
    try {
      final res = await LocationService().getDistrict(regencyId);
      List<S2Choice<String>> data = [];
      res.forEach((element) {
        data.add(S2Choice<String>(
            value: element.id.toString(), title: element.name));
      });
      setState(() {
        districtOptions = data;
      });
    } catch (e) {
      print(e);
    }
  }

  void initEdit(DonaturDataModel data) {
      if (data.name != null && data.phoneNumber != null && data.address != null) {
        nameController.text = data.name!;
        phoneController.text = data.phoneNumber!;
        addressController.text = data.address!;
        latController.text = data.lat.toString();
        lngController.text = data.lng.toString();
        provinceId = data.provinceId.toString();
        regencyId = data.regencyId.toString();
        districtId = data.districtId.toString();
        districtlabel = data.district?.name;
        regencylabel = data.regency?.name;
        provincelabel = data.province?.name;
      }
  }

  @override
  void initState() {
    super.initState();
    getProvinces();
    if (widget.data == null) {
      getCurrentLocation();
    }
    if (widget.data != null) {
      initEdit(widget.data!);
    }
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
      body: BlocConsumer<DonaturBloc, DonaturState>(
        listener: (context, state) {
          if (state is DonaturSuccess) {
            setState(() {
              isLoading = false;
            });
            Navigator.pushAndRemoveUntil( context, MaterialPageRoute(builder: (context) => const DonaturPage()), (route) => false);
            successSnackbar(context, 'Donatur berhasil disimpan');
          }

          if (state is DonaturFailed) {
            setState(() {
              isLoading = false;
            });
            customSnackbar(context, state.message);
          }

          if (state is DonaturLoading) {
            setState(() {
              isLoading = true;
            });
          }
        },
        builder: (context, state) {
          return Padding(
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
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Provinsi",
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
                              title: provincelabel ?? "Pilih Provinsi",
                              tileBuilder: (context, state) {
                                return ListTile(
                                  title: Text(
                                    state.title ?? '',
                                    style: grayTextStyle.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                  trailing:
                                      const Icon(Icons.keyboard_arrow_down),
                                  onTap: state.showModal,
                                );
                              },
                              selectedValue: provinceId,
                              choiceItems: provinceOptions,
                              modalType: S2ModalType.popupDialog,
                              modalFilter: true,
                              choiceStyle: S2ChoiceStyle(
                                color: blueColor,
                                titleStyle: grayTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                                subtitleStyle: grayTextStyle.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                              onChange: (state) => {
                                    setState(() {
                                      provinceId = state.value;
                                      provincelabel = state.title;
                                      regencyId = '';
                                      districtId = '';
                                      regencylabel = '';
                                      districtlabel = '';
                                      getRegencies(state.value);
                                    })
                                  }),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kabupaten",
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
                              title: regencylabel ?? "Pilih Kabupaten",
                              tileBuilder: (context, state) {
                                return ListTile(
                                  title: Text(
                                    state.title ?? '',
                                    style: grayTextStyle.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                  trailing:
                                      const Icon(Icons.keyboard_arrow_down),
                                  onTap: state.showModal,
                                );
                              },
                              selectedValue: regencyId,
                              choiceItems: regencyOptions,
                              modalType: S2ModalType.popupDialog,
                              modalFilter: true,
                              choiceStyle: S2ChoiceStyle(
                                color: blueColor,
                                titleStyle: grayTextStyle.copyWith(
                                  fontSize: 12,
                                  overflow: TextOverflow.clip,
                                  // line 1
                                ),
                                subtitleStyle: grayTextStyle.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                              onChange: (state) => {
                                    setState(() {
                                      regencyId = state.value;
                                      regencylabel = state.title;
                                      getDistricts(state.value);
                                    })
                                  }),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kecamatan",
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
                              title: districtlabel ?? "Pilih Kecepatan",
                              tileBuilder: (context, state) {
                                return ListTile(
                                  title: Text(
                                    state.title ?? '',
                                    style: grayTextStyle.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                  trailing:
                                      const Icon(Icons.keyboard_arrow_down),
                                  onTap: state.showModal,
                                );
                              },
                              selectedValue: districtId,
                              choiceItems: districtOptions,
                              modalType: S2ModalType.popupDialog,
                              modalFilter: true,
                              choiceStyle: S2ChoiceStyle(
                                color: blueColor,
                                titleStyle: grayTextStyle.copyWith(
                                  fontSize: 12,
                                  overflow: TextOverflow.clip,
                                  // line 1
                                ),
                                subtitleStyle: grayTextStyle.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                              onChange: (state) => {
                                    setState(() {
                                      districtId = state.value;
                                      districtlabel = state.title;
                                    })
                                  }),
                        ),
                        const SizedBox(height: 15),
                      ],
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
                                    side: BorderSide(color: blueColor))),
                            onPressed: () {
                              getCurrentLocation();
                            },
                            child: Text(
                              "dapatkan koordinat",
                              style: blueTextStyle.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                    CustomButton(
                      title: "Simpan Donatur",
                      isLoading: isLoading,
                      onPressed: () {
                        if (validate()) {
                          if (widget.data != null) {
                            context.read<DonaturBloc>().add(UpdateDonatur(
                              uuid: widget.data!.id.toString(),
                              data: DonaturFormModel(
                                  name: nameController.text,
                                  phoneNumber: phoneController.text,
                                  address: addressController.text,
                                  lat: latController.text,
                                  lng: lngController.text,
                                  provinceId: provinceId,
                                  regencyId: regencyId,
                                  districtId: districtId
                              )
                            ));
                          } else {
                            context.read<DonaturBloc>().add(CreateDonatur(
                              data: DonaturFormModel(
                                  name: nameController.text,
                                  phoneNumber: phoneController.text,
                                  address: addressController.text,
                                  lat: latController.text,
                                  lng: lngController.text,
                                  provinceId: provinceId,
                                  regencyId: regencyId,
                                  districtId: districtId
                              )
                            ));
                          }
                        } else {
                          customSnackbar(context, 'Semua kolom harus diisi');
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
