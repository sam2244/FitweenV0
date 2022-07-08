import 'package:fitween1/model/plan/todo.dart';
import 'package:fitween1/presenter/model/exercise.dart';
import 'package:fitween1/presenter/page/add_plan/add_plan.dart';
import 'package:get/get.dart';

class AddTodoPresenter extends GetxController {
  static List<String> types = const ['회', 'km', 'm', '시간', '분', '초'];
  static AddPlanPresenter addPlanPresenter = Get.find<AddPlanPresenter>();

  int updateIndex = -1;
  String? name;
  String? unitType;
  Map<String, int> numbers = Map.fromEntries(types.map((type) => MapEntry(type, 0)));

  void backPressed() {
    Get.back();
    initialize();
  }

  void initialize([Todo? todo]) {
    name = todo?.name;
    unitType = ExercisePresenter.getExercise(name)?.units.first;
    numbers = todo?.numbers ?? initNumbers();
  }

  Map<String, int> initNumbers() => Map.fromEntries(types.map((type) => MapEntry(type, 0)));

  void nextPressed() {
    if (name == null) return;

    Todo todo = Todo(
      name: name!,
      numbers: numbers,
      units: ExercisePresenter.getExercise(name)?.units ?? [],
      selectedDays: [...addPlanPresenter.selectedDays],
    );

    if (updateIndex < 0) { addPlanPresenter.addTodo(todo); }
    else { addPlanPresenter.updateTodo(todo); }
    backPressed();
  }

  void nameSelected(String name) {
    initialize();
    this.name = name;
    unitType = ExercisePresenter.getExercise(name)!.units.first;
    update();
  }

  void numberSelected(int number, String unit) {
    numbers[unit] = number; update();
  }

  void unitSelected(String unit) {
    numbers = initNumbers();
    unitType = unit; update();
  }
}