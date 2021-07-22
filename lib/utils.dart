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

  /// Chunk List by [chunkSize]
  ///
  /// ```dart
  /// [1,2,3].chunkBy(0) == [1, 2, 3]
  /// [1,2,3].chunkBy(1) == [[1], [2], [3]]
  /// [1,2,3].chunkBy(2) == [[1, 2], [3]]
  /// ```
  ///
  /// [chunkSize] is always positive integer.
  /// When use `[1,2,3].chunkBy(-1)`, It makes [RangeError]
  List<List<E>> chunkBy<E>(int chunkSize) {
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

extension DateTimeExtension on DateTime {
  /// Compare year by target datetime.
  bool isSameYear(DateTime datetime) => year == datetime.year;

  /// Compare month by target datetime.
  bool isSameMonth(DateTime datetime) => month == datetime.month;

  /// Compare day by target datetime.
  bool isSameDay(DateTime datetime) => day == datetime.day;

  /// Compare year and month by target datetime.
  bool isSameYearMonth(DateTime datetime) =>
      isSameYear(datetime) && isSameMonth(datetime);

  /// Compare year and month and day by target datetime.
  bool isSameYearMonthDay(DateTime datetime) =>
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

  /// Add month to base [DateTime]
  ///
  /// [Duration] has no month parameters, So If you need add month to base [DateTime], use this method.
  ///
  /// ```dart
  /// DateTime(2021, 02, 01).addMonth(1) == DateTime(2021, 03, 01)
  /// DateTime(2021, 02, 01).addMonth(-1) == DateTime(2021, 02, 01)
  /// ```
  DateTime addMonth(int amount) => DateTime(year, month + amount, day);
}

/// Generate days for Calendar.
///
/// the [datetime] is source of calendar.
/// If first day of [datetime]'s weekday is not the same as [baseWeekday],
/// fill days before the first day of [datetime] until the same.
///
/// !!!: [baseWeekday] is not the same of [DateTime.monday] to [DateTime.sunday].
/// It needs to recode.
///
/// When [baseWeekday] is [DateTime.monday] and month of [datetime] if start with [DateTime.wednesday].
/// ```dart
/// [
///   [/* previous month's last -1 day */],[/* previous month's last day */],[1],[2],[3],[4],[5]
///   // ...
/// ]
/// ```
/// [generateMonth] fill first two days from previous month from [datetime]
///
/// also, If last day of [datetime]'s weekday is not the same as [baseWeekday],
/// fill days after the last day of [datetime] until the same.
///
/// when last week of [datetime]'s month like below, fill last empty days from next month
/// ```dart
/// [
///   // ...
///   [26],[27],[28],[29],[30],[31],[/* next month's first day */],
/// ]
/// ```
List<DateTime> generateMonth(DateTime datetime, int baseWeekday) {
  int firstWeekdayDiff = differenceFromDaysPerWeek(baseWeekday);
  // [datetime] 으로 부터 이번달의 1일의 요일을 가져온다.
  DateTime firstOfMonth = DateTime(datetime.year, datetime.month, 1).toLocal();
  // 이번달의 마지막 날과 요일을 가져온다.
  DateTime lastOfMonth =
      DateTime(datetime.year, datetime.month + 1, 1).toLocal();

  // weekday 7은 일요일이므로 보정해야한다.
  // 달력은 일월화수목금토이기 때문
  DateTime loopStartDay = firstOfMonth
      .toLocal()
      .subtract(Duration(days: firstOfMonth.weekday - 1 + firstWeekdayDiff));

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

/// Generate [List<DateTime>] for Pages.
///
List<DateTime> generateCalendar(DateTime startDateTime, DateTime endDateTime) {
  DateTime calendarStartDate =
      DateTime(startDateTime.year, startDateTime.month, 1);
  DateTime calendarEndDate = endDateTime.addMonth(1);

  return List<DateTime>.generate(
    calendarStartDate.differenceInMonth(calendarEndDate),
    (amount) => calendarStartDate.addMonth(amount).toLocal(),
  );
}

int differenceFromDaysPerWeek(int weekday) =>
    DateTime.daysPerWeek - weekday + 1;
