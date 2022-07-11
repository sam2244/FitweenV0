import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
        case DataType.date:
          additionalJson[type] = Timestamp.fromDate(
            DateFormat('yyyy-MM-dd').parse(cont.text),
          ); break;
        default:
          additionalJson[type] = cont.text;
      }
    });

    Map<String, dynamic> json = userPresenter.user.toJson();
    additionalJson.forEach((key, value) => json[key] = value);
    await userPresenter.user.fromJson(json);

    UserPresenter.updateDB(userPresenter.user);
    
    Get.offAndToNamed('/main/${userPresenter.user.role.name}');
  }
}