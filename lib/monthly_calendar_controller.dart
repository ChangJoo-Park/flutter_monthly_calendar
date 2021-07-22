import 'package:flutter/material.dart';

enum MonthlyCalendarControllerAction { jumpTo, animateTo }

class MonthlyCalendarController extends ChangeNotifier {
  late DateTime moveTargetDateTime;
  late MonthlyCalendarControllerAction lastAction;
  jumpTo(DateTime datetime) {
    moveTargetDateTime = datetime;
    lastAction = MonthlyCalendarControllerAction.jumpTo;
    notifyListeners();
  }

  animateTo(DateTime datetime) {
    moveTargetDateTime = datetime;
    lastAction = MonthlyCalendarControllerAction.animateTo;
    notifyListeners();
  }
}
