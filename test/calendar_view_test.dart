import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/calendar_cell.dart';
import 'package:flutter_event_calendar/calendar_header.dart';
import 'package:flutter_event_calendar/calendar_view.dart';
import 'package:flutter_event_calendar/event_calendar.dart';
import 'package:flutter_event_calendar/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Calendar View', (WidgetTester tester) async {
    var tapLogs = [];
    var longPressLogs = [];
    var theme = DefaultEventCalendarThemeData();
    var key = Key('CALENDAR_VIEW');
    var datetime = DateTime(2021, 07, 01);
    var firstWeekday = DateTime.monday;
    var calendarView = CalendarView(
      monthDateTime: datetime,
      selectedDateTime: null,
      weekdays: KoreanEventCalendarLocale().weekdaysShort,
      firstWeekday: firstWeekday,
      theme: theme,
      key: key,
      onDateTimeSelected: (value) {
        tapLogs.add(value);
      },
      onCellLongPress: (value) {
        longPressLogs.add(value);
      },
    );

    await tester.pumpWidget(
        Directionality(textDirection: TextDirection.ltr, child: calendarView));
    final calendarViewFinder = find.byKey(key);
    final state = tester.state<CalendarViewState>(calendarViewFinder);

    expect(state.days, generateMonth(datetime, firstWeekday));
    expect(state.allDays, generateMonth(datetime, firstWeekday).chunk(7));
    expect(
      state.weekdays,
      KoreanEventCalendarLocale().weekdaysShort.rotateRight(
            getDiffFromWeekday(firstWeekday),
          ),
    );

    final calendarHeadersFind = find.byType(CalendarHeader);
    expect(calendarHeadersFind.evaluate().length, state.weekdays.length);
    final calendarHeaders = calendarHeadersFind
        .evaluate()
        .toList()
        .map((element) => element.widget as CalendarHeader);
    expect(calendarHeaders.map((elm) => elm.weekday), state.weekdays);

    final calendarCellsFind = find.byType(CalendarCell);
    expect(calendarCellsFind.evaluate().length, state.days.length);
    final calendarCells = calendarCellsFind
        .evaluate()
        .toList()
        .map((element) => element.widget as CalendarCell);
    expect(calendarCells.map((elm) => elm.datetime), state.days);

    await Future.forEach(calendarCellsFind.evaluate(), (cellElement) async {
      final cellFind =
          find.byElementPredicate((element) => element == cellElement);
      await tester.tap(cellFind);
    });
    expect(tapLogs, state.days);
    await Future.forEach(calendarCellsFind.evaluate(), (cellElement) async {
      final cellFind =
          find.byElementPredicate((element) => element == cellElement);
      await tester.longPress(cellFind);
    });
    expect(longPressLogs, state.days);
  });
}
