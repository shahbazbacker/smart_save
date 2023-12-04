import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_save/configs/colors.dart';
import 'package:smart_save/configs/text_class.dart';
import 'package:smart_save/configs/textstyle_class.dart';

import 'bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavigation()));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Hero(
          tag: 'logo',
          child: Text(
            TextClass.appName,
            style: TextStyleClass.whiteExtraBold28,
          ),
        ),
      ),
    );
  }
}
