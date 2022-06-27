// 기록 모델
class Record {
  late double value;
  late DateTime date;

  Record({
    required this.value,
    required this.date,
  });

  void fromMap(Map<String, dynamic> map) {
    value = map['value'];
    date = map['date'];
  }

  Map<String, dynamic> toMap() => {
    'value': value,
    'date': date,
  };
}