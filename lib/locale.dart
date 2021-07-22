abstract class MonthlyCalendarLocale {
  List<String> get weekdaysLong;
  List<String> get weekdaysShort;
}

class EnglishMonthlyCalendarLocale implements MonthlyCalendarLocale {
  const EnglishMonthlyCalendarLocale();
  @override
  List<String> get weekdaysShort =>
      const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

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

class KoreanMonthlyCalendarLocale implements MonthlyCalendarLocale {
  const KoreanMonthlyCalendarLocale();

  @override
  List<String> get weekdaysShort => const ['월', '화', '수', '목', '금', '토', '일'];

  @override
  List<String> get weekdaysLong =>
      const ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
}

class SpanishMonthlyCalendarLocale implements MonthlyCalendarLocale {
  const SpanishMonthlyCalendarLocale();

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

class GermanMonthlyCalendarLocale implements MonthlyCalendarLocale {
  const GermanMonthlyCalendarLocale();

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

class JapaneseMonthlyCalendarLocale implements MonthlyCalendarLocale {
  const JapaneseMonthlyCalendarLocale();

  @override
  List<String> get weekdaysShort => const ["日", "月", "火", "水", "木", "金", "土"];

  @override
  List<String> get weekdaysLong =>
      const ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"];
}

class VietnameseMonthlyCalendarLocale implements MonthlyCalendarLocale {
  const VietnameseMonthlyCalendarLocale();

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

class ChineseMonthlyCalendarLocale implements MonthlyCalendarLocale {
  const ChineseMonthlyCalendarLocale();

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
