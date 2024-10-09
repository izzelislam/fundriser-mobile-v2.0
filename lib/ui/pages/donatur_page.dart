import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/donatur/donatur_bloc.dart';
import 'package:fundriser/model/donatur/donatur_data_model.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/pages/donatur_form_page.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class DonaturPage extends StatefulWidget {
  const DonaturPage({super.key});

  @override
  State<DonaturPage> createState() => _DonaturPageState();
}

class _DonaturPageState extends State<DonaturPage> {

  List<DonaturDataModel> donatur = [];
  bool loading = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    donatur = [];
    context.read<DonaturBloc>().add(const GetAllDonatur());
  }

  void handleLoadMore() {
    setState(() {
      currentPage++;
    });
    context.read<DonaturBloc>().add(GetAllDonatur(page: currentPage.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donatur"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/donatur-form"),
        backgroundColor: blueColor,
        child: Image.asset(
          "assets/ic_add.png",
          width: 30,
          height: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: BlocConsumer<DonaturBloc, DonaturState>(
          
          listener: (context, state) {

            if (state is DonaturLoading) {
              setState(() {
                loading = true;
              });
            }

            if (state is DonaturFailed) {
              customSnackbar(context, state.message);
              setState(() {
                loading = false;
              });
            }

            if (state is DonaturSuccess) {
              setState(() {
                loading = false;
              });
              context.read<DonaturBloc>().add(GetAllDonatur(page: currentPage.toString()));
            }
            
            if (state is DonaturAllSuccess){
              setState(() {
                // donatur = List.from(state.data!);
                if (currentPage > 1){
                  donatur.addAll(state.data!);
                }else{
                  donatur = List.from(state.data!);
                }
                loading = false;
              });
            }
          },

          builder: (context, state) {
            return ListView(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 90,
                          child: const CustomInput(
                            isLabel: false,
                            hintText: "Cari berdasarkan ID",
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          "assets/ic_short.png",
                          width: 33,
                          height: 33,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    if (state is DonaturLoading) ...[
                      Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: blueColor,),
                        ),
                      ),
                    ], 
                    
                    

                    if (state is DonaturAllSuccess) ...[
                      if (state.data!.isNotEmpty) ...[
                        Column(
                          children: donatur.map((donation) {
                            return DonaturCard(data:donation);
                          }).toList(),
                        )
                      ] else ...[
                        const Center(
                          child: Text("Belum ada donatur"),
                        ),
                      ]
                    ],

                    
                    const SizedBox(
                      height: 20,
                    ),

                    TextButton(
                      onPressed: () => handleLoadMore(), 
                      child: loading ? SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(color: blueColor,) ,
                      ): Text(
                        "lebih banyak",
                        style: blueTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      )
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class DonaturCard extends StatelessWidget {
  final DonaturDataModel? data;

  const DonaturCard({
    super.key,
    this.data
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/donatur-detail", arguments: data),
      child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: double.infinity,
          height: 82,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: thinGrayColor)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "donatur",
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
                    Text(data?.name ?? "",
                        style: darkGrayTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 230,
                      child: Text(data?.address ?? "",
                        style: grayTextStyle.copyWith(
                            fontSize: 10, fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, "/donatur-form", arguments: data);
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => DonaturFormPage(data: data)),
                        );
                      },
                      child: Image.asset(
                        "assets/ic_edit.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<DonaturBloc>().add(DeleteDonatur(uuid: data?.id.toString() ?? ""));
                      },
                      child: Image.asset(
                        "assets/ic_delete.png",
                        width: 23,
                        height: 23,
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
