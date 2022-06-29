import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInfoPresenter extends GetxController {
  final userPresenter = Get.find<UserPresenter>();

  Map<String, TextEditingController> controllers = {};
  Map<String, dynamic> additionalJson = {};

  void initControllers(List<String> nullData) {
    controllers = Map.fromEntries(
      nullData.map((field) => MapEntry(
        field, TextEditingController()
      )),
    );
    update();
  }

  TextEditingController? getController(String field) => controllers[field];

  void nextPressed() async {
    controllers.forEach((type, cont) {
      switch (FWUser.types[type]) {
        case DataType.number:
          additionalJson[type] = double.parse(cont.text); break;
        default:
          additionalJson[type] = cont.text;
      }
    });

    await userPresenter.fromJson(additionalJson);
    userPresenter.updateDB();
    
    Get.offAndToNamed('/main/${userPresenter.user.role.name}');
  }
}