import 'package:flutter/material.dart';

enum EventCalendarControllerAction { moveTo }

class EventCalendarController extends ChangeNotifier {
  late DateTime moveTargetDateTime;
  late EventCalendarControllerAction lastAction;
  moveTo(DateTime datetime) {
    moveTargetDateTime = datetime;
    lastAction = EventCalendarControllerAction.moveTo;
    notifyListeners();
  }
}
