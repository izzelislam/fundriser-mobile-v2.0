import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/auth/auth_bloc.dart';
import 'package:fundriser/bloc/permit/permit_bloc.dart';
import 'package:fundriser/model/permit/permit_data_model.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';

class PermitPage extends StatefulWidget {
  const PermitPage({super.key});

  @override
  State<PermitPage> createState() => _PermitPageState();
}

class _PermitPageState extends State<PermitPage> {

  @override
  void initState() {
    context.read<PermitBloc>().add(GetAllPermit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Perizinan"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/permit-form"),
        backgroundColor: blueColor,
        child: Image.asset(
          "assets/ic_add.png",
          width: 30,
          height: 30,
        ),
      ),
      body: BlocConsumer<PermitBloc, PermitState>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                
                const SizedBox(height: 20),
                Text("Perizinan Pada Bulan ${getCurrentMonth()}", style: grayTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 12),),
                const SizedBox(height: 20),
                // if state is AuthSUccess
                if (state is PermitAllSuccess)...[
                  if (state.permits.isEmpty)...[
                    Center(child: Text("Belum ada data", style: darkGrayTextStyle.copyWith(fontSize: 12),))
                  ] else ...[
                    Column(
                      children: state.permits.map((e) => PermitCard(data: e)).toList(),
                    )
                  ]
                ],

                if (state is PermitLoading)
                Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator(color: blueColor),
                  )
                )

                ],
              ),
            );
        },
      ),
    );
  }
}

class PermitCard extends StatelessWidget {

  final PermitDataModel data;

  const PermitCard({
    super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/permit-detail", arguments: data),
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
                        Image.asset(
                          "assets/ic_calender.png",
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Tanggal perizinan",
                          style: grayTextStyle.copyWith(
                              fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 230,
                      child: Text(
                        parseDate2(data.permitAt!),
                        style: grayTextStyle.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Image.asset(
                          "assets/ic_note.png",
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          data.note ?? '-',
                          style: grayTextStyle.copyWith(
                              fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                      ],
                    )
                    
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // show dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Hapus Perizinan", style: TextStyle(color: redColor, fontSize: 14),),
                            content: const Text("Silahkan hubungi admin jika ingin menghapus perizinan ini"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Tutup", style: TextStyle(color: blueColor),),
                              ),
                            ],
                          ),
                        );
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