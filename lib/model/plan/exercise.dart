class Exercise {
  String category;
  String name;
  List<String> units = [];

  Exercise({
    required this.category,
    required this.name,
    required String unit,
  }) { units = unit.split(','); }
}