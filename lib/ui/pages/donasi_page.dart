import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class DonasiPage extends StatelessWidget {
  const DonasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donasi"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20
        ),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 90,
                  child: CustomInput(
                    isLabel: false,
                    hintText: "Cari berdasarkan no kwitansi",
                  ),
                ),
                const Spacer(),
                Image.asset("assets/ic_short.png", width: 33, height: 33,)
              ],
            ),
            const SizedBox(height: 15,),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
            const DonationCard(),
          ],  
        ),
      ),
    );
  }
}


class DonationCard extends StatelessWidget {
  const DonationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/donasi-detail"),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: thinGrayColor
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8      
          ),
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 37,
                    height: 37,
                    decoration: BoxDecoration(
                      color: slateColor,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: Image.asset("assets/ic_person_placeholder.png", width: 28, height: 28,),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Donasi Dari", style: grayTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700
                      ),),
                      const SizedBox(width: 5),
                      Image.asset("assets/ic_badge_check.png", width: 14, height: 14,),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text("Bpk, H Joko Suwarno", style: darkGrayTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700
                  )),
                  const SizedBox(width: 2),
                  Text("12/Januari/2025", style: thinGrayTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700
                  ),),
                ],
              ),
              const Spacer(),
              Text("Rp. 250.000", style: darkGrayTextStyle700.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500
              ))
            ],
          ),
        )
      ),
    );
  }
}