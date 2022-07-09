import 'package:fitween1/model/user/user.dart';

class Chat {
  FWUser user;
  String text;
  DateTime date = DateTime.now();

  Chat({
    required this.user,
    required this.text,
    required this.date,
  });

  void fromMap(Map<String, dynamic> map) {
    user = map['sentUser'];
    text = map['text'];
    date = map['date'];
  }

  Map<String, dynamic> toMap() => {
    'user': user,
    'text': text,
    'date': date,
  };

  static DateTime removeTime(DateTime date) => DateTime(date.year, date.month, date.day);
  static DateTime fullTime(DateTime date) => removeTime(date).add(
    const Duration(days: 1)).subtract(const Duration(seconds: 1),
  );
  DateTime ignoreTime() => removeTime(date);
}
