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
  String? uid;
  String? name;
  String? email;
  String? nickname;
  String? statusMessage;
  String imageUrl = UserPresenter.defaultProfile;
  Role role = Role.trainee;
  Sex? sex;
  double? height;
  double? weight;

  List<Plan>? trainerPlans;
  List<Plan>? traineePlans;

  FWUser();

  FWUser.fromMap(Map<String, dynamic> map) {
    fromMap(map);
  }

  void fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    name = map['name'];
    email = map['email'];
    nickname = map['nickname'];
    imageUrl = map['imageUrl'];
    statusMessage = map['statusMessage'];
    role = map['role'];
    sex = map['sex'];
    height = map['height'];
    weight = map['weight'];
    trainerPlans = map['trainerPlans'];
    traineePlans = map['traineePlans'];
  }

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'name': name,
    'email': email,
    'nickname': nickname,
    'imageUrl': imageUrl,
    'statusMessage': statusMessage,
    'role': role,
    'sex': sex,
    'height': height,
    'weight': weight,
    'trainerPlans': trainerPlans,
    'traineePlans': traineePlans,
  };

  // 문자열을 역할 enum 으로 전환 ('trainer' => Role.trainer)
  static Role toRole(String string) => Role.values.firstWhere(
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

  // 사용자 리스트의 각 사용자의 uid 값으로 이루어진 리스트 반환 (List<FWUser> => List<String>)
  static List<String>? toUids(List<FWUser>? users) {
    if (users == null) return null;
    return users.map((user) => user.uid ?? '').toList();
  }
}
