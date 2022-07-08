import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/chart.dart';
import 'package:fitween1/presenter/page/my/my.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:fitween1/view/widget/image.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 마이 페이지의 위젯 모음

// 마이 페이지 앱바
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(15.0),
            child: FWLogo(),
          ),
          leadingWidth: 600.0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: MyPresenter.settingPressed,
            ),
          ],
          elevation: 0.0,
        )
    );
  }
}

class MyProfileImage extends StatelessWidget {
  const MyProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPresenter>(
      builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ProfileImageCircle(
                size: 100.0,
                user: MyPresenter.userPresenter.user,
                //onPressed: () => controller.profileImagePressed(Theme.of(context)),
              ),
            ),
            FWText(
              MyPresenter.userPresenter.user.nickname!, size: 20.0,
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
        controller.initChart();
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 50.0, 0.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: FWText(
                      "기본 정보",
                      style: Theme.of(context).textTheme.headlineMedium,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: FWCard(
                        height: 447,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(10.0),
                              child: FWText(
                                "신장  |  ${MyPresenter.userPresenter.user.height} cm",
                                style: Theme.of(context).textTheme.headlineSmall,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(10.0),
                              child: FWText(
                                title,
                                style: Theme.of(context).textTheme.headlineSmall,
                                color: Theme.of(context).colorScheme.onSurface,
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
                            Container(
                              height: 50.0,
                              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
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
                              margin: const EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: controller.addWeightPressed,
                                child: FWText(
                                  '체중 기록하기',
                                  size: 15.0,
                                  style: Theme.of(context).textTheme.titleMedium,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}