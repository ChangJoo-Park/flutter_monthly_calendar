import 'package:flutter_event_calendar/calendar_cell.dart';
import 'package:flutter_event_calendar/calendar_header.dart';
import 'package:flutter_event_calendar/themes.dart';
import 'package:flutter_event_calendar/utils.dart';
import 'package:flutter/material.dart';

class CalendarView extends StatefulWidget {
  CalendarView({
    Key? key,
    required this.initialDateTime,
    required this.selectedDateTime,
    required this.weekdays,
    required this.firstWeekday,
    this.onDateTimeSelected,
    required this.theme,
    this.onCellLongPress,
  }) : super(key: key);

  final int firstWeekday;
  final DateTime initialDateTime;
  final DateTime? selectedDateTime;
  final ValueChanged<DateTime>? onDateTimeSelected;
  final List<String> weekdays;
  final EventCalendarThemeData theme;
  final Function(DateTime datetime)? onCellLongPress;

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late List<String> weekdays = [];
  late final DateTime initialDateTime;
  List<DateTime> days = [];
  List<List<DateTime>> allDays = [];

  @override
  void initState() {
    int diff = getDiffFromWeekday(widget.firstWeekday);
    weekdays = [...widget.weekdays].rotateRight(diff);
    days = generateMonth(widget.initialDateTime.toLocal(), diff);
    allDays = days.chunk(7);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        border: widget.theme.calendarTableBorder,
        defaultColumnWidth: widget.theme.defaultColumnWidth,
        textBaseline: widget.theme.textBaseline,
        textDirection: widget.theme.textDirection,
        children: [
          TableRow(
              children: weekdays
                  .map((weekday) =>
                      CalendarHeader(weekday: weekday, theme: widget.theme))
                  .toList()),
          ...allDays
              .map((List<DateTime> row) => TableRow(
                    children: row
                        .map(
                          (datetime) => CalendarCell(
                            theme: widget.theme,
                            onLongPressed: (datetime) {
                              if (widget.onCellLongPress != null) {
                                widget.onCellLongPress!(datetime);
                              }
                            },
                            datetime: datetime,
                            isSameMonth: datetime.toLocal().isSameYearMonth(
                                widget.initialDateTime.toLocal()),
                            isSelected: widget.selectedDateTime == null
                                ? false
                                : datetime.toLocal().isSameYearMonthDay(
                                    widget.selectedDateTime!.toLocal()),
                            isToday: datetime
                                .isSameYearMonthDay(DateTime.now().toLocal()),
                            key: ValueKey(
                                'CALENDAR_CELL_${datetime.toIso8601String()}'),
                            onTap: (selected) {
                              if (widget.onDateTimeSelected != null) {
                                widget.onDateTimeSelected!(selected);
                              }
                            },
                          ),
                        )
                        .toList(),
                  ))
              .toList()
        ],
      ),
    );
  }

  int getDiffFromWeekday(int weekday) {
    var diff = 0;

    switch (weekday) {
      case DateTime.monday:
        diff = 0;
        break;
      case DateTime.sunday:
        diff = 1;
        break;
      case DateTime.saturday:
        diff = 2;
        break;
      default:
    }
    return diff;
  }
}
