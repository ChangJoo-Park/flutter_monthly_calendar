import 'package:flutter_event_calendar/calendar_view.dart';
import 'package:flutter_event_calendar/event_calendar_controller.dart';
import 'package:flutter_event_calendar/locale.dart';
import 'package:flutter_event_calendar/themes.dart';
import 'package:flutter_event_calendar/utils.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

export 'themes.dart';
export 'locale.dart';
export 'event_calendar_controller.dart';

class EventCalendar extends StatefulWidget {
  EventCalendar({
    Key? key,
    required this.startDateTime,
    required this.endDateTime,
    this.shortHeader = true,
    this.selectedDateTime,
    this.locale = const EnglishEventCalendarLocale(),
    this.onMonthChanged,
    this.onSelectedDateChanged,
    this.firstWeekday = DateTime.monday,
    this.pageViewAnimationDuration = const Duration(milliseconds: 200),
    this.pageViewAnimationCurve = Curves.fastOutSlowIn,
    this.pageViewEstimateHeight = 350,
    this.scrollPhysics = const PageScrollPhysics(),
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.theme,
    this.onCellLongPress,
    this.controller,
  })  : assert(
          firstWeekday == DateTime.monday ||
              firstWeekday == DateTime.sunday ||
              firstWeekday == DateTime.saturday,
          "EventCalendar support only Monday, Sunday, Saturday",
        ),
        assert(startDateTime.isBefore(endDateTime)),
        super(key: key);

  // For PageView
  final int firstWeekday;
  final bool shortHeader;
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
  final EventCalendarController? controller;

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  late final PageController pageController;
  late final List<DateTime> months;
  late final EventCalendarThemeData theme;
  @override
  void initState() {
    theme = widget.theme ?? DefaultEventCalendarThemeData();
    months = generateCalendar(widget.startDateTime, widget.endDateTime);
    pageController = PageController(initialPage: _initialPage);

    if (widget.controller != null) {
      widget.controller!.addListener(_listenEventCalendarController);
    }
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    if (widget.controller != null) {
      widget.controller!.dispose();
    }
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
          theme: theme,
          firstWeekday: widget.firstWeekday,
          initialDateTime: months[index],
          selectedDateTime: widget.selectedDateTime,
          onDateTimeSelected: (datetime) {
            if (widget.onSelectedDateChanged != null)
              widget.onSelectedDateChanged!(datetime);
          },
          onCellLongPress: (datetime) {
            if (widget.onCellLongPress != null)
              widget.onCellLongPress!(datetime);
          },
          weekdays: widget.shortHeader
              ? widget.locale.weekdaysShort
              : widget.locale.weekdaysLong,
        );
      },
    );
  }

  int get _initialPage {
    if (widget.selectedDateTime == null) {
      final now = DateTime.now();
      final isBetweenRange =
          widget.startDateTime.isBefore(now) && widget.endDateTime.isAfter(now);

      return isBetweenRange ? now.month - widget.startDateTime.month : 0;
    }
    return widget.startDateTime.differenceInMonth(widget.selectedDateTime!);
  }

  void _onPageChanged(int index) {
    if (widget.onMonthChanged != null) {
      widget.onMonthChanged!(months[index]);
    }
  }

  void _listenEventCalendarController() {
    if (pageController == null) return;

    switch (widget.controller!.lastAction) {
      case EventCalendarControllerAction.MOVETO:
        DateTime target = DateTime(widget.controller!.moveTargetDateTime.year,
            widget.controller!.moveTargetDateTime.month, 1);

        int index = months.indexOf(target);

        if (index < 0) return;

        pageController.animateToPage(
          index,
          duration: theme.defaultDuration,
          curve: theme.defaultCurve,
        );
        break;
      default:
    }
  }
}
