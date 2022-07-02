import 'package:fitween1/presenter/page/my.dart';
import 'package:fitween1/view/page/my/widget.dart';
import 'package:fitween1/view/widget/text.dart';

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
              const MyProfileImageButton(),
              const MyWeightGraphView(title: '체중', ratio: 1.5),
              Container(
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                child: FWText(
                  '체중 변화 기록',
                  size: 20.0,
                  color: Colors.black,
                ),
              ),
              Container(
                child: FWText(
                  "키" + " 190 " + "cm",
                  size: 20.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
