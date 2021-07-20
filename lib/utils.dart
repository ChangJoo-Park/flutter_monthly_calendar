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
    List<T> target = [...this];

    for (var i = 0; i < amount; i++) {
      if (isRight) {
        var lastItem = target.removeLast();
        target.insert(0, lastItem);
      } else {
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
  bool isSameMonth(datetime) =>
      this.isSameYear(this) && this.month == datetime.month;
  bool isSameDay(datetime) =>
      this.isSameMonth(this) && this.day == datetime.day;
}

List<DateTime> generateMonth(DateTime datetime, int baseWeekdayIndex) {
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
                firstOfMonth.weekday - 1 + baseWeekdayIndex), // 필요하면 유틸리티로 빼야함
      );

  DateTime loopEndDay = lastOfMonth
      .toLocal()
      .add(Duration(days: 7 - lastOfMonth.weekday - baseWeekdayIndex));

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

  return List.generate(
    calendarEndDate.month - calendarStartDate.month + 1,
    (i) => DateTime(calendarStartDate.year, calendarStartDate.month + i, 1)
        .toLocal(),
  );
}
