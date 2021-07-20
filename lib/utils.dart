List<List<T>> chunk<T>(List<T> list, int chunkSize) {
  List<List<T>> chunks = [];
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

List<T> rotateList<T>(
    {List<T> list = const [], int amount = 0, bool right = true}) {
  var target = [...list];

  for (var i = 0; i < amount; i++) {
    if (right) {
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
