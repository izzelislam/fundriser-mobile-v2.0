import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/auth/auth_bloc.dart';
import 'package:fundriser/bloc/present/present_bloc.dart';
import 'package:fundriser/model/present/present_model.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {

  @override
  void initState() {
    super.initState();
    context.read<PresentBloc>().add(GetAllPresent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Presensi"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, "/presensi-form"),
          backgroundColor: blueColor,
          child: Image.asset(
            "assets/ic_add.png",
            width: 30,
            height: 30,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<PresentBloc, PresentState>(
            listener: (context, state) {
              if (state is PresentFailed){
                customSnackbar(context, state.message);
              }

              if (state is PresentDeleteSuccess){
                successSnackbar(context, "Berhasil menghapus data");
                context.read<PresentBloc>().add(GetAllPresent());
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
                              hintText: "Cari absensi",
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

                      if (state is PresentLoading)
                        Center(
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: blueColor,),
                            ),
                          ),
                        ),

                      if (state is PresentAllSuccess)...[
                        if (state.presents.isEmpty)...[
                          const SizedBox(height: 20),
                          Text("Tidak ada data presensi", style: grayTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 12),),
                          const SizedBox(height: 20),
                        ],

                        if (state.presents.isNotEmpty)...[
                          Column(
                            children: state.presents.map((e) => PresentCard(data: e)).toList(),
                          ) 
                        ]
                      ]
                    
                    ],
                  )
                ],
              );
            },
          ),
        ));
  }
}

class PresentCard extends StatelessWidget {

  final PresentModel data;

  const PresentCard({
    super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/presensi-detail", arguments: data),
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
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            (context.read<AuthBloc>().state as AuthSuccess)
                                .data.imageUrl!,
                          ),
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
                          "absensi ${data.type}",
                          style: grayTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(
                          "assets/ic_calender.png",
                          width: 14,
                          height: 14,
                        )
                      ],
                    ),
                    const SizedBox(height: 2),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 230,
                      child: Text(
                        parseDate2(data.presentAt!),
                        style: grayTextStyle.copyWith(
                            fontSize: 10, fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(parseTime2(data.presentAt!),
                        style: darkGrayTextStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<PresentBloc>().add(DeletePresent(data.id.toString()));
                      },
                      child: Image.asset(
                        "assets/ic_delete.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
