import 'package:flutter_event_calendar/themes.dart';
import 'package:flutter/material.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({Key? key, required this.weekday, required this.theme})
      : super(key: key);

  final String weekday;
  final EventCalendarThemeData theme;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        decoration: theme.headerBoxDecoration,
        constraints: theme.headerBoxConstraints,
        alignment: theme.headerAlignment,
        foregroundDecoration: theme.headerForegroundDecoration,
        padding: theme.headerPadding,
        child: Center(
          child: FittedBox(
            child: Text(weekday, style: theme.headerTextStyle),
          ),
        ),
      ),
    );
  }
}
