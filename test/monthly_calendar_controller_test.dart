import 'package:flutter_monthly_calendar/monthly_calendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var eventCalendarController = MonthlyCalendarController();
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
    eventCalendarController.jumpTo(now);
    expect(logs.length, 1);
    expect(logs.first.first, MonthlyCalendarControllerAction.jumpTo);
    expect(logs.first.last, now);
    eventCalendarController.jumpTo(now);
    expect(logs.length, 2);
    expect(logs[1].first, MonthlyCalendarControllerAction.jumpTo);
    expect(logs[1].last, now);
  });
}
