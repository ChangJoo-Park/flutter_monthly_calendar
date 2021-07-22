import 'package:flutter/material.dart';
import 'package:flutter_monthly_calendar/monthly_calendar.dart';
import 'package:flutter_monthly_calendar/themes.dart';

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
      home: MyHomePage(title: 'Monthly Calendar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final DateTime startDateTime = DateTime(1970, 01, 01).toLocal();
  final DateTime endDateTime = DateTime(2035, 12, 31).toLocal();
  final DateTime selectedDateTime = DateTime.now().add(Duration(days: 2));

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime selectedDateTime;
  late String title = '선택해주세요.';
  late MonthlyCalendarController controller;
  late MonthlyCalendarThemeData theme = DefaultMonthlyCalendarThemeData();
  MonthlyCalendarLocale locale = EnglishMonthlyCalendarLocale();
  int firstWeekday = DateTime.monday;
  bool shortHeader = true;
  @override
  void initState() {
    selectedDateTime = widget.selectedDateTime;
    title = '${selectedDateTime.year}년 ${selectedDateTime.month}월';
    controller = MonthlyCalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
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
            child: MonthlyCalendar(
              controller: controller,
              firstWeekday: firstWeekday,
              shortHeader: shortHeader,
              theme: theme,
              locale: locale,
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
          SliverList(
              delegate: SliverChildListDelegate.fixed([
            ListTile(
              title: Text('Change Theme to Default'),
              onTap: () {
                setState(() {
                  theme = DefaultMonthlyCalendarThemeData();
                });
              },
            ),
            ListTile(
              title: Text('Change Theme to Neumorphism'),
              onTap: () {
                setState(() {
                  theme = NeumorphicMonthlyCalendarThemeData();
                });
              },
            ),
            ListTile(
              title: Text('Change Theme to CyberFunk'),
              onTap: () {
                setState(() {
                  theme = CyberFunkMonthlyCalendarThemeData();
                });
              },
            ),
            ListTile(
              title: Text('Select Today ${DateTime.now()} and Move Today'),
              onTap: () {
                setState(() {
                  selectedDateTime = DateTime.now();
                });
                controller.moveTo(selectedDateTime);
              },
            ),
            ListTile(
              title: Text('Move to 1970, 01, 01'),
              onTap: () {
                controller.moveTo(DateTime(1970, 01, 01));
              },
            ),
            ListTile(
              title: Text('Move to 2035, 12, 31'),
              onTap: () {
                controller.moveTo(DateTime(2035, 12, 31));
              },
            ),
            ListTile(
              title: Text('Change first weekday to Monday'),
              onTap: () {
                setState(() {
                  firstWeekday = DateTime.monday;
                });
              },
            ),
            ListTile(
              title: Text('Change first weekday to Sunday'),
              onTap: () {
                setState(() {
                  firstWeekday = DateTime.sunday;
                });
              },
            ),
            ListTile(
              title: Text('Change first weekday to Saturday'),
              onTap: () {
                setState(() {
                  firstWeekday = DateTime.saturday;
                });
              },
            ),
            ListTile(
              title: Text('Change locale to Korean'),
              onTap: () {
                setState(() {
                  locale = KoreanMonthlyCalendarLocale();
                });
              },
            ),
            ListTile(
              title: Text('Change locale to English'),
              onTap: () {
                setState(() {
                  locale = EnglishMonthlyCalendarLocale();
                });
              },
            ),
            ListTile(
              title: Text('Toggle weekday type'),
              onTap: () {
                setState(() {
                  shortHeader = !shortHeader;
                });
              },
            ),
          ])),
        ],
      ),
    );
  }
}
