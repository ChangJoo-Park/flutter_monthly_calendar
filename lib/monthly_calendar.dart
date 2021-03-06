import 'package:flutter_monthly_calendar/calendar_view.dart';
import 'package:flutter_monthly_calendar/monthly_calendar_controller.dart';
import 'package:flutter_monthly_calendar/locale.dart';
import 'package:flutter_monthly_calendar/themes.dart';
import 'package:flutter_monthly_calendar/utils.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

export 'themes.dart';
export 'locale.dart';
export 'monthly_calendar_controller.dart';

class MonthlyCalendar extends StatefulWidget {
  MonthlyCalendar({
    Key? key,
    required this.startDateTime,
    required this.endDateTime,
    this.shortHeader = true,
    this.selectedDateTime,
    this.locale = const EnglishMonthlyCalendarLocale(),
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
          "MonthlyCalendar support only Monday, Sunday, Saturday",
        ),
        assert(startDateTime.isBefore(endDateTime)),
        super(key: key);

  // For PageView
  final int firstWeekday;
  final bool shortHeader;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final DateTime? selectedDateTime;
  final MonthlyCalendarLocale locale;
  final ValueChanged<DateTime>? onMonthChanged;
  final ValueChanged<DateTime>? onSelectedDateChanged;
  final Duration pageViewAnimationDuration;
  final Curve pageViewAnimationCurve;
  final double pageViewEstimateHeight;
  final ScrollPhysics scrollPhysics;
  final String? restorationId;
  final Clip clipBehavior;
  final MonthlyCalendarThemeData? theme;
  final Function(DateTime datetime)? onCellLongPress;
  final MonthlyCalendarController? controller;

  @override
  MonthlyCalendarState createState() => MonthlyCalendarState();
}

class MonthlyCalendarState extends State<MonthlyCalendar> {
  late final PageController pageController;

  List<DateTime> get months =>
      generateCalendar(widget.startDateTime, widget.endDateTime);

  @override
  void initState() {
    pageController = PageController(initialPage: _initialPage);

    if (widget.controller != null) {
      widget.controller!.addListener(_listenMonthlyCalendarController);
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
    return Container(
      decoration: widget.theme!.calendarBoxDecoration,
      child: ExpandablePageView(
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
            theme: widget.theme ?? DefaultMonthlyCalendarThemeData(),
            firstWeekday: widget.firstWeekday,
            monthDateTime: months[index],
            selectedDateTime: widget.selectedDateTime,
            onDateTimeSelected: (datetime) {
              if (widget.onSelectedDateChanged != null) {
                widget.onSelectedDateChanged!(datetime);
              }
            },
            onCellLongPress: (datetime) {
              if (widget.onCellLongPress != null) {
                widget.onCellLongPress!(datetime);
              }
            },
            weekdays: widget.shortHeader
                ? widget.locale.weekdaysShort
                : widget.locale.weekdaysLong,
          );
        },
      ),
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

  void _listenMonthlyCalendarController() {
    switch (widget.controller!.lastAction) {
      case MonthlyCalendarControllerAction.jumpTo:
        DateTime target = DateTime(widget.controller!.moveTargetDateTime.year,
            widget.controller!.moveTargetDateTime.month, 1);
        int index = months.indexOf(target);

        if (index < 0) return;

        pageController.jumpToPage(index);
        break;
      case MonthlyCalendarControllerAction.animateTo:
        DateTime target = DateTime(widget.controller!.moveTargetDateTime.year,
            widget.controller!.moveTargetDateTime.month, 1);
        int index = months.indexOf(target);

        if (index < 0) return;

        var theme = DefaultMonthlyCalendarThemeData();

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
