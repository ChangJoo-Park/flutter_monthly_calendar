import 'package:flutter/material.dart';

enum EventCalendarControllerAction { MOVETO }

class EventCalendarController extends ChangeNotifier {
  late DateTime moveTargetDateTime;
  late EventCalendarControllerAction lastAction;
  moveTo(DateTime datetime) {
    moveTargetDateTime = datetime;
    lastAction = EventCalendarControllerAction.MOVETO;
    notifyListeners();
  }
}
