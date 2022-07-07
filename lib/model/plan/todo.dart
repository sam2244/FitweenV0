// 할일 모델
class Todo {
  String? exercise;
  int count = 0;
  String? unit;
  bool completed = false;

  Todo();

  // 할일 완료 여부를 전환
  void toggleComplete() => completed = !completed;
}