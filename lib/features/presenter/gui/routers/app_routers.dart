import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../pages/camera_page.dart';
import '../pages/home_nav_page.dart';
import '../pages/processing_image.dart';
import '../pages/splash_screen_page.dart';
import '../tabs/about_page.dart';
import '../tabs/chat_page.dart';
import '../tabs/favorite_page.dart';
import '../tabs/home_page.dart';

part 'app_routers.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  // TODO: implement routes
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRouteRoute.page, initial: true),
        AutoRoute(page: CameraRoute.page),
        AutoRoute(page: ProcessingImageRoute.page),
        AutoRoute(page: HomeNavigationRoute.page, children: [
          AutoRoute(
            page: HomeRoute.page,
          ), // path: "/home"),
          AutoRoute(
            page: ChatRoute.page,
          ), // path: "/chat"),
          AutoRoute(
            page: AboutRoute.page,
          ), // path: "/about"),
          AutoRoute(
            page: FavoriteRoute.page,
          ), // path: "/favorite"),
        ]),
      ];
}
