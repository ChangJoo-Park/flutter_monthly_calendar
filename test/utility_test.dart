import 'package:flutter_event_calendar/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ListChunk extension', () {
    List source = List.generate(100, (index) => index);

    test('chunked list by 2 length is 50',
        () => expect(source.chunk(2).length, (100 / 2).ceil()));
    test('chunk list by 3 length is 34',
        () => expect(source.chunk(3).length, (100 / 3).ceil()));

    test('chunk empty list', () => expect([].chunk(3).length, 0));
    test('chunk list by minus will be throw RangeError',
        () => expect(() => source.chunk(-50), throwsA(isA<RangeError>())));
  });

  group('ListMutation extension', () {
    List source = List.generate(5, (index) => index);

    test('Rotated list right side 3', () {
      // 0 : [0, 1, 2, 3, 4];
      // 1 : [4, 0, 1, 2, 3];
      // 2 : [3, 4, 0, 1, 2];
      // 3 : [2, 3, 4, 0, 1];
      expect(source.rotate(3, true), [2, 3, 4, 0, 1]);
    });

    test('Rotated list right side 5 will be same as source', () {
      expect(source.rotate(5, true), source);
    });

    test('rotateRight is same as rotate(amount, true)', () {
      expect(source.rotate(3, true), source.rotateRight(3));
    });

    test('rotateLeft is same as rotate(amount, false)', () {
      expect(source.rotate(3, false), source.rotateLeft(3));
    });
  });

  group('DateComparison extension', () {
    test('DateTime(2021,01) ~ DateTime(2021,12) has 11 differences', () {
      expect(DateTime(2021, 01).differenceInMonth(DateTime(2021, 12)), 11);
    });

    test('DateTime(2021,01) ~ DateTime(2021,01) has no difference', () {
      expect(DateTime(2021, 01).differenceInMonth(DateTime(2021, 01)), 0);
    });

    test('DateTime(2019,01) ~ DateTime(2021,01) has 24 differences', () {
      expect(DateTime(2019, 01).differenceInMonth(DateTime(2021, 01)), 24);
    });

    test('DateTime(2021,01) ~ DateTime(2019,01) has -24 differences', () {
      expect(DateTime(2021, 01).differenceInMonth(DateTime(2019, 01)), -24);
    });

    test('DateTime(2021, 01).addMonth is DateTime(2021, 02)', () {
      expect(DateTime(2021, 01).addMonth(1), DateTime(2021, 02));
    });
    test('DateTime(2021, 12).addMonth is DateTime(2022, 01)', () {
      expect(DateTime(2021, 12).addMonth(1), DateTime(2022, 01));
    });

    test('DateTime(2021, 12).addMonth -1 is DateTime(2021, 11)', () {
      expect(DateTime(2021, 12).addMonth(-1), DateTime(2021, 11));
    });

    test('DateTime(2021, 01).addMonth -1 is DateTime(2020, 12)', () {
      expect(DateTime(2021, 01).addMonth(-1), DateTime(2020, 12));
    });
  });

  group('Generate Calendar', () {
    test('Generate 2021, 01 to 2021 12 is 12 length list', () {
      expect(
          generateCalendar(DateTime(2021, 1), DateTime(2021, 12)).length, 12);
    });
    test('Generate 2021, 01 to 2021 01 is 12 length list', () {
      expect(generateCalendar(DateTime(2021, 1), DateTime(2021, 01)).length, 1);
    });

    test('Will throw start date', () {
      expect(
        () => generateCalendar(DateTime(2021, 12), DateTime(2021, 1)),
        throwsA(isA<RangeError>()),
      );
    });
  });

  group('Generate Month', () {
    test("generated month's first/last weekday is based on baseWeekday", () {
      var mondayBaseMonth =
          generateMonth(DateTime(2021, 07, 01), DateTime.monday);
      expect(mondayBaseMonth.first.weekday, DateTime.monday);
      expect(mondayBaseMonth.last.weekday, DateTime.sunday);

      var sundayBaseMonth =
          generateMonth(DateTime(2021, 07, 01), DateTime.sunday);
      expect(sundayBaseMonth.first.weekday, DateTime.sunday);
      expect(sundayBaseMonth.last.weekday, DateTime.saturday);

      var saturdayBaseMonth =
          generateMonth(DateTime(2021, 07, 01), DateTime.saturday);
      expect(saturdayBaseMonth.first.weekday, DateTime.saturday);
      expect(saturdayBaseMonth.last.weekday, DateTime.friday);
    });

    test('generated list has all target days', () {
      var startDay = DateTime(2021, 07, 01);
      var lastDay = DateTime(2021, 07, 31);

      var result = generateMonth(DateTime(2021, 07, 01), DateTime.monday);
      var source = startDay;
      for (var i = 0; i < lastDay.difference(startDay).inDays; i++) {
        expect(result.contains(source), true);
        source = source.add(Duration(days: 1));
      }
    });
  });
}
