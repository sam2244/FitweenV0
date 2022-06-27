import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/view/page/main/trainee/widget.dart';
import 'package:fitween1/view/page/main/widget.dart';
import 'package:flutter/material.dart';

// 피트위너 메인 페이지
class TraineeMainPage extends StatelessWidget {
  const TraineeMainPage({Key? key}) : super(key: key);

  static const List<Widget> pageWidgets = [
    TopProfile(),
    PlanTabBar(),
    TextPartition('운동', index: 1),
    TodoListView(),
    TextPartition('식단', index: 1),
    DietCardView(),
  ];

  static List<Widget> paddedWidgets(double padding) {
    List<Widget> widgets = [];
    for (var widget in pageWidgets) {
      widgets.addAll([widget, SizedBox(height: padding)]);
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppbar(role: Role.trainee),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin.width,
          vertical: defaultMargin.height,
        ),
        child: Column(
          children: paddedWidgets(8.0),
        ),
      ),
      bottomNavigationBar: const MainBottomBar(),
    );
  }
}