extension ListMutation on List {
  List<E> rotate<E>(int amount, bool isRight) {
    List<E> target = List.from(this);

    if (isRight) {
      for (var i = 0; i < amount; i++) {
        target.insert(0, target.removeLast());
      }
    } else {
      for (var i = 0; i < amount; i++) {
        target.add(target.removeAt(0));
      }
    }
    return target;
  }

  List<E> rotateRight<E>(int amount) => rotate(amount, true);
  List<E> rotateLeft<E>(int amount) => rotate(amount, false);

  List<List<E>> chunk<E>(int chunkSize) {
    if (chunkSize.isNegative) throw RangeError.range(chunkSize, 0, null);

    List<List<E>> chunks = [];
    int len = length;
    for (var i = 0; i < len; i += chunkSize) {
      int size = i + chunkSize;
      chunks.add(sublist(i, size > len ? len : size) as List<E>);
    }
    return chunks;
  }
}

extension DateComparison on DateTime {
  bool isSameYear(datetime) => year == datetime.year;

  bool isSameMonth(datetime) => month == datetime.month;

  bool isSameDay(datetime) => day == datetime.day;

  bool isSameYearMonth(datetime) =>
      isSameYear(datetime) && isSameMonth(datetime);

  bool isSameYearMonthDay(datetime) =>
      isSameYear(datetime) && isSameMonth(datetime) && isSameDay(datetime);

  /// Get difference from two datetimes.
  ///
  /// ```dart
  /// // result is 11 same as `12 - 1`
  /// DateTime(2021, 01).differenceInMonth(DateTime(2021, 12))
  /// ```
  /// This method is exclusive target DateTime.
  /// result difference can be **Positive** or **Negative**.
  /// [DateTime(/*Past*/).differenceInMonth(/*Future*/)] is positive.
  /// [DateTime(/*Future*/).differenceInMonth(/*Past*/)] is negative.
  int differenceInMonth(DateTime datetime) {
    int diff = 0;
    DateTime source = this;
    int delta = source.isBefore(datetime) ? 1 : -1;

    // Add delta until same year and month between [source] and [datetime].
    while (!source.isSameYearMonth(datetime)) {
      source = source.addMonth(delta);
      diff += delta;
    }

    return diff;
  }

  DateTime addMonth(int amount) => DateTime(year, month + amount, day);
}

List<DateTime> generateMonth(DateTime datetime, int baseWeekday) {
  int firstWeekdayDiff = getDiffFromWeekday(baseWeekday);
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
                firstOfMonth.weekday - 1 + firstWeekdayDiff), // 필요하면 유틸리티로 빼야함
      );

  DateTime loopEndDay = lastOfMonth
      .toLocal()
      .add(Duration(days: 7 - lastOfMonth.weekday - firstWeekdayDiff));

  // !!!: 임의로 추가함
  if (loopEndDay.toLocal().isBefore(lastOfMonth.toLocal())) {
    loopEndDay = loopEndDay.toLocal().add(Duration(days: 7));
  }

  int difference =
      loopEndDay.toLocal().difference(loopStartDay.toLocal()).inDays;

  List<DateTime> days = [];
  for (var i = 0; i <= difference; i++) {
    days.add(loopStartDay.add(Duration(days: i)).toLocal());
  }

  return days;
}

List<DateTime> generateCalendar(DateTime startDateTime, DateTime endDateTime) {
  DateTime calendarStartDate =
      DateTime(startDateTime.year, startDateTime.month, 1);
  DateTime calendarEndDate = endDateTime.addMonth(1);

  return List.generate(
    calendarStartDate.differenceInMonth(calendarEndDate),
    (amount) => calendarStartDate.addMonth(amount).toLocal(),
  );
}

int getDiffFromWeekday(int weekday) => DateTime.daysPerWeek - weekday + 1;
