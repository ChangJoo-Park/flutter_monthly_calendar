import 'package:flutter_event_calendar/themes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CalendarCell extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: theme.tableCellAlignment,
      child: GestureDetector(
        onTap: () => {if (onTap != null) onTap!(datetime)},
        onLongPress: () =>
            {if (onLongPressed != null) onLongPressed!(datetime)},
        child: Container(
          decoration: theme.outerCellBoxDecoration,
          constraints: theme.outerCellBoxConstraints,
          child: Center(
            child: AnimatedContainer(
              alignment: theme.cellAlignment,
              width: theme.cellWidth,
              height: theme.cellHeight,
              decoration: cellDecoration,
              curve: theme.cellCurve,
              duration: theme.cellDuration,
              child: FittedBox(
                child: Text('${datetime.toLocal().day}', style: cellTextStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration get cellDecoration {
    if (isSelected) return theme.selectedCellBoxDecoration;
    if (isToday) return theme.todayCellBoxDecoration;
    return theme.defaultCellBoxDecoration;
  }

  TextStyle get cellTextStyle {
    if (isSameMonth) {
      return theme.defaultCellTextStyle;
    }
    return theme.otherMonthCellTextStyle;
  }
}
