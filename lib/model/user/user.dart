import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/model/user/range.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:get/get.dart';

// 역할
enum Role {
  trainer, trainee;

  String get kr {
    switch (name) {
      case 'trainer': return '트레이너';
      case 'trainee': return '피트위너';
    }
    return '';
  }
}

enum Sex {
  male, female;

  String get kr {
    switch (name) {
      case 'male': return '남성';
      case 'female': return '여성';
    }
    return '';
  }
}

// 사용자 모델
class FWUser {
  static Range weightRange = DoubleRange(start: 20, end: 220);
  static Range heightRange = DoubleRange(start: 100, end: 220);
  static const double defaultWeight = 60.0;
  static const double defaultHeight = 175.0;

  String? uid;
  String? email;
  String? nickname;
  String imageUrl = UserPresenter.defaultProfile;
  String? statusMessage;
  Role role = Role.trainee;
  Sex? sex;
  double height = defaultHeight;
  DateTime? dateOfBirth;
  Map<DateTime, double>? weights;
  List<Plan>? trainerPlans;
  List<Plan>? traineePlans;
  List<FWUser>? friends;
  List<String> categories = [];

  List<String> trainerPlanIds = [];
  List<String> traineePlanIds = [];
  List<String> friendUids = [];

  FWUser();

  FWUser.fromMap(Map<String, dynamic> map) {
    fromMap(map);
  }

  void fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    email = map['email'];
    nickname = map['nickname'];
    imageUrl = map['imageUrl'];
    statusMessage = map['statusMessage'];
    role = map['role'];
    sex = map['sex'];
    height = map['height'];
    weights = map['weights'];
    dateOfBirth = map['dateOfBirth'];
    trainerPlans = map['trainerPlans'];
    traineePlans = map['traineePlans'];
    trainerPlanIds = map['trainerPlanIds'];
    traineePlanIds = map['traineePlanIds'];
    friends = map['friends'];
    friendUids = map['friendUids'];
    categories = map['categories'];
  }

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'email': email,
    'nickname': nickname,
    'imageUrl': imageUrl,
    'statusMessage': statusMessage,
    'role': role,
    'sex': sex,
    'height': height,
    'weights': weights,
    'dateOfBirth': dateOfBirth,
    'trainerPlans': trainerPlans,
    'traineePlans': traineePlans,
    'trainerPlanIds': trainerPlanIds,
    'traineePlanIds': traineePlanIds,
    'friends': friends,
    'friendUids': friendUids,
    'categories': categories,
  };

  // json 데이터를 user 객체에 주입
  Future fromJson(Map<String, dynamic> json) async {
    Map<String, dynamic> map = toJson();
    map.addAll(json);
    map['role'] = FWUser.toRole(json['role']);
    map['sex'] = FWUser.toSex(json['sex']);
    map['height'] = json['height'] ?? defaultHeight;
    map['weights'] = <DateTime, double>{
      if (json['weights'] != null)
      for (var data in json['weights'].map((data) => MapEntry<DateTime, double>(
        data['date'].toDate(), data['weight'],
      ))) data.key : data.value,
    };
    map['trainerPlanIds'] = json['trainerPlanIds'].cast<String>();
    map['traineePlanIds'] = json['traineePlanIds'].cast<String>();
    map['friendUids'] = json['friendUids'].cast<String>();
    map['dateOfBirth'] = json['dateOfBirth']?.toDate();
    map['categories'] = json['categories'] ?? <String>[];
    fromMap(map);
  }

  // user 객체에서 json 데이터 추출
  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'nickname': nickname,
    'imageUrl': imageUrl,
    'role': role.name,
    'sex': sex?.name,
    'height': height,
    'weights': weights?.entries.map((data) => {
      'date': Timestamp.fromDate(data.key),
      'weight': data.value,
    }).toList(),
    'dateOfBirth': dateOfBirth == null
        ? null : Timestamp.fromDate(dateOfBirth!),
    'friendUids': friendUids,
    'trainerPlanIds': trainerPlanIds,
    'traineePlanIds': traineePlanIds,
  };

  static Map<String, DataType> get types => {
    'name': DataType.string,
    'email': DataType.string,
    'role': DataType.string,
    'sex': DataType.string,
    'dateOfBirth': DataType.date,
    'height': DataType.number,
    'weights': DataType.number,
  };

  static bool isRequired(String field) {
    return types.keys.contains(field);
  }

  @override
  String toString() {
    return '\n\nUSER INFO\n${toMap().entries.map(
      (data) => '  ${data.key}: ${data.value}',
    ).join('\n')}\n';
  }

  static DateTime? stringToDate(String string) {
    try {
      String yy = string.substring(0, 2);
      int year = int.parse('${int.parse(yy) > 50 ? '19' : '20'}$yy');
      int month = int.parse(string.substring(2, 4));
      int day = int.parse(string.substring(4));

      if (month > 12) return null;
      if (month == 2 && day > 29) return null;
      if ([4, 6, 9, 11].contains(month) && day > 30) return null;
      if (day > 31) return null;

      return DateTime(year, month, day);
    }
    catch(e) { return null; }
  }

  // 문자열을 역할 enum 으로 전환 ('trainer' => Role.trainer)
  static Role toRole(String? string) => Role.values.firstWhere(
    (role) => role.name == string,
    orElse: () => Role.trainee,
  );

  // 문자열을 성별 enum 으로 전환 ('male' => Sex.male)
  static Sex? toSex(String? string) => Sex.values.firstWhereOrNull(
    (sex) => sex.name == string,
  );

  // 역할을 전환
  void toggleRole() {
    role = Role.values.firstWhere((value) => value != role);
  }

  // 성별을 설정
  void setSex(Sex sex) => this.sex = sex;

  // 사용자 리스트의 각 사용자의 uid 값으로 이루어진 리스트 반환 (List<FWUser> => List<String>)
  static List<String>? toUids(List<FWUser>? users) {
    if (users == null) return null;
    return users.map((user) => user.uid!).toList();
  }
}
