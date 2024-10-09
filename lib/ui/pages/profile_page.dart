import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundriser/bloc/auth/auth_bloc.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial) {
                setState(() {
                  isLoading = false;
                });
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (route) => false);
              }

              if (state is AuthLoading) {
                setState(() {
                  isLoading = true;
                });
              }

            },
            child: ListView(
              children: [
                Column(
                  children: [
                    const ProfileSection(),
                    const SizedBox(height: 46),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/change-password");
                      },
                      child: Container(
                        color: whiteColor,
                        width: double.infinity,
                        height: 40,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/ic_change_passwor.png",
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 12),
                            Text("Ubah Password",
                                style: darkGrayTextStyle.copyWith(
                                    fontSize: 13, fontWeight: FontWeight.w700)),
                            const Spacer(),
                            Icon(
                              Icons.chevron_right_outlined,
                              color: darkGrayColor,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(height: 17),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/about");
                      },
                      child: Container(
                        color: whiteColor,
                        width: double.infinity,
                        height: 40,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/ic_about_app.png",
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 12),
                            Text("Tentang Aplikasi",
                                style: darkGrayTextStyle.copyWith(
                                    fontSize: 13, fontWeight: FontWeight.w700)),
                            const Spacer(),
                            Icon(
                              Icons.chevron_right_outlined,
                              color: darkGrayColor,
                              size: 24,
                            ),
                          ],
                        ),
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
                    CustomButton(
                      title: "Keluar Aplikasi",
                      isOutline: true,
                      isLoading: isLoading,
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogout());
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
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
          border: Border.all(color: thinGrayColor)),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      state.data.imageUrl!,
                    ),
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
                        child: Text(
                          state.data.name!,
                          style: grayTextStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(state.data.team?.uuid ?? '',
                          style: grayTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400)),
                    ],
                  )
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
