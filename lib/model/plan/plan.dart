import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitween1/model/chat/chat.dart';
import 'package:fitween1/model/plan/todo.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:intl/intl.dart';

// 플랜의 상태
enum PlanState { training, fail, complete }

// 플랜 모델
class Plan {
  String? id;
  String? purpose;
  PlanState state = PlanState.training;
  FWUser? trainer;
  FWUser? trainee;
  DateTime? startDate;
  DateTime? endDate;
  bool isDiet = true;
  bool isWeight = true;
  Map<Timestamp, List<Todo>>? todos;

  Plan();

  void fromMap(Map<String, dynamic> map) {
    id = map['id'];
    purpose = map['purpose'];
    state = map['state'];
    trainer = map['trainer'];
    trainee = map['trainee'];
    startDate = map['startDate'];
    endDate = map['endDate'];
    isDiet = map['isDiet'];
    isWeight = map['isWeight'];
    todos = map['todos'];
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'purpose': purpose,
    'state': state,
    'trainer': trainer,
    'trainee': trainee,
    'startDate': startDate,
    'endDate': endDate,
    'isDiet': isDiet,
    'isWeight': isWeight,
    'todos': todos,
  };

  @override
  String toString() {
    return '\n\n${toMap().entries.map(
          (data) => '${data.key}: ${data.value}',
    ).join('\n')}';
  }

  // 문자열을 상태 enum 으로 전환 ('training' => State.training)
  static PlanState toState(String string) {
    return PlanState.values.firstWhere((e) => e.toString() == string);
  }

  // 플랜 리스트의 각 플랜의 id 값으로 이루어진 리스트 반환 (List<Plan> => List<String>)
  static List<String>? toIds(List<Plan>? plans) {
    if (plans == null) return null;
    return plans.map((plan) => plan.id ?? '').toList();
  }

  static dateToString(DateTime date) => DateFormat('yyyy년 MM월 dd일').format(date);
  static DateTime get today => Chat.removeTime(DateTime.now());

  static const List<String> purposes = ['다이어트', '벌크업', '기타'];
}
