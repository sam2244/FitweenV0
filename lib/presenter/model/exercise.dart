import 'dart:convert';
import 'dart:io';

import 'package:fitween1/model/plan/exercise.dart';
import 'package:get/get.dart';

class ExercisePresenter {
  static String jsonFileDir = '/Volumes/One Touch/projects/flutter/Fitween/assets/json/exercises.json';
  static List<Exercise> exercises = [];

  static void loadExercises() async {
    List<dynamic> json = jsonDecode(File(jsonFileDir).readAsStringSync());
    exercises = json.map((data) => Exercise(
      category: data['분류'], name: data['이름'], unit: data['단위'],
    )).toList();
  }

  static Exercise? getExercise(String? name) {
    return exercises.firstWhereOrNull((exercise) => exercise.name == name);
  }

  static int unitsLength(String? name) => getExercise(name)?.units.length ?? 0;
}