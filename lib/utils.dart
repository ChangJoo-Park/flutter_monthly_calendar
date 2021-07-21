extension ListChunk on List {
  List<List<T>> chunk<T>(int chunkSize) {
    List<List<T>> chunks = [];
    int len = this.length;
    for (var i = 0; i < len; i += chunkSize) {
      int size = i + chunkSize;
      chunks.add(this.sublist(i, size > len ? len : size) as List<T>);
    }
    return chunks;
  }
}

extension ListMutation on List {
  List<T> rotate<T>(int amount, bool isRight) {
    List<T> target = List.from(this);

    if (isRight) {
      for (var i = 0; i < amount; i++) {
        var lastItem = target.removeLast();
        target.insert(0, lastItem);
      }
    } else {
      for (var i = 0; i < amount; i++) {
        var firstItem = target[0];
        target.removeAt(0);
        target.add(firstItem);
      }
    }
    return target;
  }

  List<T> rotateRight<T>(int amount) => this.rotate(amount, true);
  List<T> rotateLeft<T>(int amount) => this.rotate(amount, false);
}

extension DateComparison on DateTime {
  bool isSameYear(datetime) => this.year == datetime.year;

  bool isSameMonth(datetime) => this.month == datetime.month;

  bool isSameDay(datetime) => this.day == datetime.day;

  bool isSameYearMonth(datetime) =>
      this.isSameYear(datetime) && this.isSameMonth(datetime);

  bool isSameYearMonthDay(datetime) =>
      this.isSameYear(datetime) &&
      this.isSameMonth(datetime) &&
      this.isSameDay(datetime);

  int differenceInMonth(DateTime datetime) {
    int count = 0;
    DateTime source = this;
    bool isBefore = source.isBefore(datetime);
    while (!source.isSameYearMonth(datetime)) {
      if (isBefore) {
        source = DateTime(source.year, source.month + 1, 1);
        count++;
      } else {
        source = DateTime(source.year, source.month - 1, 1);
        count--;
      }
    }
    return count;
  }
}

List<DateTime> generateMonth(DateTime datetime, int firstWeekdayIndex) {
  // [datetime] 으로 부터 이번달의 1일의 요일을 가져온다.
  DateTime firstOfMonth = DateTime(datetime.year, datetime.month, 1).toLocal();
  // 이번달의 마지막 날과 요일을 가져온다.
  DateTime lastOfMonth =
      DateTime(datetime.year, datetime.month + 1, 1).toLocal();

  // weekday 7은 일요일이므로 보정해야한다.
  // 달력은 일월화수목금토이기 때문
  DateTime loopStartDay = firstOfMonth.toLocal().subtract(
        Duration(
            days:
                firstOfMonth.weekday - 1 + firstWeekdayIndex), // 필요하면 유틸리티로 빼야함
      );

  DateTime loopEndDay = lastOfMonth
      .toLocal()
      .add(Duration(days: 7 - lastOfMonth.weekday - firstWeekdayIndex));

  // !!!: 임의로 추가함
  if (loopEndDay.toLocal().isBefore(lastOfMonth.toLocal())) {
    loopEndDay = loopEndDay.toLocal().add(Duration(days: 7));
  }

  int difference =
      loopEndDay.toLocal().difference(loopStartDay.toLocal()).inDays;

  List<DateTime> days = [];
  for (var i = 0; i <= difference; i++)
    days.add(loopStartDay.add(Duration(days: i)).toLocal());

  return days;
}

List<DateTime> generateCalendar(DateTime startDateTime, DateTime endDateTime) {
  DateTime calendarStartDate =
      DateTime(startDateTime.year, startDateTime.month, 1);
  DateTime calendarEndDate =
      DateTime(endDateTime.year, endDateTime.month + 1, 0);
  int difference = calendarStartDate.differenceInMonth(calendarEndDate);
  List<DateTime> data = List.generate(
    difference,
    (i) => DateTime(calendarStartDate.year, calendarStartDate.month + i, 1)
        .toLocal(),
  );
  return data;
}
