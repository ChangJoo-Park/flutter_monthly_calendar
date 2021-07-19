import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

List<List<DateTime>> chunk(List<DateTime> list, int chunkSize) {
  List<List<DateTime>> chunks = [];
  int len = list.length;
  for (var i = 0; i < len; i += chunkSize) {
    int size = i + chunkSize;
    chunks.add(list.sublist(i, size > len ? len : size));
  }
  return chunks;
}

bool isSameYear(DateTime datetime1, DateTime datetime2) {
  return datetime1.year == datetime2.year;
}

bool isSameMonth(DateTime datetime1, DateTime datetime2) {
  return isSameYear(datetime1, datetime2) && datetime1.month == datetime2.month;
}

bool isSameDay(DateTime datetime1, datetime2) {
  return isSameMonth(datetime1, datetime2) && datetime1.day == datetime2.day;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Sliver Calendar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final DateTime startDate = DateTime(2021, 04, 30).toLocal();
  final DateTime endDate = DateTime(2021, 12, 31).toLocal();
  final DateTime selectedDate = DateTime.now().add(Duration(days: 2));

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime calendarStartDate;
  late DateTime calendarEndDate;
  late int pageCount;
  late int initialPageIndex;
  late DateTime selectedDate;
  late PageController pageController;
  late List<DateTime> months = [];

  @override
  void initState() {
    calendarStartDate =
        DateTime(widget.startDate.year, widget.startDate.month, 1);
    calendarEndDate =
        DateTime(widget.endDate.year, widget.endDate.month + 1, 0);

    if (widget.selectedDate != null) {
      selectedDate = widget.selectedDate;
    }

    pageCount = calendarEndDate.month - calendarStartDate.month + 1;
    initialPageIndex = widget.selectedDate.month - widget.startDate.month;

    for (var i = 0; i < pageCount; i++)
      months.add(
        DateTime(calendarStartDate.year, calendarStartDate.month + i, 1)
            .toLocal(),
      );

    pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ExpandablePageView(
              allowImplicitScrolling: true,
              estimatedPageSize: 300,
              animateFirstPage: true,
              pageSnapping: true,
              controller: pageController,
              itemCount: pageCount,
              itemBuilder: (context, index) {
                return CalendarView(
                  initialDateTime: months[index],
                  selectedDateTime: selectedDate,
                  onDateTimeSelected: (datetime) {
                    setState(() {
                      selectedDate = datetime;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarView extends StatefulWidget {
  CalendarView({
    Key? key,
    required this.initialDateTime,
    required this.selectedDateTime,
    this.onDateTimeSelected,
  }) : super(key: key);

  late final DateTime initialDateTime;
  late final DateTime selectedDateTime;
  final Function(DateTime datetime)? onDateTimeSelected;
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late final DateTime initialDateTime;

  List<String> dayOfWeeks = [
    '일',
    '월',
    '화',
    '수',
    '목',
    '금',
    '토',
  ];

  List<DateTime> days = [];
  List<List<DateTime>> allDays = [];
  String timezone = 'Asia/Seoul';

  // Styles
  TextStyle headTextStyle = const TextStyle(color: Colors.black, fontSize: 16);
  TextStyle otherMonthCellStyle = const TextStyle(
      color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle sameMonthCellStyle =
      const TextStyle(color: Colors.black, fontSize: 14);
  BoxDecoration todayCellBoxDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(32),
  );
  BoxDecoration selectedDayCellBoxDecoration = BoxDecoration(
      color: Colors.greenAccent, borderRadius: BorderRadius.circular(32));
  Size? oldSize;

  @override
  void initState() {
    generateCalendar(widget.initialDateTime.toLocal());
    super.initState();
  }

  void generateCalendar(datetime) {
    initialDateTime = datetime;
    // [initialDateTime] 으로 부터 이번달의 1일의 요일을 가져온다.
    DateTime firstOfMonth =
        DateTime(initialDateTime.year, initialDateTime.month, 1).toLocal();
    // 이번달의 마지막 날과 요일을 가져온다.
    DateTime lastOfMonth =
        DateTime(initialDateTime.year, initialDateTime.month + 1, 1).toLocal();

    // weekday 7은 일요일이므로 보정해야한다.
    // 달력은 일월화수목금토이기 때문
    DateTime loopStartDay = firstOfMonth.toLocal().subtract(
          Duration(
            days: firstOfMonth.weekday == 7 ? 0 : firstOfMonth.weekday,
          ), // 필요하면 유틸리티로 빼야함
        );
    DateTime loopEndDay =
        lastOfMonth.toLocal().add(Duration(days: 6 - lastOfMonth.weekday));

    int difference =
        loopEndDay.toLocal().difference(loopStartDay.toLocal()).inDays;

    for (var i = 0; i <= difference; i++)
      days.add(loopStartDay.add(Duration(days: i)).toLocal());

    allDays = chunk(days, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        border: TableBorder(),
        children: [
          TableRow(
              children: dayOfWeeks.map((e) => _generateHeader(e)).toList()),
          ...allDays.map((List<DateTime> row) => _generateRow(row)).toList()
        ],
      ),
    );
  }

  TableRow _generateRow(List<DateTime> row) {
    return TableRow(
      children: row.map((day) => _generateCell(day)).toList(),
    );
  }

  TableCell _generateCell(DateTime day) {
    BoxDecoration cellDecoration = BoxDecoration(color: Colors.white);
    TextStyle? textStyle;
    final DateTime now = DateTime.now();

    if (widget.selectedDateTime != null &&
        isSameDay(day, widget.selectedDateTime)) {
      cellDecoration = selectedDayCellBoxDecoration;
    } else if (isSameDay(day, now)) {
      cellDecoration = todayCellBoxDecoration;
    }

    if (isSameMonth(day, initialDateTime)) {
      textStyle = sameMonthCellStyle;
    } else {
      textStyle = otherMonthCellStyle;
    }

    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: GestureDetector(
        onTap: () {
          if (widget.onDateTimeSelected != null) {
            widget.onDateTimeSelected!(day);
          }
        },
        child: Container(
          color: Colors.white,
          constraints: BoxConstraints(minHeight: 48),
          child: Center(
            child: AnimatedContainer(
              alignment: Alignment.center,
              width: 36,
              height: 36,
              decoration: cellDecoration,
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 400),
              child: Text('${day.toLocal().day}', style: textStyle),
            ),
          ),
        ),
      ),
    );
  }

  TableCell _generateHeader(String e) {
    return TableCell(
      child: Container(
        color: Colors.white,
        constraints: BoxConstraints(minHeight: 64),
        child: Center(
          child: Text(e, style: headTextStyle),
        ),
      ),
    );
  }
}

class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const SizeReportingWidget({
    Key? key,
    required this.child,
    required this.onSizeChange,
  }) : super(key: key);

  @override
  _SizeReportingWidgetState createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  final _widgetKey = GlobalKey();
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _notifySize());
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        WidgetsBinding.instance!.addPostFrameCallback((_) => _notifySize());
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Container(
          key: _widgetKey,
          child: widget.child,
        ),
      ),
    );
  }

  void _notifySize() {
    final context = _widgetKey.currentContext;
    if (context == null) return;
    final size = context.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size!);
    }
  }
}
