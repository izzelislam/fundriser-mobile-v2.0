import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/permit/permit_bloc.dart';
import 'package:fundriser/model/permit/permit_form_model.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/button_input.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class PermitFormPage extends StatefulWidget {
  const PermitFormPage({super.key});

  @override
  State<PermitFormPage> createState() => _PermitFormPageState();
}

class _PermitFormPageState extends State<PermitFormPage> {
  bool isLoading = false;
  String date = '';
  List<DateTime?> datesValue = [null];


  TextEditingController noteField = TextEditingController(text: '');

  bool validated() {
    if (noteField.text.isEmpty && date.isEmpty) {
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
          "Ajukan Perizinan",
          style: TextStyle(color: whiteColor),
        ),
        backgroundColor: greenColor,
        iconTheme: IconThemeData(color: whiteColor),
      ),
      body: BlocConsumer<PermitBloc, PermitState>(
        listener: (context, state) {
          if (state is PermitCreateSuccess) {
            successSnackbar(context, "Berhasil mengajukan izin");
            Navigator.pushNamed(context, "/permit-detail", arguments: state.permit);
          }

          if (state is PermitFailed) {
            customSnackbar(context, state.message);
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
                      title: "Ajukan Perizinan",
                      isOutline: true,
                      isLoading: isLoading,
                      onPressed: () {
                        if (!validated()) {
                          customSnackbar(context, "Semua field wajib diisi !");
                        }else {
                          context.read<PermitBloc>().add(CreatePermit(
                            PermitFormModel(
                              note: noteField.text,
                              permitAt: date
                            )
                          ));
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonInput(
                            title: "Tanggal Perizinan",
                            isOutline: true,
                            isLoading: isLoading,
                            value: date,
                            onPressed: () async {
                                List<DateTime?>? selectetDate = await showCalendarDatePicker2Dialog(
                                  context: context,
                                  config: CalendarDatePicker2WithActionButtonsConfig(
                                    selectedDayHighlightColor: greenColor,
                                    daySplashColor: greenColor,
                                  ),
                                  value: datesValue,
                                  dialogSize: const Size(325, 400),
                                  borderRadius: BorderRadius.circular(15),
                                );

                                setState(() {
                                  date = selectetDate!.first.toString().substring(0, 10);
                                  datesValue = selectetDate;
                                });
                            },
                          ),
                          const SizedBox(height: 15),
                          CustomInput(
                            label: "Catatan",
                            controller: noteField,
                          ),
                        ],
                      ),
                    ),
                  )
                )
            ],
          );
        },
      ),
    );
  }
}
