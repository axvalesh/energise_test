import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class StopwatchController extends GetxController {
  final Rx<Duration> _elapsedTime = Rx<Duration>(const Duration(seconds: 0));
  RxBool isPlaying = false.obs;
  Timer? _timerSubscription;

  Rx<Duration> get elapsedTime => _elapsedTime;

  void startStopwatch() {
    _timerSubscription = Timer.periodic(const Duration(seconds: 1), (time) {
      debugPrint('time is ${_elapsedTime.value.inSeconds}');
      _elapsedTime.value = Duration(seconds: _elapsedTime.value.inSeconds + 1);
    });
  }

  void pauseStopwatch() {
    _timerSubscription?.cancel();
  }

  @override
  void dispose() {
    _timerSubscription?.cancel();
    super.dispose();
  }
}