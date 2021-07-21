import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/event_calendar.dart';

void main() {
  runApp(MyApp());
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

  final DateTime startDateTime = DateTime(2020, 01, 01).toLocal();
  final DateTime endDateTime = DateTime(2021, 12, 31).toLocal();
  final DateTime selectedDateTime = DateTime.now().add(Duration(days: 2));

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime selectedDateTime;
  late String title = '선택해주세요.';
  late EventCalendarController controller;
  @override
  void initState() {
    if (widget.selectedDateTime != null) {
      selectedDateTime = widget.selectedDateTime;
      title = '${selectedDateTime.year}년 ${selectedDateTime.month}월';
    }
    controller = EventCalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: EventCalendar(
              controller: controller,
              baseWeekday: EventCalendarWeekday.MONDAY,
              locale: KoreanEventCalendarLocale(),
              startDateTime: widget.startDateTime,
              endDateTime: widget.endDateTime,
              selectedDateTime: selectedDateTime,
              onMonthChanged: (DateTime dt) {
                setState(() => title = '${dt.year}년 ${dt.month}월');
              },
              onSelectedDateChanged: (value) {
                setState(() => selectedDateTime = value);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(child: Text('선택한 날짜')),
                  Container(
                      child: Text(
                    '${selectedDateTime.year}년 ${selectedDateTime.month}월 ${selectedDateTime.day}일',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {
                  controller.moveTo(DateTime(2021, 07));
                },
                child: Text("Move to 2021, 07"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
