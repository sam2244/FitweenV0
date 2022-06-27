// 카테고리
enum Category {
  shoulder, arm, chest, abdominal, back, leg;

  String get kr {
    switch (name) {
      case 'shoulder': return '어깨';
      case 'arm': return '팔';
      case 'chest': return '가슴';
      case 'abdominal': return '복부';
      case 'back': return '등';
      case 'leg': return '하체';
    }
    return '';
  }
}

// 운동 모델
class Exercise {
  List<Category> categories = [];
  String name;

  Exercise({
    required this.name,
  });
}