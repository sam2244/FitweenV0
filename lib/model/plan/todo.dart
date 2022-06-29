// 할일 모델
class Todo {
  String? exercise;
  bool completed = false;

  Todo();

  // 할일 완료 여부를 전환
  void toggleComplete() => completed = !completed;
}