// Carousel 뷰 위젯
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/global.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/main/trainer.dart';
import 'package:fitween1/view/page/main/widget.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SelectModeBottomBar extends StatelessWidget {
  const SelectModeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrainerPresenter>(
      builder: (controller) {
        return BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.drive_file_move_outline),
                  iconSize: 40.0,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  iconSize: 40.0,
                ),
                IconButton(
                  onPressed: () {
                    controller.resetSelectState();
                    controller.changeMode(false);
                  },
                  icon: const Icon(Icons.close_rounded),
                  iconSize: 40.0,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}


// 트레이너 메인 페이지 CategoryBar
class TraineeCategoryBar extends StatelessWidget {
  const TraineeCategoryBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrainerPresenter>();

    return Padding(
      padding: EdgeInsets.only(top: 20.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!controller.selectMode)
          IconButton(
            onPressed: controller.backPressed,
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.primary,
            ),
            iconSize: 24,
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width.w - 150.w,
            child: FWText(
              controller.currentGroup,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          if (!controller.selectMode)
          IconButton(
            onPressed: controller.nextPressed,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.primary,
            ),
            iconSize: 24,
          ),
        ],
      ),
    );
  }
}

// 트레이너 메인 페이지 Card
class TraineeCardView extends StatelessWidget {
  final String? group;
  const TraineeCardView({Key? key, this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrainerPresenter>(
      builder: (controller) {
        List<Plan> filteredPlans = [];
        if (group == null) { filteredPlans = [...controller.plans]; }
        else {
          filteredPlans = controller.plans.where((plan) {
            return plan.group == group;
          }).toList();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: filteredPlans.length,
                  itemBuilder: (context, index) {
                    return Material(
                      color: controller.planSelected[index]
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Colors.transparent,
                      child: InkWell(
                        onTap: () => controller.planTilePressed(index: index),
                        onLongPress: () {
                          controller.changeMode(true);
                          controller.toggleSelectState(index);
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          height: 120.0,
                          margin: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TraineeInfoTile(plan: filteredPlans[index]),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, _) => Divider(
                    thickness: 1.0,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                child: const PlanAddButton(role: Role.trainer),
              ),
            ],
          ),
        );
      },
    );
  }
}


// 트레이너 메인 페이지 Trainee Information
class TraineeInfoTile extends StatelessWidget {
  final Plan plan;
  const TraineeInfoTile({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FWUser? trainee = plan.trainee;

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          SizedBox(
            width: 80.0,
            child: TraineeProfileImage(
              trainee: trainee,
              rate: plan.goalRate,
            ),
          ),
          const SizedBox(width: 15.0),
          trainee == null ? FWText(
            '피트위너를 등록하세요.\n${plan.id}',
            color: Theme.of(context).colorScheme.onSurface,
            style: Theme.of(context).textTheme.labelLarge,
          ) : Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TraineeNameWidget(trainee: trainee),
                Expanded(child: TraineeGraphView(plan: plan)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 트레이너 메인 페이지 CategoryBar
class TraineeProfileImage extends StatelessWidget {
  final FWUser? trainee;
  final double rate;
  const TraineeProfileImage({
    Key? key,
    required this.trainee,
    required this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 42.0,
      lineWidth: 12.0,
      percent: rate,
      center: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(30.0), // Image radius
          child: Image.network(
            trainee?.imageUrl ?? UserPresenter.defaultProfile,
            fit: BoxFit.cover,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      linearGradient: FWTheme.fitweenGradient,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
// 트레이너 메인 페이지 CategoryBar
class TraineeNameWidget extends StatelessWidget {
  final FWUser? trainee;
  const TraineeNameWidget({Key? key, this.trainee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FWText(trainee!.nickname!,
      color: Theme.of(context).colorScheme.onSurface,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}

class TraineeGraphView extends StatelessWidget {
  final Plan plan;
  const TraineeGraphView({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TrainerMainPageGraph(
          title: '운동',
          rate: plan.todoRate,
        ),
        if (plan.isDiet)
        TrainerMainPageGraph(
          title: '식단',
          rate: plan.dietRate,
        ),
      ],
    );
  }
}

// 트레이너 메인 페이지 Graph
class TrainerMainPageGraph extends StatelessWidget {
  final String title;
  final double rate;

  const TrainerMainPageGraph({
    Key? key,
    required this.title,
    required this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percent = rate;
    if (rate == .0) percent = .05;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FWText(
          title,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Container(
          padding: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: LinearPercentIndicator(
            padding: EdgeInsets.zero,
            lineHeight: 10,
            backgroundColor: Colors.transparent,
            progressColor: FWTheme.primary.withOpacity(.3 + percent * 7 / 10),
            barRadius: const Radius.circular(10.0),
            percent: percent,
          ),
        ),
      ],
    );
  }
}

class TrainerView extends StatelessWidget {
  const TrainerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    // bool keyboardDisabled = WidgetsBinding.instance.window.viewInsets.bottom < 100.0;
    Size screenSize = MediaQuery.of(context).size;
    // int _current = 0;

    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          constraints: BoxConstraints(minWidth: screenSize.width),
          child: GetBuilder<TrainerPresenter>(
            builder: (controller) {
              List<Widget> items = [const TraineeCardView()];
              items.addAll(
                controller.categories.map((group) {
                  return TraineeCardView(group: group);
                }).toList(),
              );

              return controller.plans.isEmpty
                  ? const NoPlanWidget(role: Role.trainer)
                  : Column(
                children: [
                  const TraineeCategoryBar(),
                  Expanded(
                    child: CarouselSlider(
                      carouselController: TrainerPresenter.carouselCont,
                      items: items,
                      options: CarouselOptions(
                        height: double.infinity,
                        viewportFraction: 1.0,
                        scrollPhysics: controller.selectMode || controller.categories.isEmpty
                            ? const NeverScrollableScrollPhysics()
                            : null,
                        onPageChanged: (index, _) => controller.pageChanged(index),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        GetBuilder<GlobalPresenter>(
          builder: (controller) {
            if (!controller.loading) return Container();
            return CircularProgressIndicator(
              backgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(.7),
            );
          },
        ),
      ],
    );
  }
}
