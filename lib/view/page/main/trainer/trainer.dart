import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/view/page/main/widget.dart';
import 'package:flutter/material.dart';

// 트레이너 메인 페이지
class TrainerMainPage extends StatelessWidget {
  const TrainerMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(role: Role.trainer),
      body: Container(),
    );
  }
}
