import 'package:flutter_event_calendar/themes.dart';
import 'package:flutter/material.dart';

class CalendarCell extends StatefulWidget {
  CalendarCell({
    Key? key,
    required this.datetime,
    required this.theme,
    this.isSelected = false,
    this.isToday = false,
    this.isSameMonth = false,
    this.onTap,
    this.onLongPressed,
  }) : super(key: key);

  final DateTime datetime;
  final bool isSelected;
  final bool isToday;
  final bool isSameMonth;
  final Function(DateTime selected)? onTap;
  final Function(DateTime selected)? onLongPressed;
  final EventCalendarThemeData theme;

  @override
  CalendarCellState createState() => CalendarCellState();
}

class CalendarCellState extends State<CalendarCell> {
  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: widget.theme.tableCellAlignment,
      child: GestureDetector(
        onTap: () => {if (widget.onTap != null) widget.onTap!(widget.datetime)},
        onLongPress: () => {
          if (widget.onLongPressed != null)
            widget.onLongPressed!(widget.datetime)
        },
        child: Container(
          decoration: widget.theme.outerCellBoxDecoration,
          constraints: widget.theme.outerCellBoxConstraints,
          child: Center(
            child: AnimatedContainer(
              alignment: widget.theme.cellAlignment,
              width: widget.theme.cellWidth,
              height: widget.theme.cellHeight,
              decoration: cellDecoration,
              curve: widget.theme.cellCurve,
              duration: widget.theme.cellDuration,
              child: FittedBox(
                child: Text('${widget.datetime.toLocal().day}',
                    style: cellTextStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration get cellDecoration {
    if (widget.isSelected) return widget.theme.selectedCellBoxDecoration;
    if (widget.isToday) return widget.theme.todayCellBoxDecoration;
    return widget.theme.defaultCellBoxDecoration;
  }

  TextStyle get cellTextStyle {
    if (widget.isSelected) return widget.theme.selectedCellTextStyle;
    if (widget.isToday && widget.isSameMonth) {
      return widget.theme.todayCellTextStyle;
    }
    if (widget.isSameMonth) return widget.theme.defaultCellTextStyle;
    return widget.theme.otherMonthCellTextStyle;
  }
}
