import 'dart:math';

import 'package:fitween1/model/chat/chat.dart';
import 'package:fitween1/model/plan/diet.dart';
import 'package:fitween1/model/plan/todo.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:intl/intl.dart';

// 플랜의 상태
enum PlanState { training, fail, complete }

// 요일
enum Weekday {
  mon,
  tue,
  wed,
  thu,
  fri,
  sat,
  sun;

  get kr => ['월', '화', '수', '목', '금', '토', '일'][index];
}

// 플랜 모델
class Plan {
  String? group;
  String? id;
  String? purpose;
  PlanState state = PlanState.training;
  FWUser? trainer;
  FWUser? trainee;
  DateTime? startDate;
  DateTime? endDate;
  bool isDiet = false;
  bool isWeight = true;
  late Map<DateTime, List<Todo>> todos;
  late Map<DateTime, List<Diet>> diets;

  String? trainerUid;
  String? traineeUid;

  Plan({String? id}) {
    if (id == null) {
      generatePlanId();
    } else {
      this.id = id;
    }
    todos = initMap<Todo>();
    diets = initMap<Diet>();
  }

  Map<DateTime, List<T>> initMap<T>() {
    Map<DateTime, List<T>> result = {};
    DateTime date = startDate ?? today;
    while (date.isBefore(endDate ?? tomorrow)) {
      result[date] = [];
      date = date.add(const Duration(days: 1));
    }
    return result;
  }

  Plan.fromMap(Map<String, dynamic> map) {
    todos = initMap<Todo>();
    diets = initMap<Diet>();
    fromMap(map);
  }

  void fromMap(Map<String, dynamic> map) {
    group = map['group'];
    id = map['id'];
    purpose = map['purpose'];
    state = map['state'];
    trainer = map['trainer'];
    trainee = map['trainee'];
    trainerUid = map['trainerUid'];
    traineeUid = map['traineeUid'];
    startDate = map['startDate'];
    endDate = map['endDate'];
    isDiet = map['isDiet'];
    isWeight = map['isWeight'];
  }

  Map<String, dynamic> toMap() => {
        'group': group,
        'id': id,
        'purpose': purpose,
        'state': state,
        'trainer': trainer,
        'trainee': trainee,
        'trainerUid': trainerUid,
        'traineeUid': traineeUid,
        'startDate': startDate,
        'endDate': endDate,
        'isDiet': isDiet,
        'isWeight': isWeight,
      };

  // json 데이터를 plan 객체에 주입
  void fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> map = {...json};
    map['state'] = Plan.toState(json['state']);
    map['startDate'] = json['startDate'].toDate();
    map['endDate'] = json['endDate'].toDate();
    map['todos'] = Plan.toTodos(json['todos']);
    map['diets'] = Plan.toDiets(json['diets']);
    fromMap(map);
  }

  // plan 객체에서 json 데이터 추출
  Map<String, dynamic> toJson() => {
        'group': group,
        'id': id,
        'state': state.name,
        'purpose': purpose,
        'trainerUid': trainerUid,
        'traineeUid': traineeUid,
        'startDate': startDate,
        'endDate': endDate,
        'todos': todos.entries
            .map((dateTodo) => {
                  'date': dateTodo.key,
                  'todoList':
                      dateTodo.value.map((todo) => todo.toJson()).toList(),
                })
            .toList(),
        'diets': diets.entries
            .map((dateDiet) => {
                  'date': dateDiet.key,
                  'dietList':
                      dateDiet.value.map((diet) => diet.toJson()).toList(),
                })
            .toList(),
        'isDiet': isDiet,
        'isWeight': isWeight,
      };

  void generatePlanId() {
    int length = 7;
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    id = String.fromCharCodes(
      Iterable.generate(
          length,
          (_) => chars.codeUnitAt(
                Random().nextInt(chars.length),
              )),
    );
  }

  double get goalRate {
    int total = 1;
    int completed = 0;
    for (List<Todo> todoList in todos.values) {
      total += todoList.length;
      completed += todoList.where((todo) => todo.completed).length;
    }
    return completed / total;
  }

  double get todoRate {
    todos[today] ??= [];
    int total = todos[today]!.isEmpty ? 1 : todos[today]!.length;
    int completed = todos[today]?.where((todo) => todo.completed).length ?? 0;
    return completed / total;
  }

  double get dietRate {
    diets[today] ??= [];
    int total = diets[today]!.isEmpty ? 1 : diets[today]!.length;
    int completed = diets[today]?.where((diet) => diet.completed).length ?? 0;
    return completed / total;
  }

  @override
  String toString() {
    return '\n\nPLAN INFO\n${toMap().entries.map(
          (data) => '  ${data.key}: ${data.value}',
        ).join('\n')}\n';
  }

  // 문자열을 상태 enum 으로 전환 ('training' => State.training)
  static PlanState toState(String string) {
    return PlanState.values.firstWhere((state) => state.name == string);
  }

  // 플랜 리스트의 각 플랜의 id 값으로 이루어진 리스트 반환 (List<Plan> => List<String>)
  static List<String>? toIds(List<Plan>? plans) {
    if (plans == null) return null;
    return plans.map((plan) => plan.id ?? '').toList();
  }

  static Map<DateTime, List<Todo>>? toTodos(List<dynamic>? jsonTodos) {
    Map<DateTime, List<Todo>> result = {};
    if (jsonTodos == null) return null;
    for (var jsonTodo in jsonTodos) {
      result[jsonTodo['date'].toDate()] = jsonTodo['todos'] ?? [];
    }
    return result;
  }

  static Map<DateTime, List<Todo>>? toDiets(List<dynamic>? jsonDiets) {
    Map<DateTime, List<Todo>> result = {};
    if (jsonDiets == null) return null;
    for (var jsonDiet in jsonDiets) {
      result[jsonDiet['date'].toDate()] = jsonDiet['diets'] ?? [];
    }
    return result;
  }

  static dateToString(DateTime date) =>
      DateFormat('yyyy년 MM월 dd일').format(date);
  static DateTime get today => Chat.removeTime(DateTime.now());
  static DateTime get tomorrow => Chat.fullTime(today);

  static const List<String> purposes = ['다이어트', '벌크업', '기타'];

  static Weekday toWeekday(DateTime date) {
    return {
      DateTime.monday: Weekday.mon,
      DateTime.tuesday: Weekday.tue,
      DateTime.wednesday: Weekday.wed,
      DateTime.thursday: Weekday.thu,
      DateTime.friday: Weekday.fri,
      DateTime.saturday: Weekday.sat,
      DateTime.sunday: Weekday.sun,
    }[date.weekday]!;
  }

  static Weekday stringToWeekDay(String date) {
    return Weekday.values.firstWhere((day) => day.name == date);
  }
}
