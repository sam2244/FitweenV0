import 'package:fitween1/model/plan/plan.dart';

class Diet {
  String? imageUrl;
  String description;
  String type;
  List<Weekday> selectedDays = [];
  bool completed = false;

  Diet({
    required this.description,
    required this.type,
    required this.selectedDays,
  });

  @override
  String toString() => description;
}