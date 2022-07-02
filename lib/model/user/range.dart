// 범위 추상 모델
abstract class Range<E> {
  E start;
  late E end;

  Range({required this.start, E? end, double? range});

  double get range;
}

// 날짜 범위 모델
class DateRange extends Range<DateTime> {
  DateRange({required super.start, DateTime? end, int? range}) {
    assert(end == null || range == null);
    if (range == null) { super.end = end ?? start; }
    else { super.end = start.add(Duration(days: range - 1)); }
  }

  @override
  double get range => end.difference(start).inDays + 1;
  DateTime getDate(double range) => start.add(Duration(days: range.toInt()));
  double getValue(DateTime date) => date.difference(start).inDays.toDouble();
}

// 체중 범위 모델
class WeightRange extends Range<double> {
  WeightRange({required super.start, double? end, int? range}) {
  assert(end == null || range == null);
    if (range == null) { super.end = end ?? start; }
    else { super.end = start - range + 1; }
  }

  @override
  double get range => end - start - 1;
}