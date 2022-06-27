import 'dart:collection';

import 'package:fitween1/model/plan/record.dart';
import 'package:fitween1/model/plan/todo.dart';
import 'package:fitween1/model/user/user.dart';

// 플랜의 상태
enum PlanState { training, fail, complete }

// 플랜 모델
class Plan {
  String? id;
  PlanState state = PlanState.training;
  FWUser? trainer;
  FWUser? trainee;
  DateTime? startDate;
  DateTime? endDate;
  String? goal;
  double? value;
  double? goalValue;
  List<String>? tags;

  LinkedHashMap todos = LinkedHashMap<DateTime, List<Todo>>();
  LinkedHashMap records = LinkedHashMap<DateTime, Record>();

  Plan();

  void fromMap(Map<String, dynamic> map) {
    id = map['id'];
    state = map['state'];
    trainer = map['trainer'];
    trainee = map['trainee'];
    startDate = map['startDate'];
    endDate = map['endDate'];
    goal = map['goal'];
    value = map['value'];
    goalValue = map['goalValue'];
    tags = map['tags'];
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'state': state,
    'trainer': trainer,
    'trainee': trainee,
    'startDate': startDate,
    'endDate': endDate,
    'goal': goal,
    'value': value,
    'goalValue': goalValue,
    'tags': tags,
  };

  // 문자열을 상태 enum 으로 전환 ('training' => State.training)
  static PlanState toState(String string) {
    return PlanState.values.firstWhere((e) => e.toString() == string);
  }

  // 플랜 리스트의 각 플랜의 id 값으로 이루어진 리스트 반환 (List<Plan> => List<String>)
  static List<String>? toIds(List<Plan>? plans) {
    if (plans == null) return null;
    return plans.map((plan) => plan.id ?? '').toList();
  }
}
