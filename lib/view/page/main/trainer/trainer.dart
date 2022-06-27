import 'package:fitween1/global/palette.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/page/main/trainer/widget.dart';
import 'package:fitween1/view/page/main/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 트레이너 메인 페이지
class TrainerMainPage extends StatelessWidget {
  const TrainerMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppbar(role: Role.trainer),
      body: GetBuilder<UserPresenter>(
        builder: (controller) {
          return Container(
            color: Palette.light,
            child: Column(
              children: const [
                IncompleteTraineeView(),
                TextPartition('피트위너', index: 0),
                TraineeManageCardView(),
              ],
            ),
          );
        }
      ),
      bottomNavigationBar: const MainBottomBar(),
    );
  }
}
