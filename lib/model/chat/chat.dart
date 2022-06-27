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

  DateTime ignoreTime() => DateTime(date.year, date.month, date.day);
}
