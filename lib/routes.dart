
import 'package:energise/screens/info/info.dart';
import 'package:energise/screens/map/map.dart';
import 'package:energise/screens/stopwatch/stopwatch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Routes {
  static String stopwatch = '/stopwatch';
  static String map = '/map';
  static String info = '/info';
  
}

final getPages = [
  GetPage(
    name: Routes.stopwatch,
    page: () => StopwatchScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 200),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Routes.map,
    page: () => MapScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 200),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Routes.info,
    page: () => InfoScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 200),
    middlewares: [MyMiddelware()],
  ),
];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    debugPrint(page?.name);
    return super.onPageCalled(page);
  }
}