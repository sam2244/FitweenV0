import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/plan/plan.dart';
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
  static const double defaultWeight = 60.0;
  static const double defaultHeight = 175.0;

  String? uid;
  String? email;
  String? nickname;
  String imageUrl = UserPresenter.defaultProfile;
  String? stateMessage;
  Role role = Role.trainee;
  Sex? sex;
  double height = defaultHeight;
  DateTime? dateOfBirth;
  Map<DateTime, double>? weights;
  // Map<DateTime, double>? weights = {
  //   DateTime(2019, 5, 3): 53.0,
  //   DateTime(2019, 7, 8): 52.0,
  //   DateTime(2019, 11, 11): 51.0,
  //   DateTime(2020, 3, 5): 51.2,
  //   DateTime(2020, 6, 5): 50.0,
  //   DateTime(2020, 9, 11): 49.1,
  //   DateTime(2020, 11, 11): 48.0,
  //   DateTime(2021, 4, 5): 47.6,
  //   DateTime(2021, 7, 7): 47.4,
  //   DateTime(2021, 11, 25): 47.4,
  //   DateTime(2022, 1, 1): 47.2,
  //   DateTime(2022, 2, 7): 46.5,
  //   DateTime(2022, 3, 2): 46.4,
  //   DateTime(2022, 4, 1): 45.4,
  //   DateTime(2022, 5, 1): 45.7,
  //   DateTime(2022, 6, 6): 45.1,
  //   DateTime(2022, 6, 25): 44.8,
  //   DateTime(2022, 7, 2): 44.5,
  // };
  List<Plan>? trainerPlans;
  List<Plan>? traineePlans;
  List<FWUser>? friends;
  List<String> categories = [];

  FWUser();

  FWUser.fromMap(Map<String, dynamic> map) {
    fromMap(map);
  }

  void fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    email = map['email'];
    nickname = map['nickname'];
    imageUrl = map['imageUrl'];
    stateMessage = map['stateMessage'];
    role = map['role'];
    sex = map['sex'];
    height = map['height'];
    weights = map['weights'];
    dateOfBirth = map['dateOfBirth'];
    trainerPlans = map['trainerPlans'];
    traineePlans = map['traineePlans'];
    friends = map['friends'];
    categories = map['categories'];
  }

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'email': email,
    'nickname': nickname,
    'imageUrl': imageUrl,
    'stateMessage': stateMessage,
    'role': role,
    'sex': sex,
    'height': height,
    'weights': weights,
    'dateOfBirth': dateOfBirth,
    'trainerPlans': trainerPlans,
    'traineePlans': traineePlans,
    'friends': friends,
    'categories': categories,
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
