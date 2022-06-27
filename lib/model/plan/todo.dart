import 'package:fitween1/model/plan/exercise.dart';

// 할일 모델
class Todo {
  Exercise exercise;
  int countPerSet;
  int setCount;
  bool completed;

  Todo({
    required this.exercise,
    required this.countPerSet,
    this.setCount = 5,
    this.completed = false,
  });

  // 할일 완료 여부를 전환
  void toggleComplete() => completed = !completed;

  // 할일을 문자열로 반환
  @override
  String toString() => '${exercise.name} $countPerSet회 × $setCount세트';
}