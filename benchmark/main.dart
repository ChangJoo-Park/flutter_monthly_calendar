import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:flutter_event_calendar/utils.dart';

class CalendarGenerateBenchmark extends BenchmarkBase {
  CalendarGenerateBenchmark(String name) : super(name);

  static void main() {
    CalendarGenerateBenchmark('CalendarGenerate').report();
  }

  @override
  void run() {
    generateCalendar(DateTime(1970, 01, 01), DateTime(2035, 01, 12));
  }

  @override
  void setup() {}

  @override
  void teardown() {}
}

class MonthGenerateBenchmark extends BenchmarkBase {
  MonthGenerateBenchmark(String name) : super(name);

  static void main() {
    MonthGenerateBenchmark('MonthGenerate').report();
  }

  @override
  void run() {
    generateMonth(DateTime.now(), DateTime.monday);
  }

  @override
  void setup() {}

  @override
  void teardown() {}
}

void main() {
  CalendarGenerateBenchmark.main();
  MonthGenerateBenchmark.main();
}
