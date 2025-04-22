import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/donation/donation_bloc.dart';
import 'package:fundriser/model/donation_data_model.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class DonasiPage extends StatefulWidget {
  const DonasiPage({super.key});

  @override
  State<DonasiPage> createState() => _DonasiPageState();
}

class _DonasiPageState extends State<DonasiPage> {
  int currentPage = 2;
  bool loadingMore = false;

  List<DonationDataModel> donations = <DonationDataModel>[];
  TextEditingController searchField = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void handleSearch (String param){
      context.read<DonationBloc>().add( SearchDonation(param));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Donasi"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Row(
              children: [
                BlocListener<DonationBloc, DonationState>(
                  listener: (context, state) {
                    
                    if (state is DonationAllSuccess) {
                      setState(() {
                        if (state.data.length <= 0){
                          donations = [];
                        }else{
                          donations = List.from(state.data);
                        }
                      });
                    }

                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 90,
                    child: CustomInput(
                      isLabel: false,
                      hintText: "Cari berdasarkan no kwitansi",
                      controller: searchField,
                      onFieldSubmitted: (param){
                        handleSearch(param);
                      },
                    ),
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
            BlocProvider(
              create: (context) => DonationBloc()..add(const GetAllDonation()),
              child: BlocBuilder<DonationBloc, DonationState>(
                builder: (context, state) {
                  if (state is DonationLoading) {
                    return Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: blueColor,
                        ),
                      ),
                    );
                  }

                  if (state is DonationAllSuccess) {
                    if (state.data.isNotEmpty) {
                      donations = state.data;
                      return Column(
                        children:
                            donations.map((e) => DonationCard(data: e)).toList(),
                      );
                    }else{
                      return Center(
                        child: Text("Donasi Kosong", style: thinGrayTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w700),),
                      );
                    }
                  }

                  if (state is DonationLoading) {
                    return Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: blueColor,
                          strokeWidth: 5,
                        ),
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ),
            BlocListener<DonationBloc, DonationState>(
              listener: (context, state) {
                if (state is DonationAllSuccess) {
                  setState(() {
                    currentPage += 1;
                    loadingMore = false;
                  });
                  if (state.data.length > 0) {
                    setState(() {
                      donations.addAll(state.data);
                    });
                  }
                }

                if (state is DonationLoading) {
                  setState(() {
                    loadingMore = true;
                  });
                }

                if (state is DonationFailed) {
                  setState(() {
                    loadingMore = false;
                  });
                }
              },
              child: Center(
                child: TextButton(
                    onPressed: () => {
                          context
                              .read<DonationBloc>()
                              .add(GetAllDonation(page: currentPage.toString()))
                        },
                    child: loadingMore
                        ? SizedBox(
                            width: 10,
                            height: 10,
                            child: CircularProgressIndicator(
                                color: blueColor, strokeWidth: 1.5),
                          )
                        : Text(
                            "lebih banyak",
                            style: blueTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          )),
              ),
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
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, "/donasi-detail", arguments: data),
      child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(data.donor?.name ?? 'Unknown Donor',
                        style: darkGrayTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 2),
                    Text(
                      stringToDate(data.createdAt ?? ''),
                      style: thinGrayTextStyle.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const Spacer(),
                Text(numberToIdr(int.parse(data.amount)),
                    style: darkGrayTextStyle700.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w500))
              ],
            ),
          )),
    );
  }
}
