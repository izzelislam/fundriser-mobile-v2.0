import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fundriser/bloc/auth/auth_bloc.dart';
import 'package:fundriser/bloc/donation/donation_bloc.dart';
import 'package:fundriser/bloc/donatur/donatur_bloc.dart';
import 'package:fundriser/bloc/permit/permit_bloc.dart';
import 'package:fundriser/bloc/present/present_bloc.dart';
import 'package:fundriser/shared/theme.dart';
import 'package:fundriser/ui/pages/about_page.dart';
import 'package:fundriser/ui/pages/absensi_form_page.dart';
import 'package:fundriser/ui/pages/change_password.dart';
import 'package:fundriser/ui/pages/content_detail.dart';
import 'package:fundriser/ui/pages/donasi_detail_page.dart';
import 'package:fundriser/ui/pages/donasi_form_page.dart';
import 'package:fundriser/ui/pages/donasi_page.dart';
import 'package:fundriser/ui/pages/donatur_detail_page.dart';
import 'package:fundriser/ui/pages/donatur_page.dart';
import 'package:fundriser/ui/pages/donatur_form_page.dart';
import 'package:fundriser/ui/pages/home_page.dart';
import 'package:fundriser/ui/pages/login_page.dart';
import 'package:fundriser/ui/pages/notif_page.dart';
import 'package:fundriser/ui/pages/permit_detail.dart';
import 'package:fundriser/ui/pages/permit_form.dart';
import 'package:fundriser/ui/pages/permit_page.dart';
import 'package:fundriser/ui/pages/presensi_page.dart';
import 'package:fundriser/ui/pages/present_detail.dart';
import 'package:fundriser/ui/pages/profile_page.dart';
import 'package:fundriser/ui/pages/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  _showNotification(message);
  // print("Handling a background message: ${message.messageId}");
}

void _showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'high_importance_channel', // Channel ID
    'High Importance Notifications', // Channel name
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title,
    message.notification?.body,
    platformChannelSpecifics,
    payload: 'item x',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AuthGetProfile())),
        BlocProvider(create: (context) => DonationBloc()),
        BlocProvider(create: (context) => DonaturBloc()),
        BlocProvider(create: (context) => PresentBloc()),
        BlocProvider(create: (context) => PermitBloc()),
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
          "/presensi-detail": (context) => PresentDetail(),
          "/presensi-form": (context) => const AbsensiFormPage(),
          "/permit": (context) => const PermitPage(),
          "/permit-form": (context) => const PermitFormPage(),
          "/permit-detail": (context) => PermitDetail(),
          "/content-detail": (context) => const ContentDetailPage(),
        },
      ),
    );
  }
}
