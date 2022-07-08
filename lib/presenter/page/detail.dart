import 'package:get/get.dart';

// 트레이너 디테일 페이지 프리젠터
class TrainerDetailPresenter extends GetxController {
  DateTime selectedDay = DateTime.now();
  final demo = <Map>[
    {
      'dateTime': DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 2),
      'exercises': ['윗몸일으키기 20회'],
      'completed': [false],
    },
    {
      'dateTime': DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      'exercises': ['푸쉬업 30회'],
      'completed': [true],
    },
    {
      'dateTime': DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      'exercises': ['턱걸이 20회'],
      'completed': [false],
    },
    {
      'dateTime': DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
      'exercises': ['윗몸일으키기 20회', '푸쉬업 30회'],
      'completed': [false, false],
    },
    {
      'dateTime': DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
      'exercises': ['윗몸일으키기 20회', '턱걸이 30회'],
      'completed': [false, true],
    },
    {
      'dateTime': DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 3),
      'exercises': ['푸쉬업 30회', '턱걸이 30회'],
      'completed': [true, false],
    },
    {
      'dateTime': DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 4),
      'exercises': ['윗몸일으키기', '푸쉬업', '턱걸이', '바벨컬', '달리기'],
      'completed': [true, false, true, false, false],
    },
  ];

  // 날짜 변경 트리거
  void indexChanged(DateTime selected) {
    selectedDay = selected;
    update();
  }

  void checkboxState(int index, int exercise, bool state) {
    demo[index]['completed'][exercise] = state;
    update();
  }
}

class TraineeDetail {
  final DateTime dateTime;
  final List<String> exercises;
  final List<bool> completed;

  const TraineeDetail({
    required this.dateTime,
    required this.exercises,
    required this.completed,
  });
}
