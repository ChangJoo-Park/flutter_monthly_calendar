import 'package:flutter_monthly_calendar/calendar_cell.dart';
import 'package:flutter_monthly_calendar/calendar_header.dart';
import 'package:flutter_monthly_calendar/themes.dart';
import 'package:flutter_monthly_calendar/utils.dart';
import 'package:flutter/material.dart';

class CalendarView extends StatefulWidget {
  CalendarView({
    Key? key,
    required this.monthDateTime,
    required this.selectedDateTime,
    required this.weekdays,
    required this.firstWeekday,
    this.onDateTimeSelected,
    required this.theme,
    this.onCellLongPress,
  }) : super(key: key);

  final int firstWeekday;
  final DateTime monthDateTime;
  final DateTime? selectedDateTime;
  final ValueChanged<DateTime>? onDateTimeSelected;
  final List<String> weekdays;
  final MonthlyCalendarThemeData theme;
  final Function(DateTime value)? onCellLongPress;

  @override
  CalendarViewState createState() => CalendarViewState();
}

class CalendarViewState extends State<CalendarView> {
  List<String> get weekdays => List<String>.from(widget.weekdays)
      .rotateRight<String>(differenceFromDaysPerWeek(widget.firstWeekday));

  List<DateTime> get days =>
      generateMonth(widget.monthDateTime.toLocal(), widget.firstWeekday);

  List<List<DateTime>> get allDays => days.chunkBy(7);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: widget.theme.calendarTableBorder,
      defaultColumnWidth: widget.theme.defaultColumnWidth,
      textBaseline: widget.theme.textBaseline,
      textDirection: widget.theme.textDirection,
      children: [
        TableRow(children: generateHeader()),
        ...allDays.map(generateDayRow).toList()
      ],
    );
  }

  List<CalendarHeader> generateHeader() {
    return weekdays
        .map((weekday) => CalendarHeader(weekday: weekday, theme: widget.theme))
        .toList();
  }

  TableRow generateDayRow(List<DateTime> row) =>
      TableRow(children: row.map(generateCalendarCell).toList());

  CalendarCell generateCalendarCell(DateTime datetime) {
    bool isSameYearMonth =
        datetime.toLocal().isSameYearMonth(widget.monthDateTime.toLocal());

    bool isSelected = widget.selectedDateTime == null
        ? false
        : datetime
            .toLocal()
            .isSameYearMonthDay(widget.selectedDateTime!.toLocal());

    bool isToday = datetime.isSameYearMonthDay(DateTime.now().toLocal());

    return CalendarCell(
      key: ValueKey('CALENDAR_CELL_${datetime.toIso8601String()}'),
      theme: widget.theme,
      datetime: datetime,
      isSameMonth: isSameYearMonth,
      isSelected: isSelected,
      isToday: isToday,
      onTap: (selected) {
        if (widget.onDateTimeSelected != null) {
          widget.onDateTimeSelected!(selected);
        }
      },
      onLongPressed: (datetime) {
        if (widget.onCellLongPress != null) {
          widget.onCellLongPress!(datetime);
        }
      },
    );
  }
}
