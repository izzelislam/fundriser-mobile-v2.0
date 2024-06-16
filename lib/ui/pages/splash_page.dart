import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    super.initState();
    Future.delayed( Duration(seconds: 2), (){
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    } );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        
              Image.asset("assets/logo.png", 
                width: 82,
                height: 82,
              ),
              SizedBox(height: 2),
              Text("Fundriser", style: whiteTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold
              ),)
        
          ],
        ),
      ),
    );
  }
}