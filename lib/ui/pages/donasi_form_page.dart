import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fundriser/model/donatur/donatur_detail_model.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class DonasiFormPage extends StatefulWidget {
  const DonasiFormPage({super.key});

  @override
  State<DonasiFormPage> createState() => _DonasiFormPageState();
}

class _DonasiFormPageState extends State<DonasiFormPage> {
  @override
  Widget build(BuildContext context) {

    final DonaturDetailModel data = ModalRoute.of(context)!.settings.arguments as DonaturDetailModel;
     SingleValueDropDownController _cnt = SingleValueDropDownController();

    TextEditingController codeField = TextEditingController(text: data.uuid);
    TextEditingController nameField = TextEditingController(text: data.name);
    TextEditingController amountField = TextEditingController(text: '');
    TextEditingController typeField = TextEditingController(text: '');
    TextEditingController noteField = TextEditingController(text: '');

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
                // const CustomInput(
                //   label: "Jenis",
                //   hintText: "jenis donasi",
                // ),
                DropDownTextField(
                  controller: _cnt,
                  clearOption: true,
                  enableSearch: true,
                  clearIconProperty: IconProperty(color: Colors.green),
                  searchTextStyle: const TextStyle(color: Colors.red),
                  searchDecoration: const InputDecoration(
                      hintText: "enter your custom hint text here"),
                  validator: (value) {
                    if (value == null) {
                      return "Required field";
                    } else {
                      return null;
                    }
                  },
                  dropDownItemCount: 6,
                  dropDownList: const [
                    DropDownValueModel(name: 'name1', value: "value1"),
                    DropDownValueModel(
                        name: 'name2',
                        value: "value2",
                        toolTipMsg:
                            "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                    DropDownValueModel(name: 'name3', value: "value3"),
                    DropDownValueModel(
                        name: 'name4',
                        value: "value4",
                        toolTipMsg:
                            "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                    DropDownValueModel(name: 'name5', value: "value5"),
                    DropDownValueModel(name: 'name6', value: "value6"),
                    DropDownValueModel(name: 'name7', value: "value7"),
                    DropDownValueModel(name: 'name8', value: "value8"),
                  ],
                  onChanged: (val) {},
                ),
                const CustomInput(
                  label: "Catatan",
                  hintText: "Catatan donasi",
                ),
                CustomButton(
                  title: "Simpan Donasi",
                  onPressed: () => {
                    Navigator.pushNamed(context, "/donasi-detail")
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}