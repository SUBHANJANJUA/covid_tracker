import 'dart:async';

import 'package:covid_tracker/Word_State_Screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SaplashScreen extends StatefulWidget {
  const SaplashScreen({super.key});

  @override
  State<SaplashScreen> createState() => _SaplashScreenState();
}

class _SaplashScreenState extends State<SaplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WordStateScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _controller,
              child: Container(
                width: 200,
                height: 200,
                child: Center(
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 0.2 * math.pi,
                  child: child,
                );
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.09,
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Covid-19\nTracker App",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              )),
        ],
      ),
    ));
  }
}
