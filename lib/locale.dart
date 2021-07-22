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

class SpanishEventCalendarLocale implements EventCalendarLocale {
  const SpanishEventCalendarLocale();

  @override
  List<String> get weekdaysShort =>
      const ["dom.", "lun.", "mar.", "mié.", "jue.", "vie.", "sáb."];

  @override
  List<String> get weekdaysLong => const [
        "domingo",
        "lunes",
        "martes",
        "miércoles",
        "jueves",
        "viernes",
        "sábado"
      ];
}

class GermanEventCalendarLocale implements EventCalendarLocale {
  const GermanEventCalendarLocale();

  @override
  List<String> get weekdaysShort =>
      const ["So.", "Mo.", "Di.", "Mi.", "Do.", "Fr.", "Sa."];

  @override
  List<String> get weekdaysLong => const [
        "Sonntag",
        "Montag",
        "Dienstag",
        "Mittwoch",
        "Donnerstag",
        "Freitag",
        "Samstag"
      ];
}

class JapaneseEventCalendarLocale implements EventCalendarLocale {
  const JapaneseEventCalendarLocale();

  @override
  List<String> get weekdaysShort => const ["日", "月", "火", "水", "木", "金", "土"];

  @override
  List<String> get weekdaysLong =>
      const ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"];
}

class VietnameseEventCalendarLocale implements EventCalendarLocale {
  const VietnameseEventCalendarLocale();

  @override
  List<String> get weekdaysShort =>
      const ["CN", "T2", "T3", "T4", "T5", "T6", "T7"];

  @override
  List<String> get weekdaysLong => const [
        "chủ nhật",
        "thứ hai",
        "thứ ba",
        "thứ tư",
        "thứ năm",
        "thứ sáu",
        "thứ bảy"
      ];
}

class ChineseEventCalendarLocale implements EventCalendarLocale {
  const ChineseEventCalendarLocale();

  @override
  List<String> get weekdaysShort =>
      const ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];

  @override
  List<String> get weekdaysLong => const [
        "chủ nhật",
        "thứ hai",
        "thứ ba",
        "thứ tư",
        "thứ năm",
        "thứ sáu",
        "thứ bảy"
      ];
}
