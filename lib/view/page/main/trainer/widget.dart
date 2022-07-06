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
          IconButton(
            onPressed: () {
              controller.backPressed();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.primary,
            ),
            iconSize: 40,
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
          IconButton(
            onPressed: () {
              controller.nextPressed();
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.primary,
            ),
            iconSize: 40,
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
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var trainee in trainees)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () => Get.toNamed('/detail/trainer', arguments: trainee),
                child: Card(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 108.0,
                      child: Row(
                        children: [
                          const TraineeProfileImage(),
                          Expanded(child: TraineeInfo(trainee: trainee)),
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
  }
}

// 트레이너 메인 페이지 CategoryBar
class TraineeProfileImage extends StatelessWidget {
  const TraineeProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 10.0,
      percent: 0.8,
      center: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(40.0), // Image radius
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
          lineHeight: 12,
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

  static List<String> categories() => ['삼손', '암스트롱', '청풍'];

  static List<Trainee> trainees() => const [
        Trainee(category: '삼손', name: '정윤석', total: 5, completed: 4),
        Trainee(category: '삼손', name: '정윤석', total: 5, completed: 2),
        Trainee(category: '삼손', name: '정윤석', total: 5, completed: 5),
        Trainee(category: '암스트롱', name: '정윤석', total: 5, completed: 4),
        Trainee(category: '암스트롱', name: '정윤석', total: 5, completed: 3),
        Trainee(category: '암스트롱', name: '정윤석', total: 5, completed: 0),
        Trainee(category: '암스트롱', name: '정윤석', total: 5, completed: 2),
        Trainee(category: '청풍', name: '정윤석', total: 5, completed: 4),
        Trainee(category: '청풍', name: '정윤석', total: 5, completed: 5),
      ];
  static int widgetCount = categories().length;

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    // bool keyboardDisabled = WidgetsBinding.instance.window.viewInsets.bottom < 100.0;
    final controller = Get.find<TrainerPresenter>();
    Size screenSize = MediaQuery.of(context).size;
    // int _current = 0;

    List<Widget> items = categories()
        .map((category) => TraineeCard(
            trainees:
                trainees().where((element) => element.category == category)))
        .toList();

    items.insert(0, TraineeCard(trainees: trainees()));

    List<String> currentCategory = categories();
    currentCategory.insert(0, '전체보기');

    return Container(
      alignment: Alignment.topCenter,
      constraints: BoxConstraints(minWidth: screenSize.width),
      child: Column(
        children: [
          // TraineeCategory(category: currentCategory),
          GetBuilder<TrainerPresenter>(
            builder: (controller) {
              return TraineeCategory(
                category: currentCategory[controller.pageIndex],
              );
            },
          ),
          Expanded(
            child: CarouselSlider(
              carouselController: TrainerPresenter.carouselCont,
              items: items,
              options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 1.0,
                  // scrollPhysics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index, reason) {
                    controller.indexChanged(index);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class Trainee {
  final String category;
  final String name;
  final int total;
  final int completed;

  const Trainee({
    required this.category,
    required this.name,
    required this.total,
    required this.completed,
  });
}
