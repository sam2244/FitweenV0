import 'package:fitween1/model/plan/plan.dart';

class Diet {
  String? imageUrl;
  String description;
  String type;
  List<Weekday> selectedDays = [];
  bool completed = false;

  Diet({
    required this.description,
    required this.type,
    required this.selectedDays,
  });

  void fromMap(Map<String, dynamic> map) {
    imageUrl = map['imageUrl'];
    description = map['description'];
    type = map['type'];
    selectedDays = map['selectedDays'];
    completed = map['completed'];
  }

  Map<String, dynamic> toMap() => {
    'imageUrl': imageUrl,
    'description': description,
    'type': type,
    'selectedDays': selectedDays,
    'completed': completed,
  };

  void fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> map = {...json};
    map['numbers'] = {};
    json['numbers'].forEach((number) => map['numbers'][number['unit']] = number['number']);
    map['selectedDays'] = json['selectedDays'].map((day) => Plan.stringToWeekDay(day));
    fromMap(map);
  }

  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
    'description': description,
    'type': type,
    'selectedDays': selectedDays.map((day) => day.name).toList(),
    'completed': completed,
  };

  @override
  String toString() => description;
}