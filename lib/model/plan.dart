import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/record.dart';

/*
**Plans: 플랜**

- id (String): 계획 id
- state (String): Plan의 상태 - ‘training’, ‘fail’, ‘complete’
- trainerUid (String): 트레이너의 uid
- traineeUid (String): 회원의 uid
- startDate (Timestamp): 트레이닝 시작일
- endDate (Timestamp): 트레이닝 종료일
- height (double?): 회원의 키 값
- purpose (String) : 목적
- goal (String?) : 목표
- curValue (double?): 현재값
- goalValue (double?) : 목표치
    - **Records: 사용자의 날짜별 정보**
        - weight (double) : 사용자의 몸무게 값
        - regDate (Timestamp): 저장 날짜
 */

class Plan {
  late String id;
  String state = 'training';
  String? trainerUid;
  String? traineeUid;
  DateTime? startDate;
  DateTime? endDate;
  double? height;
  List<String> purposes = [];
  String? goal;
  double? value;
  double? goalValue;
  List<Record> records = [];

  Plan({
    required this.id,
    this.trainerUid,
    this.traineeUid,
    this.startDate,
    this.endDate,
    this.height,
    this.goal,
    this.value,
    this.goalValue,
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
    purposes = json['purposes'].cast<String>();
    goal = json['goal'];
    value = json['value'];
    goalValue = json['goalValue'];
    records = json['records'].cast<String>();
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'state': state,
    'trainerUid': trainerUid,
    'traineeUid': traineeUid,
    'startDate': startDate,
    'endDate': endDate,
    'height': height,
    'purposes': purposes,
    'goal': goal,
    'value': value,
    'goalValue': goalValue,
    'records': records,
  };

  Future loadDB(String planId) async {
    return (await instance.collection('plans').doc(planId).get());
  }

  void updateDB() {
    instance.collection('plans').doc(id).set(toJson());
  }
}
