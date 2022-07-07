// 트레이너 메인 페이지
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../detail/widget.dart';

class TrainerDetailPage extends StatelessWidget {
  const TrainerDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: Column(
        children: [
          TraineeDetailPage(trainee: Get.arguments),
        ],
      ),
    );
  }
}
