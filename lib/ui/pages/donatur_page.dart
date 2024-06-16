import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class DonaturPage extends StatelessWidget {
  const DonaturPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donatur"),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20
        ),
        child: ListView(
          children: [
            Column(
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
                const DonaturCard(),
                const DonaturCard(),
                const DonaturCard(),
                const DonaturCard(),
                const DonaturCard(),

              ],
            )
          ],
        ),
      ),
    );
  }
}

class DonaturCard extends StatelessWidget {
  const DonaturCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/donatur-detail"),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: double.infinity,
        height: 82,
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("Donasi Dari", style: grayTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700
                      ),),
                      const SizedBox(width: 5),
                      Image.asset("assets/ic_badge_check.png", width: 14, height: 14,)
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text("Bpk, H Joko Suwarno", style: darkGrayTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700
                  )),
                  const SizedBox(height: 2),
                  Container(
                    width: MediaQuery.of(context).size.width - 230,
                    child: Text("Magelang jawatenggah jl hj kasan rejo no 6 toko bapak joko narman", style: grayTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w700
                    ),
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
                    onTap: () {},
                    child: Image.asset("assets/ic_edit.png", width: 20, height: 20,),
                  ),
                  const SizedBox(width: 10,),
                  InkWell(
                    onTap: () {},
                    child: Image.asset("assets/ic_delete.png", width: 23, height: 23,),
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}