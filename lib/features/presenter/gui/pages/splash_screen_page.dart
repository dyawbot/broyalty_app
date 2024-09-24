import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:broyalty_app/features/presenter/gui/routers/app_routers.dart';
import 'package:flutter/material.dart';

import '../../constant/color.dart';

@RoutePage()
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _simulateProgress();
    _startSplashScreenTimer();
  }

  void _startSplashScreenTimer() {
    Timer(Duration(seconds: 3), () {
      AutoRouter.of(context).push(HomeNavigationRoute());
    });
  }

  void _simulateProgress() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_progress >= 1.0) {
        timer.cancel();
      } else {
        setState(() {
          _progress +=
              0.04; // Adjust the increment for faster or slower progress
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.pageBg,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/broyalty_logo.png"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: LinearProgressIndicator(
                  value: _progress,
                ),
              ),
            ],
          ),
        ));
  }
}
