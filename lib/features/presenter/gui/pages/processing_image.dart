// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:broyalty_app/features/presenter/constant/color.dart';
import 'package:broyalty_app/features/presenter/gui/routers/app_routers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

@RoutePage()
class ProcessingImagePage extends StatefulWidget {
  final XFile imageFile;

  const ProcessingImagePage(this.imageFile, {super.key});

  @override
  State<ProcessingImagePage> createState() => _ProcessingImagePageState();
}

class _ProcessingImagePageState extends State<ProcessingImagePage> {
  double identifyPercentage = 0.0;
  final logger = Logger();

  @override
  void initState() {
    super.initState();

    _simulateProgress();
  }

  void _simulateProgress() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (identifyPercentage >= 100.0) {
        timer.cancel();

        logger.d("This will show the processed");
        _showResult();
      } else {
        setState(() {
          identifyPercentage +=
              2; // Adjust the increment for faster or slower progress
        });
      }
    });
  }

  void _showResult() {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return Container(
          // color: Colors.red,
          height: 300,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                  top: 18,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Identified Disease Report",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  )),
              Positioned(
                  top: 70,
                  left: 18,
                  right: 0,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "The identified disease is..",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            AutoRouter.of(context).push(const HomeRoute());
                          },
                          child: const Icon(Icons.home)),
                      ElevatedButton(
                          onPressed: () {
                            AutoRouter.of(context).push(const CameraRoute());
                          },
                          child: const Icon(Icons.camera))
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Processing Image"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Image.file(
                width: _w,
                File(
                  widget.imageFile.path,
                ),
                fit: BoxFit.cover),
          ),
          // const Spacer(),
          // Expanded(
          //   flex: 1,
          //   child: ElevatedButton(
          //       onPressed: _showResult,
          //       child: const Text("Identify this Image")),
          // ),
          Visibility(
            child: Expanded(
              flex: 2,
              child: Container(
                color: AppColors.pageBg,
                width: _w,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const Text("Wait for a moment"),
                      Text(
                          "Identifying: ${identifyPercentage.toStringAsFixed(1)}%"),
                      const SizedBox(height: 25),
                      Stack(
                        alignment:
                            Alignment.center, // Align children to the center
                        children: [
                          // Circular loading indicator

                          const SizedBox(
                            width:
                                70, // Set the size of the circular loading indicator
                            height: 70,
                            child: CircularProgressIndicator(
                              strokeWidth:
                                  8, // Thickness of the circular loading indicator
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                          // Image inside the circular loading indicator
                          ClipOval(
                            child: Image.asset(
                              "assets/broyalty_logo.png", // Replace with your image path
                              width: 70, // Size of the image inside the circle
                              height: 70,
                              fit: BoxFit
                                  .cover, // Ensures the image fills the circle properly
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
