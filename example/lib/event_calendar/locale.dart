abstract class EventCalendarLocale {
  List<String> get weekdaysLong;
  List<String> get weekdaysShort;
}

class EnglishEventCalendarLocale implements EventCalendarLocale {
  const EnglishEventCalendarLocale();
  @override
  List<String> get weekdaysShort =>
      const ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];

  @override
  List<String> get weekdaysLong => const [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
}

class KoreanEventCalendarLocale implements EventCalendarLocale {
  const KoreanEventCalendarLocale();

  @override
  List<String> get weekdaysShort => const ['월', '화', '수', '목', '금', '토', '일'];

  @override
  List<String> get weekdaysLong =>
      const ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
}
