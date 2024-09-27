import 'package:flutter/material.dart';
import 'package:fundriser/bloc/auth/auth_bloc.dart';
import 'package:fundriser/bloc/donation/donation_bloc.dart';
import 'package:fundriser/bloc/donatur/donatur_bloc.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/pages/about_page.dart';
import 'package:fundriser/ui/pages/absensi_form_page.dart';
import 'package:fundriser/ui/pages/change_password.dart';
import 'package:fundriser/ui/pages/donasi_detail_page.dart';
import 'package:fundriser/ui/pages/donasi_form_page.dart';
import 'package:fundriser/ui/pages/donasi_page.dart';
import 'package:fundriser/ui/pages/donatur_detail_page.dart';
import 'package:fundriser/ui/pages/donatur_page.dart';
import 'package:fundriser/ui/pages/donatur_form_page.dart';
import 'package:fundriser/ui/pages/home_page.dart';
import 'package:fundriser/ui/pages/login_page.dart';
import 'package:fundriser/ui/pages/notif_page.dart';
import 'package:fundriser/ui/pages/permit_page.dart';
import 'package:fundriser/ui/pages/presensi_page.dart';
import 'package:fundriser/ui/pages/profile_page.dart';
import 'package:fundriser/ui/pages/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AuthGetProfile())),
        BlocProvider(create: (context) => DonationBloc()),
        BlocProvider(create: (context) => DonaturBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: whiteColor,
            appBarTheme: AppBarTheme(
              surfaceTintColor: blueColor,
              backgroundColor: whiteColor,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: darkGrayTextStyle.copyWith(
                  fontSize: 20, fontWeight: semiBold),
              iconTheme: IconThemeData(color: darkGrayColor),
            )),
        routes: {
          "/": (context) => const SplashPage(),
          "/login": (context) => LoginPage(),
          "/home": (context) => const HomePage(),
          "/donasi": (context) => const DonasiPage(),
          "/donasi-form": (context) => DonasiFormPage(),
          "/donasi-detail": (context) => DonasiDetailPage(),
          "/donatur-form": (context) => const DonaturFormPage(),
          "/donatur": (context) => const DonaturPage(),
          "/donatur-detail": (context) => const DonaturDetailPage(),
          "/profile": (context) => const ProfilePage(),
          "/about": (context) => const AboutPage(),
          "/change-password": (context) => const ChangePasswordPage(),
          "/notif": (context) => const NotifPage(),
          "/presensi": (context) => const PresensiPage(),
          "/presensi-form": (context) => const AbsensiFormPage(),
          "/permit": (context) => const PermitPage(),
        },
      ),
    );
  }
}
