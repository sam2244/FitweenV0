import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitween1/model/record.dart';

class Plan {
  late String id;
  String state = 'training';
  String? trainerUid;
  String? traineeUid;
  DateTime? startDate = DateTime.now();
  DateTime? endDate;
  double? height;
  double? weight;
  double? goal;
  List<Record> records = [];

  Plan({
    required this.id,
    this.trainerUid,
    this.traineeUid,
    this.startDate,
    this.endDate,
    this.height,
    this.weight,
    this.goal,
  });

  Plan.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    trainerUid = json['trainerUid'];
    traineeUid = json['traineeUid'];
    startDate = (json['startDate'] ?? Timestamp.now()).toDate();
    endDate = (json['endDate'] ?? Timestamp.now()).toDate();
    height = json['height'];
    weight = json['weight'];
    goal = json['goal'];
    records = json['records'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'state': state,
    'trainerUid': trainerUid,
    'traineeUid': traineeUid,
    'startDate': startDate,
    'endDate': endDate,
    'height': height,
    'weight': weight,
    'goal': goal,
    'records': records,
  };
}
