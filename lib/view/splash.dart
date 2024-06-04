import 'dart:async';

import 'package:flutter/material.dart';

import 'package:covid_tracker/animation/rotating_logo.dart';
import 'package:covid_tracker/view/worlds_states.dart';

class SplashScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final bool isDarkMode;

  const SplashScreen({
    Key? key,
    required this.onThemeChanged,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WorldsStates(onThemeChanged: widget.onThemeChanged))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotatingLogo(imagePath: "assets/images/right_16590659.png"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Text(
              "Covid-19\nTracker App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
      )),
    );
  }
}
