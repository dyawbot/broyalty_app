import 'package:auto_route/auto_route.dart';
import 'package:broyalty_app/features/presenter/constant/color.dart';
import 'package:flutter/material.dart';

import '../routers/app_routers.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  // final double width;
  // final double height;
  const HomePage({Key? key}) : super(key: key);

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: _height * 0.02,
                ),
                const Text(
                  "Broyalty Disease Detector",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: _height * 0.03,
                ),
                Center(
                  child: Container(
                    width: _width,
                    height: _height * 0.25,
                    decoration: BoxDecoration(
                        color: AppColors.analogComMainColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 12),
                          child: SizedBox(
                            // color: Colors.green,
                            child: Image.asset(
                              'assets/home_image/camera2.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                // height: 100,
                                width: _width * 0.38,
                                child: const Text(
                                  "Identify the disease of your Broiler",
                                  maxLines: 3,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: _width * 0.43,
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextButton.icon(
                                  onPressed: () {
                                    AutoRouter.of(context).push(CameraRoute());
                                  },
                                  label: const Text(
                                    "Start Scan",
                                    style: TextStyle(
                                        color: AppColors.comMainColor),
                                  ),
                                  icon: const Icon(Icons.schema_rounded,
                                      color: AppColors.comMainColor),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const SizedBox(
                  height: 28,
                  child: Text(
                    "Information about the disease",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: _height * 0.22,
                          width: _width * 0.43,
                          decoration: BoxDecoration(
                              color: AppColors.analogComMainColor,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          // color: Colors.orange,
                          height: _height * 0.22,
                          width: _width * 0.43,
                          decoration: BoxDecoration(
                              color: AppColors.analogComMainColor,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ],
                    ),
                    Container(
                      // color: Colors.green,
                      height: _height * 0.27,
                      width: _width * 0.43,
                      decoration: BoxDecoration(
                          color: AppColors.analogComMainColor,
                          borderRadius: BorderRadius.circular(12)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
