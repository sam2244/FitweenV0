import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/chart.dart';
import 'package:fitween1/presenter/page/my.dart';
import 'package:fitween1/view/widget/image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:get/get.dart';

// 마이 페이지의 위젯 모음

// 마이 페이지 AppBar

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
        elevation: 0.0,
      )
    );
  }
}

class MyProfileImageButton extends StatelessWidget {
  const MyProfileImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPresenter>(
      builder: (controller) {
        return Column(
          children: [
            ProfileImageCircle(
              size: 70.0,
              user: MyPresenter.userPresenter.user,
              onPressed: () => controller.profileImagePressed(Theme.of(context)),
            ),
            FWText(
              '닉네임', size: 20.0,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        );
      }
    );
  }
}

class MyWeightGraphView extends StatelessWidget {
  const MyWeightGraphView({
    Key? key,
    required this.ratio,
    this.title = '',
  }) : super(key: key);

  final double ratio;
  final String title;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<MyPresenter>(
      builder: (controller) {
        controller.initChart(Theme.of(context));
        return Column(
          children: [
            SizedBox(
              height: 50.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: PeriodType.values.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () => controller.typeChanged(PeriodType.values[index]),
                    child: Text(PeriodType.values[index].name),
                  );
                }
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 50.0, 0.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(15.0),
                    child: FWText(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: ratio,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: LineChart(
                        controller.weightChart.chartData,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}
