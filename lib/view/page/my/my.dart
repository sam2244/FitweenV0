import 'package:fitween1/presenter/page/my.dart';
import 'package:fitween1/view/page/my/widget.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 마이 페이지
class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPresenter>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: const MyAppBar(),
          body: Column(
            children: [
              MyProfileImageButton(),
              MyWeightGraphView(title: '체중', ratio: 1.5),
              HeightInfo(),
            ],
          ),
          bottomNavigationBar: const FWBottomBar(),
        );
      }
    );
  }
}
