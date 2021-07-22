import 'package:flutter/material.dart';

/// base of MonthlyCalendarData
///
/// If you need new ThemeData for you project,
/// You can `implements` this class.
///
/// ```dart
/// class YourAwesomeMonthlyCalendarThemeData implements  MonthlyCalendarThemeData {}
/// ```
abstract class MonthlyCalendarThemeData {
  Duration defaultDuration = Duration(milliseconds: 200);
  Curve defaultCurve = Curves.fastOutSlowIn;
  // Container
  late BoxDecoration calendarBoxDecoration;
  late TableBorder calendarTableBorder;
  late FlexColumnWidth defaultColumnWidth;
  late TextDirection textDirection;
  late TextBaseline textBaseline;

  // Calendar Header
  late TextStyle headerTextStyle;
  late BoxDecoration headerBoxDecoration;
  late BoxDecoration headerForegroundDecoration;
  late BoxConstraints headerBoxConstraints;
  late Alignment headerAlignment;
  late EdgeInsetsGeometry headerPadding;
  late EdgeInsetsGeometry headerMargin;

  // Calendar Cell
  late TextStyle otherMonthCellTextStyle;
  late TextStyle defaultCellTextStyle;
  late TextStyle todayCellTextStyle;
  late TextStyle selectedCellTextStyle;
  late BoxDecoration outerCellBoxDecoration;
  late BoxConstraints outerCellBoxConstraints;
  late BoxDecoration defaultCellBoxDecoration;
  late BoxDecoration todayCellBoxDecoration;
  late BoxDecoration selectedCellBoxDecoration;
  late TableCellVerticalAlignment tableCellAlignment;
  late double cellWidth;
  late double cellHeight;
  late Duration cellDuration;
  late Curve cellCurve;
  late Alignment cellAlignment;
}

class DefaultMonthlyCalendarThemeData implements MonthlyCalendarThemeData {
  @override
  BoxDecoration calendarBoxDecoration = BoxDecoration();

  @override
  Curve defaultCurve = Curves.fastOutSlowIn;

  @override
  Duration defaultDuration = Duration(milliseconds: 200);

  @override
  late TableBorder calendarTableBorder = TableBorder.all(
    style: BorderStyle.none,
    width: 0,
    color: Colors.transparent,
  );

  @override
  FlexColumnWidth defaultColumnWidth = FlexColumnWidth();

  @override
  TextBaseline textBaseline = TextBaseline.ideographic;

  @override
  TextDirection textDirection = TextDirection.ltr;

  @override
  TextStyle headerTextStyle =
      const TextStyle(color: Colors.black, fontSize: 16);

  @override
  BoxDecoration headerBoxDecoration = BoxDecoration(
    color: Colors.white,
  );

  @override
  BoxConstraints headerBoxConstraints = BoxConstraints(
    minHeight: 64,
  );

  @override
  Alignment headerAlignment = Alignment.center;

  @override
  BoxDecoration headerForegroundDecoration = BoxDecoration();

  @override
  EdgeInsetsGeometry headerPadding = EdgeInsets.zero;

  @override
  EdgeInsetsGeometry headerMargin = EdgeInsets.zero;

  @override
  BoxDecoration defaultCellBoxDecoration = BoxDecoration();

  @override
  TextStyle defaultCellTextStyle =
      const TextStyle(color: Colors.black, fontSize: 14);

  @override
  TextStyle otherMonthCellTextStyle =
      const TextStyle(color: Colors.grey, fontSize: 14);

  @override
  BoxDecoration selectedCellBoxDecoration = BoxDecoration(
    color: Colors.greenAccent,
    borderRadius: BorderRadius.circular(32),
  );

  @override
  TextStyle selectedCellTextStyle =
      const TextStyle(color: Colors.black, fontSize: 14);

  @override
  BoxDecoration todayCellBoxDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(32),
  );

  @override
  TextStyle todayCellTextStyle = TextStyle();

  @override
  BoxDecoration outerCellBoxDecoration = BoxDecoration(
    color: Colors.white,
  );

  @override
  BoxConstraints outerCellBoxConstraints = BoxConstraints(minHeight: 48);

  @override
  Curve cellCurve = Curves.fastOutSlowIn;

  @override
  Duration cellDuration = Duration(milliseconds: 200);

  @override
  double cellHeight = 32.0;

  @override
  double cellWidth = 32.0;

  @override
  Alignment cellAlignment = Alignment.center;

  @override
  TableCellVerticalAlignment tableCellAlignment =
      TableCellVerticalAlignment.middle;
}

class CyberFunkMonthlyCalendarThemeData implements MonthlyCalendarThemeData {
  @override
  BoxDecoration calendarBoxDecoration = BoxDecoration();

  @override
  Curve defaultCurve = Curves.fastOutSlowIn;

  @override
  Duration defaultDuration = Duration(milliseconds: 200);

  @override
  late TableBorder calendarTableBorder = TableBorder.all(
    style: BorderStyle.none,
    width: 0,
    color: Colors.transparent,
  );

  @override
  FlexColumnWidth defaultColumnWidth = FlexColumnWidth();

  @override
  TextBaseline textBaseline = TextBaseline.ideographic;

  @override
  TextDirection textDirection = TextDirection.ltr;

  @override
  TextStyle headerTextStyle =
      const TextStyle(color: Colors.black, fontSize: 16);

  @override
  BoxDecoration headerBoxDecoration = BoxDecoration(
    color: Color(0xFFF3E600),
  );

  @override
  BoxConstraints headerBoxConstraints = BoxConstraints(
    minHeight: 64,
  );

  @override
  Alignment headerAlignment = Alignment.center;

  @override
  BoxDecoration headerForegroundDecoration = BoxDecoration();

  @override
  EdgeInsetsGeometry headerPadding = EdgeInsets.zero;

  @override
  EdgeInsetsGeometry headerMargin = EdgeInsets.zero;

  @override
  BoxDecoration defaultCellBoxDecoration = BoxDecoration();

  @override
  TextStyle defaultCellTextStyle =
      const TextStyle(color: Color(0xFF000000), fontSize: 14);

  @override
  TextStyle otherMonthCellTextStyle = const TextStyle(
      color: Color(0xFF554B41), fontSize: 14, fontWeight: FontWeight.normal);

  @override
  BoxDecoration selectedCellBoxDecoration = BoxDecoration(
    color: Color(0xFF04DAF6),
    borderRadius: BorderRadius.circular(32),
  );

  @override
  TextStyle selectedCellTextStyle =
      const TextStyle(color: Colors.black, fontSize: 14);

  @override
  BoxDecoration todayCellBoxDecoration = BoxDecoration(
    border: Border.all(color: Color(0xFFFF003C)),
    borderRadius: BorderRadius.circular(32),
  );

  @override
  TextStyle todayCellTextStyle = TextStyle(color: Color(0xFF000000));

  @override
  BoxDecoration outerCellBoxDecoration = BoxDecoration(
    color: Color(0xFFF3E600),
  );

  @override
  BoxConstraints outerCellBoxConstraints = BoxConstraints(minHeight: 48);

  @override
  Curve cellCurve = Curves.fastOutSlowIn;

  @override
  Duration cellDuration = Duration(milliseconds: 200);

  @override
  double cellHeight = 32.0;

  @override
  double cellWidth = 32.0;

  @override
  Alignment cellAlignment = Alignment.center;

  @override
  TableCellVerticalAlignment tableCellAlignment =
      TableCellVerticalAlignment.middle;
}

class NeumorphicMonthlyCalendarThemeData implements MonthlyCalendarThemeData {
  @override
  BoxDecoration calendarBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(6.0),
    color: Colors.grey.shade50,
    shape: BoxShape.rectangle,
    boxShadow: [
      BoxShadow(
          color: Colors.grey.shade300,
          spreadRadius: 0.0,
          blurRadius: 2.0,
          offset: Offset(3.0, 3.0)),
      BoxShadow(
          color: Colors.grey.shade400,
          spreadRadius: 0.0,
          blurRadius: 2.0 / 2.0,
          offset: Offset(3.0, 3.0)),
      BoxShadow(
          color: Colors.white,
          spreadRadius: 2.0,
          blurRadius: 2.0,
          offset: Offset(-3.0, -3.0)),
      BoxShadow(
          color: Colors.white,
          spreadRadius: 2.0,
          blurRadius: 2.0 / 2,
          offset: Offset(-3.0, -3.0)),
    ],
  );
  @override
  Curve defaultCurve = Curves.fastOutSlowIn;

  @override
  Duration defaultDuration = Duration(milliseconds: 200);

  @override
  late TableBorder calendarTableBorder = TableBorder.all(
    style: BorderStyle.none,
    width: 0,
    color: Colors.transparent,
  );

  @override
  FlexColumnWidth defaultColumnWidth = FlexColumnWidth();

  @override
  TextBaseline textBaseline = TextBaseline.ideographic;

  @override
  TextDirection textDirection = TextDirection.ltr;

  @override
  TextStyle headerTextStyle = const TextStyle(
      color: Color(0xFF333333), fontSize: 16, fontWeight: FontWeight.bold);

  @override
  BoxDecoration headerBoxDecoration = BoxDecoration(
    color: Colors.grey.shade50,
  );

  @override
  BoxConstraints headerBoxConstraints = BoxConstraints(
    minHeight: 64,
  );

  @override
  Alignment headerAlignment = Alignment.center;

  @override
  BoxDecoration headerForegroundDecoration = BoxDecoration();

  @override
  EdgeInsetsGeometry headerPadding = EdgeInsets.zero;

  @override
  EdgeInsetsGeometry headerMargin = EdgeInsets.zero;

  @override
  BoxDecoration defaultCellBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(32.0),
  );

  @override
  TextStyle defaultCellTextStyle = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);

  @override
  TextStyle otherMonthCellTextStyle =
      const TextStyle(color: Color(0xFFCBCBCB), fontSize: 14);

  @override
  BoxDecoration selectedCellBoxDecoration = BoxDecoration(
    color: Colors.grey.shade50,
    borderRadius: BorderRadius.circular(32.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300,
        spreadRadius: 0.0,
        blurRadius: 2.0,
        offset: Offset(3.0, 3.0),
      ),
      BoxShadow(
        color: Colors.grey.shade400,
        spreadRadius: 0.0,
        blurRadius: 2.0 / 2.0,
        offset: Offset(3.0, 3.0),
      ),
      BoxShadow(
        color: Colors.white,
        spreadRadius: 2.0,
        blurRadius: 2.0,
        offset: Offset(-3.0, -3.0),
      ),
      BoxShadow(
        color: Colors.white,
        spreadRadius: 2.0,
        blurRadius: 2.0 / 2,
        offset: Offset(-3.0, -3.0),
      ),
    ],
  );

  @override
  TextStyle selectedCellTextStyle = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);

  @override
  BoxDecoration todayCellBoxDecoration = BoxDecoration(
    color: HSLColor.fromAHSL(1, 220, 0.2, 0.93).toColor(),
    borderRadius: BorderRadius.circular(32.0),
    boxShadow: [
      BoxShadow(
        blurRadius: 2,
        color: HSLColor.fromAHSL(0.2, 220, 1, 0.2).toColor(),
        offset: Offset(2, 2),
      ),
      BoxShadow(
        blurRadius: 2,
        color: Colors.white,
        offset: Offset(-2, -2),
      ),
    ],
  );

  @override
  TextStyle todayCellTextStyle = const TextStyle(
      color: Color(0xFF333333), fontSize: 14, fontWeight: FontWeight.bold);

  @override
  BoxDecoration outerCellBoxDecoration = BoxDecoration(
    color: Colors.grey.shade50,
  );

  @override
  BoxConstraints outerCellBoxConstraints = BoxConstraints(minHeight: 48);

  @override
  Curve cellCurve = Curves.fastOutSlowIn;

  @override
  Duration cellDuration = Duration(milliseconds: 200);

  @override
  double cellHeight = 32.0;

  @override
  double cellWidth = 32.0;

  @override
  Alignment cellAlignment = Alignment.center;

  @override
  TableCellVerticalAlignment tableCellAlignment =
      TableCellVerticalAlignment.middle;
}
