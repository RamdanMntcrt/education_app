import 'dart:async';

import 'package:edu_app/utils/font_constants.dart';
import 'package:edu_app/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../utils/color_constants.dart';
import 'home screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Class Manager',
                style: TextStyle(
                    fontFamily: Fonts.poppins,
                    fontSize: 32,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal * 3,
              ),
              const Text(
                'Make your management faster',
                style: TextStyle(
                    fontFamily: Fonts.poppins,
                    fontSize: 20,
                    color: ClrConst.primaryDeepBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
