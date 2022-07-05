import 'package:fitween1/presenter/page/my/editheight.dart';
import 'package:fitween1/view/page/editHeight/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 신장 수정 페이지
class EditHeightPage extends StatelessWidget {
  const EditHeightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditHeightPresenter>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: const EditHeightAppBar(),
          body: Center(
            child: Column(
              children: const [
                HeightTextField(),
              ],
            ),
          ),
        );
      }
    );
  }
}
