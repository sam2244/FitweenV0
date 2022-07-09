import 'dart:convert';

import 'package:fitween1/model/plan/exercise.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ExercisePresenter {
  static String jsonFileDir = 'assets/json/exercises.json';
  static List<Exercise> exercises = [];

  static Future<String> _loadAStudentAsset() async {
    return await rootBundle.loadString(jsonFileDir);
  }

  static Future<void> loadExercises() async {
    String jsonString = await _loadAStudentAsset();
    List<dynamic> json = jsonDecode(jsonString);
    exercises = json
        .map((data) => Exercise(
              category: data['분류'],
              name: data['이름'],
              unit: data['단위'],
            ))
        .toList();
  }

  static Exercise? getExercise(String? name) {
    return exercises.firstWhereOrNull((exercise) => exercise.name == name);
  }

  static int unitsLength(String? name) => getExercise(name)?.units.length ?? 0;
}
