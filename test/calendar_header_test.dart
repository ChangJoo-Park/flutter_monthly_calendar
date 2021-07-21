import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/calendar_header.dart';
import 'package:flutter_event_calendar/event_calendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Calendar Header render weekday', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Table(
          children: [
            TableRow(children: [
              CalendarHeader(
                weekday: '월',
                theme: DefaultEventCalendarThemeData(),
              )
            ])
          ],
        ),
      ),
    );

    final weekdayFinder = find.text('월');
    expect(weekdayFinder, findsOneWidget);
  });
}
