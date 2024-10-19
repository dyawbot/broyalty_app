// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:auto_route/auto_route.dart';
import 'package:broyalty_app/features/presenter/constant/color.dart';
import 'package:broyalty_app/features/presenter/constant/ui_boolean.dart';
import 'package:broyalty_app/features/presenter/gui/routers/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

@RoutePage()
class HomeNavigationPage extends StatefulWidget {
  const HomeNavigationPage({super.key});

  @override
  State<HomeNavigationPage> createState() => _HomeNavigationPageState();
}

class _HomeNavigationPageState extends State<HomeNavigationPage> {
  bool homeNavCLick = true;
  bool chatNavClick = false;
  bool aboutNavClick = false;
  bool favNavClick = false;
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    // double _height = MediaQuery.of(context).size.height;
    return AutoTabsRouter(
      routes: const [
        HomeRoute(
            // height: _height,
            // width: _width,
            ),
        ChatRoute(),
        AboutRoute(),
        HistoryRoute(),
      ],
      // transitionBuilder: (context, child, animation) => FadeTransition(
      //   opacity: animation,
      //   child: child,
      // ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomAppBar(
              height: 60,
              color: AppColors.mainColor,
              shape: const CircularNotchedRectangle(),
              notchMargin: 6.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: _width * 0.35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // HOME
                        IconButton(
                          onPressed: () {
                            tabsRouter.setActiveIndex(0);

                            setState(() {
                              homeNavCLick = true;
                              aboutNavClick = false;
                              chatNavClick = false;
                              favNavClick = false;
                              UiBoolean.isChatOpen = true;
                            });
                          },
                          icon: Icon(
                            Icons.home,
                            color: homeNavCLick
                                ? AppColors.comMainColor
                                : AppColors.analogMainColor,
                          ),
                        ),

                        //CHAT
                        IconButton(
                          onPressed: () {
                            tabsRouter.setActiveIndex(1);

                            setState(() {
                              homeNavCLick = false;
                              aboutNavClick = false;
                              chatNavClick = !chatNavClick;
                              favNavClick = false;

                              UiBoolean.isChatOpen = true;
                            });
                          },
                          icon: Icon(
                            Icons.chat,
                            color: chatNavClick
                                ? AppColors.comMainColor
                                : AppColors.analogMainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: _width * 0.35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //INFO
                        IconButton(
                          onPressed: () {
                            tabsRouter.setActiveIndex(2);

                            setState(() {
                              homeNavCLick = false;
                              aboutNavClick = !aboutNavClick;
                              chatNavClick = false;
                              favNavClick = false;
                              UiBoolean.isChatOpen = true;
                            });
                          },
                          icon: Icon(
                            Icons.info,
                            color: aboutNavClick
                                ? AppColors.comMainColor
                                : AppColors.analogMainColor,
                          ),
                        ),

                        //FAVORITE
                        IconButton(
                          onPressed: () {
                            tabsRouter.setActiveIndex(3);

                            setState(() {
                              homeNavCLick = false;
                              aboutNavClick = false;
                              chatNavClick = false;
                              favNavClick = !favNavClick;
                              UiBoolean.isChatOpen = true;
                            });
                          },
                          icon: Icon(
                            Icons.history,
                            color: favNavClick
                                ? AppColors.comMainColor
                                : AppColors.analogMainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          floatingActionButton: Visibility(
            visible: UiBoolean.isChatOpen,
            child: FloatingActionButton(
              backgroundColor: AppColors.mainColor,
              // mini: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                // Action for camera button
                logger.d('Camera button pressed');
                AutoRouter.of(context).push(const CameraRoute());
              },
              child: const Icon(
                Icons.camera_alt,
                color: AppColors.comMainColor,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
