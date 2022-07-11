import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/presenter/page/add_plan/add_todo.dart';

// 할일 모델
class Todo {
  String name;
  int setCount = 1;
  Map<String, int> numbers = Map.fromEntries(
    AddTodoPresenter.types.map((type) => MapEntry(type, 0)),
  );
  List<Weekday> selectedDays = [];
  bool completed = false;

  Todo({
    required this.name,
    required this.numbers,
    required this.selectedDays,
  });

  void fromMap(Map<String, dynamic> map) {
    name = map['name'];
    setCount = map['setCount'];
    numbers = map['numbers'];
    selectedDays = map['selectedDays'];
    completed = map['completed'];
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'setCount': setCount,
    'numbers': numbers,
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
    'name': name,
    'setCount': setCount,
    'numbers': numbers.entries.map((number) => {'unit': number.key, 'number': number.value}).toList(),
    'selectedDays': selectedDays.map((day) => day.name).toList(),
    'completed': completed,
  };

  @override
  String toString() {
    String result = '$name ';
    numbers.forEach((unit, number) {
      if (number > 0) result += '$number$unit ';
    });

    return result;
  }

  // 할일 완료 여부를 전환
  void toggleComplete() => completed = !completed;
}
