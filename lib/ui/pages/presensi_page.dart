import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_input.dart';

class PresensiPage extends StatelessWidget {
  const PresensiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Presensi"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20
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
                        hintText: "Cari absensi",
                      ),
                    ),
                    const Spacer(),
                    Image.asset("assets/ic_short.png", width: 33, height: 33,)
                  ],
                ),

                const PresentCard(),
                const PresentCard(),
                const PresentCard(),
                const PresentCard(),
                const PresentCard(),
                const PresentCard(),

              ],
            )
          ],
        ),
      )
    );
  }
}


class PresentCard extends StatelessWidget {
  const PresentCard({
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
                      Text("absensi Masuk", style: grayTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700
                      ),),
                      const SizedBox(width: 5),
                      Image.asset("assets/ic_calender.png", width: 14, height: 14,)
                    ],
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: MediaQuery.of(context).size.width - 230,
                    child: Text("12 januari 2025", style: grayTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w700
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text("09 : 00", style: darkGrayTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  )),
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
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}