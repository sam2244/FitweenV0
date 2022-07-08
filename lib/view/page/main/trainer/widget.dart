// Carousel 뷰 위젯
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitween1/presenter/page/main/trainer.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

// 트레이너 메인 페이지 CategoryBar
class TraineeCategory extends StatelessWidget {
  final String category;
  const TraineeCategory({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrainerPresenter>();

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          controller.selectMod
              ? Container()
              : IconButton(
                  onPressed: () {
                    controller.backPressed();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  iconSize: 24,
                ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 150,
            child: FWText(
              category,
              size: 20,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          controller.selectMod
              ? Container()
              : IconButton(
                  onPressed: () {
                    controller.selectMod ? null : controller.nextPressed();
                  },
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
class TraineeCard extends StatelessWidget {
  final Iterable<Trainee> trainees;
  const TraineeCard({Key? key, required this.trainees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrainerPresenter>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < trainees.length; i++)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () => controller.selectMod
                        ? controller.toggleSelectState(i)
                        : Get.toNamed(
                            '/detail/trainer',
                            arguments: trainees.elementAt(i),
                          ),
                    onLongPress: () {
                      controller.modChange(true);
                      controller.toggleSelectState(i);
                    },
                    child: Card(
                      color: TrainerPresenter.traineeCheck[i]
                          ? Theme.of(context).colorScheme.surfaceVariant
                          : null,
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 108.0,
                          child: Row(
                            children: [
                              const TraineeProfileImage(),
                              Expanded(
                                child: TraineeInfo(
                                  trainee: trainees.elementAt(i),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// 트레이너 메인 페이지 CategoryBar
class TraineeProfileImage extends StatelessWidget {
  const TraineeProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 40.0,
      lineWidth: 8.0,
      percent: 0.8,
      center: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(30.0), // Image radius
          child: Image.network(
            'https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      reverse: true,
      backgroundColor: Colors.transparent,
      linearGradient: const LinearGradient(
        colors: [Color(0xffB07BE6), Color(0xff5BA2E0)],
      ),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}

// 트레이너 메인 페이지 Trainee Information
class TraineeInfo extends StatelessWidget {
  final Trainee trainee;
  const TraineeInfo({Key? key, required this.trainee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TraineeName(name: trainee.name),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TrainerMainPageGraph(
                    title: '운동',
                    total: trainee.total,
                    completed: trainee.completed),
                if (true) // isDiet
                  TrainerMainPageGraph(
                      title: '식단',
                      total: trainee.total,
                      completed: trainee.completed),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// 트레이너 메인 페이지 CategoryBar
class TraineeName extends StatelessWidget {
  final String name;
  const TraineeName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FWText(
      name,
      color: Theme.of(context).colorScheme.onSurface,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}

// 트레이너 메인 페이지 CategoryBar
class TrainerMainPageSubTitle extends StatelessWidget {
  final String subtitle;
  const TrainerMainPageSubTitle({Key? key, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: FWText(
        subtitle,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

// 트레이너 메인 페이지 Graph
class TrainerMainPageGraph extends StatelessWidget {
  final String title;
  final int total;
  final int completed;

  const TrainerMainPageGraph({
    Key? key,
    required this.title,
    required this.completed,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percent = completed / total == 0 ? 0.05 : completed / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FWText(
          title,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        LinearPercentIndicator(
          padding: EdgeInsets.zero,
          lineHeight: 8,
          linearGradient: const LinearGradient(
            colors: <Color>[Color(0xffB07BE6), Color(0xff5BA2E0)],
          ),
          barRadius: const Radius.circular(10),
          percent: percent,
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

    List<Widget> items = TrainerPresenter.categories()
        .map((category) => TraineeCard(
            trainees: TrainerPresenter.trainees()
                .where((element) => element.category == category)))
        .toList();

    items.insert(0, TraineeCard(trainees: TrainerPresenter.trainees()));

    List<String> currentCategory = TrainerPresenter.categories();
    currentCategory.insert(0, '전체보기');

    return Container(
      alignment: Alignment.topCenter,
      constraints: BoxConstraints(minWidth: screenSize.width),
      child: GetBuilder<TrainerPresenter>(
        builder: (controller) {
          return Column(
            children: [
              TraineeCategory(
                category: currentCategory[controller.pageIndex],
              ),
              Expanded(
                child: CarouselSlider(
                  carouselController: TrainerPresenter.carouselCont,
                  items: items,
                  options: CarouselOptions(
                      height: double.infinity,
                      viewportFraction: 1.0,
                      scrollPhysics: controller.selectMod
                          ? const NeverScrollableScrollPhysics()
                          : null,
                      onPageChanged: (index, reason) {
                        controller.indexChanged(index);
                      }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
