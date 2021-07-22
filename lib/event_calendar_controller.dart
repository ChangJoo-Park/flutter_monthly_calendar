import 'package:flutter/material.dart';

enum MonthlyCalendarControllerAction { moveTo }

class MonthlyCalendarController extends ChangeNotifier {
  late DateTime moveTargetDateTime;
  late MonthlyCalendarControllerAction lastAction;
  moveTo(DateTime datetime) {
    moveTargetDateTime = datetime;
    lastAction = MonthlyCalendarControllerAction.moveTo;
    notifyListeners();
  }
}
