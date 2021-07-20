import 'package:example/event_calendar/calendar_cell.dart';
import 'package:example/event_calendar/calendar_header.dart';
import 'package:example/event_calendar/consts.dart';
import 'package:example/event_calendar/themes.dart';
import 'package:example/event_calendar/utils.dart';
import 'package:flutter/material.dart';

class CalendarView extends StatefulWidget {
  CalendarView({
    Key? key,
    required this.initialDateTime,
    required this.selectedDateTime,
    required this.weekdays,
    required this.baseWeekday,
    this.onDateTimeSelected,
    required this.theme,
    this.onCellLongPress,
  }) : super(key: key);

  final Weekday baseWeekday;
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
    int diff = getDiffFromWeekday(widget.baseWeekday);
    weekdays = rotateList(list: [...widget.weekdays], amount: diff);
    days = generateMonth(widget.initialDateTime.toLocal(), diff);
    allDays = chunk(days, 7);
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
                            isSameMonth: isSameMonth(datetime.toLocal(),
                                widget.initialDateTime.toLocal()),
                            isSelected: widget.selectedDateTime == null
                                ? false
                                : isSameDay(datetime.toLocal(),
                                    widget.selectedDateTime!.toLocal()),
                            isToday:
                                isSameDay(datetime, DateTime.now().toLocal()),
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

  int getDiffFromWeekday(Weekday weekday) {
    var diff = 0;

    switch (weekday) {
      case Weekday.MONDAY:
        diff = 0;
        break;
      case Weekday.SUNDAY:
        diff = 1;
        break;
      case Weekday.SATURDAY:
        diff = 2;
        break;
      default:
    }
    return diff;
  }
}
