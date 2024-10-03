import 'package:flutter/material.dart';
import 'package:flutter_awesome_select_clone/flutter_awesome_select.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/donation/donation_bloc.dart';
import 'package:fundriser/model/danation/donation_form_model.dart';
import 'package:fundriser/model/donatur/donatur_detail_model.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class DonasiFormPage extends StatefulWidget {
  const DonasiFormPage({super.key});

  @override
  State<DonasiFormPage> createState() => _DonasiFormPageState();
}

class _DonasiFormPageState extends State<DonasiFormPage> {
  String value = '';
  bool isLoading = false;

  TextEditingController amountField = TextEditingController(text: '');
  TextEditingController noteField = TextEditingController(text: '');

  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'shodaqoh', title: 'shodaqoh'),
    S2Choice<String>(value: 'zakat', title: 'zakat'),
    S2Choice<String>(value: 'infaq', title: 'infaq'),
    S2Choice<String>(value: 'wakaf', title: 'wakaf'),
    S2Choice<String>(value: 'lainnya', title: 'lainnya'),
  ];

  bool validated() {
      if (!amountField.text.isEmpty && value.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }

  @override
  Widget build(BuildContext context) {
    final DonaturDetailModel data =
        ModalRoute.of(context)!.settings.arguments as DonaturDetailModel;

    TextEditingController codeField = TextEditingController(text: data.uuid);
    TextEditingController nameField = TextEditingController(text: data.name);
    
    

    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Donasi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                CustomInput(
                  label: "Kode Donatur",
                  hintText: "kode donatur",
                  isReadOnly: true,
                  controller: codeField,
                ),
                CustomInput(
                  label: "Nama Donatur",
                  hintText: "nama donatur",
                  isReadOnly: true,
                  controller: nameField,
                ),
                CustomInput(
                  label: "Nominal",
                  hintText: "nominal",
                  keyboardType: TextInputType.number,
                  controller: amountField,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jenis Donasi",
                        style: darkGrayTextStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 5),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: thinGrayColor, width: 1),
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
                  ],
                ),
                CustomInput(
                  label: "Catatan",
                  hintText: "Catatan donasi",
                  controller: noteField,
                ),
                BlocListener<DonationBloc, DonationState>(
                  listener: (context, state) {

                    if (state is DonationLoading){
                      setState(() {
                        isLoading = true;
                      });
                    }

                    if (state is DonationFailed){
                      setState(() {
                        isLoading = false;
                      });
                      customSnackbar(context, state.message);
                    }
                    
                    if (state is DonationSuccess){
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushNamed(context, "/donasi-detail", arguments: state.data);
                    }
                  },
                  child: CustomButton(
                      title: "Simpan Donasi",
                      isLoading: isLoading,
                      onPressed: () => {
                        if (validated()) {
                          BlocProvider.of<DonationBloc>(context).add(
                            CreateDonation(
                              DonationFormModel(
                                uuid: codeField.text,
                                amount: amountField.text,
                                note: noteField.text,
                                type: value
                              )
                            )
                          )
                        }else{
                          customSnackbar(context, "Lengkapi form terlebih dahulu !")
                        }
                      }
                    ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
