import 'package:flutter_event_calendar/calendar_view.dart';
import 'package:flutter_event_calendar/consts.dart';
import 'package:flutter_event_calendar/locale.dart';
import 'package:flutter_event_calendar/themes.dart';
import 'package:flutter_event_calendar/utils.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

export 'consts.dart';
export 'themes.dart';
export 'locale.dart';

class EventCalendar extends StatefulWidget {
  EventCalendar({
    Key? key,
    required this.startDateTime,
    required this.endDateTime,
    this.selectedDateTime,
    this.locale = const EnglishEventCalendarLocale(),
    this.onMonthChanged,
    this.onSelectedDateChanged,
    this.baseWeekday = EventCalendarWeekday.MONDAY,
    this.pageViewAnimationDuration = const Duration(milliseconds: 200),
    this.pageViewAnimationCurve = Curves.fastOutSlowIn,
    this.pageViewEstimateHeight = 350,
    this.scrollPhysics = const PageScrollPhysics(),
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.theme,
    this.onCellLongPress,
  })  : assert(
          baseWeekday == EventCalendarWeekday.MONDAY ||
              baseWeekday == EventCalendarWeekday.SUNDAY ||
              baseWeekday == EventCalendarWeekday.SATURDAY,
          "EventCalendar support only Monday, Sunday, Saturday",
        ),
        assert(startDateTime.isBefore(endDateTime)),
        super(key: key);

  // For PageView
  final EventCalendarWeekday baseWeekday;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final DateTime? selectedDateTime;
  final EventCalendarLocale locale;
  final ValueChanged<DateTime>? onMonthChanged;
  final ValueChanged<DateTime>? onSelectedDateChanged;
  final Duration pageViewAnimationDuration;
  final Curve pageViewAnimationCurve;
  final double pageViewEstimateHeight;
  final ScrollPhysics scrollPhysics;
  final String? restorationId;
  final Clip clipBehavior;
  final EventCalendarThemeData? theme;
  final Function(DateTime datetime)? onCellLongPress;
  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  late final PageController pageController;
  late final List<DateTime> months;

  @override
  void initState() {
    months = generateCalendar(widget.startDateTime, widget.endDateTime);
    final initialPage = _getInitialPage(
        widget.selectedDateTime, widget.startDateTime, widget.endDateTime);

    pageController = PageController(initialPage: initialPage);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePageView(
      allowImplicitScrolling: true,
      animateFirstPage: false,
      estimatedPageSize: widget.pageViewEstimateHeight,
      animationCurve: widget.pageViewAnimationCurve,
      animationDuration: widget.pageViewAnimationDuration,
      physics: widget.scrollPhysics,
      pageSnapping: true,
      controller: pageController,
      itemCount: months.length,
      clipBehavior: widget.clipBehavior,
      restorationId: widget.restorationId,
      onPageChanged: _onPageChanged,
      key: widget.key,
      itemBuilder: (context, index) {
        return CalendarView(
          theme: widget.theme ?? DefaultEventCalendarThemeData(),
          baseWeekday: widget.baseWeekday,
          initialDateTime: months[index],
          selectedDateTime: widget.selectedDateTime,
          onDateTimeSelected: (datetime) {
            if (widget.onSelectedDateChanged != null) {
              widget.onSelectedDateChanged!(datetime);
            }
          },
          onCellLongPress: (datetime) {
            print('datetime => $datetime');
          },
          weekdays: widget.locale.weekdaysShort,
        );
      },
    );
  }

  void _onPageChanged(int index) {
    if (widget.onMonthChanged != null) {
      widget.onMonthChanged!(months[index]);
    }
  }

  int _getInitialPage(DateTime? selectedDateTime, DateTime startDateTime,
      DateTime endDateTime) {
    if (selectedDateTime == null) {
      final now = DateTime.now();
      final isBetweenRange =
          startDateTime.isBefore(now) && endDateTime.isAfter(now);

      return isBetweenRange ? now.month - startDateTime.month : 0;
    }
    return startDateTime.differenceInMonth(selectedDateTime);
  }
}
