// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:auto_route/auto_route.dart';
import 'package:broyalty_app/features/presenter/constant/color.dart';
import 'package:broyalty_app/features/presenter/constant/descriptions.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  // final double width;
  // final double height;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      // appBar: AppBar(
      //   title: const Text(
      //     "Broyalty Disease Detector",
      //     style: TextStyle(fontSize: 18),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _height * 0.2,
              width: _width,
              decoration: const BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18)),
              ),
              child: const SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to \nBroyalty Disease Detector",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Image.asset(
                    "assets/broyalty_logo.png",
                    height: _height * 0.25,
                  ),
                  const Text(
                    AppDescriptions.descriptions,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
