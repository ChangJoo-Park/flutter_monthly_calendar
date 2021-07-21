import 'package:flutter_event_calendar/event_calendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var eventCalendarController = EventCalendarController();
  test('listen EventcalendarController', () {
    List<List> logs = [];
    eventCalendarController.addListener(() {
      logs.add([
        eventCalendarController.lastAction,
        eventCalendarController.moveTargetDateTime
      ]);
    });

    expect(logs.length, 0);
    var now = DateTime.now();
    eventCalendarController.moveTo(now);
    expect(logs.length, 1);
    expect(logs.first.first, EventCalendarControllerAction.MOVETO);
    expect(logs.first.last, now);
    eventCalendarController.moveTo(now);
    expect(logs.length, 2);
    expect(logs[1].first, EventCalendarControllerAction.MOVETO);
    expect(logs[1].last, now);
  });
}
