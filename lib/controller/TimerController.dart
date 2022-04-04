import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController{
  int minutes = 2;
  int second = 0;
  Timer? _timer;

  changeSecond() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (minutes > 0) {
        if (second > 0) {
          second--;
        } else {
          if (minutes != 0) {
            minutes--;
          }
          second = 59;
        }
      } else {
        if (second > 0) {
          second--;
        } else {
          _timer!.cancel();
        }
      }
      update();
    });
  }

  resetTimer(){
    minutes = 2;
    second = 0;
    update();
    changeSecond();
  }

  cancelTimer() {
    _timer!.cancel();
    update();
  }
}