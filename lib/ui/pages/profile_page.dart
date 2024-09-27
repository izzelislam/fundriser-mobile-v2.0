import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                const ProfileSection(),
                const SizedBox(height: 46),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/change-password");
                  },
                  child: Row(
                    children: [
                      Image.asset("assets/ic_change_passwor.png", width: 24, height: 24,),
                      const SizedBox(width: 12),
                      Text("Ubah Password", style: darkGrayTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w700
                      )),
                      const Spacer(),
                      Icon(Icons.chevron_right_outlined, color: darkGrayColor, size: 24,),
                    ],
                  ),
                ),
                const SizedBox(height: 17),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/about");
                  },
                  child: Row(
                    children: [
                      Image.asset("assets/ic_about_app.png", width: 24, height: 24,),
                      const SizedBox(width: 12),
                      Text("Tentang Aplikasi", style: darkGrayTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w700
                      )),
                      const Spacer(),
                      Icon(Icons.chevron_right_outlined, color: darkGrayColor, size: 24,),
                    ],
                  ),
                ),
                const SizedBox(height: 17),
                // GestureDetector(
                //   onTap: (){
                //   },
                //   child: Row(
                //     children: [
                //       Image.asset("assets/ic_about_app.png", width: 24, height: 24,),
                //       const SizedBox(width: 12),
                //       Text("Biometrik", style: darkGrayTextStyle.copyWith(
                //         fontSize: 13,
                //         fontWeight: FontWeight.w700
                //       )),
                //       const Spacer(),
                //       Icon(Icons.chevron_right_outlined, color: darkGrayColor, size: 24,),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 400),
                CustomButton(title: "Keluar Aplikasi", isOutline: true, onPressed: () {},),
              ],
            )
          ],
        ),
      )
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 79,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: thinGrayColor
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage("assets/img_dumy.png"),
              backgroundColor: greenColor,
              radius: 25,
            ),
            const SizedBox(width: 17),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 230,
                  child: Text("Muttafakur Al aio Muttafakur Al aio Muttafakur Al aio", style: grayTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text("1827873746736473", style: grayTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}