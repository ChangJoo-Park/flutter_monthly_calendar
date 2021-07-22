import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monthly_calendar/calendar_cell.dart';
import 'package:flutter_monthly_calendar/monthly_calendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Calendar Cell render days', (WidgetTester tester) async {
    var datetime = DateTime(2017, 9, 7);
    var tapLogs = <DateTime>[];
    var longPressLogs = <DateTime>[];
    var calendarCell = CalendarCell(
      datetime: datetime,
      theme: DefaultMonthlyCalendarThemeData(),
      onTap: (selected) {
        tapLogs.add(selected);
      },
      onLongPressed: (selected) {
        longPressLogs.add(selected);
      },
    );

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Table(
          children: [
            TableRow(children: [calendarCell])
          ],
        ),
      ),
    );

    final cellTextFinder = find.text(datetime.day.toString());
    expect(cellTextFinder, findsOneWidget);

    await tester.tap(cellTextFinder);
    expect(tapLogs.length, 1);
    expect(tapLogs.first, datetime);
    await tester.longPress(cellTextFinder);
    expect(longPressLogs.length, 1);
    expect(longPressLogs.first, datetime);

    expect(calendarCell.isSameMonth, false);
    expect(calendarCell.isToday, false);
    expect(calendarCell.isSelected, false);
  });

  testWidgets('Calendar Cell with isSelected', (WidgetTester tester) async {
    var datetime = DateTime(2017, 9, 7);
    var key = GlobalKey<State<CalendarCell>>();
    var calendarCell = CalendarCell(
      key: key,
      datetime: datetime,
      theme: DefaultMonthlyCalendarThemeData(),
      isSelected: true,
    );

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Table(
          children: [
            TableRow(children: [calendarCell])
          ],
        ),
      ),
    );

    expect(calendarCell.isSameMonth, false);
    expect(calendarCell.isToday, false);
    expect(calendarCell.isSelected, true);
    final calendarCellFinder = find.byKey(key);
    expect(calendarCellFinder, findsOneWidget);
    final state = tester.state<CalendarCellState>(calendarCellFinder);
    expect(state.cellDecoration,
        DefaultMonthlyCalendarThemeData().selectedCellBoxDecoration);
    expect(state.cellTextStyle,
        DefaultMonthlyCalendarThemeData().selectedCellTextStyle);
  });

  testWidgets(
      'Calendar Cell with isSelected / isSameMonth. isSelcted has high priority',
      (WidgetTester tester) async {
    var datetime = DateTime(2017, 9, 7);
    var key = GlobalKey<State<CalendarCell>>();
    var calendarCell = CalendarCell(
      key: key,
      datetime: datetime,
      theme: DefaultMonthlyCalendarThemeData(),
      isSameMonth: true,
      isSelected: true,
    );

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Table(
          children: [
            TableRow(children: [calendarCell])
          ],
        ),
      ),
    );

    expect(calendarCell.isSameMonth, true);
    expect(calendarCell.isToday, false);
    expect(calendarCell.isSelected, true);
    final calendarCellFinder = find.byKey(key);
    expect(calendarCellFinder, findsOneWidget);
    final state = tester.state<CalendarCellState>(calendarCellFinder);
    expect(state.cellDecoration,
        DefaultMonthlyCalendarThemeData().selectedCellBoxDecoration);
    expect(state.cellTextStyle,
        DefaultMonthlyCalendarThemeData().selectedCellTextStyle);
  });

  testWidgets('Calendar Cell with isSameMonth.', (WidgetTester tester) async {
    var datetime = DateTime(2017, 9, 7);
    var key = GlobalKey<State<CalendarCell>>();
    var calendarCell = CalendarCell(
      key: key,
      datetime: datetime,
      theme: DefaultMonthlyCalendarThemeData(),
      isSameMonth: true,
      isToday: true,
    );

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Table(
          children: [
            TableRow(children: [calendarCell])
          ],
        ),
      ),
    );

    expect(calendarCell.isSameMonth, true);
    expect(calendarCell.isToday, true);
    expect(calendarCell.isSelected, false);
    final calendarCellFinder = find.byKey(key);
    expect(calendarCellFinder, findsOneWidget);
    final state = tester.state<CalendarCellState>(calendarCellFinder);
    expect(state.cellDecoration,
        DefaultMonthlyCalendarThemeData().todayCellBoxDecoration);
    expect(state.cellTextStyle,
        DefaultMonthlyCalendarThemeData().todayCellTextStyle);
  });
}
