import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/presenter/page/add_plan/add_todo.dart';

// 할일 모델
class Todo {
  String name;
  int setCount = 1;
  Map<String, int> numbers = Map.fromEntries(
    AddTodoPresenter.types.map((type) => MapEntry(type, 0)),
  );
  List<String> units = [];
  List<Weekday> selectedDays = [];

  bool completed = false;

  Todo({
    required this.name,
    required this.numbers,
    required this.units,
    required this.selectedDays,
  });

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
