// Carousel 뷰 위젯
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitween1/presenter/page/main/trainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../widget/text.dart';

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
              Icons.chevron_left,
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
            ),
          ),
          IconButton(
            onPressed: () {
              controller.nextPressed();
            },
            icon: Icon(
              Icons.chevron_right,
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
    return Column(
      children: [
        for (var trainee in trainees)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      const TraineeProfileImage(),
                      TraineeInfo(trainee: trainee),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// 트레이너 메인 페이지 CategoryBar
class TraineeProfileImage extends StatelessWidget {
  const TraineeProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 10.0,
      percent: 0.8,
      center: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(50), // Image radius
          child: Image.network(
              'https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg',
              fit: BoxFit.cover),
        ),
      ),
      reverse: false,
      backgroundColor: Colors.grey.withOpacity(0),
      linearGradient: const LinearGradient(
        colors: <Color>[Color(0xffB07BE6), Color(0xff5BA2E0)],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TraineeName(name: trainee.name),
        const TrainerMainPageSubTitle(subtitle: '운동'),
        TrainerMainPageGraph(
            total: trainee.total, completed: trainee.completed),
        const TrainerMainPageSubTitle(subtitle: '식단'),
        TrainerMainPageGraph(
            total: trainee.total, completed: trainee.completed),
      ],
    );
  }
}

// 트레이너 메인 페이지 CategoryBar
class TraineeName extends StatelessWidget {
  final String name;
  const TraineeName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.labelLarge,
        overflow: TextOverflow.ellipsis,
      ),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

// 트레이너 메인 페이지 Graph
class TrainerMainPageGraph extends StatelessWidget {
  final int total;
  final int completed;

  const TrainerMainPageGraph(
      {Key? key, required this.completed, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percent = completed / total == 0 ? 0.05 : completed / total;

    return LinearPercentIndicator(
      width: 224.0,
      lineHeight: 15,
      linearGradient: const LinearGradient(
        colors: <Color>[Color(0xffB07BE6), Color(0xff5BA2E0)],
      ),
      barRadius: const Radius.circular(10),
      percent: percent,
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
    Size screenSize = MediaQuery.of(context).size;

    List<Widget> items = categories()
        .map((category) => SingleChildScrollView(
              child: Column(
                children: [
                  TraineeCategory(category: category),
                  TraineeCard(
                      trainees: trainees()
                          .where((element) => element.category == category)),
                ],
              ),
            ))
        .toList();

    items.insert(
        0,
        SingleChildScrollView(
          child: Column(
            children: [
              const TraineeCategory(category: '전체보기'),
              TraineeCard(trainees: trainees()),
            ],
          ),
        ));

    return Container(
      alignment: Alignment.topCenter,
      constraints: BoxConstraints(minWidth: screenSize.width),
      child: CarouselSlider(
        items: items,
        options: CarouselOptions(
          height: double.infinity,
          viewportFraction: 1.0,
          // scrollPhysics: const NeverScrollableScrollPhysics(),
        ),
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
